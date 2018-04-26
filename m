Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga18.intel.com ([134.134.136.126]:38662 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbeDZDYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Apr 2018 23:24:30 -0400
Date: Thu, 26 Apr 2018 11:23:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, nicolas.pitre@linaro.org,
        josh@joshtriplett.org, Brijesh Singh <brijesh.singh@amd.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-pci@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Baoquan He <bhe@redhat.com>, linux-nvdimm@lists.01.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        linux-input@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devel@linuxdriverproject.org
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <201804261137.HPgv5SSG%fengguang.wu@intel.com>
References: <20180419001848.3041-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <20180419001848.3041-2-bhe@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc2 next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180419-223752
config: xtensa-common_defconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   In file included from arch/xtensa/lib/pci-auto.c:22:0:
   arch/xtensa/include/asm/pci-bridge.h: In function 'pcibios_init_resource':
>> arch/xtensa/include/asm/pci-bridge.h:74:15: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
     res->sibling = NULL;
                  ^
   arch/xtensa/include/asm/pci-bridge.h:75:13: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
     res->child = NULL;
                ^

vim +74 arch/xtensa/include/asm/pci-bridge.h

9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  65  
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  66  static inline void pcibios_init_resource(struct resource *res,
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  67  		unsigned long start, unsigned long end, int flags, char *name)
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  68  {
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  69  	res->start = start;
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  70  	res->end = end;
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  71  	res->flags = flags;
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  72  	res->name = name;
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  73  	res->parent = NULL;
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23 @74  	res->sibling = NULL;
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  75  	res->child = NULL;
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  76  }
9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  77  

:::::: The code at line 74 was first introduced by commit
:::::: 9a8fd5589902153a134111ed7a40f9cca1f83254 [PATCH] xtensa: Architecture support for Tensilica Xtensa Part 6

:::::: TO: Chris Zankel <czankel@tensilica.com>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
JNVL/w+8yZEIpJgAAA==

--VbJkn9YxBvnuCH5J--
