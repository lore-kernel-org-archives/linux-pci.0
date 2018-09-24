Return-Path: <SRS0=+fdl=MG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C763C433F4
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3874620833
	for <linux-pci@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GK0TyoJG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3874620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeIXQN4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:13:56 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42114 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeIXQNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Sep 2018 12:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uOUEzo9vk8s2/QTfoROwIEFHEF1EYVDuKjqMAO14YIc=; b=GK0TyoJGW+p7Pdi8u+bP/3xci
        4FBQFgSsDSFfLUsiYsef0fOj4ZFVcS8mp6jFMnHcpozczyr85s0P0OtcJ/MEEh/9eN6L5pcpOwo6c
        vv97tL/0Od7QI5r3YHMnCWkVSMcgcsti2Yo43SPXW0ZpmtJ9/TMZ7i5RW1RJamnfnkMJs=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:37729)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g4Nqq-0002dj-Qt; Mon, 24 Sep 2018 11:12:24 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g4Nqk-000686-K6; Mon, 24 Sep 2018 11:12:19 +0100
Date:   Mon, 24 Sep 2018 11:12:13 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
Message-ID: <20180924101213.GO30658@n2100.armlinux.org.uk>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180913104241.65db8243@windsurf>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 13, 2018 at 10:42:41AM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Thu, 13 Sep 2018 10:20:45 +0200, Jan Kundrát wrote:
> > On čtvrtek 13. září 2018 9:45:15 CEST, Thomas Petazzoni wrote:
> > > What about something like the below. I tested it, including the error
> > > case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
> > > after pci_unmap_iospace(). Actually, I would prefer to use
> > > pci_remap_iospace() and pci_unmap_iospace() but for now this API
> > > doesn't allow overloading the memory type used for the mapping.  
> > 
> > Thanks for providing this fix so quickly, Thomas. I can confirm that this 
> > patch -- tested on top of 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge 
> > tag 'pci-v4.19-fixes-1' of 
> > git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"). Disclaimer: I 
> > have zero familiarity with Linux' PCI code.
> > 
> > Tested-by: Jan Kundrát <jan.kundrat@cesnet.cz>
> 
> Thanks for the testing. I'll wait for Russell to say if he is happy
> (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> the case, I'll send a proper patch to fix the issue.

I'd prefer not to provide an unmapping API, because it gives the
impression that it's okay to unmap the IO space mapping, and we'll
end up with drivers that decide to call it in their cleanup path.
IO space isn't expected to ever go away - eg, on a PC, it's always
present.

I've been toying with the idea of making pci_map_io() ignore
subsequent attempts to overwrite the mapping with an identical
mapping, and WARN() if there is an attempt to overwrite an existing
mapping with other physical address, but I'm not entirely happy
with that either (which is why I haven't responded sooner.)

At the moment, I don't have a way forward that I'm happy with for
this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
