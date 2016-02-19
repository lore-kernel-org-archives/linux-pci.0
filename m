Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48535 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757179AbcBSKAv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Feb 2016 05:00:51 -0500
Subject: Re: [PATCH] Create sysfs entries for PCI VPDI and VPDR tags
To: Jordan Hargrave <Jordan_Hargrave@dell.com>, bhelgaas@google.com
References: <1455825895-10951-1-git-send-email-Jordan_Hargrave@dell.com>
Cc: alexander.duyck@gmail.com, linux-pci@vger.kernel.org,
	babu.moger@oracle.com, linux-kernel@vger.kernel.org,
	jharg93@gmail.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <56C6E7D1.4@suse.de>
Date: Fri, 19 Feb 2016 11:00:49 +0100
MIME-Version: 1.0
In-Reply-To: <1455825895-10951-1-git-send-email-Jordan_Hargrave@dell.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/18/2016 09:04 PM, Jordan Hargrave wrote:
> The VPD-R is a readonly area of the PCI Vital Product Data region.
> There are some standard keywords for serial number, manufacturer,
> and vendor-specific values.  Dell Servers use a vendor-specific
> tag to store number of ports and port mapping of partitioned NICs.
> 
> info = VPD-Info string
> PN = Part Number
> SN = Serial Number
> MN = Manufacturer ID
> Vx = Vendor-specific (x=0..9 A..Z)
> 
> This creates a sysfs subdirectory in the pci device: vpdattr with
> 'info', 'EC', 'SN', 'V0', etc. files containing the tag values.
> 
> Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
Hmm. Can we first get an agreement on the PCI VPD parsing patches
I've posted earlier?
VPD parsing is really tricky, and we should aim on making the
read_vpd function robust enough before we begin putting things into
sysfs.

Also, I'm not utterly keen on this patchset.
The sysfs space is blown up with tiny pieces of information, which
can easily gotten via lspci, too.

Also, to my knowledge it's perfectly valid to _write_ to the VPD, in
which case the entire sysfs attribute setup would be invalided.
How do you propose to handle that?

Cheers,

Hannes

-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
