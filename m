Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6382EECDE3D
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 20:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151EF2087A
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 20:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Agx067pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151EF2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbeJTE3I (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:29:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45843 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeJTE3I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Oct 2018 00:29:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id m6-v6so9027848eds.12
        for <linux-pci@vger.kernel.org>; Fri, 19 Oct 2018 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuSXJawjNRleS2HWs9A13Chba5vGhEXuKJpdbi/y5FA=;
        b=Agx067pGi5E1vgSPF2Ty/x0qN4/K7d1F+WxmkZTQuJAZz4B1TzwN4YwtWK6qpA2GG+
         fF7AZqKBX8tUgrscBqor1Npwqo4fllBTFI9RqwGMoKoHnOck35fBm1Az7B13L5Xe0zdE
         uACNFhCFKE03oGtleYlWEYWOBm0hGpYxgmJAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuSXJawjNRleS2HWs9A13Chba5vGhEXuKJpdbi/y5FA=;
        b=EQlZNyfnJJREJle+8BA/AyqVMNGfQdTob2V5uthlwJ8XmRaDeZsxUtYNrjBKprajMb
         sIrO5CBCqSbN3TPm8Mv5quJLaNC7+bCYvVhtXEDWctMj57kG+vZsQj6cVcVdQfzuIuFg
         uUt+UfyT1Baf8a29kBYIoZpayzCPpmJ6qh3qI30oduNfiAjjmdKDyvhUpnK1mfY9zu01
         LfEH8Fpn0FMYUFiQBwLsStQHEZsmDdZLa3Db+D0fhW8Y4AMV2KpuvC4rf9x+88YDHG2g
         sXBeRykTxxh4jfAsg2xFR435bu4M2pL2dzfq9vpLGhufRVXThM+oirwHB54RW/rZ19mL
         0LAA==
X-Gm-Message-State: ABuFfogjJmPpUEQtrASinIKfW+SGjfPxixF32Q6+XYd9tGSIqus71Jrz
        qll6ZaKtsKEe1GNZLcR4QRcakfBBe+M=
X-Google-Smtp-Source: ACcGV62twjnpNLx297VVJJ8g/zHh12XFPjdMfrRKCeXQ5qvwi5mXTfhqWms4R36HQVR2E8IuDZN4bA==
X-Received: by 2002:a50:e602:: with SMTP id y2-v6mr7458538edm.278.1539980488918;
        Fri, 19 Oct 2018 13:21:28 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id b36-v6sm10007394ede.11.2018.10.19.13.21.27
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 13:21:27 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id d15-v6so32543640edq.6
        for <linux-pci@vger.kernel.org>; Fri, 19 Oct 2018 13:21:27 -0700 (PDT)
X-Received: by 2002:a50:9554:: with SMTP id v20-v6mr7314561eda.4.1539980487060;
 Fri, 19 Oct 2018 13:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181019021132.14743-1-okaya@kernel.org> <20181019021132.14743-4-okaya@kernel.org>
 <20181019201449.GA105697@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181019201449.GA105697@bhelgaas-glaptop.roam.corp.google.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 19 Oct 2018 13:21:15 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNJ+GFsXTRwskVDbxXUoF8AtD9mBnPWjndjPYhgtRAydg@mail.gmail.com>
Message-ID: <CA+ASDXNJ+GFsXTRwskVDbxXUoF8AtD9mBnPWjndjPYhgtRAydg@mail.gmail.com>
Subject: Re: [PATCH v6 4/7] PCI: Expose reset type to users of pci_try_reset_function()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     okaya@kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        alex.williamson@redhat.com, aik@ozlabs.ru, peterx@redhat.com,
        gustavo@embeddedor.com, amitkarwar@gmail.com,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>, huxinming820@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 19, 2018 at 1:14 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc mwifiex maintainers, Brian]
>
> On Fri, Oct 19, 2018 at 02:11:24AM +0000, Sinan Kaya wrote:
> > Looking to have more control between the users of the API vs. what the API
> > can do internally. The new reset_type tells the PCI core about the bounds
> > of the request.
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  drivers/pci/pci.c                  | 5 +++--
> >  drivers/vfio/pci/vfio_pci.c        | 7 ++++---
> >  drivers/vfio/pci/vfio_pci_config.c | 4 ++--
> >  include/linux/pci.h                | 2 +-
>
> Doesn't mwifiex_pcie_card_reset_work() also use
> pci_try_reset_function() and need an update?

Yes :)

> vfio is special in several ways, but I'm a little dubious about
> mwifiex since it's the only other driver in the whole tree that uses
> pci_try_reset_function().
>
> The mwifiex use was added by a64e7a79dd60 ("mwifiex: resolve reset vs.
> remove()/shutdown() deadlocks").

I won't say that patch is perfect (there are cases where we'll end up
failing to try to reset, and the device will just stay dead instead),
but it definitely resolved deadlocks in a way that looked reasonable
to me. Feel free to poke holes in my original commit description, or
else ask questions, if you'd like mwifiex to do something differently.

Brian

> >  4 files changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 9a649d1adb13..7739f28988ae 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4851,10 +4851,11 @@ EXPORT_SYMBOL_GPL(pci_reset_function_locked);
> >  /**
> >   * pci_try_reset_function - quiesce and reset a PCI device function
> >   * @dev: PCI device to reset
> > + * @reset_type: reset type to apply
> >   *
> >   * Same as above, except return -EAGAIN if unable to lock device.
> >   */
> > -int pci_try_reset_function(struct pci_dev *dev)
> > +int pci_try_reset_function(struct pci_dev *dev, u32 reset_type)
> >  {
> >       int rc;
> >
> > @@ -4865,7 +4866,7 @@ int pci_try_reset_function(struct pci_dev *dev)
> >               return -EAGAIN;
> >
> >       pci_dev_save_and_disable(dev);
> > -     rc = __pci_reset_function_locked(dev, PCI_RESET_ANY);
> > +     rc = __pci_reset_function_locked(dev, reset_type);
> >       pci_dev_restore(dev);
> >       pci_dev_unlock(dev);
> >
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index cddb453a1ba5..fe7ada997c51 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -228,7 +228,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
> >               return ret;
> >
> >       /* If reset fails because of the device lock, fail this path entirely */
> > -     ret = pci_try_reset_function(pdev);
> > +     ret = pci_try_reset_function(pdev, PCI_RESET_ANY);
> >       if (ret == -EAGAIN) {
> >               pci_disable_device(pdev);
> >               return ret;
> > @@ -376,7 +376,7 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev)
> >        * Try to reset the device.  The success of this is dependent on
> >        * being able to lock the device, which is not always possible.
> >        */
> > -     if (vdev->reset_works && !pci_try_reset_function(pdev))
> > +     if (vdev->reset_works && !pci_try_reset_function(pdev, PCI_RESET_ANY))
> >               vdev->needs_reset = false;
> >
> >       pci_restore_state(pdev);
> > @@ -844,7 +844,8 @@ static long vfio_pci_ioctl(void *device_data,
> >
> >       } else if (cmd == VFIO_DEVICE_RESET) {
> >               return vdev->reset_works ?
> > -                     pci_try_reset_function(vdev->pdev) : -EINVAL;
> > +                     pci_try_reset_function(vdev->pdev, PCI_RESET_ANY) :
> > +                      -EINVAL;
> >
> >       } else if (cmd == VFIO_DEVICE_GET_PCI_HOT_RESET_INFO) {
> >               struct vfio_pci_hot_reset_info hdr;
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> > index 115a36f6f403..0d66bac66211 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -831,7 +831,7 @@ static int vfio_exp_config_write(struct vfio_pci_device *vdev, int pos,
> >                                                &cap);
> >
> >               if (!ret && (cap & PCI_EXP_DEVCAP_FLR))
> > -                     pci_try_reset_function(vdev->pdev);
> > +                     pci_try_reset_function(vdev->pdev, PCI_RESET_ANY);
> >       }
> >
> >       /*
> > @@ -910,7 +910,7 @@ static int vfio_af_config_write(struct vfio_pci_device *vdev, int pos,
> >                                               &cap);
> >
> >               if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP))
> > -                     pci_try_reset_function(vdev->pdev);
> > +                     pci_try_reset_function(vdev->pdev, PCI_RESET_ANY);
> >       }
> >
> >       return count;
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9103ac1b3c31..cde63e0a85ea 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1170,7 +1170,7 @@ int pcie_flr(struct pci_dev *dev);
> >  int __pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
> >  int pci_reset_function(struct pci_dev *dev, u32 reset_type);
> >  int pci_reset_function_locked(struct pci_dev *dev, u32 reset_type);
> > -int pci_try_reset_function(struct pci_dev *dev);
> > +int pci_try_reset_function(struct pci_dev *dev, u32 reset_type);
> >  int pci_probe_reset_slot(struct pci_slot *slot);
> >  int pci_probe_reset_bus(struct pci_bus *bus);
> >  int pci_reset_bus(struct pci_dev *dev);
> > --
> > 2.19.0
> >
