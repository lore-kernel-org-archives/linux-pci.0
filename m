Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:45018 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3IIQK7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Sep 2013 12:10:59 -0400
Received: by mail-qc0-f176.google.com with SMTP id t7so796578qcv.7
        for <linux-pci@vger.kernel.org>; Mon, 09 Sep 2013 09:10:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+C+4OYxqgExkepUix5wU4VPRRUcnAFPQJcbUYcLHRcAmNgqgw@mail.gmail.com>
References: <1378431958-7874-1-git-send-email-weiyang@linux.vnet.ibm.com>
	<20130906230941.GC12956@google.com>
	<CA+C+4OYxqgExkepUix5wU4VPRRUcnAFPQJcbUYcLHRcAmNgqgw@mail.gmail.com>
Date: Mon, 9 Sep 2013 09:10:59 -0700
Message-ID: <CA+C+4OavOY3qxKLauPNV7AwxTeVZ-kNMuYouzGMsy3Z3BYf1NA@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: use pci_is_root_bus() to check whether it is a
 root bus
From: Alex Chiang <achiang@canonical.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Resending because the first mail got rejected by vger.

On Fri, Sep 6, 2013 at 4:09 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> [+cc Kenji, Alex]
>
> On Fri, Sep 06, 2013 at 09:45:56AM +0800, Wei Yang wrote:
> > In __pci_bus_size_bridges() we check whether a pci bus is a root
> > bus by testing bus->self. As indicated by commit 79af72d7
> > ("PCI: pci_is_root_bus helper"), bus->self == NULL is not a proper
> > way to check the pci root bus.
> >
> > This patch changes it to pci_is_root_bus() to check whether it is
> > a root bus.
>
> I think this is a good change, even if only on the grounds of
> consistency.
>
> Did you trip over a case where a root bus has bus->self != NULL?
> I'd like to know more details about the case where:
>
>   (bus->parent == NULL) && (bus->self != NULL)
>
> I'm sure that situation exists, or Kenji and Alex would not have
> made the change in 79af72d7, but I don't know the details.
>
> I'd like to know the details so I can recognize similar problems
> elsewhere.

It has been quite a long time, and so I had to google around in the
archives to try and remind myself why we made this change.
Unfortunately, I couldn't find anything public...

Reaching back into my unreliable human memory though, I truly seem to
recall that this interface was created out of paranoia/future-proofing
and not because we had tripped over any actual issues we had found in
the wild at that time.

Sorry for not being more helpful.

/ac
