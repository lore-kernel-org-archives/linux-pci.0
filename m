Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33169C04EBC
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCAD2075B
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 13:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="O+CMcYSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCAD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeKTXlg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:41:36 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:47074 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKTXlg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 18:41:36 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A18555C21FC;
        Tue, 20 Nov 2018 14:12:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542719550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAsMiJ/ognRSZmMxK1JKQolbBDGuLOku+iNadRy4yDE=;
        b=O+CMcYSVvjrIfhKIEgDWlEMsHO06XRUMf5tQi+ZzLit+lP6lqcGPITXIGQ4hulXo/Tv70h
        /cp3G6GsXx3yd4430GcTKE2mC3veQf2jsg0TBlUJy03LMsZEUBe+Ss+8eKkeWwFoeFVIph
        SReQr6QKpanr2mU8HgNdQfxZPCnvt6A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 20 Nov 2018 14:12:30 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, linux-kernel@vger.kernel.org,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        tpiepho@impinj.com, andrew.smirnov@gmail.com,
        linux-pci@vger.kernel.org, l.stach@pengutronix.de,
        bhelgaas@google.com
Subject: Re: [PATCH 2/2] PCI: imx6: limit DBI register length
In-Reply-To: <VI1PR04MB553386A3F452E13BFCF79688EED90@VI1PR04MB5533.eurprd04.prod.outlook.com>
References: <20181119094144.4127-1-stefan@agner.ch>
 <20181119094144.4127-2-stefan@agner.ch>
 <ceb95fbdf0f6d0e0eeb1db3a22743f1453c8e060.camel@nxp.com>
 <6dfdd46d76a380b900b68d13ce5bfa62@agner.ch>
 <VI1PR04MB553386A3F452E13BFCF79688EED90@VI1PR04MB5533.eurprd04.prod.outlook.com>
Message-ID: <d0efcd4d71a4af9da6c2fb0b3f2183b0@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20.11.2018 14:03, Leonard Crestez wrote:
> From: Stefan Agner <stefan@agner.ch>
>> On 20.11.2018 11:22, Leonard Crestez wrote:
>> > On Mon, 2018-11-19 at 10:41 +0100, Stefan Agner wrote:
>> >> Define the length of the DBI registers. This makes sure that
>> >> the kernel does not access registers beyond that point, avoiding
>> >> the following abort on a i.MX 6Quad:
>> >>   # cat
>> /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
>> >>   [  100.021433] Unhandled fault: imprecise external abort (0x1406) at
>> 0xb6ea7000
>> >>   ...
>> >>   [  100.056423] PC is at dw_pcie_read+0x50/0x84
>> >>   [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
>> >>   ...
>> >>
>> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >>
>> >> diff --git a/drivers/pci/controller/dwc/pci-imx6.c
>> >
>> >> +struct imx6_pcie_drvdata {
>> >> +	enum imx6_pcie_variants variant;
>> >> +	int			dbi_length;
>> >> +};
>> >
>> > Turning imx6_pcie drvdata into a struct is very nice, maybe in the
>> > future some of the long case statements in this driver could be split
>> > into per-soc functions called via drvdata.
>>
>> Yeah I thought that too. At a quick glance I did not saw an obvious
>> contender. Should certainly help for similar cases in the future.
> 
> Yes, there are other cases in which it would be useful.
> 
> But I think it makes more sense to split introducing drvdata to a
> separate patch.
> It's nice to separate functional and code cleanup changes.
> 
> For example maybe dbi_length causes issues and has to be reverted?

Ok, makes sense, will split drvdata introduction in its own patch.

--
Stefan
