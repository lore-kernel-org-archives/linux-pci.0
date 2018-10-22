Return-Path: <SRS0=Y6al=NC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78585C67863
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 06:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F5A20875
	for <linux-pci@archiver.kernel.org>; Mon, 22 Oct 2018 06:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F5A20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeJVO1E (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Oct 2018 10:27:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42055 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbeJVO1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Oct 2018 10:27:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id c23so37065472otl.9;
        Sun, 21 Oct 2018 23:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A82BZu+XujgCm+r/fO5QnvxNBxDN/QEN/2JOui1vTqQ=;
        b=H2TshRnXJ5KFM2wtijd1uCMYG+jRIOdTg5VibdcCXbGdnAwk4yUdnG0Te7RyWgSR4q
         GcfXkb7/FULdodMNAFZ3O1JtKUEJYW6JrlyRV/7mgCmsgdkpBMkejREpvImJzCufWp3X
         DZ7Lbr3lBMTMn26RuLuRJlTbkbPJD+x/dxkiFk7Mb8HgNTXxRmCcbJTRottEKGe2x1r1
         2/2HoPHfdUgwK3DzXw4vUc86d4uKgJVG1jdjBNiWJQWN1V5dFgMgRuigtDct2s0JYxM7
         gt9er1L+dWeMILOp5ZWdxU/xWLAVsRvJMfGMgfZ6L8GcGHVKr8ppKWvq/c159HwiBmsq
         igDA==
X-Gm-Message-State: ABuFfohcZHfOdIZFbR8d/d3cT/x/0epqc0cEwSzgT2N2hBg8RvTehFa0
        TYj3t1cuZk251+39Woy7eTZ+XmOxvkYQ4wHa6yc=
X-Google-Smtp-Source: ACcGV61eNdfiI4Aj9tmFNSIKSL5Mf1c8SZGB9hVHBkfGEIbUHDpfn8S/gQz7A8H9vRlbogLsl/d3b54RpgNlP1svb3k=
X-Received: by 2002:a9d:538c:: with SMTP id w12mr29611469otg.139.1540188597797;
 Sun, 21 Oct 2018 23:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181018123038.21386-1-jarkko.nikula@linux.intel.com>
 <20181019152105.0325a663@endymion> <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181020161948.GS5906@bhelgaas-glaptop.roam.corp.google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Oct 2018 08:06:26 +0200
Message-ID: <CAJZ5v0h65cYvR9+7PmrDDMazuUE4_vbgF7R1rrosbTEaX=UhMg@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Allow runtime PM without callback functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 20, 2018 at 6:19 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Oct 19, 2018 at 03:21:05PM +0200, Jean Delvare wrote:
> > On Thu, 18 Oct 2018 15:30:38 +0300, Jarkko Nikula wrote:
> > > Allow PCI core to do runtime PM to devices without needing to use dummy
> > > runtime PM callback functions if there is no need to do anything device
> > > specific beyond PCI device power state management.
> > >
> > > Implement this by letting core to change device power state during
> > > runtime PM transitions even if no callback functions are defined.
> >
> > Thank you very much for looking into this and providing a fix.
> >
> > > Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > > ---
> > > This is related to my i2c-i801.c fix thread back in June which I completely
> > > forgot till now: https://lkml.org/lkml/2018/6/27/642
> > > Discussion back then was that it should be handled in the PCI PM instead
> > > of having dummy functions in the drivers. I wanted to respin with a
> > > patch.
> > > ---
> > >  drivers/pci/pci-driver.c | 16 ++++++----------
> > >  1 file changed, 6 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index bef17c3fca67..6185b878ede1 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -1239,7 +1239,7 @@ static int pci_pm_runtime_suspend(struct device *dev)
> > >     struct pci_dev *pci_dev = to_pci_dev(dev);
> > >     const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> > >     pci_power_t prev = pci_dev->current_state;
> > > -   int error;
> > > +   int error = 0;
> > >
> > >     /*
> > >      * If pci_dev->driver is not set (unbound), we leave the device in D0,
> > > @@ -1251,11 +1251,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
> > >             return 0;
> > >     }
> > >
> > > -   if (!pm || !pm->runtime_suspend)
> > > -           return -ENOSYS;
> > > -
> > >     pci_dev->state_saved = false;
> > > -   error = pm->runtime_suspend(dev);
> > > +   if (pm && pm->runtime_suspend)
> > > +           error = pm->runtime_suspend(dev);
> > >     if (error) {
> > >             /*
> > >              * -EBUSY and -EAGAIN is used to request the runtime PM core
> >
> > Later in this function, pm is dereferenced again. It happens twice in
> > the "if (error)" condition where it is currently safe (error can't be
> > non-zero if pm->runtime_suspend() has not been called, and obviously
> > pm->runtime_suspend() can't have been called if pm was NULL). However
> > it also happens later without the condition:
> >
> >       if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
> >           && pci_dev->current_state != PCI_UNKNOWN) {
> >               WARN_ONCE(pci_dev->current_state != prev,
> >                       "PCI PM: State of device not saved by %pF\n",
> >                       pm->runtime_suspend);
> >               return 0;
> >       }
> >
> > I am no expert of the PM framework but is there no risk to dereference
> > NULL at this point? Or even if pm is non-NULL, pm->runtime_suspend may
> > be NULL, leading to a confusing warning message?
> >
> > More generally, I would feel better if instead of initializing error to
> > 0, we would move under the "if (pm && pm->runtime_suspend)" condition
> > everything that must not be run if pm->runtime_suspend is not defined.
> > That would make the possible code flows a lot clearer.
>
> I agree, this isn't good.  Even if it's safe (and I don't think that
> second spot is safe), it's too hard to analyze.  I'm going to drop
> this for now.

Yeah, sorry for missing this.

[Note to self: be more careful with patch reviews in the future.]

Cheers,
Rafael
