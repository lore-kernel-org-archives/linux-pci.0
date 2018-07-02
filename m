Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41912 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeGBOUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Jul 2018 10:20:40 -0400
Received: by mail-qt0-f196.google.com with SMTP id y20-v6so13908694qto.8
        for <linux-pci@vger.kernel.org>; Mon, 02 Jul 2018 07:20:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180701140634.GA22322@wunner.de>
References: <1530268061-17324-1-git-send-email-hari.vyas@broadcom.com>
 <1530268061-17324-2-git-send-email-hari.vyas@broadcom.com> <20180701140634.GA22322@wunner.de>
From: Hari Vyas <hari.vyas@broadcom.com>
Date: Mon, 2 Jul 2018 19:50:39 +0530
Message-ID: <CAM5rFu9yysO2vX0JrjVExURjLuRPR_WVuPRG5C6MfP177H5UOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] PCI: Data corruption happening due to race condition
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, benh@kernel.crashing.org,
        linux-pci@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 1, 2018 at 7:36 PM, Lukas Wunner <lukas@wunner.de> wrote:
> On Fri, Jun 29, 2018 at 03:57:39PM +0530, Hari Vyas wrote:
>> Fix moves device addition is_added bit to separate private flag
>> variable and use different atomic functions to set, clear and
>> retrieve device addition state. As is_added shares different
>> memory location so race condition is avoided.
>
> As 0-day has already discovered, you need to squash all 3 patches
> together to avoid breaking the build.
>
>
Agreed. I will squash and raise a new patch
>> +static inline int pci_dev_set_added(struct pci_dev *dev, void *unused)
>> +{
>> +     set_bit(PCI_DEV_ADDED, &dev->priv_flags);
>> +     return 0;
>> +}
>> +
>> +static inline int pci_dev_clear_added(struct pci_dev *dev, void *unused)
>> +{
>> +     clear_bit(PCI_DEV_ADDED, &dev->priv_flags);
>> +     return 0;
>> +}
>
> You don't need the "unused" parameter here and you can return void.
> pci_dev_set_disconnected() has the parameter because the function is
> passed in to pci_walk_bus() in a few places, but you're not doing that
> AFAICS.
>
> What you *could* do however is collapse pci_dev_set_added() and
> pci_dev_clear_added() into a single function, pass in a bool "added",
> then use assign_bit() to set or clear it.  It would save 6 LoC.
>
Agreed.  Just for symmetry I did that one. Will incorporate change.
> Thanks,
>
> Lukas
