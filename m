Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49707 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbcBWMVF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 07:21:05 -0500
Subject: Re: [PATCH v4 06/11] PCI: Move pci_read_vpd() and pci_write_vpd()
 close to other VPD code
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160223004707.10635.94730.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56CC4EA9.7030904@suse.de>
Date: Tue, 23 Feb 2016 20:20:57 +0800
MIME-Version: 1.0
In-Reply-To: <20160223004707.10635.94730.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2016 08:47 AM, Bjorn Helgaas wrote:
> pci_read_vpd() and pci_write_vpd() were stranded in the middle of config
> accessor functions.  Move them close to the other VPD code in the file.
> No functional change.
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
