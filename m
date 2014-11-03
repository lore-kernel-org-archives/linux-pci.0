Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:52033 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbaKCLGt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Nov 2014 06:06:49 -0500
Date: Mon, 3 Nov 2014 11:06:41 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>,
	Simon Horman <simon@horms.net>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
Message-ID: <20141103110641.GA24433@red-moon>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
 <b095e031880c44f0b79c8c42bc8d7bd5@SIXPR06MB0639.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b095e031880c44f0b79c8c42bc8d7bd5@SIXPR06MB0639.apcprd06.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Phil,

On Fri, Oct 31, 2014 at 01:43:49PM +0000, Phil Edworthy wrote:
> Hi Lorenzo,
> 
> On 30 October 2014 11:45, Lorenzo wrote:
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
> 
> This patch fixes a current problem with R-Car devices where there is an
> internal PCI bridge and an external PCIe bridge on the devices. Both drivers
> work independently but need to be on different domains. Just needed to enable
> PCI_DOMAINS along with this.
> I've done basic testing that the internal PCI and external PCIe work at the
> same time.
> 
> Acked-by: Phil Edworthy <phil.edworthy@renesas.com>

Thank you very much.

Lorenzo
