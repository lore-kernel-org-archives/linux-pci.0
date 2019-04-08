Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E350C10F13
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400BD20880
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfDHQuH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:50:07 -0400
Received: from foss.arm.com ([217.140.101.70]:51882 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfDHQuH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Apr 2019 12:50:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB59315AB;
        Mon,  8 Apr 2019 09:50:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ABF93F718;
        Mon,  8 Apr 2019 09:50:04 -0700 (PDT)
Date:   Mon, 8 Apr 2019 17:50:01 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>,
        wangkefeng.wang@huawei.com, lorenzo.pieralisi@arm.com,
        arnd@arndb.de, rafael@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        andy.shevchenko@gmail.com, catalin.marinas@arm.com, bp@suse.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
Message-ID: <20190408165001.GD7872@fuggles.cambridge.arm.com>
References: <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net>
 <20190404185815.GA26522@google.com>
 <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
 <20190405180615.GB109021@google.com>
 <20190405182923.GA11563@roeck-us.net>
 <ec054678-ce9e-bd5c-5225-a025214f1075@huawei.com>
 <9be8d131-d1d5-cc97-26fe-e32fe30c0544@roeck-us.net>
 <efff6e58-b48d-f168-ed92-1714f5a08292@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efff6e58-b48d-f168-ed92-1714f5a08292@huawei.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 08, 2019 at 05:35:51PM +0100, John Garry wrote:
> On 08/04/2019 14:47, Guenter Roeck wrote:
> > > > > > FC patch 1/4 ("resource: Request IO port regions from children
> > > > > > of ioport_resource").
> > > > > 
> > > > > Maybe I'm missing something, but on x86, drivers like f71882fg do not
> > > > > crash the system because inb() *never* causes a crash.
> > > > > 
> > > > > If you want to build that driver for ARM, I think you need to make
> > > > > sure that inb() on ARM also *never* causes a crash.  I don't think
> > > > > changing f71882fg and all the similar drivers is the right answer.
> > > > > 
> > > > 
> > > > Agreed. As I had mentioned earlier, the driver changes are orthogonal:
> > > > the drivers should request the IO region before accessing it, primarily
> > > > to avoid conflicting accesses by multiple drivers in parallel. For
> > > > example, the f71882fg driver supports chips which implement hardware
> > > > monitoring as well as watchdog functionality, and both the hwmon
> > > > and the watchdog driver may try to access the io space.
> > > > 
> > > > If and how the system ensures that the IO region exists and/or that
> > > > inb() always succeeds is a different question. I would prefer a less
> > > > complex solution than the one suggested here, but that is my personal
> > > > opionion.
> > > 
> > > Hi Guenter,
> > > 
> > > I have a question about these super-IO accesses:
> > > 
> > > To me, it's not good that these hwmon, watchdog, gpio, etc drivers
> > > make unconstrained accesses to 0x2e and 0x4e ports (ignoring the
> > > request_muxed_region() call).
> > > 
> > > The issue I see is that on an arm, IO space for some other device may
> > > be mapped in this region, so it would not be right for these drivers
> > > to access those same regions.
> > > 
> > Yes, but then there _could_ be some arm or arm64 device supporting one
> > of those chips,
> > so we can not just add something like "depends on !(ARM || ARM64)".
> 
> This looks like what has been added for PPC in commmit 746cdfbf01c0.
> 
> However, agreed, it's not a good approach.
> 
> > 
> > > Is there any other platform check which can be made to ensure that
> > > accesses these super-IO ports is appropriate?
> > > 
> > 
> > Not that I know of. It would make some sense to provide API functions
> > for Super-IO accesses, but that would be a lot of work, and I guess
> > it isn't really valuable enough for anyone to pick up and do.
> > 
> > Normally, if you have such a system, the respective drivers should not be
> > built. After all, this isn't the only instance where drivers
> > unconditionally
> > access some io region, no matter if the underlying hardware exists or not.
> > The only real defense against that is to not build those drivers into
> > a given kernel.
> 
> If we're going to support a multi-plaform kernel for a given arch, then we
> can't always avoid it.
> 
> It seems that the only solution on the table now is to discard these IO port
> accesses on arm64 when the IO port are not mapped.

Hmm, how are you going to achieve that? I'm not sure we can guarantee a
synchronous abort, so I'd be nervous about anything that tries to handle
the exception after making the unmapped access.

Will
