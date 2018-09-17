Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb1-f196.google.com ([209.85.219.196]:32851 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRBNq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Sep 2018 21:13:46 -0400
Received: by mail-yb1-f196.google.com with SMTP id y9-v6so4284660ybh.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Sep 2018 12:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
 <20180914161404.4685-2-s.miroshnichenko@yadro.com> <CACK8Z6F1-P+SDYHx6x3zitSFh2iEPhQtY-Vdhz6Qwkt9=0XTjA@mail.gmail.com>
 <20180917193832.mfy7m4uumb3kohuv@wunner.de>
In-Reply-To: <20180917193832.mfy7m4uumb3kohuv@wunner.de>
From: Rajat Jain <rajatja@google.com>
Date: Mon, 17 Sep 2018 12:44:23 -0700
Message-ID: <CACK8Z6E7OiPati12a2nMbxNJu-dca-oBgmPJvZb4C7XkrDe7mw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] PCI: hotplug: Add parameter to put devices to
 reset during rescan
To: Lukas Wunner <lukas@wunner.de>
Cc: s.miroshnichenko@yadro.com, linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 17, 2018 at 12:38 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Mon, Sep 17, 2018 at 12:00:22PM -0700, Rajat Jain wrote:
> > On Fri, Sep 14, 2018 at 9:21 AM Sergey Miroshnichenko <s.miroshnichenko@yadro.com> wrote:
> > > If a new PCIe device has been hot-plugged between two active ones, which
> > > have no (or not big enough) gap between their BARs, allocating new BARs
> > > requires to move BARs of the following working devices:
> >
> > * What about non-memory resources? E.g. cards may have pci bridges or
> > switches on them, and they may need extra PCI bus numbers. Does this
> > help that use case?
>
> FWIW, macOS has had a "PCI Pause" functionality since 2013, documented here:
> (the anchor is apparently overridden by Javascript, scroll down to
> "Supporting PCIe Pause")
>
> https://developer.apple.com/library/archive/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics02/Basics02.html#//apple_ref/doc/uid/TP40011138-CH4-SW14
>
> In addition to memory resources, they also reallocate bus numbers and MSIs.

Thanks, that makes me wonder that would also mean that now the user
space / UDEV may need to be notified (because some one may have taken
a note of the PCI B:D:F). Also, the UIO drivers, ugh....

Thanks,

Rajat

>
> Thanks,
>
> Lukas
