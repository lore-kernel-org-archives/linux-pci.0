Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51294 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbcBWSRy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Feb 2016 13:17:54 -0500
Subject: Re: [PATCH v2] PCI: tegra: Support per-lane PHYs
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
References: <1455029465-9211-1-git-send-email-thierry.reding@gmail.com>
 <1455904860-29090-1-git-send-email-thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <56CCA250.2010403@wwwdotorg.org>
Date: Tue, 23 Feb 2016 11:17:52 -0700
MIME-Version: 1.0
In-Reply-To: <1455904860-29090-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/19/2016 11:01 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The current XUSB pad controller bindings are insufficient to describe
> PHY devices attached to USB controllers. New bindings have been created
> to overcome these restrictions. As a side-effect each root port now is
> assigned a set of PHY devices, one for each lane associated with the
> root port. This has the benefit of allowing fine-grained control of the
> power management for each lane.

Overall this change looks OK. However, since it encodes aspects of the 
DT binding (i.e. that the per-port nodes have a phys property in the new 
scheme), I think it can't be applied until the related DT binding change 
is accepted.

> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c

> @@ -883,14 +904,24 @@ static int tegra_pcie_enable_controller(struct tegra_pcie *pcie)

> +	if (of_get_property(pcie->dev->of_node, "phys", NULL) == NULL) {

Rather than re-parsing DT to determine this, thus duplicating the logic, 
can't the code store some flag in tegra_pcie_phys_get() indicating which 
path was taken, and that flag used here? Perhaps that flag could be 
based on whether pcie->phy is set, although the else block here implies 
that particular solution won't work.
