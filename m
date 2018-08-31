Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:45234 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeHaLXk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Aug 2018 07:23:40 -0400
Received: by mail-oi0-f43.google.com with SMTP id t68-v6so19988760oie.12
        for <linux-pci@vger.kernel.org>; Fri, 31 Aug 2018 00:17:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180830094016.GA18925@al>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al> <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <20180828095722.GA8820@al> <CAD8Lp44Re2menmZfY3GLExZVMDfQANTvG3hWC1wQwrXpQ6WKCA@mail.gmail.com>
 <20180830094016.GA18925@al>
From: Daniel Drake <drake@endlessm.com>
Date: Fri, 31 Aug 2018 15:17:35 +0800
Message-ID: <CAD8Lp45An=kA2ymHgWUZUhTkhGfp2fp5ERR2Tw1gXs6hc=de0A@mail.gmail.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
To: Peter Wu <peter@lekensteyn.nl>
Cc: linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2018 at 5:40 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> As the BIOS date is not visible, can you also confirm that this message
> is visible in dmesg?
>
>    nouveau: detected PR support, will not use DSM

Yes, that gets logged.

> For laptops, it appears that you have to do at least two things:
> - Ensure that the Subsystem Vendor/Product ID are set.
> - Expose a _ROM ACPI method that provides VBIOS.
>
> Perhaps you also need to provide a "_DSM" method that emulates at least
> the "Optimus" interface for GUID a486d8f8-0bda-471b-a72b-6042a6b5bee0.
>
> You probably lost interest here, but if you want to continue anyway this
> is what allowed me to install the driver on the XPS 9560:
> https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/fakedev.asl

Indeed. I'm going to submit the workaround and I'll look to come back
to this qemu/vfio analysis later.

Thanks
Daniel
