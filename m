Return-Path: <SRS0=ld9y=MT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529B5C65C1D
	for <linux-pci@archiver.kernel.org>; Sun,  7 Oct 2018 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCF920882
	for <linux-pci@archiver.kernel.org>; Sun,  7 Oct 2018 13:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vIKampce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFCF920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbeJGUbU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 7 Oct 2018 16:31:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44182 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeJGUbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Oct 2018 16:31:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so17910584wra.11
        for <linux-pci@vger.kernel.org>; Sun, 07 Oct 2018 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aAL3fZUFBVwRXWuu2uhsqoK4mzwzp8b9HpzY6V1JSxM=;
        b=vIKampcexcLkv0S+mOD2T5pGgtpBVKtgtdbPNsTZ4GOkoOrzV9vMbEQ45/9qEOIrKy
         ZjOvvFgL8O3hvcyGcWAk6DPIXvqJ7ywZ+dpyWQK7NIr55MSHm1nSordrg3VhEuF9dV0H
         ZAbmBwPoPjwrC381O6kOt/sWmHdDE96xY4kJFM8yPzFeXFFEptxJGPO9Byo6FkUa4/2l
         BXpQbd9IfMJdbn5uZrL3CMvs2fhFtFbJh7GYGRaHzJPKCAxSgQw1V/tVjA7miAkMMNsK
         5/oFWq3LngX1i8MiPkXfRT/4gPC1x8X2tjNJUfuC6O4oLPmQSLIeEsKEZtb2XDKtrDIO
         Acwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAL3fZUFBVwRXWuu2uhsqoK4mzwzp8b9HpzY6V1JSxM=;
        b=MQGAdK8x1/VNepxP6y40vVmPr1AZ6NPh6OjcRtvxjaAGYuUA+ra6TM0SWiHx7R2PPN
         ye14oPKASOm7ICewazxPfGclnwM3bHWrO48uofoedXuoQWCAqIHBz4pdhbYpKk/61f6l
         wXgk8CRVg9zT2n3XoAkAePgyyh7LJsDG9g1d+sgotyhgWjpRpjmE9eR1iXlTsj6cFKq8
         iMUKTk67mL4PKS6Q58HW8pZuUbcUEvXUSRYtjIbnP0RP5kxUY4L0Z8CdHb+5VhTVyvg5
         csytsKl2RfdJmfNEhpBQWAk2dtDYjz3Dn1Ie5hJe0b4wh7pnvWoZgdARsSNxtYMtuTQ6
         oogA==
X-Gm-Message-State: ABuFfojemIY7EeZusfe67fun8+tvNNbauSOeO8mBF5GwUql0VWADMu83
        gaMp3EAPrY0CM2s5jCJzs9zW6V6n
X-Google-Smtp-Source: ACcGV63XTPHlSZ6IkGp1k+LpH19058bcC+ck+1788NKi323frKDrOK7DUYWm3G3ikQB68NrTl3+CnQ==
X-Received: by 2002:adf:bc84:: with SMTP id g4-v6mr14406546wrh.250.1538918645598;
        Sun, 07 Oct 2018 06:24:05 -0700 (PDT)
Received: from kontron.lan (2001-1ae9-0ff1-f191-4cf5-3d33-8e4a-f17f.ip6.tmcz.cz. [2001:1ae9:ff1:f191:4cf5:3d33:8e4a:f17f])
        by smtp.gmail.com with ESMTPSA id l67-v6sm21435540wma.20.2018.10.07.06.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 06:24:04 -0700 (PDT)
From:   Petr Cvek <petrcvekcz@gmail.com>
Subject: Re: mt7621/mt7628 PCIe linux driver
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     ryder.lee@mediatek.com, blogic@openwrt.org,
        linux-mediatek@lists.infradead.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org
References: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
 <CAMhs-H-CM3bb9fg2eX6G_534bmuQYcoFa+pJSuNeArXLSXO4=Q@mail.gmail.com>
Message-ID: <283247bf-fa56-875a-6669-eddd6142d399@gmail.com>
Date:   Sun, 7 Oct 2018 15:25:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMhs-H-CM3bb9fg2eX6G_534bmuQYcoFa+pJSuNeArXLSXO4=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

sorry for a late reaction and thanks for your input. It took me two
weeks to get MT7628 ethernet driver to start working (so I could use the
current kernel version).

Dne 23.9.2018 v 08:20 Sergio Paracuellos napsal(a):
> Hi Petr,
> 
> On Sat, Sep 22, 2018 at 11:06 PM, Petr Cvek <petrcvekcz@gmail.com> wrote:
>> Hello,
>>
>> I'm trying to play with mt7628 PCIe (and it's old driver mt7620), but
>> the system keeps freezing. It is probably because of bus master access
>> of my PCIe cards but I don't see any memory access controls for PCIe <->
>> RAM in the datasheet. The same problem is with MSI. It seems the root
>> complex supports MSI (it has an MSI capability field), but there isn't
>> any mention in the MT7628 datasheet too. As it seems the MT7628 PCIe is
>> based on MT7621 PCIe, I went for an MT7621 datasheet, but sadly in the
>> datasheet the PCIe section is missing completely.
> 
> AFAIK, MT7628 should be covered with mt7620 driver. The source code is in
> arch/mips/pci/pci-mt7620.c. For initialization in really depends on
> the "ralink_soc"
> variable exported in arch/mips/ralink/prom.c.
> 

I was able to fix some of the problems. But still there are still
missing pieces.

The PCI driver (from pci-mt7620.c) isn't working in the vanilla version.
It has a lot of problems:
- Wrong access to the reset register (the wrong writing function used)
- IO access is not working at all. There is a function call missing to
setting MMIO base. The indirect access base register has a wrong value
and I've had to force code some other IOPORT related stuff.
- Forcing BAR0 is irrelevant for a root complex and it interferes with
kernel resources assignment.
- Cards other than 01:00.0 will have no IRQ set (and the drivers will fail).
- Some minor problem like using the mdelay vs msleep.


> You have to figure out why and where is really freezing. Does a clean kernel
> boots and success on setting up PCI? A 'dmesg' would be helpful.
> 
>>
>> Does anybody have a working MT7621/28 bus master setup or a more
>> completed datasheet? I would like to get some information for fixing the
>> mt7620 PCIe driver. It is possible the MSI/bus master is controlled by
>> the undocumented bridge registers (in the pci-mt7621 they controls the
>> manual oscillator settings, I've found a link quality register at
>> 0x101490c4) or in a PCI config space of the root complex (around 0x700
>> offset). If you have a working SoC with MSI/bus mastering (= mem access
>> from card), can you send me the dump of there spaces?
> 
> The datasheet for the mt7620 contains information about PCI registers.
> Linux initializes the
> pci topology but master bit of command registers for endpoints is
> disabled and is mission of final
> card driver to enable it in order to allow memory accessing to the card.
> 

But even with things (above) in the driver fixed, there will be still
questions for the documentation left:
- No MSI support or at least documentation for implementation (I could
do it myself probably). The MSI functionality is IMO required for PCIe
hosts, the MT7628 root complex itself has MSI capability.
- The 3.10 kernel from linux-mips.org had a support for spread spectrum
and manual PLL setting (no documentation for these registers too).
- No additional documentation for the interrupt of the controller
events. It could be useful to have its behavior because the PCIe
controller resets itself when it loses the link connection (and the
mention of this behavior could be useful to have in the datasheet too).
- Can the PCIe device/bus-master card access all 4 GiB of the MT7628
address space? What about 64bit address access?
- Does MT7628 support PCIe device mode (as observed from the hardware
behavior, when it sets it's own config space to a device/wireless
network class, from the residual mentions in the datasheet, from PCIe
device oriented registers and from similarities with MT SoCs which
support PCIe host/device mode)
- No documentation if there are any PCIe resistive terminations on chip
(I cannot get a connection without external resistors)
- I would like to have the documentation of 0x101490c4 register as it is
link quality oriented (which I've had to reverse engineer from hw
behavior when I was searching for a solution to resistor termination
problem).

> Hope this helps.

Well in a way it did ;-).

BTW the idea about merging with MT7621 is from TODO file from MT7621 driver:

https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/staging/mt7621-pci/TODO#L8

... and from that 3.10 kernel where all ralink/mediatek PCIe drivers
were in a single file (it seems the controllers are really similar).

> 
> Best regards,
>     Sergio Paracuellos
> 

cheers,
Petr
