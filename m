Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:45059 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbaDDPA2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 11:00:28 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so1033640igc.7
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 08:00:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396579914.3215.36.camel@ul30vt.home>
References: <20130711204439.1701.90503.stgit@bling.home> <20130711210326.1701.56478.stgit@bling.home>
 <20130723223533.GB19765@google.com> <1374621703.15429.98.camel@ul30vt.home>
 <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
 <1374689548.5208.62.camel@ul30vt.home> <20130724232427.GA9272@google.com>
 <1374775016.2642.116.camel@ul30vt.home> <20130726215435.GB20021@google.com>
 <1375113975.2642.208.camel@ul30vt.home> <CAErSpo7pfCtTm5Cq=VixPTKMpM4VQpDr+ZmS5qMw32z6ABu0xQ@mail.gmail.com>
 <1375137140.2642.349.camel@ul30vt.home> <CAErSpo5+-r3qMca1_Kvt3jJ6OP6Q7--4VmTo3fWJ0y4CPewgEQ@mail.gmail.com>
 <1375462795.31262.327.camel@ul30vt.home> <CAErSpo5p+6yt8ZyVuLnJTiKAWZWq9ixQQu78nD-bNFkw4ntWmw@mail.gmail.com>
 <1396579914.3215.36.camel@ul30vt.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 4 Apr 2014 09:00:07 -0600
Message-ID: <CAErSpo4_WUXTXbte+coJ+Q5yboFYKkE-WAVM5SDUxH7c=w0orQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Andrew Cooks <acooks@gmail.com>,
	Don Dutile <ddutile@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	George Spelvin <linux@horizon.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 3, 2014 at 8:51 PM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Thu, 2014-04-03 at 15:48 -0600, Bjorn Helgaas wrote:
>> [+cc George]
>>
>> On Fri, Aug 2, 2013 at 10:59 AM, Alex Williamson
>> <alex.williamson@redhat.com> wrote:
>> > ...
>> > Great!  I'm still trying to figure out how to handle the quirk around
>> > Intel PCI-to-PCI bridge on the root complex as just another quirk.  I
>> > respin another version once I have that worked out.  Thanks,
>>
>> Is anything happening here?  These buggy IOMMU/DMA source problems,
>> e.g., [1], have been lingering a long time, and I don't know if we're
>> stuck because I haven't been giving them enough attention, or if we
>> don't really have a good solution yet.
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=42679
>
> Sorry, no.  This has completely dropped off my radar.  I'll try to
> resurrect it and figure out how to move forward.  Thanks,

Not a problem; I'm just way behind on processing patches, so I'm
trying to clean up my backlog and take care of things that are waiting
on me.

Bjorn
