Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76451C10F14
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 04:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42AEC20843
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 04:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfDWEJ6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 00:09:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59044 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDWEJ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 00:09:58 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BC87314E84BB9;
        Mon, 22 Apr 2019 21:09:57 -0700 (PDT)
Date:   Mon, 22 Apr 2019 21:09:55 -0700 (PDT)
Message-Id: <20190422.210955.874397955396314386.davem@davemloft.net>
To:     helgaas@kernel.org
Cc:     hkallweit1@gmail.com, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: add help pci_dev_id
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190422132020.GK173520@google.com>
References: <b193514c-23d1-e090-7ddb-40371595f3a7@gmail.com>
        <20190419.151338.2080189024614749302.davem@davemloft.net>
        <20190422132020.GK173520@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Apr 2019 21:09:57 -0700 (PDT)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Mon, 22 Apr 2019 08:20:20 -0500

> On Fri, Apr 19, 2019 at 03:13:38PM -0700, David Miller wrote:
>> From: Heiner Kallweit <hkallweit1@gmail.com>
>> Date: Fri, 19 Apr 2019 20:27:45 +0200
>> 
>> > In several places in the kernel we find PCI_DEVID used like this:
>> > PCI_DEVID(dev->bus->number, dev->devfn) Therefore create a helper
>> > for it.
>> 
>> I'll wait for an ACK from the PCI folks on patch #1.
> 
> #1 and #2 touch PCI, #3 is a trivial r8169 patch.  There are a few
> other places where this helper could be used (powernv/npu-dma.c,
> amdkfd/kfd_topology.c, amd_iommu.c, intel-iommu.c,
> intel_irq_remapping.c, stmmac_pci.c, chromeos_laptop.c).
> 
> I think it would be easier for me to collect acks for the trivial
> changes to those places and merge the whole shebang via PCI.

That's fine with me, you can add my:

Acked-by: David S. Miller <davem@davemloft.net>
