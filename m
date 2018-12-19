Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474FFC43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 14:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C6921841
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 14:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkxOyuQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeLSOgT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:36:19 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34254 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeLSOgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 09:36:19 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so19339870otk.1;
        Wed, 19 Dec 2018 06:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1J0G7Qb3L5GwrfmGAi18Vk60flEeeXwzQEPVkr55SY=;
        b=AkxOyuQ/VKMUyBKMAsIpcqo3mrGqy/ybUEq99It7f+i+QeLwblefCZ83NKSCVGVXby
         lcy5Tbxo+Eh7BN4m63AboyDERrSkLysJ7kZJeU1TUqXLozV+93uxLlgLNpozxYayvLsZ
         1HXyfzFSrmQXtrCNtG7SKD/SAA3dlZmq4xpVuskdGeKrw8pUcJEhG01BEfN2cboIeS3g
         oe7b2YwBiEBDYELbrIb1pjgtPQAKSPSIcD7l7qfjCAg+22qnmykKNczkkk1NoGRGYVOB
         2R9UwNGXiKhUj8VL4/5wWavdNa2KbNUR1C5V2styzHvQp0oRTqvx4pkfCPjvnC3Zu2OI
         K3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1J0G7Qb3L5GwrfmGAi18Vk60flEeeXwzQEPVkr55SY=;
        b=LwgL8ZtH3U8Rjry9iOw9O/S4QQngexQ0LGi6J2fuJkJz2z84w4kwlpwCx5goTN8sPP
         ouQnNY1F3rLcAITj7xVO3oEDH0JAGpzQWT8pwAEYyCDl55yV9qqGMCQoxp1Mgt1rUP+b
         +vKRME30BQfDa0th76pRSFfCyBXQVMKiStwWzYZXDFmIaSH18tz52lSYycjd+HsTZ+jo
         Q12KM7cpYKcQuZ0U+TlddOF+nXfS7LPojvEP5YrGe0Vcs1fXJDsTBYkhgY80luMsbRV5
         qToZ6C0LOeIseAECpA1G/O/iXrOCq+p+zGbg25tA+YDQuYJmOyP2eb+51KBP+35hHFL5
         qH+w==
X-Gm-Message-State: AA+aEWYZGzwmBmMa3dIq68EEJWBXJ6BKLjShzAdvfTj2P/9EsnT2XlWj
        LUzJ9t66jrpHYobwhPe51gDHUeb5CmDCe22VIkd8saDhkfk=
X-Google-Smtp-Source: AFSGD/UgRLSh8/GFEdpsl9xF2QriOmP/FnBpyP0jEteY15mqRsbcsZlcMFCiCzNbmrVaDwRDaOldPhi1liitXQdMSuo=
X-Received: by 2002:a9d:74c3:: with SMTP id a3mr5481870otl.107.1545230178083;
 Wed, 19 Dec 2018 06:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20181218210444.5950-1-TheSven73@googlemail.com> <1545174393.22930.65.camel@impinj.com>
In-Reply-To: <1545174393.22930.65.camel@impinj.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 19 Dec 2018 09:36:07 -0500
Message-ID: <CAGngYiXRXmgWQwUGRrymZzbD-sRqHmzP2u4ysv15S1ha8vbn2g@mail.gmail.com>
Subject: Re: [RFC BUG] pci: Freescale i.MX6 PCIe controller: revert mainline regression
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you Trent !

This patch was intended as a bug report, rather than an actual
solution to be merged.
I chose this format so people could easily verify the change in
behaviour, just by
applying the patch locally.

On Tue, Dec 18, 2018 at 6:06 PM Trent Piepho <tpiepho@impinj.com> wrote:
>
>
> It's actually commit f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig
> selection of CONFIG_PCIEPORTBUS") that made this problem apparent.
>
> But the real bug is not in that commit, but a problem with imx6/7 not
> configuring a setting in the RC correctly without pcieportbus, which
> should not be necessary.
>
> See "[v4] PCI: imx: make msi work without CONFIG_PCIEPORTBUS=y" by
> Richard Zhu for a real fix.

Awesome! I can verify this patch on our i.MX6 boards, if Richard Zhu
(or anyone else) is interested.

>
> There another bug that makes this driver sometimes lose an MSI, but

Is it the one you alerted me to before?
https://patchwork.kernel.org/patch/10657987/

We are planning to use the PCIe controller in a production environment -
to communicate with a tg3 based Broadcom ethernet NIC.

What are the practical consequences of this bug?
What is the state of the patch that fixes it?
Last patch activity seems to have been in mid-November?

Apologies for the trivial questions, I am by no means a PCIe expert.

> that regression was in v4.14 and would not be fixed by your patch, so
> this tigon3 problem is almost certainly caused by the previously
> mentioned issue with pcieportbus.
>
