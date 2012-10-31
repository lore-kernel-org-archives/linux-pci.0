Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106]:56885 "EHLO
	e06smtp10.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710Ab2JaWGH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 18:06:07 -0400
Received: from /spool/local
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <arnd@arndb.de>;
	Wed, 31 Oct 2012 22:06:05 -0000
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q9VM5twF60358786
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 22:05:55 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q9VM61eK010182
	for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 16:06:02 -0600
From: Arnd Bergmann <arnd@arndb.de>
To: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH 03/15] SPEAr13xx: Add mach/io.h
Date: Wed, 31 Oct 2012 22:05:14 +0000
Cc: viresh kumar <viresh.kumar@linaro.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	"spear-devel" <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
References: <cover.1351492562.git.pratyush.anand@st.com> <201210302145.47011.arnd@arndb.de> <50910A70.7050209@st.com>
In-Reply-To: <50910A70.7050209@st.com>
MIME-Version: 1.0
Message-Id: <201210312205.14399.arnd@arndb.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 31 October 2012, Pratyush Anand wrote:
> Sorry, I could not find pci_ioremap_io function. May be you wanted to 
> refer something else.

$ git grep pci_ioremap_io
arch/arm/include/asm/io.h:extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
arch/arm/mach-dove/pcie.c:              pci_ioremap_io(sys->busnr * SZ_64K, DOVE_PCIE0_IO_PHYS_BASE);
...
arch/arm/mach-versatile/pci.c:  ret = pci_ioremap_io(0, VERSATILE_PCI_MEM_BASE0);
arch/arm/mm/ioremap.c:int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
arch/arm/mm/ioremap.c:EXPORT_SYMBOL_GPL(pci_ioremap_io);


> In case of SPEAr too , we can reserve first 32Kb per controller as PCIe 
> IO space. So, lets say I fixed address 0x80000000--0x80007FFF for IO 
> transaction. I need to register address range of this window somehow.
> 
> But, issue which faced was that I was not able to successfully 
> request_resource(&ioport_resource, &res]) with res.start = 0x80000000 
> and res.end = 0x80007fff.

That cannot work properly, because the ioport_resource lists ports between
0 and 0x10000 normally, or possibly a little bit higher. You certainly
don't want to waste 2 GB of virtual address space for having a PCI I/O window
that you don't use.

> So, I though first to change IO_SPACE_LIMIT. But I found it not a 
> correct way.
> 
> May be I am missing something and not able to get how can I use 
> pci_ioremap_io or something else to register 0x80000000--0x80007FFF 
> window. A reference will help.

Calling pci_ioremap_io will do the right thing, you just have to decide
how you partition the I/O space between the root complexes you have.

	Arnd

