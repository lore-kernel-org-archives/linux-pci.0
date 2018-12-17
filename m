Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5885C43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 18:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9125D2086C
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 18:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeLQS1s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:27:48 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:50765 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbeLQS1s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 13:27:48 -0500
Received: from tarshish (unknown [10.0.8.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 5DFDC44071F;
        Mon, 17 Dec 2018 20:27:44 +0200 (IST)
References: <20181212102142.16053-1-miquel.raynal@bootlin.com> <20181212102142.16053-4-miquel.raynal@bootlin.com> <20181214014701.373b220b@nic.cz> <20181214015712.31f749ea@nic.cz> <20181217170724.58421a29@xps13>
User-agent: mu4e 1.0; emacs 25.2.2
From:   Baruch Siach <baruch@tkos.co.il>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Marek Behun <marek.behun@nic.cz>,
        Nadav Haklai <nadavh@marvell.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        devicetree@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-pci@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 03/12] PCI: aardvark: Add PHY support
In-reply-to: <20181217170724.58421a29@xps13>
Date:   Mon, 17 Dec 2018 20:27:42 +0200
Message-ID: <87zht480v5.fsf@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Miquel,

Miquel Raynal writes:
> Marek Behun <marek.behun@nic.cz> wrote on Fri, 14 Dec 2018 01:57:12
> +0100:
>
>> On Fri, 14 Dec 2018 01:47:01 +0100
>> Marek Behun <marek.behun@nic.cz> wrote:
>> 
>> > are there already patches for the A37xx comphy driver?  
>
> Please try the latest patches on top of phy -next (with PHY interface
> mode), available there [1]. You can pick only the COMPHY patches, but
> keep them over the phy -next branch.
>
> Please note that for the SMC calls to succeed you must use a recent
> ATF. Personally I used to work with the 'atf-v1.5-devel' branch of
> Marvell's misl-atf repository but it is not available anymore. If you
> already have a clone, then you are good to go, otherwise it might be
> great if someone from Marvell could share a public Github link?

The latest ATF from Marvell is at the 'atf-v1.5-armada-18.09' branch at

  https://github.com/MarvellEmbeddedProcessors/atf-marvell

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
