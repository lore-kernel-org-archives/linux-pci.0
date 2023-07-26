Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32FEC001DC
	for <linux-pci@archiver.kernel.org>; Wed, 26 Jul 2023 11:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbjGZLqC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Jul 2023 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjGZLqB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 07:46:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556753585;
        Wed, 26 Jul 2023 04:45:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99342a599e9so1128680266b.3;
        Wed, 26 Jul 2023 04:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690371889; x=1690976689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Jxs0fOJLTdaAHkFwdwifoROzPuQHOe1aKlOsGdIk/Q=;
        b=rVzDmnNwa2Y0PtEEII62KiyYrkg7EjfcReI9qalg5Pj67aLBYc6BG3Nz6Nv9rJ8Tag
         wI6S4QEUIcge4YxtWTmp/U8SogueHl3dTdDLrOqJvtNT6O8DIMrGMk+i25jmPZR7lBGJ
         IBNhlLJtk7JP7xJJmgu/GsdtRK6I9DIV0P2WzEvDDUnebHwGANbGz7QUttSMtKJPOFoY
         o4YdTWAVeY90vQxrRaMZ9PRqDNVPpvY7sfKKZZ7bR3/QLJRGalU4jDG4RISROjj3cBk6
         +pkp1sxDEfx0HRQMtTShUuZNb062gjBbhCwfp96zrFJHkli9DRgp0AklhXkldaeqCvdD
         cgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690371889; x=1690976689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Jxs0fOJLTdaAHkFwdwifoROzPuQHOe1aKlOsGdIk/Q=;
        b=XYUzLTnzcXQYQ//8gMN7brUNGACER0ZTrt+x3tQL2tDLyU4+R9A0+ToexWz6AiffHV
         n15Z9YagVY24p7NN5BpRc3bDYn9aO/+1VaqpUDbVWwc4oIL7I9mHONJbZ6Y4AHl8V2/X
         Lg8Kvi7sLgjbtfRBE5Zy4QR33gIrBETzZFCvL+09Wb9RPJ+bAn0p/bHtee2/32f0DKH7
         Ngf67IzW5T9OAbTyJKYAsEvyfLJcAoE4+q4vBlET6OnV7dMBuyiHSeKig1DTz04wkfQ7
         Y8wXD5LJSeF6E3ohvHiYcpT4QZ5cVFp+Ci323McfZG2vlUuQvik1Vi3+XladC3g/Yi+l
         Ja+w==
X-Gm-Message-State: ABy/qLaQwRKX4HtaiUGK61fb771fGoK1SwtzBsrStm/3QJ9Hh2KEKfsy
        MJ87SixYgwN0JYXCyFZhF6tbn9536LJu1oGQLey2V7z9H7w=
X-Google-Smtp-Source: APBJJlEmdF8AcS/zpgVhNrAf7by/1chWf2ukKopttGylBTycpLGvESXDcvZEi9he6YDumuW4xXxsW8dekRGijr1DDQ4=
X-Received: by 2002:a17:907:7745:b0:99b:c778:d46d with SMTP id
 kx5-20020a170907774500b0099bc778d46dmr1354012ejc.75.1690371888954; Wed, 26
 Jul 2023 04:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230724083933.3173513-1-jiaqing.zhao@linux.intel.com> <20230724083933.3173513-5-jiaqing.zhao@linux.intel.com>
In-Reply-To: <20230724083933.3173513-5-jiaqing.zhao@linux.intel.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 26 Jul 2023 12:44:12 +0100
Message-ID: <CADVatmOSGzD4sn3-JGFpCJsfqt2TTndXgArt7_DPMmE1b2vhDA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] parport_pc: add support for ASIX AX99100
To:     Jiaqing Zhao <jiaqing.zhao@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Gerhard Uttenthaler <uttenthaler@ems-wuensche.com>,
        support@ems-wuensche.com, linux-serial@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Jul 2023 at 09:40, Jiaqing Zhao <jiaqing.zhao@linux.intel.com> wrote:
>
> The PCI function 2 on ASIX AX99100 PCIe to Multi I/O Controller can be
> configured as a single-port parallel port controller. The subvendor id
> is 0x2000 when configured as parallel port. It supports IEEE-1284 EPP /
> ECP with its ECR on BAR1.
>
> Signed-off-by: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
