Return-Path: <SRS0=GqAx=SG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE423C4360F
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A385C20820
	for <linux-pci@archiver.kernel.org>; Thu,  4 Apr 2019 18:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554404297;
	bh=6ExJ9046PCPNSnwgHJ0lFpyBupkZefxFZh1kFArbs50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aV+u7jPYnEEM85suYWcCo9bXybUQyKIMD6kZgk5htYehBhflYiKYAe6RpPo431pHJ
	 XFW7oOyELr9c0q3UvW5VAFwxqmKkTUdqHp9zlcD0Jq7eQdUzBIKAczPUmPIL4yitO9
	 9etfCmRmPt6nfKW3ljJeaz0XNehzgot/jTfg+ydw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDDS6R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfDDS6Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Apr 2019 14:58:16 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D4042075E;
        Thu,  4 Apr 2019 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554404296;
        bh=6ExJ9046PCPNSnwgHJ0lFpyBupkZefxFZh1kFArbs50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yff9bA6zROCoAHa4Q2WOOlquYTiBHd1/StocSZUebTK3/ljoyrQ8RLrf3HMY3RAr8
         T2CxX/pdI5pB+3qu1LRNYaJiz+BfPdTxRuucUVoIl3KSoS+IAnYjheHeLd3C19/+G7
         wOgClwo3vYpHlxRKZgzqOJL81EqWSCL2uzEKEGjg=
Date:   Thu, 4 Apr 2019 13:58:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     John Garry <john.garry@huawei.com>, wangkefeng.wang@huawei.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de, rafael@kernel.org,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        andy.shevchenko@gmail.com, catalin.marinas@arm.com, bp@suse.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
Message-ID: <20190404185815.GA26522@google.com>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404174336.GA10404@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 04, 2019 at 10:43:36AM -0700, Guenter Roeck wrote:
> On Thu, Apr 04, 2019 at 05:52:35PM +0100, John Garry wrote:
> > >>Note that the f71805f driver does not call
> > >>request_{muxed_}region(), as it should.
> > 
> > >... which is the real problem, one that is not solved by this
> > >patch. This may result in parallel and descructive accesses if
> > >there is another device on the LPC bus, and another driver
> > >accessing that device. Personally I'd rather have
> > >request_muxed_region() added to the f71805f driver.
> > 
> > Right, we should and will still fix f71805f. If you recall, I did
> > have the f71805f fix in the v1 series, but you committed that it
> > was orthogonal, so I decided to take it out of this work for now.
> > 
> > And even if we fix up f71805f and other known drivers which don't
> > call request_muxed_region(), we still need to police against these
> > rogue accesses, which is what this patch attempts to do.
> > 
> Do we ? I am personally not convinced that LPC accesses _have_ to
> occur through PCI on any given system.

On current systems, I suspect ISA/LPC devices are typically connected
via a PCI-to-ISA/LPC bridge.  But AFAIK there's no actual requirement
for that bridge, and there certainly *were* systems with ISA devices
but no PCI at all.

IMO, if you want to build ISA drivers on your arch, you need to make
sure the inb() probing done by those drivers works like it does on
x86.  If there's no device there, the inb() should return 0xff with no
fuss and no crash.

Bjorn
