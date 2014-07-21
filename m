Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47325 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932900AbaGUPyx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jul 2014 11:54:53 -0400
Message-ID: <53CD37CA.7020308@wwwdotorg.org>
Date: Mon, 21 Jul 2014 09:54:50 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Add debugfs support
References: <1405062024-2364-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1405062024-2364-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/11/2014 01:00 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Provide a debugfs file that shows the current link status for each root
> port.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

Does this patch conflict with or merge well with the Tegra124 PCIe
driver patches, I wonder?
