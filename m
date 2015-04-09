Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54703 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256AbbDIXcA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 9 Apr 2015 19:32:00 -0400
Message-ID: <1428622302.18187.87.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] PCI: Set pref for mem64 resource of pcie device
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	David Ahern <david.ahern@oracle.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Date: Fri, 10 Apr 2015 09:31:42 +1000
In-Reply-To: <CAE9FiQWf1kRx2Dx7LzCy7WhDonO54Q3o+5Nu+uxxsCs1unBMtg@mail.gmail.com>
References: <1427857069-6789-1-git-send-email-yinghai@kernel.org>
	 <1427857069-6789-4-git-send-email-yinghai@kernel.org>
	 <20150406220638.GH10892@google.com>
	 <20150406.203533.1356187749826485194.davem@davemloft.net>
	 <CAErSpo7zvqft2frrwCd5AKMSO1LB7=7Ys9stKsj7OGzkQv4K1Q@mail.gmail.com>
	 <20150408154759.GN10892@google.com>
	 <1428527527.18187.28.camel@kernel.crashing.org>
	 <CAE9FiQXQN-VqN3ynLEhHh5WUYE+8tLR8ubKKMeHZ3h=BQ0rA9A@mail.gmail.com>
	 <1428549459.18187.56.camel@kernel.crashing.org>
	 <CAErSpo5VwuLjZtQFcJqfpkC=j5TJmLD0oZPQ=6oJpSOthB+BFA@mail.gmail.com>
	 <1428569681.18187.69.camel@kernel.crashing.org>
	 <CAE9FiQWf1kRx2Dx7LzCy7WhDonO54Q3o+5Nu+uxxsCs1unBMtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-04-09 at 11:31 -0700, Yinghai Lu wrote:
> On Thu, Apr 9, 2015 at 1:54 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Wed, 2015-04-08 at 23:26 -0500, Bjorn Helgaas wrote:
> >> I'm not planning to review this until after the merge window opens,
> >> but I took a quick glance, and I agree with Ben.  I don't want to add
> >> a new IORESOURCE_ flag.  I think a pci_resource_compatible() helper is
> >> a great idea.
> >
> > So the new resource flag was handy here still regardless of the
> > implementation choice because otherwise, we have to do the whole tree
> > walk to check for "PCI Express only path".
> >
> > *But*, this is a property of the device as a whole, not of the resource,
> > so we could instead have a pci_dev flag established at probe time that
> > indicates that the path to a given device is PCIe only.
> 
> > That way, you avoid the special resource flag alltogether.
> 
> in the assign path: pci_bus_alloc_resource() does not take dev pointer.
> 
> should we make
> 
> int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
> 
> to
> 
> int pci_bus_alloc_resource(struct pci_bus *bus, struct pci_dev *dev,
> struct resource *res,

Do you need to pass bus if you have dev ?

Do we have any caller that doesn't have dev available ?

Cheers,
Ben.

> ?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


