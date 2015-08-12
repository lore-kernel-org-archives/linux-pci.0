Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36009 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbHLPLz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 12 Aug 2015 11:11:55 -0400
Received: by lbbpu9 with SMTP id pu9so11330473lbb.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Aug 2015 08:11:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439372036-15303-4-git-send-email-l.stach@pengutronix.de>
References: <1439372036-15303-1-git-send-email-l.stach@pengutronix.de>
	<1439372036-15303-4-git-send-email-l.stach@pengutronix.de>
Date: Wed, 12 Aug 2015 20:41:53 +0530
Message-ID: <CAHM4w1=_7mDk=NSAi2z2PO7rNQfb7Zo_nvc6Zb75hmDt8FaPvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] PCI: designware: implement multivector MSI irq setup
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	patchwork-lst@pengutronix.de, kernel@pengutronix.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 12, 2015 at 3:03 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Allows to set up and use multiple MSI irqs per device.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
