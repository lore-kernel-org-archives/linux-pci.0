Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f169.google.com ([209.85.213.169]:42732 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731757AbeG0AT6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jul 2018 20:19:58 -0400
Received: by mail-yb0-f169.google.com with SMTP id c10-v6so1312236ybf.9
        for <linux-pci@vger.kernel.org>; Thu, 26 Jul 2018 16:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
In-Reply-To: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
From: Rajat Jain <rajatja@google.com>
Date: Thu, 26 Jul 2018 16:00:24 -0700
Message-ID: <CACK8Z6GsOkhTgPA1HRtgdRgKta7d=vVP_1t0EhcyJMJCj+aV+A@mail.gmail.com>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: "Busch, Keith" <keith.busch@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>, austin_bolen@dell.com,
        Alex_Gagniuc@dellteam.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 26, 2018 at 3:38 PM Alex G. <mr.nuke.me@gmail.com> wrote:
>
> Hi,
>
> I was under the impression that a DLLSC or PDSC would trigger the
> PCI_DEV_DISCONNECTED bit to be set, blocking any further config access.

This sounds like an good idea to me. Caveat below.

>
> Although I'm not seeing that happen after a  "Slot(xxx): Link Down"
> event.

It should eventually happen when the pciehp takes a note and finally
processes the event in pciehp_unconfigure_device(). I suspect that the
reason this was put towards the end of the event processing was to be
absolutely be sure that the device removal won't be cancelled (Since
the bit is not being cleared anywhere, if somehow the device removal
is not processed, it may result in ghost devices that are permanently
"unreadable").

Thanks,

Rajat

> I suspect my understanding is then wrong. Or maybe
> PCI_DEV_DISCONNECTED means something else.
>
> In the latter case, does it not make sense to have a separate bit to say
> "Don't touch this device"?
>
> Alex
