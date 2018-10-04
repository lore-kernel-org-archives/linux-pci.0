Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E39C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 11:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB7021470
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 11:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y9P633Vj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB7021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJDSUI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:20:08 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36214 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbeJDSUI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Oct 2018 14:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Ed3gueUo5Bf5YqUpF1zexEQyFUzWS5jYOrHt3AM+Tk=; b=Y9P633VjCwXw8GDoPK0zjRJ+G
        /R8HWCpXEbPxPkyiO5Li+VavaMrrF1kazZSVnggBapjyakjiAZtt17ZxW/TrcPnRuYAOggMpN5dma
        EoN/9BMHMg5+A/zgAR/lQVklvFV98PXbGYvTFF0JQ9yLTYzNCTN72N0M85ArihtkbzzJ0=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:58560)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g81mg-0006Kd-Kd; Thu, 04 Oct 2018 12:27:10 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g81mX-0002vZ-Qh; Thu, 04 Oct 2018 12:27:01 +0100
Date:   Thu, 4 Oct 2018 12:26:59 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Miqu??l Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCHv2 2/3] PCI: mvebu: Convert to PCI emulated bridge config
 space
Message-ID: <20181004112659.GB30658@n2100.armlinux.org.uk>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
 <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
 <20180918161745.GB31440@e107981-ln.cambridge.arm.com>
 <20181004104805.GB5233@e107981-ln.cambridge.arm.com>
 <20181004131342.130d356a@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004131342.130d356a@windsurf>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 01:13:42PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 4 Oct 2018 11:48:05 +0100, Lorenzo Pieralisi wrote:
> 
> > > I would drop "recently introduced", unless we can define a precise
> > > commit when code was added so that it can actually be checked (I know
> > > you can't since the relevant patch is part of this series and not in
> > > the mainline yet).
> > > 
> > > Bjorn posted some guidelines that are helpful:
> > > 
> > > https://marc.info/?l=linux-pci&m=150905742808166&w=2
> > > 
> > > I can make these changes myself, no problem but please address Russell's
> > > comment so that we can proceed.  
> > 
> > Hi Thomas,
> > 
> > I understand you have more important things to think about these days :)
> > (congratulations), let me know if I can fix this patch up myself, I
> > would like to merge this series for v4.20.
> 
> Fixing up the commit log, of course, you can fix up yourself. However,
> Russell made a comment about a remaining FIXME, and I haven't had the
> chance to get back deep into the code to remember why I added this
> FIXME, and whether it is still needed or not.

Thank you for making my point about unexplained FIXME comments so well!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
