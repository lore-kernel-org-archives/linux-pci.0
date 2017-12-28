Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 28 Dec 2017 23:36:07 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH 1/4] PCI/AER: factor out error reporting from AER
Message-ID: <201712282300.yLkNaHMv%fengguang.wu@intel.com>
References: <1514370022-4431-2-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <1514370022-4431-2-git-send-email-poza@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Oza,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15-rc5]
[cannot apply to pci/next pm/linux-next next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oza-Pawandeep/Address-error-and-recovery-for-AER-and-DPC/20171228-222058
config: i386-randconfig-s0-201752 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:96:0,
                    from include/ras/ras_event.h:414,
                    from drivers/ras/ras.c:15:
   include/trace/../../include/ras/ras_event.h: In function 'trace_raw_output_aer_event':
>> include/trace/../../include/ras/ras_event.h:319:24: error: 'AER_CORRECTABLE' undeclared (first use in this function)
      __entry->severity == AER_CORRECTABLE ? "Corrected" :
                           ^
   include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
     trace_seq_printf(s, print);     \
                         ^~~~~
   include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
            PARAMS(print));         \
            ^~~~~~
   include/trace/../../include/ras/ras_event.h:298:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(aer_event,
    ^~~~~~~~~~~
   include/trace/../../include/ras/ras_event.h:317:2: note: in expansion of macro 'TP_printk'
     TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
     ^~~~~~~~~
   include/trace/../../include/ras/ras_event.h:319:24: note: each undeclared identifier is reported only once for each function it appears in
      __entry->severity == AER_CORRECTABLE ? "Corrected" :
                           ^
   include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
     trace_seq_printf(s, print);     \
                         ^~~~~
   include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
            PARAMS(print));         \
            ^~~~~~
   include/trace/../../include/ras/ras_event.h:298:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(aer_event,
    ^~~~~~~~~~~
   include/trace/../../include/ras/ras_event.h:317:2: note: in expansion of macro 'TP_printk'
     TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
     ^~~~~~~~~
>> include/trace/../../include/ras/ras_event.h:320:25: error: 'AER_FATAL' undeclared (first use in this function)
       __entry->severity == AER_FATAL ?
                            ^
   include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
     trace_seq_printf(s, print);     \
                         ^~~~~
   include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
            PARAMS(print));         \
            ^~~~~~
   include/trace/../../include/ras/ras_event.h:298:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(aer_event,
    ^~~~~~~~~~~
   include/trace/../../include/ras/ras_event.h:317:2: note: in expansion of macro 'TP_printk'
     TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
     ^~~~~~~~~

vim +/AER_CORRECTABLE +319 include/trace/../../include/ras/ras_event.h

297b64c7 Tyler Baicar 2017-06-21  254  
297b64c7 Tyler Baicar 2017-06-21  255  /*
0a2409aa Chen, Gong   2014-06-11  256   * PCIe AER Trace event
0a2409aa Chen, Gong   2014-06-11  257   *
0a2409aa Chen, Gong   2014-06-11  258   * These events are generated when hardware detects a corrected or
0a2409aa Chen, Gong   2014-06-11  259   * uncorrected event on a PCIe device. The event report has
0a2409aa Chen, Gong   2014-06-11  260   * the following structure:
0a2409aa Chen, Gong   2014-06-11  261   *
0a2409aa Chen, Gong   2014-06-11  262   * char * dev_name -	The name of the slot where the device resides
0a2409aa Chen, Gong   2014-06-11  263   *			([domain:]bus:device.function).
0a2409aa Chen, Gong   2014-06-11  264   * u32 status -		Either the correctable or uncorrectable register
0a2409aa Chen, Gong   2014-06-11  265   *			indicating what error or errors have been seen
0a2409aa Chen, Gong   2014-06-11  266   * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
0a2409aa Chen, Gong   2014-06-11  267   */
0a2409aa Chen, Gong   2014-06-11  268  
0a2409aa Chen, Gong   2014-06-11  269  #define aer_correctable_errors					\
99d44024 Chen, Gong   2014-08-13  270  	{PCI_ERR_COR_RCVR,	"Receiver Error"},		\
99d44024 Chen, Gong   2014-08-13  271  	{PCI_ERR_COR_BAD_TLP,	"Bad TLP"},			\
99d44024 Chen, Gong   2014-08-13  272  	{PCI_ERR_COR_BAD_DLLP,	"Bad DLLP"},			\
99d44024 Chen, Gong   2014-08-13  273  	{PCI_ERR_COR_REP_ROLL,	"RELAY_NUM Rollover"},		\
99d44024 Chen, Gong   2014-08-13  274  	{PCI_ERR_COR_REP_TIMER,	"Replay Timer Timeout"},	\
cb9a684a Chen, Gong   2014-08-13  275  	{PCI_ERR_COR_ADV_NFAT,	"Advisory Non-Fatal Error"},	\
cb9a684a Chen, Gong   2014-08-13  276  	{PCI_ERR_COR_INTERNAL,	"Corrected Internal Error"},	\
cb9a684a Chen, Gong   2014-08-13  277  	{PCI_ERR_COR_LOG_OVER,	"Header Log Overflow"}
0a2409aa Chen, Gong   2014-06-11  278  
0a2409aa Chen, Gong   2014-06-11  279  #define aer_uncorrectable_errors				\
846fc709 Chen, Gong   2014-08-13  280  	{PCI_ERR_UNC_UND,	"Undefined"},			\
cb9a684a Chen, Gong   2014-08-13  281  	{PCI_ERR_UNC_DLP,	"Data Link Protocol Error"},	\
cb9a684a Chen, Gong   2014-08-13  282  	{PCI_ERR_UNC_SURPDN,	"Surprise Down Error"},		\
99d44024 Chen, Gong   2014-08-13  283  	{PCI_ERR_UNC_POISON_TLP,"Poisoned TLP"},		\
cb9a684a Chen, Gong   2014-08-13  284  	{PCI_ERR_UNC_FCP,	"Flow Control Protocol Error"},	\
99d44024 Chen, Gong   2014-08-13  285  	{PCI_ERR_UNC_COMP_TIME,	"Completion Timeout"},		\
99d44024 Chen, Gong   2014-08-13  286  	{PCI_ERR_UNC_COMP_ABORT,"Completer Abort"},		\
99d44024 Chen, Gong   2014-08-13  287  	{PCI_ERR_UNC_UNX_COMP,	"Unexpected Completion"},	\
99d44024 Chen, Gong   2014-08-13  288  	{PCI_ERR_UNC_RX_OVER,	"Receiver Overflow"},		\
99d44024 Chen, Gong   2014-08-13  289  	{PCI_ERR_UNC_MALF_TLP,	"Malformed TLP"},		\
cb9a684a Chen, Gong   2014-08-13  290  	{PCI_ERR_UNC_ECRC,	"ECRC Error"},			\
cb9a684a Chen, Gong   2014-08-13  291  	{PCI_ERR_UNC_UNSUP,	"Unsupported Request Error"},	\
cb9a684a Chen, Gong   2014-08-13  292  	{PCI_ERR_UNC_ACSV,	"ACS Violation"},		\
cb9a684a Chen, Gong   2014-08-13  293  	{PCI_ERR_UNC_INTN,	"Uncorrectable Internal Error"},\
cb9a684a Chen, Gong   2014-08-13  294  	{PCI_ERR_UNC_MCBTLP,	"MC Blocked TLP"},		\
cb9a684a Chen, Gong   2014-08-13  295  	{PCI_ERR_UNC_ATOMEG,	"AtomicOp Egress Blocked"},	\
cb9a684a Chen, Gong   2014-08-13  296  	{PCI_ERR_UNC_TLPPRE,	"TLP Prefix Blocked Error"}
0a2409aa Chen, Gong   2014-06-11  297  
0a2409aa Chen, Gong   2014-06-11 @298  TRACE_EVENT(aer_event,
0a2409aa Chen, Gong   2014-06-11  299  	TP_PROTO(const char *dev_name,
0a2409aa Chen, Gong   2014-06-11  300  		 const u32 status,
0a2409aa Chen, Gong   2014-06-11  301  		 const u8 severity),
0a2409aa Chen, Gong   2014-06-11  302  
0a2409aa Chen, Gong   2014-06-11  303  	TP_ARGS(dev_name, status, severity),
0a2409aa Chen, Gong   2014-06-11  304  
0a2409aa Chen, Gong   2014-06-11  305  	TP_STRUCT__entry(
0a2409aa Chen, Gong   2014-06-11  306  		__string(	dev_name,	dev_name	)
0a2409aa Chen, Gong   2014-06-11  307  		__field(	u32,		status		)
0a2409aa Chen, Gong   2014-06-11  308  		__field(	u8,		severity	)
0a2409aa Chen, Gong   2014-06-11  309  	),
0a2409aa Chen, Gong   2014-06-11  310  
0a2409aa Chen, Gong   2014-06-11  311  	TP_fast_assign(
0a2409aa Chen, Gong   2014-06-11  312  		__assign_str(dev_name, dev_name);
0a2409aa Chen, Gong   2014-06-11  313  		__entry->status		= status;
0a2409aa Chen, Gong   2014-06-11  314  		__entry->severity	= severity;
0a2409aa Chen, Gong   2014-06-11  315  	),
0a2409aa Chen, Gong   2014-06-11  316  
0a2409aa Chen, Gong   2014-06-11  317  	TP_printk("%s PCIe Bus Error: severity=%s, %s\n",
0a2409aa Chen, Gong   2014-06-11  318  		__get_str(dev_name),
0a2409aa Chen, Gong   2014-06-11 @319  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
0a2409aa Chen, Gong   2014-06-11 @320  			__entry->severity == AER_FATAL ?
0a2409aa Chen, Gong   2014-06-11  321  			"Fatal" : "Uncorrected, non-fatal",
0a2409aa Chen, Gong   2014-06-11  322  		__entry->severity == AER_CORRECTABLE ?
0a2409aa Chen, Gong   2014-06-11  323  		__print_flags(__entry->status, "|", aer_correctable_errors) :
0a2409aa Chen, Gong   2014-06-11  324  		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
0a2409aa Chen, Gong   2014-06-11  325  );
0a2409aa Chen, Gong   2014-06-11  326  

:::::: The code at line 319 was first introduced by commit
:::::: 0a2409aad38e97b1db55e6515b990be7b17060f6 trace, AER: Move trace into unified interface

:::::: TO: Chen, Gong <gong.chen@linux.intel.com>
:::::: CC: Tony Luck <tony.luck@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
a6CxIIQBAA==

--bg08WKrSYDhXBjb5--
