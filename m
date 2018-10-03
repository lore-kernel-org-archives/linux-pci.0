Return-Path: <SRS0=Y6U6=MP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CBBC00449
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 13:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536CC20684
	for <linux-pci@archiver.kernel.org>; Wed,  3 Oct 2018 13:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536CC20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJCUYM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:24:12 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:44169 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbeJCUYM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Oct 2018 16:24:12 -0400
Received: from sapphire.tkos.co.il (unknown [10.0.4.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id BC84044011A;
        Wed,  3 Oct 2018 16:35:44 +0300 (IDT)
Date:   Wed, 3 Oct 2018 16:35:43 +0300
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
Message-ID: <20181003133543.t7laclm5wbj2olhq@sapphire.tkos.co.il>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
 <20181003132811.GC427@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003132811.GC427@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew,

On Wed, Oct 03, 2018 at 03:28:11PM +0200, Andrew Lunn wrote:
> On Wed, Oct 03, 2018 at 03:49:43PM +0300, Baruch Siach wrote:
> > This commit adds support for the gpio reset signal binding as described
> > in the designware-pcie.txt DT binding document. Both the documented
> > 'reset-gpio' property name, and the more standard 'reset-gpios' name are
> > supported.
> 
> I don't know this code at all, so maybe a dumb question. Why support
> the old none-standard binding of reset-gpio on new hardware? I'm
> assuming reset-gpio is marked a deprecated and reset-gpios is
> recommended?

This is all hidden behind the devm_gpiod_get_optional() call that only sees 
the "reset" string. The generic code supports both the new property name and 
also the older one for backward compatibility. This patch changes nothing in 
this regard.

The designware-pcie.txt document mentions the older 'reset-gpio' name. So I 
mentioned that name as well in the commit log.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
