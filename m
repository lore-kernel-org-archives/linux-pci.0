Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8748C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B559620883
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 17:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNE6/JZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B559620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbeKHCsG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeKHCsF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Nov 2018 21:48:05 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3F020989;
        Wed,  7 Nov 2018 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541611007;
        bh=nRC87M2PPMnvtm0j0gL01u5eYnaGooMTADUzbBVqpu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNE6/JZl4WHeCa4cXwJRq25s/yAoGsSeLkfF2wVVxmC+68GqNLy38UtlfhjYTIVCH
         mAaT2BdjzBy78j1Tr44fLtKGhGluaIqyL2hqHM4Pdl8rIm2IbmVW2GTglkPiKQeY5I
         Iug3bDnKSefrKa9QhkAlyFYNpI0Qnt6w2Xg52Tkk=
Date:   Wed, 7 Nov 2018 11:16:46 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
Message-ID: <20181107171646.GB261200@google.com>
References: <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic>
 <20181106232040.GA85755@google.com>
 <20181107091838.GA10835@zn.tnic>
 <72f4a144-fe83-dc0d-b839-133873ed589b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72f4a144-fe83-dc0d-b839-133873ed589b@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 07, 2018 at 05:51:22AM -0800, Guenter Roeck wrote:
> On 11/7/18 1:18 AM, Borislav Petkov wrote:
> > On Tue, Nov 06, 2018 at 05:20:41PM -0600, Bjorn Helgaas wrote:
> > > Or maybe even drivers/acpi/thermal.c, which claims every Thermal Zone
> > > (ACPI 6.2, sec 11), would be sufficient.  I don't know what the
> > > relationship between hwmon and other thermal stuff, e.g.,
> > > Documentation/thermal/sysfs-api.txt is.  acpi/thermal.c looks tied
> > > into the drivers/thermal stuff (it registers "thermal_zone" devices),
> > > but not to hwmon.
> > 
> > Err, I still don't think I'm catching your drift but let me stop you
> > right there: amd_nb is not there only for hwmon/k10temp. It is a small
> > interface glue if you will, which exports the CPU functionality in PCI
> > config space to other consumers.
> 
> Also, thermal and hwmon are orthogonal, just like hwmon and iio. One would
> typically have a driver in one subsystem, in some cases bridging to the
> other subsystem, but one would not have drivers in both subsystems.
> I think Bjorn is suggesting that the k10temp driver should move to the
> thermal subsystem, though I don't really understand what that has to do
> with finding the correct PCI device(s) to query. Or maybe I misunderstand.

Not really; I'm suggesting that it's possible to make k10temp work in
a way that requires less knowledge about the AMD topology and hence
fewer changes for new platforms.

Today, k10temp needs CPU/PCI topology info from amd_nb to read the
sensors via PCI registers.  k10temp could conceivably read the sensors
via ACPI methods, which means that topology info would be in the
firmware and k10temp wouldn't depend on amd_nb.

Bjorn
