Return-Path: <SRS0=DXvE=DC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCAEC4363D
	for <linux-pci@archiver.kernel.org>; Fri, 25 Sep 2020 10:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B3B20BED
	for <linux-pci@archiver.kernel.org>; Fri, 25 Sep 2020 10:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIYKAY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 25 Sep 2020 06:00:24 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:35398 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgIYKAX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 06:00:23 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 902B13B0D6E;
        Fri, 25 Sep 2020 09:51:44 +0000 (UTC)
X-Originating-IP: 86.206.245.199
Received: from windsurf.hq.k.grp (lfbn-tou-1-420-199.w86-206.abo.wanadoo.fr [86.206.245.199])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id EE9C8240016;
        Fri, 25 Sep 2020 09:51:20 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:51:20 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add me as a reviewer for PCI aardvark
Message-ID: <20200925115120.40977e7b@windsurf.hq.k.grp>
In-Reply-To: <20200925092115.16546-1-pali@kernel.org>
References: <20200925092115.16546-1-pali@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Pali,

On Fri, 25 Sep 2020 11:21:15 +0200
Pali Rohár <pali@kernel.org> wrote:

> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> I have provided more fixes to this driver, I have needed functional
> specification for this PCI controller and also hardware for testing
> and developing (Espressobin V5 and Turris MOX B and G modules).
> 
> Thomas already wrote [1] that is less involved in this driver, so I
> can help with reviewing/maintaining it.
> 
> [1] - https://lore.kernel.org/linux-pci/20200513135643.478ffbda@windsurf.home/

Acked-by: Thomas Petazzzoni <thomas.petazzoni@bootlin.com>

I would certainly be fine if you were OK to switch from a R: to a M: line.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
