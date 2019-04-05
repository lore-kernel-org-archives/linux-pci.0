Return-Path: <SRS0=e3W/=SH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC4AC282CE
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE9C21852
	for <linux-pci@archiver.kernel.org>; Fri,  5 Apr 2019 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554487579;
	bh=HK3C+WQAVoOovk03K17EVGE894FDOVP/NrAJyP885xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M6YbBLzQNNRgUH6E9WuYVzLEz6D19F2zSZGa7wt6GDUdYyD8Y4SgqbIBhe+oqtyWX
	 NyZubrzSi0Mo9kVyTY1JFB1A8jevBvcNn6Rr9LuCJtwjYNxF06d/I84kURnBjU9J6/
	 uhOQYX2wnhD75/kjmt05rUsyrmDbKi2Sb7niCTAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfDESGT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbfDESGS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Apr 2019 14:06:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41142146F;
        Fri,  5 Apr 2019 18:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554487577;
        bh=HK3C+WQAVoOovk03K17EVGE894FDOVP/NrAJyP885xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8nWszjI7awFxRSTBbXrulQydNuEc5JnEQp1XJjzA/ZMndxtdqXdMifMZYxHW+tut
         Ytcy308xnFaZu6IABLQ0xW8xG++uE7gZK1wlfeXNqPSssAPpDAYeTgl+mRaTUsoyCT
         7CzcrvfuOEwjOfRcaYHzdN9mHfOrSORMx5RZULIw=
Date:   Fri, 5 Apr 2019 13:06:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, wangkefeng.wang@huawei.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de, rafael@kernel.org,
        linux-pci@vger.kernel.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        andy.shevchenko@gmail.com, catalin.marinas@arm.com, bp@suse.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
Message-ID: <20190405180615.GB109021@google.com>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net>
 <20190404185815.GA26522@google.com>
 <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 05, 2019 at 09:10:27AM +0100, John Garry wrote:
> On 04/04/2019 19:58, Bjorn Helgaas wrote:
> > On Thu, Apr 04, 2019 at 10:43:36AM -0700, Guenter Roeck wrote:
> > > On Thu, Apr 04, 2019 at 05:52:35PM +0100, John Garry wrote:
> > > > > > Note that the f71805f driver does not call
> > > > > > request_{muxed_}region(), as it should.
> > > > 
> > > > > ... which is the real problem, one that is not solved by this
> > > > > patch. This may result in parallel and descructive accesses if
> > > > > there is another device on the LPC bus, and another driver
> > > > > accessing that device. Personally I'd rather have
> > > > > request_muxed_region() added to the f71805f driver.
> > > > 
> > > > Right, we should and will still fix f71805f. If you recall, I did
> > > > have the f71805f fix in the v1 series, but you committed that it
> > > > was orthogonal, so I decided to take it out of this work for now.
> > > > 
> > > > And even if we fix up f71805f and other known drivers which don't
> > > > call request_muxed_region(), we still need to police against these
> > > > rogue accesses, which is what this patch attempts to do.
> > > > 
> > > Do we ? I am personally not convinced that LPC accesses _have_ to
> > > occur through PCI on any given system.
> > 
> > On current systems, I suspect ISA/LPC devices are typically connected
> > via a PCI-to-ISA/LPC bridge.  But AFAIK there's no actual requirement
> > for that bridge, and there certainly *were* systems with ISA devices
> > but no PCI at all.
> > 
> > IMO, if you want to build ISA drivers on your arch, you need to make
> > sure the inb() probing done by those drivers works like it does on
> > x86.  If there's no device there, the inb() should return 0xff with no
> > fuss and no crash.
> 
> Right, and this is what I am attempting to do here.
> 
> So today a call to request_muxed_region() can still succeed even if no IO
> space mapped.
> 
> As such, even well-behaved drivers like f71882fg can still crash the system,
> as noted in RFC patch 1/4 ("resource: Request IO port regions from children
> of ioport_resource").

Maybe I'm missing something, but on x86, drivers like f71882fg do not
crash the system because inb() *never* causes a crash.

If you want to build that driver for ARM, I think you need to make
sure that inb() on ARM also *never* causes a crash.  I don't think
changing f71882fg and all the similar drivers is the right answer.

Bjorn
