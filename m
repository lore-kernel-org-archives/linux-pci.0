Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F010DC43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 21:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CD821852
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 21:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="ZJew4QCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfBZVN2 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:13:28 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39905 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfBZVN2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 16:13:28 -0500
Received: by mail-wm1-f49.google.com with SMTP id z84so3611349wmg.4
        for <linux-pci@vger.kernel.org>; Tue, 26 Feb 2019 13:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=TKJFvg+1/eRnHAd1ETP7gYPMxVR4uWq7tJj23vh5ZrI=;
        b=ZJew4QCRM0g2z3xtCggzGqM4j6lBiOadtsxE9i+taGUFvijz7mO3BkzDaDrrhM3MdK
         j9iUv82M+o/hxtiZCMz9meyfgK6IdiHNVxr9mk7xr6YctkV4Z/++yrb+jReOaccsOVWG
         IKPGxgosEOfY7fFiW0/f93R8a/u5vXNjtDsRIfbvmWNBVQTawp2uCWrjpC801NKNR+Al
         ySf0t/YpxYKa7moR+EX+G2VwRvXC4nxvxeTyKObggMu/GBOTmvRWv3sq9PFms66LT0NQ
         IayUpclqk9IcWis0HrWzZe79R5CjO84owJUdazCrKNvYqSJgNVs1Rx7oTxxAY/Q5XCaI
         oSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TKJFvg+1/eRnHAd1ETP7gYPMxVR4uWq7tJj23vh5ZrI=;
        b=ql5HuIQQX8NcEDSs8UHx9hOUXIxWILaVsv90dP0V57JVU9lAFz3m61aPFxMiW8Re3W
         J0M5Ta7Yh+s2lhvi/WuDxAfOOde5kT6wISle82CgTVzr+3Ok8BX+Bn1TcjNxvnwJL/t3
         Z1X4Mqtxifu9AzT+DYC1vVJQemBuVwimdzxIzpJOlxX5EGj6pR1P/C3w1lX5dJxm5iBD
         zzYrd/K6BSoAeAfivckWlAeGOuvsh5fo34I5Bo9JscisXIPgB7Zljc6IHFPJJkcLu2I2
         MK1iJid97BI7nYLyiYWf/Iq7VZ7F9atr23cO9jTNYYD87kyqhEbo5ykZY8HDud2KDxKM
         9tlw==
X-Gm-Message-State: APjAAAV6hh581+O4OmnKw/h2i2hR5ACesxVPOREczwkMhbrjAZMhNDHt
        AApvd2bynYezeLeJ50r3sC3QLnHuXgme7iHqfhkzD1gsVRM=
X-Google-Smtp-Source: APXvYqyERmAgudauhPZ3M4nFbtmi/oq/ZP+pe7ChrbiNWvSvgUMAfo6hBRwVYGuaoPFga4uAZ97h8dtwNZ4Im/iw8JI=
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr85144wmh.42.1551215605467;
 Tue, 26 Feb 2019 13:13:25 -0800 (PST)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 26 Feb 2019 13:13:14 -0800
Message-ID: <CAJ+vNU2XcJ+btfM64p4W7VrBvB6W89MZ=+8G5NYWP16MRrY56A@mail.gmail.com>
Subject: IMX6 dwc PCI regression through switch - unable to request (legacy)
 interrupt (pci=nomsi)
To:     linux-pci@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Greetings,

I've got a miniPCIe card with a TW6869 8x frame grabber that stopped
working on an IMX6 based board with a PLX switch with Linux 4.17 as
the driver errors out with 'tw686x 0000:07:00.0: unable to request
interrupt' (request_irq() fails). I've found this only happens on
boards that have a switch. Note I'm booting with pci=nomsi as well as
the IMX6 has a limitation where legacy IRQ's wont fire if MSI irq's
are enabled. Strangely I don't see this issue with other cards such as
the ath9k with msi disabled.

I bisected the issue to 7c5925afbc58c6d6b384e1dc051bb992969bf787 'PCI:
dwc: Move MSI IRQs allocation to IRQ domains hierarchical API' which
due to continued changes in drivers/pci/dwc can no longer be reverted.

Any ideas what happened here? IMX6 PCIe through a bridge always seems
not so well tested and very fragile over the past couple of years.

Best Regards,

Tim
