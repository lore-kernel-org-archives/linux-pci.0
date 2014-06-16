Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:46581 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932496AbaFPSaa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jun 2014 14:30:30 -0400
Message-ID: <539F37C3.7070600@wwwdotorg.org>
Date: Mon, 16 Jun 2014 12:30:27 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/5] PCI: tegra: Overhaul regulator usage
References: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/28/2014 08:49 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The current device tree binding for the regulator setup on Tegra PCIe is
> not accurate. While it does work for current use-cases, that's likely by
> accident rather than design. This series replaces the existing set of
> power-supply properties with a new set that accurately describes the
> inputs of the IP block (depending on SoC generation).
> 
> As a heads-up, this breaks backwards compatibility with prior versions
> of the device tree bindings, but I don't see a reason why that should
> keep us from fixing this properly. Not many people are currently using
> these bindings and those who are are most likely tracking upstream
> development closely enough not to be impacted by this.
> 
> I've aimed to keep the series bisectible, which has the downside of
> interleaving patches to unrelated trees (ARM and PCI). I'm hoping that
> perhaps we can find a way to merge this as a whole to keep it possible
> to bisect across the series. Although again, I guess it wouldn't be all
> that bad if that wasn't the case, given how little PCIe is actually
> being used.
> 
> This second version of the series has Bjorn's Acked-by for patch 3 from
> the RFC. Stephen, it would be great if you can take this through the
> Tegra tree so that the bisectability can be preserved. I have a bunch of
> other smaller changes for the PCIe driver (mostly cleanups). I don't
> think any of them will conflict, but for extra safety Bjorn may want to
> pull this as a stable branch into his tree.

I've applied this series to Tegra's for-3.17/pcie-regulators branch.
