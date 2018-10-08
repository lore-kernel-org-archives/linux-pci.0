Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACDCC00449
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 04:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABA52085B
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 04:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvoO/gEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ABA52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbeJHLa3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 07:30:29 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44912 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeJHLa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 07:30:29 -0400
Received: by mail-wr1-f43.google.com with SMTP id 63-v6so19143617wra.11
        for <linux-pci@vger.kernel.org>; Sun, 07 Oct 2018 21:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4zs8kYJcjcwI28OyCw+2MLK+KC/8JZmg7YPIp5JHt20=;
        b=IvoO/gEMRdXa6iWs74LuW7R13xAcAeY7KFCxZ1HgAC9V9pN3Zz2lbPbq9GGS0oz6Zn
         6GOnYTViSs7rUjA1RnFbc/SqVFQbZ0BxkQsEDqkYNgaBtzCKdB7Zsme/NcZChYQUq5Ca
         NuH+q1uBjhfGI3JK+q34tVzmd25dCcdCb+S8N9E61/sZcJ+7ah+t3wxOIzNwBonz/92l
         X/0wqbLcI/3Tz4v/KH2FILd2wMqDMQMojrF5BH9tNfGRQ2ne8Xmd2kqPQlrmaGm8kjP6
         zjSLeGgwVtYxT7IOEFOTy3PY2lPLH1YhqNnEVIHgJD8G/JKMXdBXgZSL/x6gijRVLMh0
         noIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4zs8kYJcjcwI28OyCw+2MLK+KC/8JZmg7YPIp5JHt20=;
        b=aPYkb1NgSLaAYGTjDDBRV27X8TxWra+XmaY7ySZ7RUa4t71OeDlASFEr9i99L/4yux
         8z8huzts66uhHhxoUGaR812zpjEwnDI3NTLZVucOoqSh4woU++dGLFaqXC0+jLdab/L5
         SURfAQ1tkTaoczlfRT+adAVK9o0FI6PLIADYFGOfm84s04OrJxGl0Z7Vpqy672DNTRdr
         L6JTFY++cSttU6g8btN2txDXJQiCz97qywix6Qoz0ByH1Jh50MafOsTHgCQ9DXPfcwCR
         8E8MeJxI3a6ss2lUkYLMydw57rPJVV8p7R2myWjqdOKaaiiuxY7FntRVTKEiiqxxPGd3
         cLbQ==
X-Gm-Message-State: ABuFfogL6LvxvHGRGFOnPVTlAVeaCU2gBGl28muGYClJDcjXnJdpDMY8
        NuosH25rPPL9kIifqn7Zfd0=
X-Google-Smtp-Source: ACcGV612dd1H2RS6ZgH5ByuosfeAeYQW9QGZ8N+aoWEjXPCtIHLH3IhDyK4uZYVtrzU7SO22HFetiQ==
X-Received: by 2002:adf:9503:: with SMTP id 3-v6mr16097626wrs.91.1538972445943;
        Sun, 07 Oct 2018 21:20:45 -0700 (PDT)
Received: from foobar (7.red-2-136-35.staticip.rima-tde.net. [2.136.35.7])
        by smtp.gmail.com with ESMTPSA id v10-v6sm13002809wrp.0.2018.10.07.21.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 21:20:44 -0700 (PDT)
Date:   Mon, 8 Oct 2018 06:20:42 +0200
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     Petr Cvek <petrcvekcz@gmail.com>
Cc:     ryder.lee@mediatek.com, blogic@openwrt.org,
        linux-mediatek@lists.infradead.org, linux-mips@linux-mips.org,
        linux-pci@vger.kernel.org
Subject: Re: mt7621/mt7628 PCIe linux driver
Message-ID: <20181008042042.GA14820@foobar>
References: <8fd595af-53fa-c100-c369-8c7a30eba8e3@gmail.com>
 <CAMhs-H-CM3bb9fg2eX6G_534bmuQYcoFa+pJSuNeArXLSXO4=Q@mail.gmail.com>
 <283247bf-fa56-875a-6669-eddd6142d399@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283247bf-fa56-875a-6669-eddd6142d399@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 07, 2018 at 03:25:30PM +0200, Petr Cvek wrote:
> Hello,
>
Hi Petr,
 
> sorry for a late reaction and thanks for your input. It took me two
> weeks to get MT7628 ethernet driver to start working (so I could use the
> current kernel version).

Those are good news :-).

> 
> Dne 23.9.2018 v 08:20 Sergio Paracuellos napsal(a):
> > Hi Petr,
> > 
> > On Sat, Sep 22, 2018 at 11:06 PM, Petr Cvek <petrcvekcz@gmail.com> wrote:
> >> Hello,
> >>
> >> I'm trying to play with mt7628 PCIe (and it's old driver mt7620), but
> >> the system keeps freezing. It is probably because of bus master access
> >> of my PCIe cards but I don't see any memory access controls for PCIe <->
> >> RAM in the datasheet. The same problem is with MSI. It seems the root
> >> complex supports MSI (it has an MSI capability field), but there isn't
> >> any mention in the MT7628 datasheet too. As it seems the MT7628 PCIe is
> >> based on MT7621 PCIe, I went for an MT7621 datasheet, but sadly in the
> >> datasheet the PCIe section is missing completely.
> > 
> > AFAIK, MT7628 should be covered with mt7620 driver. The source code is in
> > arch/mips/pci/pci-mt7620.c. For initialization in really depends on
> > the "ralink_soc"
> > variable exported in arch/mips/ralink/prom.c.
> > 
> 
> I was able to fix some of the problems. But still there are still
> missing pieces.
> 
> The PCI driver (from pci-mt7620.c) isn't working in the vanilla version.
> It has a lot of problems:
> - Wrong access to the reset register (the wrong writing function used)
> - IO access is not working at all. There is a function call missing to
> setting MMIO base. The indirect access base register has a wrong value
> and I've had to force code some other IOPORT related stuff.
> - Forcing BAR0 is irrelevant for a root complex and it interferes with
> kernel resources assignment.
> - Cards other than 01:00.0 will have no IRQ set (and the drivers will fail).
> - Some minor problem like using the mdelay vs msleep.

mt7620 driver is an old driver and it uses the PCI legacy kernel options to build
and correct compilation. So I don't know if you are just looking to the PCI_GENERIC
support in the kernel.

> 
> 
> > You have to figure out why and where is really freezing. Does a clean kernel
> > boots and success on setting up PCI? A 'dmesg' would be helpful.
> > 
> >>
> >> Does anybody have a working MT7621/28 bus master setup or a more
> >> completed datasheet? I would like to get some information for fixing the
> >> mt7620 PCIe driver. It is possible the MSI/bus master is controlled by
> >> the undocumented bridge registers (in the pci-mt7621 they controls the
> >> manual oscillator settings, I've found a link quality register at
> >> 0x101490c4) or in a PCI config space of the root complex (around 0x700
> >> offset). If you have a working SoC with MSI/bus mastering (= mem access
> >> from card), can you send me the dump of there spaces?
> > 
> > The datasheet for the mt7620 contains information about PCI registers.
> > Linux initializes the
> > pci topology but master bit of command registers for endpoints is
> > disabled and is mission of final
> > card driver to enable it in order to allow memory accessing to the card.
> > 
> 
> But even with things (above) in the driver fixed, there will be still
> questions for the documentation left:
> - No MSI support or at least documentation for implementation (I could
> do it myself probably). The MSI functionality is IMO required for PCIe
> hosts, the MT7628 root complex itself has MSI capability.
> - The 3.10 kernel from linux-mips.org had a support for spread spectrum
> and manual PLL setting (no documentation for these registers too).
> - No additional documentation for the interrupt of the controller
> events. It could be useful to have its behavior because the PCIe
> controller resets itself when it loses the link connection (and the
> mention of this behavior could be useful to have in the datasheet too).
> - Can the PCIe device/bus-master card access all 4 GiB of the MT7628
> address space? What about 64bit address access?
> - Does MT7628 support PCIe device mode (as observed from the hardware
> behavior, when it sets it's own config space to a device/wireless
> network class, from the residual mentions in the datasheet, from PCIe
> device oriented registers and from similarities with MT SoCs which
> support PCIe host/device mode)
> - No documentation if there are any PCIe resistive terminations on chip
> (I cannot get a connection without external resistors)
> - I would like to have the documentation of 0x101490c4 register as it is
> link quality oriented (which I've had to reverse engineer from hw
> behavior when I was searching for a solution to resistor termination
> problem).

I agree that the physical part of the PCI is not documented anywhere. 
I think all of this support is reverse engineering from the mediatek SDK.
Maybe you can get better feedback from the mediatek guys.

> 
> > Hope this helps.
> 
> Well in a way it did ;-).

Good to know :-).

> 
> BTW the idea about merging with MT7621 is from TODO file from MT7621 driver:
> 
> https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/staging/mt7621-pci/TODO#L8
> 
> ... and from that 3.10 kernel where all ralink/mediatek PCIe drivers
> were in a single file (it seems the controllers are really similar).

Since mt7621 is a staging driver it is not possible at all to use PCI_LEGACY in order to
get it mainlined with the rest of the kernel (with mt7620 together I mean). Anyway mt7621 has three PCI express controllers.
I sent some patches cleaning the PCI_LEGACY part (these have been applied):

http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-August/124480.html

and there are still some series which are not applied yet (I don't have the HW and I can't test it by myself).
In case of interest see the followings:

Some cleanups and others:
    * http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-September/125937.html

About device tree bindings:
    * http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-September/126604.html

Best regards,
    Sergio Paracuellos
> 
> > 
> > Best regards,
> >     Sergio Paracuellos
> > 
> 
> cheers,
> Petr
