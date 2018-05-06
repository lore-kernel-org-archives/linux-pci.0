Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750872AbeEFGaV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 May 2018 02:30:21 -0400
Date: Sun, 6 May 2018 14:30:14 +0800
From: Baoquan He <bhe@redhat.com>
To: kbuild test robot <lkp@intel.com>
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
        linux-nvdimm@lists.01.org,
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
Message-ID: <20180506063014.GG19030@localhost.localdomain>
References: <20180419001848.3041-2-bhe@redhat.com>
 <201804261137.HPgv5SSG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201804261137.HPgv5SSG%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/26/18 at 11:23am, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17-rc2 next-20180424]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180419-223752
> config: xtensa-common_defconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=xtensa 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/xtensa/lib/pci-auto.c:22:0:
>    arch/xtensa/include/asm/pci-bridge.h: In function 'pcibios_init_resource':
> >> arch/xtensa/include/asm/pci-bridge.h:74:15: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
>      res->sibling = NULL;
>                   ^
>    arch/xtensa/include/asm/pci-bridge.h:75:13: error: incompatible types when assigning to type 'struct list_head' from type 'void *'
>      res->child = NULL;

Thanks, below fix can fix it.

diff --git a/arch/xtensa/include/asm/pci-bridge.h b/arch/xtensa/include/asm/pci-bridge.h
index 0b68c76ec1e6..f487b06817df 100644
--- a/arch/xtensa/include/asm/pci-bridge.h
+++ b/arch/xtensa/include/asm/pci-bridge.h
@@ -71,8 +71,8 @@ static inline void pcibios_init_resource(struct resource *res,
 	res->flags = flags;
 	res->name = name;
 	res->parent = NULL;
-	res->sibling = NULL;
-	res->child = NULL;
+	INIT_LIST_HEAD(&res->child);
+	INIT_LIST_HEAD(&res->sibling);
 }
 
 

>                 ^
> 
> vim +74 arch/xtensa/include/asm/pci-bridge.h
> 
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  65  
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  66  static inline void pcibios_init_resource(struct resource *res,
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  67  		unsigned long start, unsigned long end, int flags, char *name)
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  68  {
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  69  	res->start = start;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  70  	res->end = end;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  71  	res->flags = flags;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  72  	res->name = name;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  73  	res->parent = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23 @74  	res->sibling = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  75  	res->child = NULL;
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  76  }
> 9a8fd558 include/asm-xtensa/pci-bridge.h Chris Zankel 2005-06-23  77  
> 
> :::::: The code at line 74 was first introduced by commit
> :::::: 9a8fd5589902153a134111ed7a40f9cca1f83254 [PATCH] xtensa: Architecture support for Tensilica Xtensa Part 6
> 
> :::::: TO: Chris Zankel <czankel@tensilica.com>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
