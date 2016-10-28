Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33680 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760482AbcJ1Pb3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2016 11:31:29 -0400
Received: by mail-oi0-f67.google.com with SMTP id i127so3715200oia.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Oct 2016 08:31:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <acccb06d-14b9-33bd-466b-47dd3689e537@broadcom.com>
References: <1460238624-2086-1-git-send-email-zajec5@gmail.com>
 <79DC79A7-D4CE-4983-B1C5-CBD2E9CBBFB9@gmail.com> <5420659.scnjID7ZLn@wuerfel>
 <ae624772-9306-50ee-3dc1-df8156eaa16d@broadcom.com> <acccb06d-14b9-33bd-466b-47dd3689e537@broadcom.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Fri, 28 Oct 2016 17:31:28 +0200
Message-ID: <CACna6rxCdgyqFMU5-LD0rJn1s6voSiVvk1AGGnaykGZPMDbwPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: iproc: Support DT property for ignoring aborts
 when probing
To: Ray Jui <ray.jui@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20 April 2016 at 20:18, Ray Jui <ray.jui@broadcom.com> wrote:
> Hi Rafal/Florian/Arnd,
>
> After a couple days of email exchange with the ASIC team, I think I've
> figured out the behavior on all of the Broadcom SoCs that use this iProc
> PCIe controller.
>
> On NSP, Cygnus, and NS2:
> - There's an APB error enable register at offset 0xf40 from the iProc PCIe
> controller's base address. If one clears bit 0 (enabled by default after
> chip POR) of that register, one can stop this from being forwarded to "iProc
> host" as an APB error/external imprecise abort
> - I will submit a patch to the iProc PCIe driver to disable this error
> forwarding
>
> On NS:
> - Unfortunately, there's no such control register in NS. In other words, we
> cannot disable this error at the PCIe controller level
> - FSR code corresponds to external (bit[12] = '1'), read (bit[11] = '0'),
> imprecise abort (bits[10][3:0] = '1''0110'), i.e., external imprecise abort
> triggered by read access. Our ASIC team believes a read access to a
> non-exist APB register can also trigger an abort with the same FSR code.
> Note this is the tricky part, by registering an abort hook that skips this
> particular FSR, one has a chance of skipping other aborts triggered by
> accessing invalid APB registers. But given that this cannot be disabled for
> the PCIe controller NS, I'm not sure what approach we should take. Any
> thoughts?

It's really late reply but I wanted to finally handle this problem.

>From Ray's e-mail it seems Northstar is the only platform requiring
this workaround. So we don't have to worry about arm64.

We have two options then:
1) Add workaround in arch/arm/mach-bcm/bcm_5301x.c
2) Add workaround into built-in drivers/pci/host/pcie-iproc-fault.c

Do you have any preference about that?
