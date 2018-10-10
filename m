Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74191C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEFA214C4
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 17:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEFA214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJKAuM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:50:12 -0400
Received: from shell.v3.sk ([90.176.6.54]:54823 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbeJKAuM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Oct 2018 20:50:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id EFEBCBCFC6;
        Wed, 10 Oct 2018 19:27:00 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YOGe0zoO6xj4; Wed, 10 Oct 2018 19:26:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8561EBCFE6;
        Wed, 10 Oct 2018 19:26:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kiyiRDjEM7hX; Wed, 10 Oct 2018 19:26:56 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5AE8ABCFC6;
        Wed, 10 Oct 2018 19:26:56 +0200 (CEST)
Message-ID: <817b05ed7a619e9c46594f395ebc02d7cde9fc24.camel@v3.sk>
Subject: Re: [PATCH 3/5] spi: pxa2xx: use an enum for type
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 10 Oct 2018 19:26:56 +0200
In-Reply-To: <87d0t64mkk.fsf@belgarion.home>
References: <20180910115935.163121-1-lkundrak@v3.sk>
         <20180910115935.163121-4-lkundrak@v3.sk> <87d0t64mkk.fsf@belgarion.home>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2018-09-21 at 22:34 +0200, Robert Jarzmik wrote:
> Lubomir Rintel <lkundrak@v3.sk> writes:
> 
> > That seems to be the correct type.
> Okay, but what happens here when adev_id->driver_data is a value out
> of enum
> range ? Does the following assignment make sense ?
> > +		type = (enum pxa_ssp_type)adev_id->driver_data;
> 
> As a side note, could you join for the next throw to the review :
>  - Jarkko Nikula <jarkko.nikula@linux.intel.com>
>  - Mika Westerberg <mika.westerberg@linux.intel.com>

Argh, of course I forgot. My apologies.

Jarkko & Mika, I'm wondering if you could take a look at the [1] thread
and tell me what you think. (I can forward it to you via e-mail too, if
you're not subscribed to lists it has been Cc'd to, if that would be
more convenient).

[1] [PATCH 0/11] spi: pxa2xx: add DT and slave mode support"
    https://lore.kernel.org/lkml/20181010170936.316862-1-lkundrak@v3.sk/T/#t

Thanks
Lubo

> 
> Even if they are Intel, I think they have worked a lot on this driver
> for Intel
> platforms.
> 
> Cheers.
> 

