Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59022C43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281FC214C6
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 12:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W320BZeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfAJMz5 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:55:57 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39033 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbfAJMz5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 07:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ZIAvV0zR0eRizhTOOTKm5wGrDQOa6TGlyppv2iYDJWM=;
        b=W320BZeBRcAL0ry42PGNMQtTQZ6QDxQg5SFxQxuYkUcEWDXeJ5lzP0vJ/yvOOGNI0D/o7vUwsthkZPGgUU5htxpwu/qkd/TZbq1+5nPaXn8UryxoUylGo/OMzfntrpymji2y0yLXA2cU/brPZaSHGDzLcX0BopccwM6eRzSpgYk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1ghZsC-0001Yr-Bd; Thu, 10 Jan 2019 13:55:48 +0100
Date:   Thu, 10 Jan 2019 13:55:48 +0100
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
Message-ID: <20190110125548.GA29612@lunn.ch>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 10, 2019 at 02:26:22PM +0200, Baruch Siach wrote:
> Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
> signal") added reset signal support. Reset is unconditionally asserted
> and deasserted.
> 
> Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
> NIC is in the PCIe slot.
> 
> It turns out that you can toggle the reset signal only once. Another
> reset signal toggle makes access to PCI configuration registers stall
> indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
> boot.

Hi Baruch

Is this double reset issue limited to just Mellanox NICs, or any
device in the PCIe slot?

This sounds more like a workaround than a fix. It would be good to
investigate further and determine which end of the PCIe link has the
problem.

Thanks
	Andrew
