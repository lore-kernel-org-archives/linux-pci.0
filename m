Return-Path: <SRS0=MCOJ=OA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7251EC43441
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 07:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E76E20989
	for <linux-pci@archiver.kernel.org>; Wed, 21 Nov 2018 07:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E76E20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeKUSVT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:21:19 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36385 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKUSVT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Nov 2018 13:21:19 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E8139207AB; Wed, 21 Nov 2018 08:47:52 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id AAF5420729;
        Wed, 21 Nov 2018 08:47:52 +0100 (CET)
Date:   Wed, 21 Nov 2018 08:47:52 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
Message-ID: <20181121084752.544c3e79@windsurf>
In-Reply-To: <874lcagb45.fsf@tkos.co.il>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
        <20181003132811.GC427@lunn.ch>
        <20181003133543.t7laclm5wbj2olhq@sapphire.tkos.co.il>
        <20181116121043.GC3228@e107981-ln.cambridge.arm.com>
        <874lcagb45.fsf@tkos.co.il>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Wed, 21 Nov 2018 09:09:46 +0200, Baruch Siach wrote:

> As the listed maintainer of this driver, can you review this patch? This
> patch makes the PCIe slot reset sequence independent from the
> bootloader.

Yes, I'll have a look. Sorry for the delay.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
