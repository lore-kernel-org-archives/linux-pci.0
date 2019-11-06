Return-Path: <SRS0=bI25=Y6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E1C5DF63
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 18:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E3F218AE
	for <linux-pci@archiver.kernel.org>; Wed,  6 Nov 2019 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573063836;
	bh=9Mc4TTv1w7buCN3EfbAxENVmZlW/NTVD1Z1z3Oy87Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JtsbWxfapp/O+TB4hqJBrsihOe29Ibp4pliSbTr5IO5ks3IXTtr5NMHoB49VE72lU
	 wlizDqBw//Raf9fHu+hBA6ukyPxrRTj1BqUzo4wzj0FrOA+lvXE0fsUjYSfjcY5DTW
	 uCPWMypkXzJyD0jolcNH9BT6GiUR2uVy16mH6PMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfKFSKf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfKFSKf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 13:10:35 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6850E21848;
        Wed,  6 Nov 2019 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573063835;
        bh=9Mc4TTv1w7buCN3EfbAxENVmZlW/NTVD1Z1z3Oy87Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odlAsSpyd1HjT0RYFOD/4u1SsQan3BwdNm5TAWoZjCHtJS8PPIyZkeyETc/Euq7Lx
         zkfTgilPTZLXRIewSA7O2FLvZvw9YBQ615NolQkMfEjdqREUhaiRWHoKcL+m9R1ZVq
         6IvHEfKuSAKD2YMaG1FH/fWfie7hSDNCBUg9dExY=
Date:   Thu, 7 Nov 2019 03:10:32 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Message-ID: <20191106181032.GD29853@redsun51.ssa.fujisawa.hgst.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
 <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 04:40:08AM -0700, Jon Derrick wrote:
> Using managed IRQ affinities sets up the VMD affinities identically to
> the child devices when those devices vector counts are limited by VMD.
> This promotes better affinity handling as interrupts won't necessarily
> need to pass context between non-local CPUs. One pre-vector is reserved
> for the slow interrupt and not considered in the affinity algorithm.

This only works if all devices have exactly the same number of interrupts
as the parent VMD host bridge. If a child device has less, the device
will stop working if you offline a cpu: the child device may have a
resource affined to other online cpus, but the VMD device affinity is to
that single offline cpu.
