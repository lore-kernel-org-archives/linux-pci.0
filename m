Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:43475 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbdISRzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2017 13:55:20 -0400
Received: by mail-qk0-f170.google.com with SMTP id j5so428319qkd.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2017 10:55:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d3328861-2da2-918d-c3db-cc0795ab1586@gmail.com>
References: <d3328861-2da2-918d-c3db-cc0795ab1586@gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 19 Sep 2017 10:55:19 -0700
Message-ID: <CAKgT0Ud1_Ge3SWVt+G_yLdgxhjs6vvib02hVLA5Y+KH1bLWFSQ@mail.gmail.com>
Subject: Re: SR-IOV & virtfn/physfn sysfs links
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 18, 2017 at 6:53 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wr=
ote:
> Bjorn et al,
>
> I'm hoping to enhance network device naming in systemd to parse sysfs "vi=
rtfn%u" and "physfn" links, so it understands virtual devices.
>
> I've noticed that the udev event which triggers the systemd/biosdevname n=
etwork device naming--the udev "add" event for the network device, which ha=
ppens within pci_bus_add_device() when the network driver's probe function =
calls register_netdev()--occurs before the sysfs links "physfn" and "virtfn=
%u" are created.  This creates a race when the network naming code tries to=
 look at those links (something biosdevname already does).
>
> Is there any reason why we couldn't switch the order of those calls to el=
iminate the race, as shown in the patch below?  I couldn't think of any, si=
nce those links apply to the pci subsystem devices in sysfs (which are alre=
ady created), not the net subsystem devices.  I'd be happy to submit a patc=
h if that looks ok.
>
> Thank you,
> Stuart
>
>
> --- linux-4.14-rc1/drivers/pci/iov.c.orig       2017-09-18 15:00:43.16825=
5665 -0500
> +++ linux-4.14-rc1/drivers/pci/iov.c    2017-09-18 15:07:04.792280999 -05=
00
> @@ -162,7 +162,6 @@ int pci_iov_add_virtfn(struct pci_dev *d
>
>         pci_device_add(virtfn, virtfn->bus);
>
> -       pci_bus_add_device(virtfn);
>         sprintf(buf, "virtfn%u", id);
>         rc =3D sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>         if (rc)
> @@ -173,6 +172,8 @@ int pci_iov_add_virtfn(struct pci_dev *d
>
>         kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
>
> +       pci_bus_add_device(virtfn);
> +
>         return 0;
>
>  failed2:
>
>

So looking over the change the only thing I wasn't sure about was if
the exception handling paths all worked out correctly, and from what I
can tell it looks like this change didn't introduce any new errors.

The one thing I think might be here though before you patch was
introduced is a possible memory leak if pci_setup_device() fails as we
don't ever free the memory allocated to virtfn. It looks liike
checking for the error was added somewhat recently and I suspect
nobody was checking for the memory leak. I don't know if you would
want to get that as a part of your patchset or not. If not I can
probably try to get around to it later this week.

- Alex
