Return-Path: <SRS0=EJXn=O3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9D0C43387
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 20:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCAD21871
	for <linux-pci@archiver.kernel.org>; Tue, 18 Dec 2018 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLRUhS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:37:18 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42732 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeLRUhS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Dec 2018 15:37:18 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 28BDE20731; Tue, 18 Dec 2018 21:37:16 +0100 (CET)
Received: from windsurf (lfbn-tou-1-411-96.w86-206.abo.wanadoo.fr [86.206.237.96])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0344D206A7;
        Tue, 18 Dec 2018 21:37:16 +0100 (CET)
Date:   Tue, 18 Dec 2018 21:37:16 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     =?UTF-8?B?THXDrXM=?= Mendes <luis.p.mendes@gmail.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: Regression with commit PCI: mvebu: Convert to PCI emulated
 bridge config space
Message-ID: <20181218213716.70d27f1f@windsurf>
In-Reply-To: <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
References: <CAEzXK1o9L-bVRGBpAo+a_wYqXZh6_zuebF221Bd8=b-DTL1Q9g@mail.gmail.com>
        <20181218144702.752d97cd@windsurf>
        <20181218153404.45b038cf@windsurf>
        <CAEzXK1ryTQ5sbUSuZoq36ss=Z7ewLegaxsXtvsNOGqHyTQibmg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Tue, 18 Dec 2018 15:42:34 +0000, Luís Mendes wrote:

> Thanks a lot for your quick reply and patch, but unfortunately the
> problem remains the same with the patch applied.

Gaah, too bad. A shot in the dark sometimes works, sometimes not.

> How can I help to further pin down the issue?

Could you post the output of:

lspci -vvv -xxx

with the "PCI: mvebu: Convert to PCI emulated bridge config space"
patch applied and reverted, and send the result ? This would allow me
to look at the differences in the configuration space exposed by the
emulated bridge and hopefully see which one might cause the regression.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
