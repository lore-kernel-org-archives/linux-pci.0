Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750919AbcLAWJF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 17:09:05 -0500
Date: Thu, 1 Dec 2016 16:09:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Tomasz Nowicki <tn@semihalf.com>, kbuild-all@01.org,
        linux-pci@vger.kernel.org
Subject: Re: [pci:pci/ecam 6/13] arch/arm64/kernel/pci.c:128:2: error:
 expected '=', ',', ';', 'asm' or '__attribute__' before 'struct'
Message-ID: <20161201220901.GA15867@bhelgaas-glaptop.roam.corp.google.com>
References: <201612020535.QazToTo0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201612020535.QazToTo0%fengguang.wu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 02, 2016 at 05:56:44AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ecam
> head:   f80edf4d6c053d529b4f044f867f8269f0050c72
> commit: b13e44a1ff3af460ce7770face55ff1dc802efcf [6/13] PCI/ACPI: Extend pci_mcfg_lookup() to return ECAM config accessors
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b13e44a1ff3af460ce7770face55ff1dc802efcf
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/arm64/kernel/pci.c: In function 'pci_acpi_setup_ecam_mapping':
> >> arch/arm64/kernel/pci.c:128:2: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'struct'
>      struct resource cfgres;
>      ^~~~~~
> >> arch/arm64/kernel/pci.c:134:40: error: 'ecam_ops' undeclared (first use in this function)
>      ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
>                                            ^~~~~~~~
>    arch/arm64/kernel/pci.c:134:40: note: each undeclared identifier is reported only once for each function it appears in
>    arch/arm64/kernel/pci.c:131:15: warning: unused variable 'bsz' [-Wunused-variable]
>      unsigned int bsz;
>                   ^~~
> 
> vim +128 arch/arm64/kernel/pci.c
> 
> 0cb0786b Tomasz Nowicki 2016-06-10  122  pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> 0cb0786b Tomasz Nowicki 2016-06-10  123  {
> 1725c4a5 Bjorn Helgaas  2016-12-01  124  	struct device *dev = &root->device->dev;
> 0cb0786b Tomasz Nowicki 2016-06-10  125  	struct resource *bus_res = &root->secondary;
> 0cb0786b Tomasz Nowicki 2016-06-10  126  	u16 seg = root->segment;
> b13e44a1 Tomasz Nowicki 2016-09-09  127  	struct pci_ecam_ops *ecam_ops
> 0cb0786b Tomasz Nowicki 2016-06-10 @128  	struct resource cfgres;

Sorry, I broke this when I moved the acpi_resource_consumer() call here.
I added the missing semicolon.
