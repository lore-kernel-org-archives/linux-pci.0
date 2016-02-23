Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49831 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbcBWMXO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Feb 2016 07:23:14 -0500
Subject: Re: [PATCH v4 09/11] PCI: Rename VPD symbols to remove unnecessary
 "pci22"
To: Bjorn Helgaas <bhelgaas@google.com>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160223004728.10635.43331.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Cc: linux-pci@vger.kernel.org,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Babu Moger <babu.moger@oracle.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56CC4F2B.3080501@suse.de>
Date: Tue, 23 Feb 2016 20:23:07 +0800
MIME-Version: 1.0
In-Reply-To: <20160223004728.10635.43331.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/23/2016 08:47 AM, Bjorn Helgaas wrote:
> There's only one kind of VPD, so we don't need to qualify it as "the
> version described by PCI spec rev 2.2."
> 
> Rename the following symbols to remove unnecessary "pci22":
> 
>   PCI_VPD_PCI22_SIZE	-> PCI_VPD_MAX_SIZE
>   pci_vpd_pci22_size()	-> pci_vpd_size()
>   pci_vpd_pci22_wait()	-> pci_vpd_wait()
>   pci_vpd_pci22_read()	-> pci_vpd_read()
>   pci_vpd_pci22_write()	-> pci_vpd_write()
>   pci_vpd_pci22_ops	-> pci_vpd_ops
>   pci_vpd_pci22_init()	-> pci_vpd_init()
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
