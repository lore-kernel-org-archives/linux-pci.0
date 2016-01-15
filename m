Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57910 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751621AbcAOXcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jan 2016 18:32:45 -0500
Date: Fri, 15 Jan 2016 17:32:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Simon Horman <simon.horman@netronome.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: Limit config space size for Netronome NFP4000
Message-ID: <20160115233241.GC14080@localhost>
References: <1449801012-10432-1-git-send-email-simon.horman@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1449801012-10432-1-git-send-email-simon.horman@netronome.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 11, 2015 at 11:30:10AM +0900, Simon Horman wrote:
> Like the NFP6000 the NFP4000 as an erratum where reading/writing to PCI
> config space addresses above 0x600 can cause the NFP to generate PCIe
> completion timeouts.
> 
> This short series extends usage quirk_nfp6000, which handles the above
> problem by limiting config space size to 0x600 bytes, to the NFP4000.
> 
> Compile tested on top of the pci/misc branch.
> 
> Simon Horman (2):
>   PCI: Add Netronome NFP4000 device ID
>   PCI: Limit config space size for Netronome NFP4000
> 
>  drivers/pci/quirks.c    | 1 +
>  include/linux/pci_ids.h | 1 +
>  2 files changed, 2 insertions(+)

Applied to pci/misc for v4.5, thanks, Simon.
