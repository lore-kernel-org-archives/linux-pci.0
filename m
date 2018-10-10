Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF868C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C021B20841
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 08:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C021B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=intra2net.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeJJP2V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:28:21 -0400
Received: from rs07.intra2net.com ([85.214.138.66]:39332 "EHLO
        rs07.intra2net.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeJJP2V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Oct 2018 11:28:21 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 11:28:20 EDT
Received: from mail.m.i2n (unknown [172.17.128.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by rs07.intra2net.com (Postfix) with ESMTPS id 7091A15000CA;
        Wed, 10 Oct 2018 10:00:20 +0200 (CEST)
Received: from localhost (mail.m.i2n [127.0.0.1])
        by localhost (Postfix) with ESMTP id 222412D9;
        Wed, 10 Oct 2018 10:00:20 +0200 (CEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.52.82,VDF=8.15.8.188)
Received: from storm.m.i2n (storm.m.i2n [172.16.1.2])
        by mail.m.i2n (Postfix) with ESMTP id BEAD722E;
        Wed, 10 Oct 2018 10:00:13 +0200 (CEST)
From:   Thomas Jarosch <thomas.jarosch@intra2net.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bin Meng <bmeng.cn@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        stable <stable@vger.kernel.org>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci: Add a few new IDs for Intel GPU "spurious interrupt" quirk
Date:   Wed, 10 Oct 2018 10:00:13 +0200
Message-ID: <5897590.Qva4cvS4Tx@storm.m.i2n>
Organization: Intra2net AG
In-Reply-To: <20181009170158.GA5906@bhelgaas-glaptop.roam.corp.google.com>
References: <1537974841-29928-1-git-send-email-bmeng.cn@gmail.com> <CAEUhbmUBic3RJbMH6bukw3NVis4qxMKr_pqJhn14vFtpGvES=w@mail.gmail.com> <20181009170158.GA5906@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello together,

On Tuesday, 9 October 2018 19:01:58 CEST Bjorn Helgaas wrote:
> > > Do you happen to know if Windows has the same problem?  I.e., if you
> > > boot an old version of Windows with a new GPU, and unplug the VGA
> > > cable, does Windows crash?  If Windows can figure out how to handle
> > > that situation gracefully, Linux should be able to do it, too.
> > 
> > I suspect Windows cannot handle it too. Without the GPU awareness, the
> > interrupt line is simply on and no driver claims the devices and will
> > cause issues. I can test this.
> 
> If you could test this, that would be great.  I would be quite
> surprised if Windows crashed when you unplug the VGA cable.

[original patch author from 2012 chiming in here]

When doing a test on Windows, I guess it's vital to use a generic VGA / VESA 
driver. The Intel GPU driver will modify the interrupt configuration 
registers. Also at least I don't know if Windows has similar logic like Linux 
to disable spurious interrupts after XX unhandled interrupts.
Personally I'm unsure if the Windows test is worth the time.

Back in 2012 I tried to report this as a video BIOS bug via the Intel Open 
Source Technology Center. There was not much interest to report an issue to 
the BIOS developers. I have private emails from other people with similar 
problems on "Kenosha Pass" based boards. One of them talked to an actual Intel 
BIOS engineer in 2014, but still that didn't get anything fixed.

Regarding a generic fix: The problem is testing on real hardware.
Some Intel GPUs have different configuration registers. The Intel GPU driver 
could be used as template, but doing a fix without actual hardware to verify 
it is unsafe (=might mess up the system in unexpected ways).

Related ideas from Daniel Vetter in 2014:
https://lists.freedesktop.org/archives/intel-gfx/2014-August/050448.html

Cheers,
Thomas



