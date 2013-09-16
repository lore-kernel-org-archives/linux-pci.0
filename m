Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38294 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab3IPHkE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 16 Sep 2013 03:40:04 -0400
Date: Mon, 16 Sep 2013 10:40:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Prarit Bhargava <prarit@redhat.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 0/2] ACPI: return error in acpi_pci_irq_enable when there
 is no irq
Message-ID: <20130916074000.GA24222@xps8300>
References: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
 <52330A82.7050607@redhat.com>
 <2086253.mJBe8Nv4qL@vostro.rjw.lan>
 <CAErSpo4r=oQ+J0=cM9gp3-i5-+5JYpYZQfzi3HFa6spxOO9OJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4r=oQ+J0=cM9gp3-i5-+5JYpYZQfzi3HFa6spxOO9OJg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 13, 2013 at 05:55:40PM -0600, Bjorn Helgaas wrote:
> On Fri, Sep 13, 2013 at 5:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Friday, September 13, 2013 08:52:18 AM Prarit Bhargava wrote:
> >>
> >> Rafael, is this in your queue?
> >
> > No, it is not, because Bjorn wanted to debug this issue deeper as far as I
> > could understand.
> >
> > Bjorn?
> 
> Yes.  Yinghai pointed out a possible issue ("some USB3 host controller
> does not have intx configured, but still work with MSI?").  I can't
> explain to you right now what that means, but I did look at it enough
> to think that there indeed might be a problem there.
> 
> So I asked [1] for a bugzilla with more info (dmesg, acpidump) so
> somebody could look at it.  Actually, I was hoping Heikki or Prarit
> would look into it and address Yinghai's concern.  Maybe there's no
> problem there, but we should at least look and explain *why* it's not
> a problem.  And I would really like a kernel.org bugzilla with the
> info, in case this change turns out to have unintended consequences
> and we have to debug it again later.

I'll ask Sarah (xHCI maintaner) for help in case she knows something
and create a bug for this if needed.

I don't understand much about PCI, I need to study it a bit. Why would
it be a problem to get the xHCI working with only MSI?

Thanks,

-- 
heikki
