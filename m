Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:53069 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbaIERFA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 5 Sep 2014 13:05:00 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so11452786qaj.35
        for <linux-pci@vger.kernel.org>; Fri, 05 Sep 2014 10:04:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5409E6CF.8060109@ti.com>
References: <5409E6CF.8060109@ti.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 5 Sep 2014 11:04:38 -0600
Message-ID: <CAErSpo5FRyyL88yQCcqM71NKsETPBOG9yihLoK_JhawFxA=g4A@mail.gmail.com>
Subject: Re: PCI Keystone driver on host-designware
To: Murali Karicheri <m-karicheri2@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 5, 2014 at 10:37 AM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>
> Bjorn,
>
> Thank you first for queueing the Keystone PCI driver patch for v3.18.
>
> I have pulled today from pci/host-designware branch at
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> and tested PCI driver on Keystone and it works as expected.

Good.  I reorganized those branches a little bit, so the Keystone
stuff is now on the pci/host-keystone branch, but it's functionally
identical.

> Could you also clarify the following?
>
> 1. The DT documentation
> (Documentation/devicetree/bindings/pci/pci-keystone.txt) that was part of
> the PCI driver commit is missing in the branch. Was this intentional? Do you
> want me to send a patch for this or it gets merged through some other
> subystem (Documentation?)

Definitely not intentional; I'm not sure how I dropped that.  I
amended that commit to add the documentation and updated the
pci/host-keystone branch.

> 2. I have subsequently send a patch to the list and got some reviews done to
> remove the bootargs dependency on the Keystone PCI driver. The same is
> available at
> https://lkml.org/lkml/2014/8/8/486
> Could you please apply this as well?

Yep, I'm working my way through the stuff in
https://patchwork.ozlabs.org/project/linux-pci/list/?order=date, and
I've almost gotten to that one :)

Bjorn
