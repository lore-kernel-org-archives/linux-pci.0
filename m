Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58111 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbaGUP6G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jul 2014 11:58:06 -0400
Message-ID: <53CD388A.7090006@wwwdotorg.org>
Date: Mon, 21 Jul 2014 09:58:02 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: tegra: Implement a proper resource hierarchy
References: <1405062505-2606-1-git-send-email-thierry.reding@gmail.com> <1405062505-2606-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1405062505-2606-2-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/11/2014 01:08 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Currently the resource hierarchy generated from the PCIe host bridge is
> completely flat:
...
> The host bridge driver doesn't request all the resources that are used.
> Windows allocated to each of the root ports aren't tracked, so there is
> no way for resources allocated to individual devices to be matched up
> with the correct parent resource by the PCI core.
> 
> This patch addresses this in two steps. It first takes the union of all
> regions associated with the PCIe host bridge (control registers, root
> port registers, configuration space, I/O and prefetchable as well as
> non-prefetchable memory regions) and uses it as the new root of the
> resource hierarchy.

This patch briefly,
Reviewed-by: Stephen Warren <swarren@nvidia.com>
