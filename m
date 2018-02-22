Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:47880 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeBVOuJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 09:50:09 -0500
Date: Thu, 22 Feb 2018 22:49:43 +0800
From: kbuild test robot <lkp@intel.com>
To: Oza Pawandeep <poza@codeaurora.org>
Cc: kbuild-all@01.org, Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>, Wei Zhang <wzhang@fb.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v8 5/7] PCI/AER: Unify aer error defines at single space
Message-ID: <201802222217.yZR1q19N%fengguang.wu@intel.com>
References: <1519208804-24512-6-git-send-email-poza@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1519208804-24512-6-git-send-email-poza@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Oza,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pci/next]
[also build test WARNING on v4.16-rc2 next-20180222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Oza-Pawandeep/Address-error-and-recovery-for-AER-and-DPC/20180222-060518
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/init.h:134:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:135:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:268:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/init.h:269:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/printk.h:200:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:32:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:34:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:37:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:38:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:40:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:42:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:43:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:45:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:46:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/mem_encrypt.h:49:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/qspinlock.h:53:32: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/wait_bit.h:41:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:646:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/workqueue.h:647:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:34:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:35:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/numa.h:62:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:173:8: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/vmalloc.h:174:8: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:174:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:176:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:178:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/fixmap.h:180:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:254:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/apic.h:430:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/io_apic.h:184:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:113:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:125:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/smp.h:126:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:110:33: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:112:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:114:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:118:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/percpu.h:126:12: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:63:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:64:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:65:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:66:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/memory_hotplug.h:221:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mmzone.h:1292:15: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2421:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:2422:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/fs.h:3329:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/ras.h:20:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/ras.h:21:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/hrtimer.h:497:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/cred.h:167:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/io.h:47:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/kmemleak.h:29:33: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:29:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/kasan.h:30:6: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/pgtable.h:28:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:135:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/slab.h:716:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1753:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:1941:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2083:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/mm.h:2671:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/pci.h:1924:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/pci.h:1925:6: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/swiotlb.h:39:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/swiotlb.h:124:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:9:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:10:12: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:11:13: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/swiotlb.h:12:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/dma-contiguous.h:85:5: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/nsproxy.h:74:5: sparse: attribute 'indirect_branch': unknown attribute
   arch/x86/include/asm/vdso.h:44:13: sparse: attribute 'indirect_branch': unknown attribute
   include/linux/ftrace.h:462:6: sparse: attribute 'indirect_branch': unknown attribute
   include/trace/../../include/ras/ras_event.h:27:1: sparse: attribute 'indirect_branch': unknown attribute
   include/trace/../../include/ras/ras_event.h:98:1: sparse: attribute 'indirect_branch': unknown attribute
   include/trace/../../include/ras/ras_event.h:171:1: sparse: attribute 'indirect_branch': unknown attribute
   include/trace/../../include/ras/ras_event.h:219:1: sparse: attribute 'indirect_branch': unknown attribute
   include/trace/../../include/ras/ras_event.h:298:1: sparse: attribute 'indirect_branch': unknown attribute
   include/trace/../../include/ras/ras_event.h:385:1: sparse: attribute 'indirect_branch': unknown attribute
   drivers/ras/ras.c:29:12: sparse: attribute 'indirect_branch': unknown attribute
   drivers/ras/ras.c:47:12: sparse: attribute 'indirect_branch': unknown attribute
   include/trace/../../include/ras/ras_event.h:298:1: sparse: undefined identifier 'AER_CORRECTABLE'
>> include/trace/../../include/ras/ras_event.h:298:1: sparse: call with no type!
   In file included from include/trace/define_trace.h:96:0,
    from include/ras/ras_event.h:414,
    from drivers/ras/ras.c:15:
   include/trace/../../include/ras/ras_event.h: In function 'trace_raw_output_aer_event':
   include/trace/../../include/ras/ras_event.h:319:24: error: 'AER_CORRECTABLE' undeclared (first use in this function); did you mean
    __entry->severity == AER_CORRECTABLE "Corrected" :
    ^
   include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
    trace_seq_printf(s, print); 96- ^~~~~
   include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
    PARAMS(print)); 99- ^~~~~~
   include/trace/../../include/ras/ras_event.h:298:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(aer_event,
    ^~~~~~~~~~~
   include/trace/../../include/ras/ras_event.h:317:2: note: in expansion of macro 'TP_printk'
    TP_printk("%s PCIe Bus Error: severity=%s, %sn",
    ^~~~~~~~~
   include/trace/../../include/ras/ras_event.h:319:24: note: each undeclared identifier is reported only once for each function it appears in
    __entry->severity == AER_CORRECTABLE "Corrected" :
    ^
   include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
    trace_seq_printf(s, print); 111- ^~~~~
   include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
    PARAMS(print)); 114- ^~~~~~
   include/trace/../../include/ras/ras_event.h:298:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(aer_event,
    ^~~~~~~~~~~
   include/trace/../../include/ras/ras_event.h:317:2: note: in expansion of macro 'TP_printk'
    TP_printk("%s PCIe Bus Error: severity=%s, %sn",
    ^~~~~~~~~
   include/trace/../../include/ras/ras_event.h:320:25: error: 'AER_FATAL' undeclared (first use in this function); did you mean
    __entry->severity == AER_FATAL
    ^
   include/trace/trace_events.h:360:22: note: in definition of macro 'DECLARE_EVENT_CLASS'
    trace_seq_printf(s, print); 126- ^~~~~
   include/trace/trace_events.h:79:9: note: in expansion of macro 'PARAMS'
    PARAMS(print)); 129- ^~~~~~
   include/trace/../../include/ras/ras_event.h:298:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(aer_event,
    ^~~~~~~~~~~
   include/trace/../../include/ras/ras_event.h:317:2: note: in expansion of macro 'TP_printk'
    TP_printk("%s PCIe Bus Error: severity=%s, %sn",
    ^~~~~~~~~

vim +298 include/trace/../../include/ras/ras_event.h

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
0a2409aa Chen, Gong   2014-06-11  319  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
0a2409aa Chen, Gong   2014-06-11  320  			__entry->severity == AER_FATAL ?
0a2409aa Chen, Gong   2014-06-11  321  			"Fatal" : "Uncorrected, non-fatal",
0a2409aa Chen, Gong   2014-06-11  322  		__entry->severity == AER_CORRECTABLE ?
0a2409aa Chen, Gong   2014-06-11  323  		__print_flags(__entry->status, "|", aer_correctable_errors) :
0a2409aa Chen, Gong   2014-06-11  324  		__print_flags(__entry->status, "|", aer_uncorrectable_errors))
0a2409aa Chen, Gong   2014-06-11  325  );
0a2409aa Chen, Gong   2014-06-11  326  

:::::: The code at line 298 was first introduced by commit
:::::: 0a2409aad38e97b1db55e6515b990be7b17060f6 trace, AER: Move trace into unified interface

:::::: TO: Chen, Gong <gong.chen@linux.intel.com>
:::::: CC: Tony Luck <tony.luck@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
