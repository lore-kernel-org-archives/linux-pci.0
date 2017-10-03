Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22063 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbdJCMUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2017 08:20:43 -0400
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH v2] drivers/ide/pci: Fix legacy IRQ assignment
Date: Tue, 03 Oct 2017 14:20:37 +0200
Message-id: <3112151.6A1ekpngHL@amdc3058>
In-reply-to: <3245235.QGEOI6Flcd@amdc3058>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
References: <1506941567-10762-1-git-send-email-lorenzo.pieralisi@arm.com>
        <4605844.iOhxHctWQT@amdc3058> <3245235.QGEOI6Flcd@amdc3058>
        <CGME20171003122040epcas2p10af550eacdf170ffb8ebfd9a316316c0@epcas2p1.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, October 03, 2017 02:10:11 PM Bartlomiej Zolnierkiewicz wrote:

> IDE specific problems uncovered by pci_assign_irq() change have been
> addressed in separate patches, please see:
> 
> http://patchwork.ozlabs.org/patch/820859/
> http://patchwork.ozlabs.org/patch/820870/

v2 of the 2nd patch:

http://patchwork.ozlabs.org/patch/820875/

> Guenter, could you please verify them (I have only compile tested
> them)? [ Just revert Lorenzo's fix and apply both my patches. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
