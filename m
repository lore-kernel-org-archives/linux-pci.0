Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE86C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D867E20657
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 10:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfAQKyr (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 05:54:47 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:44098 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfAQKyr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 05:54:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id A801B18582;
        Thu, 17 Jan 2019 11:54:43 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id MOgDnb2tF8EW; Thu, 17 Jan 2019 11:54:42 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 4C9251857F;
        Thu, 17 Jan 2019 11:54:42 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C4681E081;
        Thu, 17 Jan 2019 11:54:42 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F30CF1E080;
        Thu, 17 Jan 2019 11:54:41 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Thu, 17 Jan 2019 11:54:41 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id E4E0E1885;
        Thu, 17 Jan 2019 11:54:41 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id E16A380B46; Thu, 17 Jan 2019 11:54:41 +0100 (CET)
Date:   Thu, 17 Jan 2019 11:54:41 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190117105441.eqediwlekofp2srg@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 16, 2019 at 06:07:53PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 16, 2019 at 5:33 PM Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > The Virtio-over-PCIe framework living under drivers/misc/mic/vop implements a
> > generic framework to use virtio between two Linux systems, given shared memory
> > and a couple of interrupts.  It does not actually require the Intel MIC
> > hardware, x86-64, or even PCIe for that matter.  This patch series makes it
> > buildable on more systems and adds a loopback driver to test it without special
> > hardware.
> >
> > Note that I don't have access to Intel MIC hardware so some testing of the
> > patchset (especially the patch "vop: Use consistent DMA") on that platform
> > would be appreciated, to ensure that the series does not break anything there.
> 
> I think we need to take a step back though and discuss what combinations
> we actually do want to support. I have not actually read the whole mic/vop
> driver, so I don't know if this would be a good fit as a generic interface --
> it may or may not be, and any other input would be helpful.

The MIC driver as a whole is uninteresting as a generic interface since
it is quite tied to the Intel hardware.  The VOP parts though are
logically separated and have no relation to that hardware, even if the
ioctls are called MIC_VIRTIO_*.

The samples/mic/mpssd/mpssd.c code handles both the boot of the MIC
(sysfs) and the VOP parts (ioctls).

> Aside from that, I should note that we have two related subsystems
> in the kernel: the PCIe endpoint subsystem maintained by Kishon and
> Lorenzo, and the NTB subsystem maintained by Jon, Dave and Allen.
> 
> In order to properly support virtio over PCIe, I would hope we can come
> up with a user space interface that looks the same way for configuring
> virtio drivers in mic, pcie-endpoint and ntb, if at all possible. Have
> you looked at those two subsystems?

pcie-endpoint is a generic framework that allows Linux to act as an
endpoint and set up the BARs, etc.  mic appears to have Intel
MIC-specific code for this (pre-dating pcie-endpoint) but this is
separate from the vop code.  pcie-endpoint and vop do not have
overlapping functionality and can be used together.

I'm not familiar with NTB, but from a quick look it seems to be tied to
special hardware, and I don't see any virtio-related code there.  A vop
backend for NTB-backend would presumably work to allow virtio
functionality there.
