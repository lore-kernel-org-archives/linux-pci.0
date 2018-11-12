Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6BC43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 02:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CBA214DB
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 02:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MopXOPMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7CBA214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbeKLMR3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 07:17:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39734 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbeKLMR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 07:17:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id n11-v6so3530884pfb.6
        for <linux-pci@vger.kernel.org>; Sun, 11 Nov 2018 18:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oq7IEiPRb7Qz/k6Vlh0Iig0PPwcDtR1ieDvW8kq5g2o=;
        b=MopXOPMTHV+3tmkm0VFWXrh5UqImVGIG5zS5tAORlkg8oQgGwubi9WrsC4WNp4n260
         7NK7ThiLX9crBKVFCdDXyreEZor8AQ+SIHLhZ46UvQp4bkz2IYfWQZSukdAiOt/2ie/w
         nrlkkecTNP+2+Q8PBBzPgAPlSShmdRUgPmCT347+GvwkiZ4v0TfmgylB10ut8qwLJJrf
         hbn3swOtIGkAtWS07Kg0X72fJo9E39XgMNlJyQNtHEYivcwR4DtSNMApeBc8xJJaw2zw
         6KQHxWLoSx42LJUMWM4OqqZkUQxfi+gQl8XU0vg2A/2Ksl53BZvrqltYTYG7zg2339H5
         XOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oq7IEiPRb7Qz/k6Vlh0Iig0PPwcDtR1ieDvW8kq5g2o=;
        b=EFIeky7S943eX2ZExdNZTH7gHiSr+ow0Pe0epHVoh2uJywO8PrdAP8jrjzyW6UzDCW
         cctTYwarMFDc7tDgG8dWy2l0YhTvfu8MqqD+TryPGYpZB03yvUda9ye/AtwcOp5Xw7Ob
         mSGFd7TSzkvMMN/F1QBd4HsX4GVQVxuQpHMGpVR+xJJPZNdB3x/ZLXNQYPnvX5BFGjSq
         s9wfjacT+E/9fQrNmw5ISf80ldRTjVuUxUAAlDpbR5aMbF1PCtDoz7cj10X87k8F8BVG
         KS3NFZQZkxF3DPgAK039Ah1IfS7pwIcmlJ+M3/ni8rU7gU0/Kot6ugq6rTCznP6rFfyU
         9HMg==
X-Gm-Message-State: AGRZ1gLvTV5A35kNzXkQofd1V3hnh7prCpmEdlzma0KCFc7t5SwXnTEq
        hH9s4n4X+WJElvv5FPL/V36wqx1l
X-Google-Smtp-Source: AJdET5f5HhO+q4tyVa1eGNF1sff1sBlRlmDz1+R+wTh4Cgn8UlyGRYq4VE6UkV3XTrzk0r3wfNeKTw==
X-Received: by 2002:a63:e156:: with SMTP id h22mr15950908pgk.255.1541989591484;
        Sun, 11 Nov 2018 18:26:31 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
        by smtp.googlemail.com with ESMTPSA id v191sm18067721pgb.77.2018.11.11.18.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 18:26:30 -0800 (PST)
Message-ID: <76ae362ccc94b836acf90839d96ff28c9f0f568b.camel@gmail.com>
Subject: Re: Sharing PCIe MMIO with other Drivers
From:   Oliver O'Halloran <oohall@gmail.com>
To:     adanaila@ctrlinux.com, linux-pci@vger.kernel.org
Date:   Mon, 12 Nov 2018 13:26:26 +1100
In-Reply-To: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
References: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-11-09 at 16:22 -0800, Andrei Danaila wrote:
> Hello,
> 
> I have a question about best practices in writing an PCIe driver for an FPGA. If this is not the best place to ask, please let me know.
> 
> I have an FPGA which is connected over PCIe to an x86 host. The FPGA has a variety of peripherals on it, I2C, UART, SPI etc. All of these peripherals can be accessed from the host by accessing different offsets from the BAR0 address.
> 
> I am running linux kernel 4.14 on the host and have written a PCIe device driver which probes off the device id manufacturer ID of the FPGA.
> 
> The device driver calls pci_iomap( to obtain the cookie used to access the BAR. This works fine and via this mechanism I can read/write to the FPGA address space after calling ioremap on the cookie.
> 
> What I am trying to do now however is create a I2C platform device representing the I2C bus on the FPGA and add to it, as a resource, the BAR0 address + the I2C offset, to get the host's i2c driver to probe off this new PCI device.

Keep in mind the address you read out of BAR0 in config space is a PCI
bus address which isn't necessarily usable as a system physical
address. It might be fine on x86 though.

> 
> In addition I am also trying to add an IRQ number for the I2C driver to use which is an MSIX mapped interrupt number obtained via pci_irq_vector.

You should be able to do something with an irqchip to forward the
interrupt to the platform device safely.

> 
> In essence, I am trying to get the x86 host to own this device exposed via io-remapped region in PCI land, and use its driver to manage it.
> 
> The problem I am having is that I am getting a EBUSY return code when I try to register the resource to the platform device, after the pci_iomap has taken place.
> 
> The resource type is IORESOURCE_SYSTEM_RAM | IORESOURCE_MUXED and the start of the resource is the BAR0 address as returned by pci_iomap + I2C_OFFSET.

IIRC IORESOURCE_SYSTEM_RAM marks the resource as being normal system
RAM (i.e. cacheable) rather than MMIO space, so this probably not the
right set of flags to use.

Anyway, trying to create resource from the result of pci_iomap() sounds
a little fishy to me since memory resources generally contain physical
addresses and pci_iomap() should be returning a virtual address. The
-EBUSY is probably due to the resource you created conflicting with an
existing resource that doesn't have the MUXED flag set. I don't
remember the exact process for doing this properly, but If I were you I
would:

a) convert your resource to use physical addresses
b) make the BAR resource the parent of your new resource.

and see if that fixes the problem.

Oliver


