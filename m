Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2on0112.outbound.protection.outlook.com ([65.55.169.112]:40352
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751339AbcDHW5T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Apr 2016 18:57:19 -0400
From: Casey Leedom <leedom@chelsio.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Hariprasad S <hariprasad@chelsio.com>,
	Hannes Reinecke <hare@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: kernel.org merge of struct pci_vpd_pci22 into struct pci_vpd breaking
 cxgb4
Date: Fri, 8 Apr 2016 20:22:30 +0000
Message-ID: <BY2PR12MB0648CE1AB2744A49938E42D1C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
References: <BY2PR12MB06487321896554A0B4046719C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
In-Reply-To: <BY2PR12MB06487321896554A0B4046719C8910@BY2PR12MB0648.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[[ N.B. I'm trying to get subscribed to linux-pci@vger.kernel.org but it's not going well.
  I started a conversation with Bjorn in order to give him a Heads Up and get the ball
  rolling on a regression in the Linux 4.6 kernel.  Bjorn informed me that I can actually
  send email to the linix-pci email list without being subscribed, so here we go ...
  -- Casey]]


----------


From: Casey Leedom
Sent: Friday, April 8, 2016 11:40 AM
To: Bjorn Helgaas <bhelgaas@google.com> 
Cc: Hariprasad S <hariprasad@chelsio.com>; 
Subject: kernel.org merge of struct pci_vpd_pci22 into struct pci_vpd breaking cxgb4
  
Hi Bjorn,

  I'm trying to get myself subscribed to the linux-pci list in order to do this in the
accepted fashion, but that seems to be stalling out for some reason, so I
wanted to give you a Heads Up prior to me being able to submit this to that list.

  Your kernel.org commit 408641e93aa5283e586fefd4dc72e67c92aae075
to fold struct pci_vpd_pci22 into struct pci_vpd is breaking the cxgb4 driver.
The problem is that the previous pci_vpd_pci22_read() didn't check for a
read with a VPD Offset > VPD Length  and the new pci_vpd_read() is
checking that.  Worse yet, when a VPD Offset is greater than the recorded
VPD Length, it simply returns 0 rather than -EINVAL.

  The problem is stemming from the fact that the Chelsio adapters actually
have two VPD structures stored in the VPD.  An abbreviated on at Offset 0x0
and the complete VPD at Offset 0x400.  The abbreviated one only contains
the PN, SN and EC Keywords, while  the complete VPD contains those plus
various adapter constants contained in V0, V1, etc.  And it also contains the
Base Ethernet MAC Address in the "NA" Keyword which the cxgb4 driver
needs when it can't contact the adapter firmware.  (We don't have the "NA"
Keywork in the VPD Structure at Offset 0x0 because that's not an allowed
VPD Keyword in the PCI-E 3.0 specification.)

  With the new code, the computed size of the VPD is 0x200 and so our
efforts to read the VPD at Offset 0x400 silently fails.  We check the result
of the read looking for a signature 0x82 byte but we're checking against
random stack garbage.

  The end result is that the cxgb4 driver now fails the PCI-E Probe.

Casey


----------


From: Bjorn Helgaas <bhelgaas@google.com> 
Sent: Friday, April 8, 2016 12:33 PDT
To: Casey Leedom <leedom@chelsio.com>
Cc: Hariprasad S <hariprasad@chelsio.com>; Hannes Reinecke <hare@suse.com>;

[+cc Hannes]

Hi Casey,

First of all, I'm really sorry about this problem.  I know it's a
major hassle to track down breakages like this.

My intent was that 408641e93aa5 ("PCI: Fold struct pci_vpd_pci22 into
struct pci_vpd") would be pure reorganization, with no functional
change.  Did you actually bisect it to that and confirm that
f1cd93f9aabe ("PCI: Rename VPD symbols to remove unnecessary "pci22"")
works and 408641e93aa5 fails?

>From your description, I would have thought the breakage would be
caused by 104daa71b396 ("PCI: Determine actual VPD size on first
access"), not by 408641e93aa5.

The reason for 104daa71b396 is that some cards don't work well when
reading outside the VPD area.  I'm not sure how to fix that problem
while keeping the Chelsio adapters working.  Maybe we'll need some
sort of quirk.

Bjorn


----------


From: Casey Leedom <leedom@chelsio.com>
Sent: Friday, April 8, 2016 13:08 PDT
To: Bjorn Helgaas <bhelgaas@google.com> 
Cc: Hariprasad S <hariprasad@chelsio.com>; Hannes Reinecke <hare@suse.com>;

  I'll post my note again and mention your hypothesis that it's really the check for the VPD size in commit 408641e93aa5.  I hadn't seen that the old pci_vpd_pci22_read() checked the length ...

Casey