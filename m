Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:65288 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759255AbaJ3Lzp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 07:55:45 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>, liviu.dudau@arm.com,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
Date: Thu, 30 Oct 2014 12:55:31 +0100
Message-ID: <1803568.ShmHEYg5Ky@wuerfel>
In-Reply-To: <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com> <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 30 October 2014 11:44:48 Lorenzo Pieralisi wrote:
> Most if not all ARM PCI host controller device drivers either ignore the
> domain field in the pci_sys_data structure or just increment it every
> time a host controller is probed, using it as a domain counter.
> 
> Therefore, instead of relying on pci_sys_data to stash the domain number
> in a standard location, ARM pcibios code can be moved to the newly
> introduced generic PCI domains code, implemented in commits:
> 
> commit 41e5c0f81d3e676d671d96a0a1fafb27abfbd9
> ("of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr()")
> 
> commit 670ba0c8883b576d0aec28bd7a838358a4be1
> ("PCI: Add generic domain handling")
> 
> In order to assign a domain number dynamically, the ARM pcibios defines
> the function, called by core PCI code:
> 
> void pci_bus_assign_domain_nr(...)
> 
> that relies on a DT property to define the domain number or falls back to
> a counter; its usage replaces the current domain assignment code in PCI
> host controllers present in the kernel.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

Very nice!
