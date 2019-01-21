Return-Path: <SRS0=cv1o=P5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5949EC2F441
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3250F2089F
	for <linux-pci@archiver.kernel.org>; Mon, 21 Jan 2019 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfAUQZL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:25:11 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:37904 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfAUQZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jan 2019 11:25:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id C9A581842B;
        Mon, 21 Jan 2019 17:25:07 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id oNBoTcps-SCS; Mon, 21 Jan 2019 17:25:06 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 2CDA61841C;
        Mon, 21 Jan 2019 17:25:06 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A6951E086;
        Mon, 21 Jan 2019 17:25:06 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C0C61E081;
        Mon, 21 Jan 2019 17:25:06 +0100 (CET)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Mon, 21 Jan 2019 17:25:06 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by thoth.se.axis.com (Postfix) with ESMTP id F29241D3B;
        Mon, 21 Jan 2019 17:25:05 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id ED49D80B46; Mon, 21 Jan 2019 17:25:05 +0100 (CET)
Date:   Mon, 21 Jan 2019 17:25:05 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Stephen Warren <swarren@wwwdotorg.org>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        "ABRAHAM, KISHON VIJAY" <kishon@ti.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
Message-ID: <20190121162505.lbbxrjkqmoqe6cx7@axis.com>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <e22d901d-f92f-90a4-eaa5-a350e3f817f1@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e22d901d-f92f-90a4-eaa5-a350e3f817f1@wwwdotorg.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 04:49:16PM -0700, Stephen Warren wrote:
> On 1/16/19 9:32 AM, Vincent Whitchurch wrote:
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
> So a while ago I took a look at running virtio over PCIe. I found virtio
> basically had two parts:
> 
> 1) The protocol used to enumerate which virtio devices exist, and perhaps
> configure them.
> 
> 2) The ring buffer protocol that actually transfers the data.
> 
> I recall that data transfer was purely based on simple shared memory and
> interrupts, and hence could run over PCIe (e.g. via the PCIe endpoint
> subsystem in the kernel) without issue.
> 
> However, the enumeration/configuration protocol requires the host to be able
> to do all kinds of strange things that can't possibly be emulated over PCIe;
> IIRC the configuration data contains "registers" that when written select
> the data other "registers" access. When the virtio device is exposed by a
> hypervisor, and all the accesses are emulated synchronously through a trap,
> this is easy enough to implement. However, if the two ends of this
> configuration parsing are on different ends of a PCIe bus, there's no way
> this can work.

Correct, and that's why the MIC "Virtio-over-PCIe framework" does not
try to implement the standard "Virtio Over PCI Bus".  (Yes, it's
confusing.)

> Are you thinking of doing something different for enumeration/configuration,
> and just using the virtio ring buffer protocol over PCIe?

The mic/vop code already does this.  See
Documentation/mic/mic_overview.txt for some information.

> I did post asking about this quite a while back, but IIRC I didn't receive
> much of a response. Yes, here it is:
> 
> > https://lists.linuxfoundation.org/pipermail/virtualization/2018-March/037276.html
> "virtio over SW-defined/CPU-driven PCIe endpoint"

I came to essentialy the same conclusions before I found the MIC code.

(Your "aside" in that email about virtio doing PCIe reads instead of
 writes is not solved by the MIC code, since that is how the standard
 virtio devices/drivers work.)
