Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49743 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbcBWMVl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 07:21:41 -0500
Subject: Re: [PATCH v4 07/11] PCI: Move pci_vpd_release() from header file to
 pci/access.c
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160223004714.10635.28635.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56CC4ECD.9050803@suse.de>
Date: Tue, 23 Feb 2016 20:21:33 +0800
MIME-Version: 1.0
In-Reply-To: <20160223004714.10635.28635.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2016 08:47 AM, Bjorn Helgaas wrote:
> Move pci_vpd_release() so it's next to the other VPD functions.  This puts
> it next to pci_vpd_pci22_init(), which allocates the space freed by
> pci_vpd_release().
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
