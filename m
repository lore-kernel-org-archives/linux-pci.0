Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 8 Apr 2018 17:09:03 +0800
From: Baoquan He <bhe@redhat.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        devel@linuxdriverproject.org, linux-input@vger.kernel.org,
        linux-nvdimm@lists.01.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180408090903.GE19345@localhost.localdomain>
References: <20180408024724.16812-2-bhe@redhat.com>
 <201804081247.F3eqBMih%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201804081247.F3eqBMih%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Thanks for telling!

On 04/08/18 at 12:12pm, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16 next-20180406]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180408-110108
> config: parisc-c3000_defconfig (attached as .config)
> compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=parisc 
> 
> All errors (new ones prefixed by >>):
> 
>    drivers//parisc/lba_pci.c: In function 'lba_dump_res':
> >> drivers//parisc/lba_pci.c:173:15: error: incompatible type for argument 1 of 'lba_dump_res'
>      lba_dump_res(r->child, d+2);

I compiled with allyesconfig, don't know why this was missed. Will
change and repost.

>                   ^
>    drivers//parisc/lba_pci.c:162:1: note: expected 'struct resource *' but argument is of type 'struct list_head'
>     lba_dump_res(struct resource *r, int d)
>     ^~~~~~~~~~~~
>    drivers//parisc/lba_pci.c:174:15: error: incompatible type for argument 1 of 'lba_dump_res'
>      lba_dump_res(r->sibling, d);
>                   ^
>    drivers//parisc/lba_pci.c:162:1: note: expected 'struct resource *' but argument is of type 'struct list_head'
>     lba_dump_res(struct resource *r, int d)
>     ^~~~~~~~~~~~
> 
> vim +/lba_dump_res +173 drivers//parisc/lba_pci.c
> 
> ^1da177e Linus Torvalds 2005-04-16  159  
> ^1da177e Linus Torvalds 2005-04-16  160  
> ^1da177e Linus Torvalds 2005-04-16  161  static void
> ^1da177e Linus Torvalds 2005-04-16  162  lba_dump_res(struct resource *r, int d)
> ^1da177e Linus Torvalds 2005-04-16  163  {
> ^1da177e Linus Torvalds 2005-04-16  164  	int i;
> ^1da177e Linus Torvalds 2005-04-16  165  
> ^1da177e Linus Torvalds 2005-04-16  166  	if (NULL == r)
> ^1da177e Linus Torvalds 2005-04-16  167  		return;
> ^1da177e Linus Torvalds 2005-04-16  168  
> ^1da177e Linus Torvalds 2005-04-16  169  	printk(KERN_DEBUG "(%p)", r->parent);
> ^1da177e Linus Torvalds 2005-04-16  170  	for (i = d; i ; --i) printk(" ");
> 645d11d4 Matthew Wilcox 2006-12-24  171  	printk(KERN_DEBUG "%p [%lx,%lx]/%lx\n", r,
> 645d11d4 Matthew Wilcox 2006-12-24  172  		(long)r->start, (long)r->end, r->flags);
> ^1da177e Linus Torvalds 2005-04-16 @173  	lba_dump_res(r->child, d+2);
> ^1da177e Linus Torvalds 2005-04-16  174  	lba_dump_res(r->sibling, d);
> ^1da177e Linus Torvalds 2005-04-16  175  }
> ^1da177e Linus Torvalds 2005-04-16  176  
> 
> :::::: The code at line 173 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
