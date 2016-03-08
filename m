Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from li153-180.members.linode.com ([109.74.206.180]:51450 "EHLO
	mail.tekno-soft.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbcCHPHQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Mar 2016 10:07:16 -0500
Subject: Re: iMX6q PCIe phy link never came up on kernel v4.4.x
To: Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>
References: <56D5E3DF.9030906@tekno-soft.it>
 <1456997527.3772.37.camel@pengutronix.de>
 <CAOMZO5A4bP34weVAvz5ZiUszNu3gLqAo7yocWaG9H-3FFe+kyw@mail.gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Roberto Fichera <kernel@tekno-soft.it>
Message-ID: <56DEEA93.4020000@tekno-soft.it>
Date: Tue, 8 Mar 2016 16:06:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAOMZO5A4bP34weVAvz5ZiUszNu3gLqAo7yocWaG9H-3FFe+kyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2016 04:02 PM, Fabio Estevam wrote:
> On Thu, Mar 3, 2016 at 6:32 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
>
>> Is this a regression from earlier kernel versions?
>>
>> If so, can you please revert 5c5fb40de8f14 (PCI: imx6: Add support for
>> active-low reset GPIO) and see if this helps?
> This commit has been applied to 4.5-rc1. Roberto is using 4.4.x.

Yes! I've just checked that isn't present

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

