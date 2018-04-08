Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 8 Apr 2018 13:55:51 +0800
From: kbuild test robot <lkp@intel.com>
To: Baoquan He <bhe@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>,
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
Message-ID: <201804081223.lLuGQOqa%fengguang.wu@intel.com>
References: <20180408024724.16812-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <20180408024724.16812-2-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Baoquan,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16 next-20180406]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baoquan-He/resource-Use-list_head-to-link-sibling-resource/20180408-110108
config: sparc-defconfig (attached as .config)
compiler: sparc-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc 

All errors (new ones prefixed by >>):

   arch/sparc/kernel/ioport.c: In function 'sparc_io_proc_show':
>> arch/sparc/kernel/ioport.c:672:9: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
     for (r = root->child; r != NULL; r = r->sibling) {
            ^
   arch/sparc/kernel/ioport.c:672:37: error: incompatible types when assigning to type 'struct resource *' from type 'struct list_head'
     for (r = root->child; r != NULL; r = r->sibling) {
                                        ^

vim +672 arch/sparc/kernel/ioport.c

^1da177e4 Linus Torvalds     2005-04-16  666  
e7a088f93 Alexey Dobriyan    2009-09-01  667  static int sparc_io_proc_show(struct seq_file *m, void *v)
^1da177e4 Linus Torvalds     2005-04-16  668  {
e7a088f93 Alexey Dobriyan    2009-09-01  669  	struct resource *root = m->private, *r;
^1da177e4 Linus Torvalds     2005-04-16  670  	const char *nm;
^1da177e4 Linus Torvalds     2005-04-16  671  
e7a088f93 Alexey Dobriyan    2009-09-01 @672  	for (r = root->child; r != NULL; r = r->sibling) {
c31f76518 Sam Ravnborg       2014-04-21  673  		if ((nm = r->name) == NULL) nm = "???";
e7a088f93 Alexey Dobriyan    2009-09-01  674  		seq_printf(m, "%016llx-%016llx: %s\n",
685143ac1 Greg Kroah-Hartman 2006-06-12  675  				(unsigned long long)r->start,
685143ac1 Greg Kroah-Hartman 2006-06-12  676  				(unsigned long long)r->end, nm);
^1da177e4 Linus Torvalds     2005-04-16  677  	}
^1da177e4 Linus Torvalds     2005-04-16  678  
e7a088f93 Alexey Dobriyan    2009-09-01  679  	return 0;
^1da177e4 Linus Torvalds     2005-04-16  680  }
^1da177e4 Linus Torvalds     2005-04-16  681  

:::::: The code at line 672 was first introduced by commit
:::::: e7a088f935180b90cfe6ab0aaae8a556f46885fe sparc: convert /proc/io_map, /proc/dvma_map to seq_file

:::::: TO: Alexey Dobriyan <adobriyan@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
EJNVwxIlRqNbM5k0ymRs+v8/bIvUCpazAAA=

--bg08WKrSYDhXBjb5--
