Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:36860 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeHQIkF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Aug 2018 04:40:05 -0400
Received: by mail-it0-f42.google.com with SMTP id p81-v6so10346198itp.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Aug 2018 22:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsMZaDZDONX6+McFJr2UMZR9inQTeTsKWqQXcwMCPrc96g@mail.gmail.com>
In-Reply-To: <CABXGCsMZaDZDONX6+McFJr2UMZR9inQTeTsKWqQXcwMCPrc96g@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 17 Aug 2018 10:37:53 +0500
Message-ID: <CABXGCsNC3RBk+TXSwRS6c+p5wPOvmDrxHbC=PxwZemspWmcnsA@mail.gmail.com>
Subject: Re: [4.18 rc8 BUG] AER: Corrected error received: 0000:00:00.0
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Is there anyone alive here?
Nobody wants to help me?


--
Best Regards,
Mike Gavrilov.
On Wed, 15 Aug 2018 at 22:40, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi guys.
> I hope I wrote in appropriate list.
> I assembled a new computer.
> But my joy is marred by a lot of errors in the kernel log:
> [  104.373852] pcieport 0000:00:03.1: AER: Corrected error received:
> 0000:00:00.0
> [  104.373877] pcieport 0000:00:03.1: PCIe Bus Error:
> severity=Corrected, type=Data Link Layer, (Transmitter ID)
> [  104.373881] pcieport 0000:00:03.1:   device [1022:1453] error
> status/mask=00001000/00006000
> [  104.373886] pcieport 0000:00:03.1:    [12] Replay Timer Timeout
> I don't know it may be false positive or can impact performance.
> Anyway I hope it can be fixed because such count of errors make it
> difficult to observe real problems.
>
>
> --
> Best Regards,
> Mike Gavrilov.
