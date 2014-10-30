Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51016 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126AbaJ3QUc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 12:20:32 -0400
Date: Thu, 30 Oct 2014 16:20:22 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
Message-ID: <20141030162022.GA2048@red-moon>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
 <1803568.ShmHEYg5Ky@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1803568.ShmHEYg5Ky@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 11:55:31AM +0000, Arnd Bergmann wrote:
> On Thursday 30 October 2014 11:44:48 Lorenzo Pieralisi wrote:
> > Most if not all ARM PCI host controller device drivers either ignore the
> > domain field in the pci_sys_data structure or just increment it every
> > time a host controller is probed, using it as a domain counter.
> > 
> > Therefore, instead of relying on pci_sys_data to stash the domain number
> > in a standard location, ARM pcibios code can be moved to the newly
> > introduced generic PCI domains code, implemented in commits:
> > 
> > commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
> > ("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")
> > 
> > commit 670ba0c8883b576d0aec28bd7a838358a4be1
> > ("PCI: Add generic domain handling")
> > 
> > In order to assign a domain number dynamically, the ARM pcibios defines
> > the function, called by core PCI code:
> > 
> > void pci_bus_assign_domain_nr(...)
> > 
> > that relies on a DT property to define the domain number or falls back to
> > a counter; its usage replaces the current domain assignment code in PCI
> > host controllers present in the kernel.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Mohit Kumar <mohit.kumar@st.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > 
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Very nice!

Thank you very much, I would be grateful if Jason, Jingoo, and Phil can
give the patch a go on the respective platforms and hopefully I will add
their tested-by tags.

I guess pci_sys_data.add_bus pointer is the next to go :)

Lorenzo
