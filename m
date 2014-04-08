Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44130 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756222AbaDHTVw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Apr 2014 15:21:52 -0400
Message-ID: <53444C4D.2080800@wwwdotorg.org>
Date: Tue, 08 Apr 2014 13:21:49 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <treding@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
CC: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [RFC 0/5] PCI: tegra: Overhaul regulator usage
References: <1396622969-17837-1-git-send-email-treding@nvidia.com>
In-Reply-To: <1396622969-17837-1-git-send-email-treding@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/04/2014 08:49 AM, Thierry Reding wrote:
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

I'd be happy to put this series into a branch in the Tegra tree, given
suitable acks from Bjorn on the PCI changes.
