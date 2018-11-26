Return-Path: <SRS0=Cddw=OF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BC2C43441
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F8620663
	for <linux-pci@archiver.kernel.org>; Mon, 26 Nov 2018 16:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQG/iCF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49F8620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeK0D0Z (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:26:25 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37594 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeK0D0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Nov 2018 22:26:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id 40so17157953oth.4
        for <linux-pci@vger.kernel.org>; Mon, 26 Nov 2018 08:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1n1WQs3tki1yR3rPhHxIPMmQbU3TXeza9RlcGZlIUTg=;
        b=kQG/iCF5jxKAGgTkZegLfIT0aIQ+PUXNRtIBZ76xYj0OYR533kCjXwnbp6FN8uehCR
         hRyJV470hoVhuDrtJqj2ico/XM/co5l3cqoO8e0jkHqTfXiknUEim8qF8iYnzogLWVem
         tN6CGO2tv62NvgfLINMhjRCaEwk0VUM0LQUfXXWeW+qYe8IQhztTRessOU7raVLBXoyV
         m3FYI+vnQzrurRuUQZKjy0WAXDYQ7icjOPQ5Ibc6yX0oW4XCCsJXcuH1mS20XFc/2938
         BV+501m+YhGrWHj6CekitNLgMFaalvUBwOulqbwQjPjEZrCZebl9QzBZARZ9Qw9QC85G
         K9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1n1WQs3tki1yR3rPhHxIPMmQbU3TXeza9RlcGZlIUTg=;
        b=ii4M2deFSIwI8s4q7nPimaf5Fx0IXEMqD2fUORLKX4nbD+XI373GZQu6rpst50+Ed9
         aM0QfWAg8M/jhsFIihCl7Lxejk157xm7z+KK9xIZomtx4yC8ZWKcXrWF3Yd/XYkCZRWl
         UUfMoPLCpbLmOX2ar2ZGy2YvmJOWrPbN3AnuP8+aQ9IF7yv5zIYRrYXiZxkdblhRDmek
         FDv7XPBVYDHKURtSrBzVbcN8TsYGuTIfT9WtFp2JpT/XE9Ecm3vY7XC0b8XftOxjCuO8
         otmTAnxB4m+nVCXt7gOHAVDIh0uigPlZGoZcFfrI9P8y4aim4AfE7Sn7jS1hwuNYjS/A
         kd9w==
X-Gm-Message-State: AA+aEWaeYjaXhyRhGOpzP3h0xtwS79y2ONETgzX1RRjfpuSoFuliDGjw
        qvXHTP3MSaG/uFA7v+olcuo1HYla6yxJ+3l33Ng=
X-Google-Smtp-Source: AFSGD/VLIPFhfFhxpWJKEqKZEamX0bhsuz3szZGgquD/lY6BdSLsssFF+bBgeAeTqw7fWwIHqvT2tKl75q/cOVtscAA=
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr15226956otl.196.1543249907782;
 Mon, 26 Nov 2018 08:31:47 -0800 (PST)
MIME-Version: 1.0
References: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
In-Reply-To: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 26 Nov 2018 14:31:44 -0200
Message-ID: <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
Subject: Re: iMX6 PCIe MSI issues
To:     hancock@sedsystems.ca, Tim Harvey <tharvey@gateworks.com>,
        Trent Piepho <tpiepho@impinj.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding Trent and Tim (as I think they managed to fix some imx6 MSI issues)

On Fri, Nov 23, 2018 at 8:17 PM Robert Hancock <hancock@sedsystems.ca> wrote:
>
> I am working with a custom FPGA PCI Express endpoint connected to an NXP
> iMX6D processor running the 4.19.2 kernel. It seems happy using INTx
> interrupts but when trying to enable MSI the device driver is not
> receiving any interrupts.
>
> From some register poking I have figured out:
> -the MSI address set on the PCIe device is correctly set in the iMX MSI
> controller's MSI Controller Address register (0x1ffc820)
> -the interrupt vectors are enabled in the MSI controller's Interrupt
> Enable register (0x1ffc828)
> -the interrupt vectors are not masked in the MSI controller's Interrupt
> Mask register (0x1ffc82c)
> -The MSI controller's Interrupt Status register (0x1ffc830) shows that
> the requested interrupt vectors are pending
> -In the ARM GIC, vector 152 (for msi_ctrl_int) is enabled in the IS
> enable register (0x00a01110), but not set in the IS pending (0x00a01210)
> or IS active (0x00a01310) registers
> -Vector 152 is not masked in the GPC interrupt mask (0x00a01310)
> -Vector 152 is not active in the GPC interrupt status (0x00a01310)
>
> So it appears the MSI controller is receiving and recognizing the MSI
> from the device, but the interrupt is not making it into the GIC for
> some reason. If I manually set vector 152 to pending in the GIC, the
> dw_handle_msi_irq handler in pci-designware-host.c does get called along
> with the interrupt handler(s) for the PCIe device, so it appears the
> chain from that point on is working:
>
> # devmem 0x00a01210 32 0x1000000
>
> I found someone else reporting this in 2014 with an unknown kernel
> version on the NXP forums here, but with no resolution listed there:
>
> https://community.nxp.com/thread/318307
>
> Any ideas on what may be going wrong? My next step may be to try an
> older kernel version to see if this got broken at some point.
>
> --
> Robert Hancock
> Senior Software Developer
> SED Systems
> Email: hancock@sedsystems.ca
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
