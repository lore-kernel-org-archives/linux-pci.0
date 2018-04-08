Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 8 Apr 2018 17:09:44 +0800
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
Message-ID: <20180408090944.GF19345@localhost.localdomain>
References: <20180408024724.16812-2-bhe@redhat.com>
 <201804081223.lLuGQOqa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201804081223.lLuGQOqa%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/18 at 01:55pm, kbuild test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.16 next-20180406]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180408-110108
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=sparc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/sparc/kernel/ioport.c: In function 'sparc_io_proc_show':
> >> arch/sparc/kernel/ioport.c:672:9: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
>      for (r = root->child; r != NULL; r = r->sibling) {
>             ^
>    arch/sparc/kernel/ioport.c:672:37: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
>      for (r = root->child; r != NULL; r = r->sibling) {
>                                         ^

Thanks, will change and repost.

> 
> vim +672 arch/sparc/kernel/ioport.c
> 
> ^1da177e4 Linus Torvalds     2005-04-16  666  
> e7a088f93 Alexey Dobriyan    2009-09-01  667  static int sparc_io_proc_show(struct seq_file *m, void *v)
> ^1da177e4 Linus Torvalds     2005-04-16  668  {
> e7a088f93 Alexey Dobriyan    2009-09-01  669  	struct resource *root = m->private, *r;
> ^1da177e4 Linus Torvalds     2005-04-16  670  	const char *nm;
> ^1da177e4 Linus Torvalds     2005-04-16  671  
> e7a088f93 Alexey Dobriyan    2009-09-01 @672  	for (r = root->child; r != NULL; r = r->sibling) {
> c31f76518 Sam Ravnborg       2014-04-21  673  		if ((nm = r->name) == NULL) nm = "???";
> e7a088f93 Alexey Dobriyan    2009-09-01  674  		seq_printf(m, "%016llx-%016llx: %s\n",
> 685143ac1 Greg Kroah-Hartman 2006-06-12  675  				(unsigned long long)r->start,
> 685143ac1 Greg Kroah-Hartman 2006-06-12  676  				(unsigned long long)r->end, nm);
> ^1da177e4 Linus Torvalds     2005-04-16  677  	}
> ^1da177e4 Linus Torvalds     2005-04-16  678  
> e7a088f93 Alexey Dobriyan    2009-09-01  679  	return 0;
> ^1da177e4 Linus Torvalds     2005-04-16  680  }
> ^1da177e4 Linus Torvalds     2005-04-16  681  
> 
> :::::: The code at line 672 was first introduced by commit
> :::::: e7a088f935180b90cfe6ab0aaae8a556f46885fe sparc: convert /proc/io_map, /proc/dvma_map to seq_file
> 
> :::::: TO: Alexey Dobriyan <adobriyan@gmail.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
