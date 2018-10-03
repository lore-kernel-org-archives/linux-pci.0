Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F054C00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 13:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D69E2082A
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 13:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TycuBD2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D69E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJCUQl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:16:41 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52816 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCUQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 16:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Sw4gVPHq2xBzSK8khPV2z/5w2/Tl9Ua9a0mtdgO+HZQ=;
        b=TycuBD2V8QKkT5rR4ebEKGHe7vZEek0EQ6tiWJwY0WbjTGoN09vDzM8kj8TMF6qurIVVOi/FX5V+yqcsg6rCHtEEvpBflYNEEmYK3/HLobdjtmD5ZHJaz3ha69WKG9KEorH9voF1g56LN7Yb2ohdwT1FkkZUvC4femj/wj/tpLE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g7hCF-0000lB-Cd; Wed, 03 Oct 2018 15:28:11 +0200
Date:   Wed, 3 Oct 2018 15:28:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
Message-ID: <20181003132811.GC427@lunn.ch>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 03, 2018 at 03:49:43PM +0300, Baruch Siach wrote:
> This commit adds support for the gpio reset signal binding as described
> in the designware-pcie.txt DT binding document. Both the documented
> 'reset-gpio' property name, and the more standard 'reset-gpios' name are
> supported.

Hi Baruch

I don't know this code at all, so maybe a dumb question. Why support
the old none-standard binding of reset-gpio on new hardware? I'm
assuming reset-gpio is marked a deprecated and reset-gpios is
recommended?

    Andrew
