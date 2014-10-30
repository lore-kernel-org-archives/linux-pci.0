Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:44486 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbaJ3Q0F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 12:26:05 -0400
Date: Thu, 30 Oct 2014 10:25:52 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	liviu.dudau@arm.com, Krzysztof Halasa <khalasa@piap.pl>,
	Anton Vorontsov <avorontsov@mvista.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
Message-ID: <20141030162552.GC26820@obsidianresearch.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 11:44:46AM +0000, Lorenzo Pieralisi wrote:

> Code in drivers/pci/pci-mvebu.c has been changed to add a domain
> number to PCI resources by using the nr value coming from the setup
> pcibios32 callback, which may not be correct and should be considered
> a temporary solution waiting for review comments.

The intent of the string was to have the domain number so that
resources in /proc/iomem can be correlated with lspci.

This would be a 'best practice' - all PCI drivers need to request
resource, and the resource should be relatable back to the PCI
domain... So it would be best if the domain number was available at
this point in a driver's flow.

> -       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x",
> -                domain);
> +       snprintf(pcie->mem_name, sizeof(pcie->mem_name), "PCI MEM %04x", nr);

I'm not sure what 'nr' is in this context, if it is not the domain
number then I'd just drop the 0x04x entirely rather than include
some nonsense number...

Jason
