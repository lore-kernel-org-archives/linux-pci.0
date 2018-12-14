Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86238C67839
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 00:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D2A2054F
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 00:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="fEkeERtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D2A2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeLNA5Q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:57:16 -0500
Received: from mail.nic.cz ([217.31.204.67]:42095 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbeLNA5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Dec 2018 19:57:15 -0500
Received: from localhost (unknown [172.20.6.233])
        by mail.nic.cz (Postfix) with ESMTPS id C6AAD62E08;
        Fri, 14 Dec 2018 01:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1544749033; bh=g02vyxvx3Z0cJLUK1phCSxH+CVN1v1rPsHLSCbkh02k=;
        h=Date:From:To;
        b=fEkeERtHp995tRVNOqiSSeBk1FCrIhiMG/AI9wjC8q4b3V5wbD0mfiN4Y+nyGESLf
         I55Wi2wcnJfp8THzoPuw0B78ub9Uqo12ncwuV3GniPUCSv59X/aA0VF+5FGoeS+j2F
         0Q9exmTs6q8UiFDcfnHh+6q9w2gp+c7YiAY8olFE=
Date:   Fri, 14 Dec 2018 01:57:12 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
Message-ID: <20181214015712.31f749ea@nic.cz>
In-Reply-To: <20181214014701.373b220b@nic.cz>
References: <20181212102142.16053-1-miquel.raynal@bootlin.com>
        <20181212102142.16053-4-miquel.raynal@bootlin.com>
        <20181214014701.373b220b@nic.cz>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 14 Dec 2018 01:47:01 +0100
Marek Behun <marek.behun@nic.cz> wrote:

> Hi Miquel,
> are there already patches for the A37xx comphy driver?

Never mind, I found them. I shall test this on Turris Mox.
Is the comphy driver supposed to be able to change eth mode from
1000BASE-X to 2500BASE-X and back without reboot?

This would be cool for our SFP cage module of Turris Mox, just to add
support for comphy into mvneta.

Marek
