Return-Path: <SRS0=66QY=NV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CDEC43441
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3093420858
	for <linux-pci@archiver.kernel.org>; Sat, 10 Nov 2018 00:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ctrlinux.com header.i=@ctrlinux.com header.b="WPb1cWQT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rb53jOhU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3093420858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ctrlinux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeKJKFQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:05:16 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41591 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728032AbeKJKFP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Nov 2018 05:05:15 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 42C5821F0A
        for <linux-pci@vger.kernel.org>; Fri,  9 Nov 2018 19:22:15 -0500 (EST)
Received: from web6 ([10.202.2.216])
  by compute7.internal (MEProxy); Fri, 09 Nov 2018 19:22:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ctrlinux.com; h=
        message-id:from:to:mime-version:content-transfer-encoding
        :content-type:subject:reply-to:date; s=fm1; bh=EKbYnbH07byfq6SeQ
        bJSn26G+entBbGJA5sYHQRetgo=; b=WPb1cWQTBJCMT3BSmXg+cGgrsLOtK2a80
        ThqFvmjbi4PtOxYqM+NZRx5XnikV23LTx6GVVpHN6u5084TIkSMUMspsaxiUD3JO
        lltLIoieEDZX1J14wrg/yn8CTKmplwjmLIR6Kkv3A+n1Kh9ShQdsz8b7SWZLzhlZ
        yDFZp2ZuTerLBsIsNmLR6n9SuNtc1TT142vLARtAVqiG/tjzYFTIAxhI16ASLna0
        MmLVNVN+OSLzrsZ/GUjdCDIpb0BqkiHsIgUn9Omo7TQGJ1gXEkrrRySvmJG9M0Ep
        hugrd1T01doVV6shLmxZ11ce6hou9Hm/5Joj3wRP3sf5ne4fxlNfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:reply-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EKbYnbH07byfq6SeQbJSn26G+entBbGJA5sYHQRetgo=; b=Rb53jOhU
        bg3Y6DKOjDRa9XsYF+4VX6bPknUOJt946HZbtzsaijwgmDjcb5ONuaimO69nptgN
        zFmR3yRxYfUb6XO2655EgTprgRNY3yYB6rt3O9pWvP5+/27zb96HS1/oLgthffHp
        /zTwgd+2hWZZRSNWYvZwwr85dYvsb1VoTsgtdBWZt6Wphn7kqCwxXsO+5HHwcAe1
        AZsxpygcA/BUmRFGO0o5ngyBeXqeCm4uspFb4tvCVCvdBXwaalFtb+c+z76Vm02x
        p9Lo8SQDVMceZTauEJ/AK+XF/UtYFy1EjtUlF3SvjRE5lQz6Fejq44X1Yobx+1eR
        szul0uRWXFAR0g==
X-ME-Sender: <xms:tiTmW2_YpgYFBew18ztpichvX-1p_6IAyc61KtLM4kw1aSnR1HpXGg>
X-ME-Proxy: <xmx:tiTmWyM7pjKhjcGuTKig3mGWPY6tsfjvPyTUCwgfx-toJk6-ntx10g>
    <xmx:tiTmW360zG7dfehZOvof8nJVqq5wyQ5jINNUDBezPrh7WqbVO0Z7cw>
    <xmx:tiTmW-54nDvH9njvZDdhB8csR29JHnRAsQkVCaArghcNb-jD8WdkFw>
    <xmx:tiTmW33SIj7eJsu3bxak--y3d2ryvLzgnRBgn80mC3FBJ4fs-7cLOA>
    <xmx:tiTmW6XiUNCMnKyiC1l7UV07bqWR_-HsDIaCuyfeHzMcH0yI7vWqCA>
    <xmx:tyTmW3UOqW8cn4y89LhGTH2b59fvkJG5L4YLZVnux-6e0QEBZ3UXPQ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id D510E4156; Fri,  9 Nov 2018 19:22:14 -0500 (EST)
Message-Id: <1541809334.2290928.1571950584.2632F1FD@webmail.messagingengine.com>
From:   Andrei Danaila <adanaila@ctrlinux.com>
To:     linux-pci@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-c0552f07
Subject: Sharing PCIe MMIO with other Drivers
Reply-To: adanaila@ctrlinux.com
Date:   Fri, 09 Nov 2018 16:22:14 -0800
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I have a question about best practices in writing an PCIe driver for an FPGA. If this is not the best place to ask, please let me know.

I have an FPGA which is connected over PCIe to an x86 host. The FPGA has a variety of peripherals on it, I2C, UART, SPI etc. All of these peripherals can be accessed from the host by accessing different offsets from the BAR0 address.

I am running linux kernel 4.14 on the host and have written a PCIe device driver which probes off the device id manufacturer ID of the FPGA.

The device driver calls pci_iomap( to obtain the cookie used to access the BAR. This works fine and via this mechanism I can read/write to the FPGA address space after calling ioremap on the cookie.

What I am trying to do now however is create a I2C platform device representing the I2C bus on the FPGA and add to it, as a resource, the BAR0 address + the I2C offset, to get the host's i2c driver to probe off this new PCI device.

In addition I am also trying to add an IRQ number for the I2C driver to use which is an MSIX mapped interrupt number obtained via pci_irq_vector.

In essence, I am trying to get the x86 host to own this device exposed via io-remapped region in PCI land, and use its driver to manage it.

The problem I am having is that I am getting a EBUSY return code when I try to register the resource to the platform device, after the pci_iomap has taken place.

The resource type is IORESOURCE_SYSTEM_RAM | IORESOURCE_MUXED and the start of the resource is the BAR0 address as returned by pci_iomap + I2C_OFFSET.

In the I2C device driver, I am expecting to do an ioremap on the resource and be able to access it by de-refencing


A couple of questions:

1. Is this the correct software flow for managing multiple devices exposed by a PCIe BAR0 address space?
    If not, what is the correct flow?
    If yes, any ideas on what may be going wrong?

Please feel free to point me to any examples, I have looked around quite a bit but did not manage to find enough detail to let me solve this problem.

Thank you
