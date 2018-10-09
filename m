Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E22C64EB8
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 16:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F492087D
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 16:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F492087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJJABk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:01:40 -0400
Received: from shell.v3.sk ([90.176.6.54]:49253 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeJJABj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Oct 2018 20:01:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E4DC8B8019;
        Tue,  9 Oct 2018 18:43:46 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 296NcWxN8LuZ; Tue,  9 Oct 2018 18:43:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id E932BBCDE7;
        Tue,  9 Oct 2018 18:43:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EQ_jSqvLYuPG; Tue,  9 Oct 2018 18:43:42 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 89BB0B8019;
        Tue,  9 Oct 2018 18:43:41 +0200 (CEST)
Message-ID: <04b4e7779325de995371685f094f3762c30793a8.camel@v3.sk>
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
Date:   Tue, 09 Oct 2018 18:43:41 +0200
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

No change in behavior. In standard C the enum type is compatible with
an integer type (char or larger), thus type would just hold a value
outside the rank of an enum.

But why would that happen? What we can get here is just the constants
from pxa2xx_spi_acpi_match[], all of them of enum pxa_ssp_type type.

> As a side note, could you join for the next throw to the review :
>  - Jarkko Nikula <jarkko.nikula@linux.intel.com>
>  - Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Even if they are Intel, I think they have worked a lot on this driver
> for Intel
> platforms.

Will do.

> Cheers.

Thanks,
Lubo

