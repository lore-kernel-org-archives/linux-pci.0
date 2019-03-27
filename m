Return-Path: <SRS0=cd0N=R6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DDDC4360F
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A97B205C9
	for <linux-pci@archiver.kernel.org>; Wed, 27 Mar 2019 18:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJtscIZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbfC0SQG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:16:06 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:42908 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389957AbfC0SQG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Mar 2019 14:16:06 -0400
Received: by mail-vs1-f52.google.com with SMTP id f15so10504057vsk.9
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2019 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=yATBZViF1nMXSPPwyY4zoRHyc4bDa9OVRLL/j+zqAO0=;
        b=BJtscIZIzEKO1DZJdCEIe43/EM2i8QTMRGplwhYfirZ/OtgDwJkCg8jt+8x526FYQ8
         AQtZDm8gXlEuhfSKVOTCVd6M7W/xCurMWY4vdoO1FNWIJGcRYwEbPtSQDohuIIfGFN5O
         hV4IyW528T+UwYTv6jbMssekgtESvLGDgw1CcL7fBBTCzIvLDbIKDy3AMReQLNteCtHo
         JntjqnN+MXY0iDJ2hkuC4tRNtP8DSvwyw3fOsX9O9PmCI1ij8miJN8Vn0Tm4y58223Yb
         UeNiUc/3Gx3EctCrmMQfpVRCnojxmihSaNB14XJ3JXDNud6ZGEVkcsUS/Ajxp2/CC/Gs
         s6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=yATBZViF1nMXSPPwyY4zoRHyc4bDa9OVRLL/j+zqAO0=;
        b=Xu93y/i/ABG2NtSYdPsobX261Kvs9p5E4DLaeCKp6qo54PHdloifdJUkRZwpim+6el
         qDhGzwOkg6mouBO/QvOzLGacPYmV/kZ69wU6qKYGmVYZlxwe7JC68b0nxehiMmfp2rzk
         AOQho23hUNp+XO3l60Etg4nvJTxG2xlZ8OURAUaMjOTQRFiGYuHRXzXGCUzF0lBoiUoJ
         X4tNgtsdwHed+Uk/6DUKttz+JVgKfIErffbqVS3Z1Z3ClGRIJirON4bzvNoHYBbqZ4Be
         zVWc8cRqGNfJD51Q0AKjeJDY21rKOhyTC7tWAKChg21hIe61oMizBGZApkKNJKZI/OlY
         eIaQ==
X-Gm-Message-State: APjAAAVaX3wTArA5lz7jyAATvyBHztm0Ed+ExKSlleMXUhIsWvNfH4gO
        +D9cGCB6J6mO7VS3aIVqzZ7xl/8CaIQZyZJDp5NJx14=
X-Google-Smtp-Source: APXvYqznnsHte1g4A96PRz7DDawrFr83Ewk/jMM+io3Hqlv9soWaWlNAMHFbDwCWttbm7Zqd3FEviPm9Nit5UbN6yyc=
X-Received: by 2002:a67:be0a:: with SMTP id x10mr9273557vsq.128.1553710564386;
 Wed, 27 Mar 2019 11:16:04 -0700 (PDT)
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
From:   tedheadster <tedheadster@gmail.com>
Date:   Wed, 27 Mar 2019 14:15:53 -0400
Message-ID: <CAP8WD_YguzTJ=O6aR_wOGYQoc4_XEu4j_VM8DNrdALwTDrS+FA@mail.gmail.com>
Subject: r8169 not being recognized by different chipsets
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The r8169 driver is not recognizing my CardBus ethernet card depending
on the chipset it has. It seems to be related to the PCI bus
recognizing the card.  It works with some hardware and not with others
on the same kernel.

This is with both the 5.1.0-rc2 and 5.0.4 kernels, so I am up to date
with patches.

I have been able to debug it down to  mdiobus_scan() returning
returned -EIO, but that failure probably should not happen.

Below is the relevant PCI information:

Failing systems:
- The same 81801 bridge chip, different CardBus chips

00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev 81)
02:00.0 CardBus bridge [0607]: Texas Instruments PCI4520 PC card
Cardbus Controller [104c:ac46] (rev 01)
02:00.1 CardBus bridge [0607]: Texas Instruments PCI4520 PC card
Cardbus Controller [104c:ac46] (rev 01)
07:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)

00:1e.0 PCI bridge [0604]: Intel Corporation 82801 Mobile PCI Bridge
[8086:2448] (rev 81)
02:01.0 CardBus bridge [0607]: Texas Instruments PCI1520 PC card
Cardbus Controller [104c:ac55] (rev 01)
02:01.1 CardBus bridge [0607]: Texas Instruments PCI1520 PC card
Cardbus Controller [104c:ac55] (rev 01)
03:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)

Working systems:

00:01.0 PCI bridge [0604]: Intel Corporation 440BX/ZX/DX -
82443BX/ZX/DX AGP bridge [8086:7191] (rev 02)
00:04.0 CardBus bridge [0607]: Texas Instruments PCI1220 [104c:ac17] (rev 02)
00:04.1 CardBus bridge [0607]: Texas Instruments PCI1220 [104c:ac17] (rev 02)
06:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)

00:00.0 Host bridge [0600]: Cyrix Corporation PCI Master [1078:0001]
00:11.0 CardBus bridge [0607]: Texas Instruments PCI1221 [104c:ac19]
00:11.1 CardBus bridge [0607]: Texas Instruments PCI1221 [104c:ac19]
01:00.0 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
RTL8169 PCI Gigabit Ethernet Controller [10ec:8169] (rev 10)

- Matthew Whitehead
