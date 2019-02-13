Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C64C282C2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1623222B2
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 12:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbfBMMdy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:33:54 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:41377 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732946AbfBMMdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2019 07:33:53 -0500
X-Originating-IP: 37.164.88.57
Received: from windsurf (unknown [37.164.88.57])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DD797240003;
        Wed, 13 Feb 2019 12:33:50 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:33:48 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated
 bridge config space
Message-ID: <20190213133348.607ebec9@windsurf>
In-Reply-To: <CAEzXK1prnOXSkOEtTqXaR05pND=OMr2qiFHfqvnbUh+qyMyY-A@mail.gmail.com>
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
        <20190212144156.655f6824@windsurf>
        <CAEzXK1prnOXSkOEtTqXaR05pND=OMr2qiFHfqvnbUh+qyMyY-A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Luis,

On Wed, 13 Feb 2019 11:34:36 +0000
Luís Mendes <luis.p.mendes@gmail.com> wrote:

> The kernel with pci-mvebu-fix you provided is working nicely with the
> AMD graphics card, and other PCI cards that I've tested including an
> Intel I350.
> 
> If you want you can add a:
> Tested-by: Luis Mendes <luis.p.mendes@gmail.com>

Thanks a lot, glad to hear that it fixes the problem. I will submit
those patches, and see what the feedback is.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
