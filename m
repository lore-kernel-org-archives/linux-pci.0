Return-Path: <SRS0=Wepl=PV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E16C43387
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 12:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F692063F
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 12:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfAMMiE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 13 Jan 2019 07:38:04 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52915 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfAMMiD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Jan 2019 07:38:03 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 1469B4400E1;
        Sun, 13 Jan 2019 14:38:01 +0200 (IST)
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il> <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il> <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish> <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish>
User-agent: mu4e 1.0; emacs 26.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andrew Lunn <andrew@lunn.ch>
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
In-reply-to: <87zhs8h5ej.fsf@tarshish>
Date:   Sun, 13 Jan 2019 14:38:00 +0200
Message-ID: <87pnt0vil3.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On Thu, Jan 10 2019, Baruch Siach wrote:
> On Thu, Jan 10 2019, Andrew Lunn wrote:
>>> Sven Auhagen reported the same issue with Intel NIC attached to
>>> mini-PCIe slots on a custom Armada 8K design.
>>
>> O.K. so that suggests the issue is on the Armada side.
>>
>>> How would you suggest to investigate this issue?
>>
>> I presume reboot works O.K? So it is possible to toggle the reset
>> multiple times, but reboot must do something additional which makes it
>> work? Do you have sources for the bootloader?
>
> The bootloader is current U-Boot master as BL33 of Marvell provided ATF
> version 18.12, current latest.
>
>> Are there status bits in the comphy about the state of the link? Maybe
>> comphy needs to be kicked to reestablish the link?
>
> Maybe. The U-Boot comphy PCIe initialization routine
> comphy_pcie_power_up() is long and complex.
>
> The ATF code also carries PCIe comphy initialization with this text:
>
> https://github.com/MarvellEmbeddedProcessors/atf-marvell/blob/atf-v1.5-armada-18.12/drivers/marvell/comphy/phy-comphy-cp110.c#L1170
>
>         /* In Armada 8K DB boards, PCIe initialization can be executed
>          * only once (PCIe reset performed during chip power on and
>          * it cannot be executed via GPIO later).
>          * This means that power on can be executed only once, so let's
>          * mark if the caller is bootloader or Linux.
>          * If bootloader -> run power on.
>          * If Linux -> exit.
>          *
>          * TODO: In MacciatoBIN, PCIe reset is connected via GPIO,
>          * so after GPIO reset is added to Linux Kernel, it can be
>          * powered-on by Linux.
>          */
>         if (!called_from_uboot)
>                 return ret;

Another look at this comment made me realize that we need comphy
initialization support in the kernel for PCIe reset to work correctly.

The workaround that this patch proposes will not solve the problem for
v5.0, since the GPIO get_direction patch will only appear in v5.1.

So the only viable solution for v5.0 is to revert the gpio reset signal
patch (commit 3d71746c42).

Thanks for your review.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
