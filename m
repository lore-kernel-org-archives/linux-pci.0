Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BA2C43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 13:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A66214DA
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 13:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W4DDbLHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfAJNTQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:19:16 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39070 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728702AbfAJNTQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 08:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=59Y29XuocJBVsq5VH2naNcUJziE420Eh/lDALsXzmYg=;
        b=W4DDbLHbLbLWX3VcklndzhhhvzoI4QnzoGL7KjPis1T0BDH5tMTkc22mFRa87jD4HtOZ1HhVlxrVL0LXfrQHtsdxdsxI0msbrF3hfbhY/Eg5+l2pwIIy2mhQ/1AEPKuud8D0MaDaGQlhMHRhZ4hcKT6iwX5lXZbLXryRcdKuBPI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ghaEq-0001ta-AG; Thu, 10 Jan 2019 14:19:12 +0100
Date:   Thu, 10 Jan 2019 14:19:12 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Message-ID: <20190110131912.GB29612@lunn.ch>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch>
 <8736q0irwy.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736q0irwy.fsf@tarshish>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Sven Auhagen reported the same issue with Intel NIC attached to
> mini-PCIe slots on a custom Armada 8K design.

O.K. so that suggests the issue is on the Armada side.
 
> How would you suggest to investigate this issue?

I presume reboot works O.K? So it is possible to toggle the reset
multiple times, but reboot must do something additional which makes it
work? Do you have sources for the bootloader?

Are there status bits in the comphy about the state of the link? Maybe
comphy needs to be kicked to reestablish the link?

       Andrew
