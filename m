Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33927 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753214AbdHUPWU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2017 11:22:20 -0400
Received: by mail-io0-f176.google.com with SMTP id g135so14672300iog.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2017 08:22:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000201d31a90$ddf52640$99df72c0$@gmail.com>
References: <20170818225638.31563-1-ard.biesheuvel@linaro.org> <000201d31a90$ddf52640$99df72c0$@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 21 Aug 2017 16:22:19 +0100
Message-ID: <CAKv+Gu-p0CJqqMWEDiGQ5hk6dKB9K3GOgTNH6GMAbugWPu8oJA@mail.gmail.com>
Subject: Re: [RFC PATCH] pci: designware: add driver for DWC controller in
 ECAM shift mode
To: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21 August 2017 at 16:19, Jingoo Han <jingoohan1@gmail.com> wrote:
> On Friday, August 18, 2017 6:57 PM, Ard Biesheuvel wrote:
>>
>> Some implementations of the Synopsys Designware PCIe controller implement
>> a so-called ECAM shift mode, which allows a static memory window to be
>> configured that covers the configuration space of the entire bus range.
>>
>> If the firmware performs all the low level configuration that is required
>> to expose this controller in a fully ECAM compatible manner, we can
>> simply describe it as "pci-host-ecam-generic" and be done with it.
>> However, it appears that in some cases (one of which is the Armada 80x0),
>> the IP is synthesized with an ATU window size that does not allow the
>> first bus to be mapped in a way that prevents the device on the
>> downstream port from appearing more than once.
>>
>> So implement a driver that relies on the firmware to perform all low
>> level initialization, and drives the controller in ECAM mode, but
>> overrides the config space accessors to take the above quirk into
>> account.
>>
>> Note that, unlike most drivers for this IP, this driver does not expose
>> a fake bridge device at B/D/F 00:00.0. There is no point in doing so,
>> given that this is not a true bridge, and does not require any windows
>> to be configured in order for the downstream device to operate correctly.
>> Omitting it also prevents the PCI resource allocation routines from
>> handing out BAR space to it unnecessarily.
>>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> Posted as RFC for discussion. We have systems booting with UEFI firmware
>
> (CC'ed Arnd Bergmann)
>
> Thank you for sharing this patch.
> I have no objection about this patch.
>

Thanks.

> I think that this driver is required for ARM-based server system.
> But, as you wrote above, UEFI should support low-level code for this
> DesignWare
> Controller if we want to use this DWC-ECAM driver. So, can we get the UEFI
> code
> for this controller?
>
> If not, can you share your plan about that?
>

Yes, I will share the code via the edk2-platforms tree as soon as we
are ready to publish support for this particular platform.
