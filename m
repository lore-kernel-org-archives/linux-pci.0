Return-Path: <SRS0=/qR3=MN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB50C43143
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 12:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830AF2089D
	for <linux-pci@archiver.kernel.org>; Mon,  1 Oct 2018 12:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830AF2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeJAT3c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:29:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56638 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbeJAT3c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Oct 2018 15:29:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 66D4B207EB; Mon,  1 Oct 2018 14:51:48 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-24-95.w90-88.abo.wanadoo.fr [90.88.144.95])
        by mail.bootlin.com (Postfix) with ESMTPSA id 103CE20719;
        Mon,  1 Oct 2018 14:51:48 +0200 (CEST)
Date:   Mon, 1 Oct 2018 14:51:48 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>,
        <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20181001145148.158c6207@windsurf>
In-Reply-To: <0f80dc88-dffe-4ca6-bb85-c4e5c967e0e1@cesnet.cz>
References: <20180912231050.GX30658@n2100.armlinux.org.uk>
        <20180913094515.351967bb@windsurf>
        <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
        <20180913104241.65db8243@windsurf>
        <20180924101213.GO30658@n2100.armlinux.org.uk>
        <20180924122614.70738b5c@windsurf>
        <20180924111341.GP30658@n2100.armlinux.org.uk>
        <20180924141203.3df9707a@windsurf>
        <20180924124620.GA10322@e107981-ln.cambridge.arm.com>
        <20180924151040.5e57462b@windsurf>
        <20180924141512.GA11875@e107981-ln.cambridge.arm.com>
        <20180924165218.26c7c418@windsurf>
        <0f80dc88-dffe-4ca6-bb85-c4e5c967e0e1@cesnet.cz>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, 01 Oct 2018 12:56:37 +0200, Jan Kundrát wrote:

> Thomas, Russell, Lorenzo,
> did you have time to convert this into a patch which can hit 4.19? I don't 
> see anything related in 4.19-rc6, but perhaps I missed something. Is there 
> something that I should test or otherwise help?

Sorry, I suddenly got busy (my second son arrived a few days earlier
than expected).

I just sent a proper patch with the proposal I made last week, after
testing on ClearFog and Armada XP GP. Note that on ClearFog, I only
tested that it fixes the panic at boot, since I didn't had any
mini-PCIe devices at hand. On Armada XP GP, I verified that an E1000E
NIC was still working as expected. Therefore, it would be useful if
you could test on your ClearFog platform with PCI devices connected.

Thanks a lot and sorry for the delay.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
