Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49794 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454AbbG0Mph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 08:45:37 -0400
Date: Mon, 27 Jul 2015 14:45:34 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 03/11] PCI: Embed ATS info directly into struct pci_dev
Message-ID: <20150727124534.GC27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001413.28145.38246.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001413.28145.38246.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:14:13PM -0500, Bjorn Helgaas wrote:
> The pci_ats struct is small and will get smaller, so I don't think it's
> worth allocating it separately from the pci_dev struct.
> 
> Embed the ATS fields directly into struct pci_dev.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c       |   61 ++++++++++++++++-------------------------------
>  drivers/pci/remove.c    |    1 -
>  include/linux/pci-ats.h |   10 +-------
>  include/linux/pci.h     |    8 ++++--
>  4 files changed, 27 insertions(+), 53 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>

