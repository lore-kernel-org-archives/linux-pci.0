Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F812C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205F521479
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 11:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205F521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbeJDSGb (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:06:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33758 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbeJDSGb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Oct 2018 14:06:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1B157207F3; Thu,  4 Oct 2018 13:13:42 +0200 (CEST)
Received: from windsurf (LFbn-1-10682-153.w90-89.abo.wanadoo.fr [90.89.35.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id C654F207B4;
        Thu,  4 Oct 2018 13:13:41 +0200 (CEST)
Date:   Thu, 4 Oct 2018 13:13:42 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@arm.linux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Miqu??l Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCHv2 2/3] PCI: mvebu: Convert to PCI emulated bridge config
 space
Message-ID: <20181004131342.130d356a@windsurf>
In-Reply-To: <20181004104805.GB5233@e107981-ln.cambridge.arm.com>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
        <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
        <20180918161745.GB31440@e107981-ln.cambridge.arm.com>
        <20181004104805.GB5233@e107981-ln.cambridge.arm.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

On Thu, 4 Oct 2018 11:48:05 +0100, Lorenzo Pieralisi wrote:

> > I would drop "recently introduced", unless we can define a precise
> > commit when code was added so that it can actually be checked (I know
> > you can't since the relevant patch is part of this series and not in
> > the mainline yet).
> > 
> > Bjorn posted some guidelines that are helpful:
> > 
> > https://marc.info/?l=linux-pci&m=150905742808166&w=2
> > 
> > I can make these changes myself, no problem but please address Russell's
> > comment so that we can proceed.  
> 
> Hi Thomas,
> 
> I understand you have more important things to think about these days :)
> (congratulations), let me know if I can fix this patch up myself, I
> would like to merge this series for v4.20.

Fixing up the commit log, of course, you can fix up yourself. However,
Russell made a comment about a remaining FIXME, and I haven't had the
chance to get back deep into the code to remember why I added this
FIXME, and whether it is still needed or not.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
