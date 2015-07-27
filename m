Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50913 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbbG0M5v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 08:57:51 -0400
Date: Mon, 27 Jul 2015 14:57:43 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 10/11] PCI: Stop caching ATS Invalidate Queue Depth
Message-ID: <20150727125743.GE27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001511.28145.29144.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001511.28145.29144.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:15:11PM -0500, Bjorn Helgaas wrote:
> Stop caching the Invalidate Queue Depth in struct pci_dev.
> pci_ats_queue_depth() is typically called only once per device, and it
> returns a fixed value per-device, so callers who need the value frequently
> can cache it themselves.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c   |    9 ++++-----
>  include/linux/pci.h |    1 -
>  2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>

