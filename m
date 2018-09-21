Return-Path: <SRS0=H68a=MD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E625C433F4
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 20:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A2E21532
	for <linux-pci@archiver.kernel.org>; Fri, 21 Sep 2018 20:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A2E21532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbeIVCYl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:24:41 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:50293 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391328AbeIVCYl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Sep 2018 22:24:41 -0400
Received: from belgarion ([90.89.234.36])
        by mwinf5d35 with ME
        id eLa31y00Z0nnJME03La40J; Fri, 21 Sep 2018 22:34:06 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 21 Sep 2018 22:34:06 +0200
X-ME-IP: 90.89.234.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/5] spi: pxa2xx: use an enum for type
References: <20180910115935.163121-1-lkundrak@v3.sk>
        <20180910115935.163121-4-lkundrak@v3.sk>
X-URL:  http://belgarath.falguerolles.org/
Date:   Fri, 21 Sep 2018 22:34:03 +0200
In-Reply-To: <20180910115935.163121-4-lkundrak@v3.sk> (Lubomir Rintel's
        message of "Mon, 10 Sep 2018 13:59:33 +0200")
Message-ID: <87d0t64mkk.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lubomir Rintel <lkundrak@v3.sk> writes:

> That seems to be the correct type.
Okay, but what happens here when adev_id->driver_data is a value out of enum
range ? Does the following assignment make sense ?
> +		type = (enum pxa_ssp_type)adev_id->driver_data;

As a side note, could you join for the next throw to the review :
 - Jarkko Nikula <jarkko.nikula@linux.intel.com>
 - Mika Westerberg <mika.westerberg@linux.intel.com>

Even if they are Intel, I think they have worked a lot on this driver for Intel
platforms.

Cheers.

-- 
Robert
