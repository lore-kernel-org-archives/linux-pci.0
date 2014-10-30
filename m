Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:54612 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214AbaJ3TW2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Oct 2014 15:22:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
Date: Thu, 30 Oct 2014 20:21:40 +0100
Message-ID: <3532414.9PZuBnKWYz@wuerfel>
In-Reply-To: <20141030174541.GH26820@obsidianresearch.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com> <20141030173914.GS1069@e106497-lin.cambridge.arm.com> <20141030174541.GH26820@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 30 October 2014 11:45:41 Jason Gunthorpe wrote:
> On Thu, Oct 30, 2014 at 05:39:15PM +0000, Liviu Dudau wrote:
> 
> > But of_pci_get_host_bridge_resources() does not request the resources, it only
> > creates them out of the DT ranges. If/when the driver decides the list of
> > resources is correct and it can work with it can also request them and use
> > whatever domain number allocation strategy it wants (auto-incrementing or DT
> > based). So I don't think the global sequencing is broken here.
> 
> So how does mvebu now allocate a unique domain number per mvebu_pcie?

I believe the answer to that is that the mvebu PCIe driver currently only
supports one domain, and it will have the unique number '0', which is the
default.

> Which hw_pci callback should do that?

I think the purpose Lorenzo's patches (more to come) is to obsolete all
of the hw_pci callbacks for modern drivers.

	Arnd
