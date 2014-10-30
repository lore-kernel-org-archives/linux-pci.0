Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:40595 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752617AbaJ3TgB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 15:36:01 -0400
Date: Thu, 30 Oct 2014 13:35:38 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Mohit Kumar <mohit.kumar@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
Message-ID: <20141030193538.GK26820@obsidianresearch.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141030173914.GS1069@e106497-lin.cambridge.arm.com>
 <20141030174541.GH26820@obsidianresearch.com>
 <3532414.9PZuBnKWYz@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3532414.9PZuBnKWYz@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 08:21:40PM +0100, Arnd Bergmann wrote:

> > So how does mvebu now allocate a unique domain number per mvebu_pcie?
> 
> I believe the answer to that is that the mvebu PCIe driver currently only
> supports one domain, and it will have the unique number '0', which is the
> default.

It is like most of the the other new drivers, each mvebu_pcie_probe
expects to create a new domain with a unique bus number set for that
platform_device. AFAIK everything is uniq'd to the struct mcebu_pcie,
so there is nothing precluding the driver from being instantiated
twice.

Indeed, the way mvebu hardware works you could actually create a DT
that assigned some ports to one domain and some other ports to a
different domain, using two platform_devices. All that was missing
from the driver was to increment the domain number.

I think Lorenzo's patches improve this, at least it appears that
unique domain numbers are now being assigned, I'm not sure - I'm a
little confused how we can safely blindly apply the new domain logic
without the driver opt'ing in....

I thought older PCI platforms tended to call pci_common_init for each
physical PCI bus, and we don't want them to suddenly have non-zero
domain numbers??

Jason
