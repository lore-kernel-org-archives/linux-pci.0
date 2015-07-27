Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50954 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbG0M7D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 27 Jul 2015 08:59:03 -0400
Date: Mon, 27 Jul 2015 14:58:57 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 11/11] PCI: Remove pci_ats_enabled()
Message-ID: <20150727125857.GF27614@suse.de>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150721001519.28145.73458.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150721001519.28145.73458.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 20, 2015 at 07:15:19PM -0500, Bjorn Helgaas wrote:
> Remove pci_ats_enabled().  There are no callers outside the ATS code
> itself.  We don't need to check ats_cap, because if we don't find an ATS
> capability, we'll never set ats_enabled.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/ats.c   |    6 +++---
>  include/linux/pci.h |    2 --
>  2 files changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Joerg Roedel <jroedel@suse.de>

