Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:51033 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758649AbaJ3QVd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 12:21:33 -0400
Date: Thu, 30 Oct 2014 16:21:17 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
Message-ID: <20141030162117.GB2048@red-moon>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
 <54522EA1.20707@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54522EA1.20707@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 12:27:13PM +0000, Yijing Wang wrote:
> On 2014/10/30 19:44, Lorenzo Pieralisi wrote:
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
> 
> Nice clean up.
> 
> Reviewed-by: Yijing Wang <wangyijing@huawei.com>

Thank you Yijing !
Lorenzo
