Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:54606 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbcAMADW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jan 2016 19:03:22 -0500
Date: Wed, 13 Jan 2016 08:02:44 +0800
From: kbuild test robot <lkp@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH] driver: add manual_bind_only option for virtual stub
 drivers
Message-ID: <201601130839.F6TIl0PS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
In-Reply-To: <1452634390-17729-2-git-send-email-jacob.e.keller@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jacob,

[auto build test WARNING on vfio/next]
[also build test WARNING on v4.4 next-20160112]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Keller/driver-add-manual_bind_only-option-for-virtual-stub-drivers/20160113-053451
base:   https://github.com/awilliam/linux-vfio.git next
reproduce: make htmldocs

All warnings (new ones prefixed by >>):

   include/linux/init.h:1: warning: no structured comments found
   kernel/sys.c:1: warning: no structured comments found
>> include/linux/device.h:283: warning: No description found for parameter 'manual_bind_only'
   drivers/dma-buf/seqno-fence.c:1: warning: no structured comments found
   drivers/dma-buf/reservation.c:1: warning: no structured comments found
   include/linux/reservation.h:1: warning: no structured comments found
   include/linux/hsi/hsi.h:150: warning: Excess struct/union/enum/typedef member 'e_handler' description in 'hsi_client'
   include/linux/hsi/hsi.h:150: warning: Excess struct/union/enum/typedef member 'pclaimed' description in 'hsi_client'
   include/linux/hsi/hsi.h:150: warning: Excess struct/union/enum/typedef member 'nb' description in 'hsi_client'

vim +/manual_bind_only +283 include/linux/device.h

f98ec3ac Jacob Keller       2016-01-12  267  	bool manual_bind_only;		/* prevent bind on driver_attach */
765230b5 Dmitry Torokhov    2015-03-30  268  	enum probe_type probe_type;
1a6f2a75 Dmitry Torokhov    2009-10-12  269  
597b9d1e Grant Likely       2010-04-13  270  	const struct of_device_id	*of_match_table;
06f64c8f Mika Westerberg    2012-10-31  271  	const struct acpi_device_id	*acpi_match_table;
597b9d1e Grant Likely       2010-04-13  272  
^1da177e Linus Torvalds     2005-04-16  273  	int (*probe) (struct device *dev);
^1da177e Linus Torvalds     2005-04-16  274  	int (*remove) (struct device *dev);
^1da177e Linus Torvalds     2005-04-16  275  	void (*shutdown) (struct device *dev);
9480e307 Russell King       2005-10-28  276  	int (*suspend) (struct device *dev, pm_message_t state);
9480e307 Russell King       2005-10-28  277  	int (*resume) (struct device *dev);
a4dbd674 David Brownell     2009-06-24  278  	const struct attribute_group **groups;
e5dd1278 Greg Kroah-Hartman 2007-11-28  279  
8150f32b Dmitry Torokhov    2009-07-24  280  	const struct dev_pm_ops *pm;
1eede070 Rafael J. Wysocki  2008-05-20  281  
e5dd1278 Greg Kroah-Hartman 2007-11-28  282  	struct driver_private *p;
^1da177e Linus Torvalds     2005-04-16 @283  };
^1da177e Linus Torvalds     2005-04-16  284  
^1da177e Linus Torvalds     2005-04-16  285  
4a7fb636 Andrew Morton      2006-08-14  286  extern int __must_check driver_register(struct device_driver *drv);
^1da177e Linus Torvalds     2005-04-16  287  extern void driver_unregister(struct device_driver *drv);
^1da177e Linus Torvalds     2005-04-16  288  
d462943a Greg Kroah-Hartman 2008-01-24  289  extern struct device_driver *driver_find(const char *name,
d462943a Greg Kroah-Hartman 2008-01-24  290  					 struct bus_type *bus);
d779249e Greg Kroah-Hartman 2006-07-18  291  extern int driver_probe_done(void);

:::::: The code at line 283 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--huq684BweRXVnRxX
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9Ae3BCuMilzKhb0Sgv/R/Ju4cVYAAA==

--huq684BweRXVnRxX--
