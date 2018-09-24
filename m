Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A962BC433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC5020883
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC5020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeIXQMT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:12:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59092 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbeIXQMT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Sep 2018 12:12:19 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 28F49207CA; Mon, 24 Sep 2018 12:10:59 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-42-80.w90-88.abo.wanadoo.fr [90.88.160.80])
        by mail.bootlin.com (Postfix) with ESMTPSA id D21FD20725;
        Mon, 24 Sep 2018 12:10:48 +0200 (CEST)
Date:   Mon, 24 Sep 2018 12:10:49 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Jan =?UTF-8?B?S3VuZHLDoXQ=?= <jan.kundrat@cesnet.cz>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924121049.2bd40c34@windsurf>
In-Reply-To: <a3da76eb-7d17-40ba-a98d-c4a743240785@cesnet.cz>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
        <87zhwm4kl6.fsf@tkos.co.il>
        <20180912231050.GX30658@n2100.armlinux.org.uk>
        <20180913094515.351967bb@windsurf>
        <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
        <20180913104241.65db8243@windsurf>
        <a3da76eb-7d17-40ba-a98d-c4a743240785@cesnet.cz>
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

On Mon, 24 Sep 2018 12:02:33 +0200, Jan Kundrát wrote:

> is there a proper patch for this? I've just verified that 4.19-rc5 won't 
> boot for me either. Thomas' quick patch applies and makes the problem go 
> away.

I was waiting for a quick review from Russell on my proposal, but since
it didn't happen so far, I will send a proper patch series, hopefully
today.

Thanks for your reminder!

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
