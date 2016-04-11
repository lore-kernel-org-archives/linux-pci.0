Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37430 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbcDKRix (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 13:38:53 -0400
Subject: Re: [PATCH v4 1/2] dt-bindings: pci: tegra: Update for per-lane PHYs
To: Thierry Reding <thierry.reding@gmail.com>
References: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <570BE129.40907@wwwdotorg.org>
Date: Mon, 11 Apr 2016 11:38:49 -0600
MIME-Version: 1.0
In-Reply-To: <1460131994-24493-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/08/2016 10:13 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> Changes to the pad controller device tree binding have required that
> each lane be associated with a separate PHY. Update the PCI host bridge
> device tree binding to allow each root port to define the list of PHYs
> required to drive the lanes associated with it.

I think the feedback I gave on v3 still applies here (I'm talking about 
the comments on the patch, not the commit description).

http://www.spinics.net/lists/linux-pci/msg49718.html

