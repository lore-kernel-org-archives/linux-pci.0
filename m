Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49777 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750740AbcBWMWd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 07:22:33 -0500
Subject: Re: [PATCH v4 08/11] PCI: Remove struct pci_vpd_ops.release function
 pointer
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160223004721.10635.89434.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56CC4F01.7080804@suse.de>
Date: Tue, 23 Feb 2016 20:22:25 +0800
MIME-Version: 1.0
In-Reply-To: <20160223004721.10635.89434.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2016 08:47 AM, Bjorn Helgaas wrote:
> The struct pci_vpd_ops.release function pointer is always
> pci_vpd_pci22_release(), so there's no need for the flexibility of a
> function pointer.
> 
> Inline the pci_vpd_pci22_release() body into pci_vpd_release() and remove
> pci_vpd_pci22_release() and the struct pci_vpd_ops.release function
> pointer.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
