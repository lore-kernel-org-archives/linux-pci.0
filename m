Return-Path: <SRS0=Wepl=PV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2ADC43387
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 15:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4639D20675
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 15:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qT9Ntmu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfAMPkf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 13 Jan 2019 10:40:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41588 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfAMPkf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Jan 2019 10:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Lld8vr13ypBCxHW8tq5dy9vDbUx+fb5D5jHr8CTg+Wc=;
        b=qT9Ntmu02+4GePzG3AuZxhz1y8DD642M2Xl0bQb++WocJkGi1VQYjAlEBZP/al+cPba/gmRsbI4vdgNaO8+0NSn1KbcybL7VrE0MF+rNwDFTafS3m9Iw4tgSOph/0/TcRSvJewxImJjBDjf4kYmjcB3AplqvSOOTTTcI9xRp5og=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gihsC-0002uh-JC; Sun, 13 Jan 2019 16:40:28 +0100
Date:   Sun, 13 Jan 2019 16:40:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-pwm@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sven Auhagen <sven.auhagen@voleatech.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/2] PCI: armada8k: don't toggle reset twice
Message-ID: <20190113154028.GB4635@lunn.ch>
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il>
 <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il>
 <20190110125548.GA29612@lunn.ch>
 <8736q0irwy.fsf@tarshish>
 <20190110131912.GB29612@lunn.ch>
 <87zhs8h5ej.fsf@tarshish>
 <87pnt0vil3.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnt0vil3.fsf@tarshish>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Another look at this comment made me realize that we need comphy
> initialization support in the kernel for PCIe reset to work correctly.
> 
> The workaround that this patch proposes will not solve the problem for
> v5.0, since the GPIO get_direction patch will only appear in v5.1.

You could ask for it to be applied to v5.0 since a real fix depends on
it.

We have a bit of a balancing act to sort out. The revert will fix
Macchiatobin. But i assume it breaks some other platforms which just
started to work. Ideally we want the best of both worlds. So maybe
getting the GPIO change into stable is the correct thing to do?

	Andrew
