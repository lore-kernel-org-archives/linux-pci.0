Return-Path: <SRS0=L200=SY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A34EC10F11
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2846220874
	for <linux-pci@archiver.kernel.org>; Mon, 22 Apr 2019 13:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555939223;
	bh=gPGpmoaDDbXZoQkuHmZS7Sh1qs0vdP7eZ4usppPF8E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sFHi0DaueoLmdEMXVItBm8iNp2q78dyRbCVJiZwk1UXmuY+CWwEAdg8irNpJG/KDZ
	 ro9mzC5IFCc4Bh6kKB1gz7hloxB+/jNi460MpCyH25v4KYGnkiNC8MoB4MlSXRLap1
	 t+ps8zykLasshk5XE/b32RDXY6pbMLyz7drYFCDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfDVNUW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVNUW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Apr 2019 09:20:22 -0400
Received: from localhost (50-82-46-41.client.mchsi.com [50.82.46.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53CDB20693;
        Mon, 22 Apr 2019 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555939221;
        bh=gPGpmoaDDbXZoQkuHmZS7Sh1qs0vdP7eZ4usppPF8E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIfKayguXGviUKT0RRQGvcifV8Yke/upWZ/QkjwIv6yeZnBTQrOKfRdlSAq1gh2nT
         ORVGULdjqFBzHHJpzBZBCzVPmFDZbppvpkMkzJvBKTpxFLtaVp2PyK1q3nxrC/5Kvi
         vdn2ikRytBUmArTqV12S0t51yvAPpxeE6dmf7n7w=
Date:   Mon, 22 Apr 2019 08:20:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     hkallweit1@gmail.com, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: add help pci_dev_id
Message-ID: <20190422132020.GK173520@google.com>
References: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
 <20190419.151338.2080189024614749302.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419.151338.2080189024614749302.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 19, 2019 at 03:13:38PM -0700, David Miller wrote:
> From: Heiner Kallweit <hkallweit1@gmail.com>
> Date: Fri, 19 Apr 2019 20:27:45 +0200
> 
> > In several places in the kernel we find PCI_DEVID used like this:
> > PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
> > for it.
> 
> I'll wait for an ACK from the PCI folks on patch #1.

#1 and #2 touch PCI, #3 is a trivial r8169 patch.  There are a few
other places where this helper could be used (powernv/npu-dma.c,
amdkfd/kfd_topology.c, amd_iommu.c, intel-iommu.c,
intel_irq_remapping.c, stmmac_pci.c, chromeos_laptop.c).

I think it would be easier for me to collect acks for the trivial
changes to those places and merge the whole shebang via PCI.

Heiner, do you want to update those other places, too?

Bjorn
