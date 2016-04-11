Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.opengridcomputing.com ([72.48.136.20]:38289 "EHLO
	smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464AbcDKSPk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2016 14:15:40 -0400
From: "Steve Wise" <swise@opengridcomputing.com>
To: "'Casey Leedom'" <leedom@chelsio.com>
Cc: <linux-pci@vger.kernel.org>, <hariprasad@chelsio.com>,
	<hare@suse.com>, <bhelgaas@google.com>
References: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com> <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
In-Reply-To: <BY2PR12MB0648F0C35D907AA640D7E56CC8940@BY2PR12MB0648.namprd12.prod.outlook.com>
Subject: RE: 4.6-rc2 regression with commit 104daa71b396: check VPD access offset against length
Date: Mon, 11 Apr 2016 13:16:17 -0500
Message-ID: <02ec01d1941e$3dda2010$b98e6030$@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> kernel.org commit 104daa71b396 added a check to make sure that efforts to
> read/write the VPD wouldn't extend past the computed length of the VPD.
> Later, kernel.org commit 408641e93aa5 folded the pci_vpd_pci22 into
> struct pci_vpd so things moved around a bit after that and an error return
> got changed into a silent failure instead of -EINVAL.
> 
>   The problem is that the previous pci_vpd_pci22_read() didn't check for a
read with
> a VPD Offset > VPD Length and the new pci_vpd_read() is checking that.  Worse
> yet, when a VPD Offset is greater than the recorded VPD Length, it simply
> returns 0 rather than -EINVAL.
> 
>   The problem is stemming from the fact that the Chelsio adapters actually
have
> two VPD structures stored in the VPD.  An abbreviated on at Offset 0x0 and the
> complete VPD at Offset 0x400.  The abbreviated one only contains the PN, SN
and
> EC Keywords, while the complete VPD contains those plus various adapter
> constants contained in V0, V1, etc.  And it also contains the Base Ethernet
MAC
> Address in the "NA" Keyword which the cxgb4 driver needs when it can't contact
> the adapter firmware.  (We don't have the "NA" Keywork in the VPD Structure at
> Offset 0x0 because that's not an allowed VPD Keyword in the PCI-E 3.0
> specification.)
> 
>   With the new code, the computed size of the VPD is 0x200 and so our efforts
> to read the VPD at Offset 0x400 silently fails.  We check the result of the
> read looking for a signature 0x82 byte but we're checking against random stack
> garbage.
> 
>   The end result is that the cxgb4 driver now fails the PCI-E Probe.
> 

Silently failing is wrong, in my opinion.  And I even question truncating which
is also done in pci_vpd_read().  To the PCI maintainers:  Should the length
checks just be removed?    If not, what is the correct solution?  Adding a
different "expert" API that ignores the length checks, or somehow allowing the
device driver to set the actual VPD size? 

Thanks,

Steve.

