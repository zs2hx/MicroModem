
#ifndef FSK_CFG
#define FSK_CFG

#define CONFIG_AFSK_FILTER AFSK_CHEBYSHEV
#define CONFIG_AFSK_RX_BUFLEN 64
#define CONFIG_AFSK_TX_BUFLEN 64
#define CONFIG_AFSK_DAC_SAMPLERATE 9600
#define CONFIG_AFSK_RXTIMEOUT 0


#define CONFIG_AFSK_PREAMBLE_LEN 300UL
#define CONFIG_AFSK_TRAILER_LEN 50UL

#endif