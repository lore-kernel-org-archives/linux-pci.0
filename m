Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:17481 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbcB2Wg7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Feb 2016 17:36:59 -0500
Subject: Re: [PATCH v4 00/11] PCI VPD access fixes
To: "Seymour, Shane M" <shane.seymour@hpe.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.de>
References: <20160223003444.10635.20204.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <DDB9C85B850785449757F9914A034FCB445368F5@G4W3219.americas.hpqcorp.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jordan Hargrave <Jordan_Hargrave@dell.com>,
	Alexander Duyck <alexander.duyck@gmail.com>
From: Babu Moger <babu.moger@oracle.com>
Message-ID: <56D4C7F9.1060609@oracle.com>
Date: Mon, 29 Feb 2016 16:36:41 -0600
MIME-Version: 1.0
In-Reply-To: <DDB9C85B850785449757F9914A034FCB445368F5@G4W3219.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/23/2016 10:52 PM, Seymour, Shane M wrote:
> Retested v4. For the series tested two PCIe cards that support VPD:
> 
> 0d:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)
> 1e:00.0 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI Express HBA (rev 03)
> 
> The first card exposes 32KiB of NUL bytes as VPD and the second 154 bytes of non-NUL data repeating every 4KiB for 32KiB before the change. After the change the first  card returns no data for VPD (since it contains only NUL bytes) and the second the expected 154 bytes of data.
> 
> The following warning message comes out as expected for the LSI card (changed from dyn debug controlled message):
> 
> [  614.475984] mpt3sas 0000:0d:00.0: invalid short VPD tag 00 at offset 1
> 
> lspci works correctly with the patch in the kernel. The only change on the system (apart from the size of the vpd file) was that with the LSI card lspci with -vvvv as root it now says "Not readable"  instead of "Unknown small resource type 00, will not decode more." in the VPD section.
> ---
> Tested-by: Shane Seymour <shane.seymour@hpe.com>
> 

I have also retested the V4 series. Did not see any side effects.
Once again here is the bug I opened for this issue.
https://bugzilla.kernel.org/show_bug.cgi?id=110681
---
Tested-by: Babu Moger <babu.moger@oracle.com>
