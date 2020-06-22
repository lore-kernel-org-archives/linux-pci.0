Return-Path: <SRS0=6QlD=AD=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E36C433E0
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jun 2020 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DBF2073E
	for <linux-pci@archiver.kernel.org>; Mon, 22 Jun 2020 18:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbgFVSkh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:40:37 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44955 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVSkh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Jun 2020 14:40:37 -0400
X-Originating-IP: 86.210.146.109
Received: from windsurf.home (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 16AE3C0010;
        Mon, 22 Jun 2020 18:40:33 +0000 (UTC)
Date:   Mon, 22 Jun 2020 20:40:33 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Shmuel Hazan <sh@tkos.co.il>, Jason Cooper <jason@lakedaemon.net>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: mvebu: setup BAR0 to internal-regs
Message-ID: <20200622204033.72055de8@windsurf.home>
In-Reply-To: <20200622172516.GA2290205@bjorn-Precision-5520>
References: <20200621053032.5262-1-sh@tkos.co.il>
        <20200622172516.GA2290205@bjorn-Precision-5520>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Mon, 22 Jun 2020 12:25:16 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> > As a result of the requirement above, without this patch, MSI won't
> > function and therefore some devices won't operate properly without
> > pci=nomsi.  
> 
> Does that mean MSIs never worked at all with mvebu?

They definitely worked. I think what happens is that this register was
normally setup by the vendor-specific bootloader, and thanks to
firmware initialization, Linux had MSIs working properly.

With other bootloaders that initialize the PCIe block differently, or
even not at all, it became clear this init was missing in Linux.

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
