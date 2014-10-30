Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:38889 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933737AbaJ3Rpw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 30 Oct 2014 13:45:52 -0400
Date: Thu, 30 Oct 2014 11:45:41 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Krzysztof Halasa <khalasa@piap.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [RFC PATCH 0/2] arm: pcibios: remove pci_sys_data domain
Message-ID: <20141030174541.GH26820@obsidianresearch.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141030162552.GC26820@obsidianresearch.com>
 <20141030165246.GC2048@red-moon>
 <20141030170305.GE26820@obsidianresearch.com>
 <20141030173914.GS1069@e106497-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141030173914.GS1069@e106497-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 30, 2014 at 05:39:15PM +0000, Liviu Dudau wrote:

> But of_pci_get_host_bridge_resources() does not request the resources, it only
> creates them out of the DT ranges. If/when the driver decides the list of
> resources is correct and it can work with it can also request them and use
> whatever domain number allocation strategy it wants (auto-incrementing or DT
> based). So I don't think the global sequencing is broken here.

So how does mvebu now allocate a unique domain number per mvebu_pcie?

Which hw_pci callback should do that?

Jason
