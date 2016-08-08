Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:14256
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750929AbcHHXyG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Aug 2016 19:54:06 -0400
From: Casey Leedom <leedom@chelsio.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Hariprasad S <hariprasad@chelsio.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	SWise OGC <swise@opengridcomputing.com>,
	"Hannes Reinecke" <hare@suse.de>
Subject: Re: [PATCH] pci: Use same logic in pci_vpd_read as that of
 pci_vpd_write
Date: Mon, 8 Aug 2016 21:20:22 +0000
Message-ID: <DM5PR12MB17864DB8AA81CBA21EBB7AA8C81B0@DM5PR12MB1786.namprd12.prod.outlook.com>
References: <1466827722-17287-1-git-send-email-hariprasad@chelsio.com>,<20160808210858.GC6129@localhost>
In-Reply-To: <20160808210858.GC6129@localhost>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

| From: Bjorn Helgaas <helgaas@kernel.org>
| Sent: Monday, August 8, 2016 2:08 PM
| 
| I think the existing semantics are the same as for the read(2)
| syscall: we return the number of bytes read, which may be less than
| the size requested, and callers may use random garbage if they don't
| check for short reads.

read(2) is a generic I/O system call, which maintains a read pointer with
lseek(2) semantics, etc.  This seems like an Apples and Oranges
comparison.

| If we make pci_read_vpd() return error instead of a short read, how do
| callers figure out how much to request?

The same question could be asked of the pci_write_vpd() call which
currently throws an error is any portion of the requested write is beyond
the recorded VPD area.  Also, isn't this what (struct pci_dev *)->vpd.len
is for?  Although I think we'd want an API to retrieve that rather than have
callers simply access the potentially uninitialized field which is lazily
initialized.  On the other hand, we don't seem to have any current callers
with this issue.

| In the current tree, I think the following callers don't handle short
| reads correctly:
| 
|   cxl_pci_read_adapter_vpd() (cxl, used via read_vpd())
|   eeprom_rd_phys() (cxgb4)
|   t4_get_raw_vpd_params() (cxgb4)
|   sky2_show_vpd() (sky2)
|   efx_probe_vpd_strings() (efx)
|   vfio_vpd_config_write() (vfio)
| 
| That's not a very long list, so we could certainly fix them.

I agree.  If we do decide not to address the weirdness of returning
success for a partial VPD read, then at least the fixup of the callers
isn't too bad.

Casey