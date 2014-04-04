Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27350 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbaDDCwe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Apr 2014 22:52:34 -0400
Message-ID: <1396579914.3215.36.camel@ul30vt.home>
Subject: Re: [RFC PATCH v2 1/2] pci: Create PCIe requester ID interface
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
	Andrew Cooks <acooks@gmail.com>,
	Don Dutile <ddutile@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	George Spelvin <linux@horizon.com>
Date: Thu, 03 Apr 2014 20:51:54 -0600
In-Reply-To: <CAErSpo5p+6yt8ZyVuLnJTiKAWZWq9ixQQu78nD-bNFkw4ntWmw@mail.gmail.com>
References: <20130711204439.1701.90503.stgit@bling.home>
	 <20130711210326.1701.56478.stgit@bling.home>
	 <20130723223533.GB19765@google.com> <1374621703.15429.98.camel@ul30vt.home>
	 <CAErSpo6bcGCjqdxn-bz_vjo+HsAiOxDu=--mD7veEZ9f7k+gyA@mail.gmail.com>
	 <1374689548.5208.62.camel@ul30vt.home> <20130724232427.GA9272@google.com>
	 <1374775016.2642.116.camel@ul30vt.home> <20130726215435.GB20021@google.com>
	 <1375113975.2642.208.camel@ul30vt.home>
	 <CAErSpo7pfCtTm5Cq=VixPTKMpM4VQpDr+ZmS5qMw32z6ABu0xQ@mail.gmail.com>
	 <1375137140.2642.349.camel@ul30vt.home>
	 <CAErSpo5+-r3qMca1_Kvt3jJ6OP6Q7--4VmTo3fWJ0y4CPewgEQ@mail.gmail.com>
	 <1375462795.31262.327.camel@ul30vt.home>
	 <CAErSpo5p+6yt8ZyVuLnJTiKAWZWq9ixQQu78nD-bNFkw4ntWmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-04-03 at 15:48 -0600, Bjorn Helgaas wrote:
> [+cc George]
> 
> On Fri, Aug 2, 2013 at 10:59 AM, Alex Williamson
> <alex.williamson@redhat.com> wrote:
> > ...
> > Great!  I'm still trying to figure out how to handle the quirk around
> > Intel PCI-to-PCI bridge on the root complex as just another quirk.  I
> > respin another version once I have that worked out.  Thanks,
> 
> Is anything happening here?  These buggy IOMMU/DMA source problems,
> e.g., [1], have been lingering a long time, and I don't know if we're
> stuck because I haven't been giving them enough attention, or if we
> don't really have a good solution yet.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=42679

Sorry, no.  This has completely dropped off my radar.  I'll try to
resurrect it and figure out how to move forward.  Thanks,

Alex

