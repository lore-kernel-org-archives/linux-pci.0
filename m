Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0122.outbound.protection.outlook.com ([65.55.169.122]:40576
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753484AbcDHWYo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2016 18:24:44 -0400
From: Casey Leedom <leedom@chelsio.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Hannes Reinecke <hare@suse.com>,
	Hariprasad S <hariprasad@chelsio.com>
Subject: 4.6-rc2 regression with commit 104daa71b396: check VPD access offset
 against length
Date: Fri, 8 Apr 2016 22:24:40 +0000
Message-ID: <BY2PR12MB06483CA232B6B3BFF7179012C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[[ I apologize if this is a duplicate message.  I've been struggling all
    afternoon to get a message successfully delivered to the linux-pci
    list.
    -- Casey ]]

  kernel.org commit 104daa71b396 added a check to make sure that efforts to
read/write the VPD wouldn't extend past the computed length of the VPD.
Later, kernel.org commit 408641e93aa5 folded the pci_vpd_pci22 into
struct pci_vpd so things moved around a bit after that and an error return
got changed into a silent failure instead of -EINVAL.

  The problem is that the previous pci_vpd_pci22_read() didn't check for a read with
a VPD Offset > VPD Length and the new pci_vpd_read() is checking that.  Worse
yet, when a VPD Offset is greater than the recorded VPD Length, it simply
returns 0 rather than -EINVAL.

  The problem is stemming from the fact that the Chelsio adapters actually have
two VPD structures stored in the VPD.  An abbreviated on at Offset 0x0 and the
complete VPD at Offset 0x400.  The abbreviated one only contains the PN, SN and
EC Keywords, while the complete VPD contains those plus various adapter
constants contained in V0, V1, etc.  And it also contains the Base Ethernet MAC
Address in the "NA" Keyword which the cxgb4 driver needs when it can't contact
the adapter firmware.  (We don't have the "NA" Keywork in the VPD Structure at
Offset 0x0 because that's not an allowed VPD Keyword in the PCI-E 3.0
specification.)

  With the new code, the computed size of the VPD is 0x200 and so our efforts
to read the VPD at Offset 0x400 silently fails.  We check the result of the
read looking for a signature 0x82 byte but we're checking against random stack
garbage.

  The end result is that the cxgb4 driver now fails the PCI-E Probe.

  Again,  apologies if I'm not communicating this to the Linux Development
Community properly -- I'm usually not allowed out of my cage.

Casey