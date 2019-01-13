Return-Path: <SRS0=Wepl=PV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA69C43387
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7A920675
	for <linux-pci@archiver.kernel.org>; Sun, 13 Jan 2019 20:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfAMUBC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:01:02 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52949 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfAMUBB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Jan 2019 15:01:01 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id ACA5B4400E1;
        Sun, 13 Jan 2019 20:42:22 +0200 (IST)
References: <024cc24efa7b99186750f90c91880b29357d379d.1547123182.git.baruch@tkos.co.il> <94cd23a60c647020dd87a923684b59255b89f02c.1547123182.git.baruch@tkos.co.il> <20190110125548.GA29612@lunn.ch> <8736q0irwy.fsf@tarshish> <20190110131912.GB29612@lunn.ch> <87zhs8h5ej.fsf@tarshish> <87pnt0vil3.fsf@tarshish> <20190113154028.GB4635@lunn.ch>
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
In-reply-to: <20190113154028.GB4635@lunn.ch>
Date:   Sun, 13 Jan 2019 20:42:39 +0200
Message-ID: <87o98kv1pc.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On Sun, Jan 13 2019, Andrew Lunn wrote:
>> Another look at this comment made me realize that we need comphy
>> initialization support in the kernel for PCIe reset to work correctly.
>>
>> The workaround that this patch proposes will not solve the problem for
>> v5.0, since the GPIO get_direction patch will only appear in v5.1.
>
> You could ask for it to be applied to v5.0 since a real fix depends on
> it.
>
> We have a bit of a balancing act to sort out. The revert will fix
> Macchiatobin. But i assume it breaks some other platforms which just
> started to work. Ideally we want the best of both worlds. So maybe
> getting the GPIO change into stable is the correct thing to do?

Support for that other board (Clearfog GT-8K) has only been introduced
in v5.0. The kernel never supported PCIe on that platform. So there is
no regression for CF GT-8K like there is for the Macchiatobin.

The issue is quite easy to deal with at the U-Boot level even for v5.0.
The workaround that this patch suggests is pretty ugly, as you noted. I
think we can live with no PCIe reset support in the kernel for another
release or two.

baruch

--
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
