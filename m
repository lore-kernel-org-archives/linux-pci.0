Return-Path: <SRS0=PQBU=L4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE743FC6182
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 14:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36492083A
	for <linux-pci@archiver.kernel.org>; Fri, 14 Sep 2018 14:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QSvxXkEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36492083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeINTxv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:53:51 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56264 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbeINTxv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Sep 2018 15:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fLG+TWc9StWIhJwtYkJidckh5wkTsc72g9qWBmlLXqg=; b=QSvxXkEOJHFiQBVW+/jWlFWaG
        Vig4LZHXZmnLxG0V1NGoYs/jRKxzJ6tHEbthwvHoZjm8C4TMaHlbZvc5dIbi7xat1ed+Ntvw9fkoN
        P8Ws8PyOckjgYRvxwyP4KslcD4KbnZ0PzvBLbq4Y1O+dFHdpbVSBLCA7R45YNh+JQoH00=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:54068)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g0pFF-0008EB-RU; Fri, 14 Sep 2018 15:38:54 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g0pFC-0007K4-SU; Fri, 14 Sep 2018 15:38:50 +0100
Date:   Fri, 14 Sep 2018 15:38:49 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCHv2 1/3] PCI: Introduce PCI bridge emulated config space
 common logic
Message-ID: <20180914143849.GC30658@n2100.armlinux.org.uk>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
 <20180912154831.2220-2-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912154831.2220-2-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180914143849.U_GURzCrdInrCfN3SmWkwwsSzGUkaXY9q6TBU6JQyd0@z>

On Wed, Sep 12, 2018 at 05:48:29PM +0200, Thomas Petazzoni wrote:
> Some PCI host controllers do not expose a configuration space for the
> root port PCI bridge. Due to this, the Marvell Armada 370/38x/XP PCI
> controller driver (pci-mvebu) emulates a root port PCI bridge
> configuration space, and uses that to (among other things) dynamically
> create the memory windows that correspond to the PCI MEM and I/O
> regions.
> 
> Since we now need to add a very similar logic for the Marvell Armada
> 37xx PCI controller driver (pci-aardvark), instead of duplicating the
> code, we create in this commit a common logic called pci-bridge-emul.
> 
> The idea of this logic is to emulate a root port PCI bridge
> configuration space by providing configuration space read/write
> operations, and faking behind the scenes the configuration space of a
> PCI bridge. A PCI host controller driver simply has to call
> pci_bridge_emul_conf_read() and pci_bridge_emul_conf_write() to
> read/write the configuration space of the bridge.
> 
> By default, the PCI bridge configuration space is simply emulated by a
> chunk of memory, but the PCI host controller can override the behavior
> of the read and write operations on a per-register basis to do
> additional actions if needed. We take care of complying with the
> behavior of the PCI configuration space registers in terms of bits
> that are read-write, read-only, reserved and write-1-to-clear.

Thanks, for the patch.  I don't see anything technically wrong from
a PCIe device behaviour point of view, although I haven't compared
the behaviour tables with the specs.

Reviewed-by: Russell King <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
