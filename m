Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:45369 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755252AbdKJA35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Nov 2017 19:29:57 -0500
Received: by mail-wm0-f42.google.com with SMTP id y80so20519643wmd.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Nov 2017 16:29:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1711091427050.1839@nanos>
References: <CAFZiPx1x9irvXCm7W9t_VjGnw2VLPhptO8WfuRXPd1jpcBU2Sw@mail.gmail.com>
 <697da40c-7cdd-3d05-5846-37eae31bb729@mobiveil.co.in> <alpine.DEB.2.20.1711091427050.1839@nanos>
From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Date: Fri, 10 Nov 2017 05:59:56 +0530
Message-ID: <CAFZiPx1pJ4WyDkP2dT8eQvZRukTbZA9H+kTD506e19s0SU8rtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Peter W Newton <peter.newton@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Raj Raina <rajesh.raina@nxp.com>,
        Rajan Kapoor <rajan.kapoor@nxp.com>,
        Prabhjot Singh <prabhjot.singh@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

tglx,


On Thu, Nov 9, 2017 at 6:57 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Thu, 9 Nov 2017, subrahmanya_lingappa wrote:
>
>> From e38b741006856f3a3623109dd5ddf5f99326ce61 Mon Sep 17 00:00:00 2001
>> From: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> Date: Thu, 9 Nov 2017 04:25:21 -0500
>> Subject: [PATCH 1/2 v2] PCI: Mobiveil: export irq_set_msi_desc symbol
>>
>> This patch exports irq_set_msi_desc symbol which is used by
>> few PCIe root port drivers.
>
> And which one of those is modular?
>

I think this one is, as I see at least 25 other files using it, albeit
SoC devices.
Hope I got the question right.

> Thanks,
>
>         tglx
