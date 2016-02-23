Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49610 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbcBWMTS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 07:19:18 -0500
Subject: Re: [PATCH v4 03/11] PCI: Use bitfield instead of bool for struct
 pci_vpd_pci22.busy
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160223004645.10635.98577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56CC4E3C.8000907@suse.de>
Date: Tue, 23 Feb 2016 20:19:08 +0800
MIME-Version: 1.0
In-Reply-To: <20160223004645.10635.98577.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2016 08:46 AM, Bjorn Helgaas wrote:
> Make struct pci_vpd_pci22.busy a 1-bit field instead of a bool.  We intend
> to add another flag, and two bitfields are cheaper than two bools.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: J. Hawn, J. Guild, F. Imendörffer, HRB 16746 (AG Nürnberg)
