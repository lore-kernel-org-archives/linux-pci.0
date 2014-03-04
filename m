Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:44949 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932481AbaCDVdy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Mar 2014 16:33:54 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so143133ieb.40
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2014 13:33:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <FC41C24E35F18A40888AACA1A36F3E418A1ECC8F@FMSMSX102.amr.corp.intel.com>
References: <5315F785.4050602@redhat.com> <CAErSpo4hjEG7bVu_T+X6Kie3tzj4PKV_4hoWmxr-pyVu5uD_1Q@mail.gmail.com>
 <FC41C24E35F18A40888AACA1A36F3E418A1ECC8F@FMSMSX102.amr.corp.intel.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Mar 2014 14:33:33 -0700
Message-ID: <CAErSpo4H=yKEnYwOPZ+i3sn08UqMzpXQg92e6ZxpDyZse=QSEQ@mail.gmail.com>
Subject: Re: [E1000-devel] kmemleak through e1000?
To: "Nelson, Shannon" <shannon.nelson@intel.com>
Cc: Daniel Borkmann <dborkman@redhat.com>,
	"e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 4, 2014 at 2:11 PM, Nelson, Shannon
<shannon.nelson@intel.com> wrote:
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>>
>> On Tue, Mar 4, 2014 at 8:55 AM, Daniel Borkmann <dborkman@redhat.com>
>> wrote:
>> > Hi all, I'm not very familiar with the e1000 code, but on the latest
>> > net.git kernel I get reliably the following (not sure if it's actually
>> > caused by e1000 though):
>>
>> Thanks a lot for the report.  What kernel is this exactly (URL and
>> SHA-1 hash)?  We have fixes for a couple leaks already queued up [1,
>> 2], so possibly you're seeing those leaks.  If you already have those
>> fixes in net.git, then we should investigate further.
>>
>> Bjorn
>
>
> FYI - I've recently seen similar kmemleak reports from ixgbe and i40e drivers, all seemly pointing to the msix allocations.  I didn't have a chance to track them down, but they were seen in variations of net-next 3.14.0-rc3.

I don't think that has the leak fixes in it yet.  I'm looking here:

  http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/log/drivers/pci/msi.c

which does not contain the fixes from 2014-02-13 that are listed here:

  http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/drivers/pci/msi.c

In particular, these two look related:

  PCI/MSI: Fix leak of msi_attrs
  PCI/MSI: Check kmalloc() return value, fix leak of name

So if you do look into them further, make sure you pick up these fixes
first, and let me know if you still see issues.

Bjorn
