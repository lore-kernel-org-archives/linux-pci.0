Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40362 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932751AbaE2Rsr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 May 2014 13:48:47 -0400
Message-ID: <538772FD.40407@wwwdotorg.org>
Date: Thu, 29 May 2014 11:48:45 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI: tegra: Overhaul regulator usage
References: <1401288555-24197-1-git-send-email-thierry.reding@gmail.com> <1401288555-24197-2-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1401288555-24197-2-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/28/2014 08:49 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The current usage of regulators for the Tegra PCIe block is wrong. It
> doesn't accurately reflect the actual supply inputs of the IP block and
> therefore isn't as flexible as it should be. Rectify this by describing
> all possible supply inputs in the device tree binding documentation and
> deprecate the old supply properties.

The series looks fine to me at a quick glance. Since Bjorn has ack'd the
PCIe driver patch, I'll apply this to the Tegra tree for 3.17. I'll put
it into a topic branch in case it needs to be merged into the PCI tree
to resolve any conflicts.
