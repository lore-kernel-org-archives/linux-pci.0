Return-Path: <SRS0=P0ok=QT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D860AC282C4
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 13:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85EB2184A
	for <linux-pci@archiver.kernel.org>; Tue, 12 Feb 2019 13:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfBLNmA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:42:00 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46635 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbfBLNmA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Feb 2019 08:42:00 -0500
X-Originating-IP: 90.88.30.68
Received: from windsurf (aaubervilliers-681-1-89-68.w90-88.abo.wanadoo.fr [90.88.30.68])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id F3DD440011;
        Tue, 12 Feb 2019 13:41:57 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:41:56 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated
 bridge config space
Message-ID: <20190212144156.655f6824@windsurf>
In-Reply-To: <CAEzXK1r_Xf=-JSzrP8+0pgeqE+RE0Vx0JAKM0PW7qzc4fgQLNg@mail.gmail.com>
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
        <20181218144702.752d97cd@windsurf>
        <20181218153404.45b038cf@windsurf>
        <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
        <20181218213716.70d27f1f@windsurf>
        <CAEzXK1qKXikS4qd1q_kw7r-_ykBgYnKQzGFhV4TT_HXhq2v6Tw@mail.gmail.com>
        <20190108114817.2bb15d5e@windsurf>
        <CAEzXK1oQd1YNZ5pyNXA76h-3CbBRxmTke=Z-SRusyfqL=Wd8eA@mail.gmail.com>
        <20190109091520.23641675@windsurf>
        <CAEzXK1oHqOb3pojfX7JqrirxjOFj=UZZfi6tNNO4y6yC3u9LAA@mail.gmail.com>
        <CAEzXK1r_Xf=-JSzrP8+0pgeqE+RE0Vx0JAKM0PW7qzc4fgQLNg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, 4 Feb 2019 11:09:23 +0000
Luís Mendes <luis.p.mendes@gmail.com> wrote:

> Have you been able to find the issue from the logs?

A separate issue was found with the pci-mvebu integration with the new
emulated bridge code, I added you in the thread.

Could you test if:

  https://github.com/tpetazzoni/linux/tree/5.0/marvell/pci-mvebu-fix

improves the situation for you ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
