Return-Path: <SRS0=9OyC=PS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A795FC43387
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 13:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB0820879
	for <linux-pci@archiver.kernel.org>; Thu, 10 Jan 2019 13:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfAJNFw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:05:52 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52800 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfAJNFw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Jan 2019 08:05:52 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 45E16440205;
        Thu, 10 Jan 2019 15:05:50 +0200 (IST)
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il> <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il> <20190110125548.GA29612@lunn.ch>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andrew Lunn <andrew@lunn.ch>
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
In-reply-to: <20190110125548.GA29612@lunn.ch>
Date:   Thu, 10 Jan 2019 15:05:49 +0200
Message-ID: <8736q0irwy.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On Thu, Jan 10 2019, Andrew Lunn wrote:
> On Thu, Jan 10, 2019 at 02:26:22PM +0200, Baruch Siach wrote:
>> Commit 3d71746c42 ("PCI: armada8k: Add support for gpio controlled reset
>> signal") added reset signal support. Reset is unconditionally asserted
>> and deasserted.
>>
>> Unfortunately, that commit breaks boot on Macchiatobin when a Mellanox
>> NIC is in the PCIe slot.
>>
>> It turns out that you can toggle the reset signal only once. Another
>> reset signal toggle makes access to PCI configuration registers stall
>> indefinitely. U-Boot toggles the Macchiatobin PCIe reset line already at
>> boot.
>
> Hi Baruch
>
> Is this double reset issue limited to just Mellanox NICs, or any
> device in the PCIe slot?
>
> This sounds more like a workaround than a fix. It would be good to
> investigate further and determine which end of the PCIe link has the
> problem.

Sven Auhagen reported the same issue with Intel NIC attached to
mini-PCIe slots on a custom Armada 8K design.

How would you suggest to investigate this issue?

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
