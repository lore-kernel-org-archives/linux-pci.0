Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35065 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbcA2OWZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jan 2016 09:22:25 -0500
Received: by mail-io0-f173.google.com with SMTP id d63so73261297ioj.2
        for <linux-pci@vger.kernel.org>; Fri, 29 Jan 2016 06:22:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8LgoeU1XZJ=i+hbOj2X_wZ9aPPWQZ+9PMeQnPiGgUU2g@mail.gmail.com>
References: <1454077035-23872-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAKv+Gu8LgoeU1XZJ=i+hbOj2X_wZ9aPPWQZ+9PMeQnPiGgUU2g@mail.gmail.com>
Date: Fri, 29 Jan 2016 15:22:24 +0100
Message-ID: <CAKv+Gu81F_p8_ZK4mHq6kQbkf7-Zv0p8SPwQ5HR02tTomDq99g@mail.gmail.com>
Subject: Re: [PATCH] PCI: generic: map config window in one go
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Will Deacon <will.deacon@arm.com>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <mark.brown@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 29 January 2016 at 15:19, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 29 January 2016 at 15:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Instead of iterating over the PCI config window and performing individual
>> ioremap() calls on all the adjacent slices, perform a single ioremap() to
>> map the entire region, and divvy it up later. This not only prevents
>> leaving some of it mapped if we fail half way through, it also ensures that
>> archs that support huge-vmap can use section mappings to perform the
>> mapping.
>>
>> On my Seattle A0 box, this transforms 128 separate 1 MB mappings that are
>> mapped down to 4 KB pages into a single 128 MB mapping using 2 MB sections,
>> saving 512 KB worth of page tables.
>>
>
> OK, this math is slightly off: 4 KB for each 2 MB section == 64 * 4 == 128 KB
>

Sigh. 64 * 4 == 256 KB


>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>
>> huge-vmap for arm64 proposed here:
>> http://article.gmane.org/gmane.linux.kernel.hardened.devel/1661
>>
>>  drivers/pci/host/pci-host-generic.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-host-generic.c b/drivers/pci/host/pci-host-generic.c
>> index 1652bc70b145..3251cd779278 100644
>> --- a/drivers/pci/host/pci-host-generic.c
>> +++ b/drivers/pci/host/pci-host-generic.c
>> @@ -161,6 +161,7 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>>         struct device *dev = pci->host.dev.parent;
>>         struct device_node *np = dev->of_node;
>>         u32 sz = 1 << pci->cfg.ops->bus_shift;
>> +       void *window;
>>
>>         err = of_address_to_resource(np, 0, &pci->cfg.res);
>>         if (err) {
>> @@ -186,14 +187,15 @@ static int gen_pci_parse_map_cfg_windows(struct gen_pci *pci)
>>                 return -ENOMEM;
>>
>>         bus_range = pci->cfg.bus_range;
>> +       window = devm_ioremap(dev, pci->cfg.res.start,
>> +                             (bus_range->end - bus_range->start + 1) * sz);
>> +       if (!window)
>> +               return -ENOMEM;
>> +
>>         for (busn = bus_range->start; busn <= bus_range->end; ++busn) {
>>                 u32 idx = busn - bus_range->start;
>>
>> -               pci->cfg.win[idx] = devm_ioremap(dev,
>> -                                                pci->cfg.res.start + idx * sz,
>> -                                                sz);
>> -               if (!pci->cfg.win[idx])
>> -                       return -ENOMEM;
>> +               pci->cfg.win[idx] = window + idx * sz;
>>         }
>>
>>         return 0;
>> --
>> 2.5.0
>>
