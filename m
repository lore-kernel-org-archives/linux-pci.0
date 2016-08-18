Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754719AbcHSBlT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:41:19 -0400
Date: Thu, 18 Aug 2016 15:55:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Casey Leedom <leedom@chelsio.com>
Cc: Hariprasad S <hariprasad@chelsio.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        SWise OGC <swise@opengridcomputing.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] pci: Use same logic in pci_vpd_read as that of
 pci_vpd_write
Message-ID: <20160818205524.GO27353@localhost>
References: <1466827722-17287-1-git-send-email-hariprasad@chelsio.com>
 <20160808210858.GC6129@localhost>
 <DM5PR12MB17864DB8AA81CBA21EBB7AA8C81B0@DM5PR12MB1786.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM5PR12MB17864DB8AA81CBA21EBB7AA8C81B0@DM5PR12MB1786.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Casey,

Sorry for the delay in responding.

On Mon, Aug 08, 2016 at 09:20:22PM +0000, Casey Leedom wrote:
> | From: Bjorn Helgaas <helgaas@kernel.org>
> | Sent: Monday, August 8, 2016 2:08 PM
> | 
> | I think the existing semantics are the same as for the read(2)
> | syscall: we return the number of bytes read, which may be less than
> | the size requested, and callers may use random garbage if they don't
> | check for short reads.
> 
> read(2) is a generic I/O system call, which maintains a read pointer with
> lseek(2) semantics, etc.  This seems like an Apples and Oranges
> comparison.
> 
> | If we make pci_read_vpd() return error instead of a short read, how do
> | callers figure out how much to request?
> 
> The same question could be asked of the pci_write_vpd() call which
> currently throws an error is any portion of the requested write is beyond
> the recorded VPD area.  Also, isn't this what (struct pci_dev *)->vpd.len
> is for?  Although I think we'd want an API to retrieve that rather than have
> callers simply access the potentially uninitialized field which is lazily
> initialized.  On the other hand, we don't seem to have any current callers
> with this issue.

Drivers that read VPD probably can figure out how much to read.  The
place I'm worried about is read_vpd_attr(), the hook for reading VPD
via sysfs.  If we do something like "cat /sys/.../vpd", I think cat
will try to read a large chunk and it will currently get a short read.
If we return an error instead of the short read, I think the sysfs
file will be much harder to use.

Bjorn
