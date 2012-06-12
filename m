Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47438 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab2FLPkZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 11:40:25 -0400
Message-ID: <4FD762E6.2080906@wwwdotorg.org>
Date: Tue, 12 Jun 2012 09:40:22 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de> <4FD660F9.7030807@wwwdotorg.org> <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de> <20120612061003.GC4040@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120612061003.GC4040@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/12/2012 12:10 AM, Thierry Reding wrote:
> * Thierry Reding wrote:
>> * Stephen Warren wrote:
>>> On 06/11/2012 09:05 AM, Thierry Reding wrote:
> [...]
>>>> +static int tegra_pcie_disable_msi(struct platform_device
>>>> *pdev)
>>> 
>>> Should this free pcie->msi->pages?
>> 
>> Yes it should. I actually mention making that change in the
>> changelog but in fact didn't.
> 
> This is really moot because the driver cannot be built as a module
> currently because arch_setup_msi_irq() and arch_teardown_msi_irq()
> need to be built-in so tegra_pcie_disable_msi() will be called only
> just before the machine is shut down.
> 
> Perhaps this is something that should be addressed? Or is it just
> not worth the effort?

Well, if the driver provides a shutdown/removal path at all, it seems
like it should be complete. I assume it's trivial to free those pages?
