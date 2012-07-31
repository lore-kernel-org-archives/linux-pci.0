Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46160 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755205Ab2GaQST (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jul 2012 12:18:19 -0400
Message-ID: <50180547.9040603@wwwdotorg.org>
Date: Tue, 31 Jul 2012 10:18:15 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Mitch Bradley <wmb@firmworks.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 00/10] ARM: tegra: Add PCIe device tree support
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/26/2012 01:55 PM, Thierry Reding wrote:
> This patch series adds support for device tree based probing of the PCIe
> controller found on Tegra SoCs.

Thierry,

I think one thing that would help here would be to split up this series
into one per subsystem, and to get all the dependencies merged by the
respective maintainers. Preferably, each subsystem would export a stable
branch (perhaps consisting of just these patches) that I can then merge
into the Tegra tree and use as a basis for the PCIe driver itself.
Hopefully this approach will get more traction on all the non-Tegra
changes. Does that sound like a good plan?

Or, I can just take it all through the Tegra tree, but I'll definitely
need acks on all/most of the non-Tegra patches, since although the
patches themselves are quite small, I'd like to be sure that maintainers
are OK with the conceptual changes, like initializing PCI controllers
later than at present etc.
