Return-Path: <SRS0=ljL/=P2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF44C5AE5E
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 23:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C10D20652
	for <linux-pci@archiver.kernel.org>; Fri, 18 Jan 2019 23:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbfARXtU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:49:20 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:52494 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbfARXtU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jan 2019 18:49:20 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 74F021C0086;
        Fri, 18 Jan 2019 16:49:18 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.2 at avon.wwwdotorg.org
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Vincent Whitchurch <rabinv@axis.com>,
        "ABRAHAM, KISHON VIJAY" <kishon@ti.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <e22d901d-f92f-90a4-eaa5-a350e3f817f1@wwwdotorg.org>
Date:   Fri, 18 Jan 2019 16:49:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116163253.23780-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/16/19 9:32 AM, Vincent Whitchurch wrote:
> The Virtio-over-PCIe framework living under drivers/misc/mic/vop implements a
> generic framework to use virtio between two Linux systems, given shared memory
> and a couple of interrupts.  It does not actually require the Intel MIC
> hardware, x86-64, or even PCIe for that matter.  This patch series makes it
> buildable on more systems and adds a loopback driver to test it without special
> hardware.
> 
> Note that I don't have access to Intel MIC hardware so some testing of the
> patchset (especially the patch "vop: Use consistent DMA") on that platform
> would be appreciated, to ensure that the series does not break anything there.

So a while ago I took a look at running virtio over PCIe. I found virtio 
basically had two parts:

1) The protocol used to enumerate which virtio devices exist, and 
perhaps configure them.

2) The ring buffer protocol that actually transfers the data.

I recall that data transfer was purely based on simple shared memory and 
interrupts, and hence could run over PCIe (e.g. via the PCIe endpoint 
subsystem in the kernel) without issue.

However, the enumeration/configuration protocol requires the host to be 
able to do all kinds of strange things that can't possibly be emulated 
over PCIe; IIRC the configuration data contains "registers" that when 
written select the data other "registers" access. When the virtio device 
is exposed by a hypervisor, and all the accesses are emulated 
synchronously through a trap, this is easy enough to implement. However, 
if the two ends of this configuration parsing are on different ends of a 
PCIe bus, there's no way this can work.

Are you thinking of doing something different for 
enumeration/configuration, and just using the virtio ring buffer 
protocol over PCIe?

I did post asking about this quite a while back, but IIRC I didn't 
receive much of a response. Yes, here it is:

> https://lists.linuxfoundation.org/pipermail/virtualization/2018-March/037276.html
"virtio over SW-defined/CPU-driven PCIe endpoint"
