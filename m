Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D52C4338F
	for <linux-pci@archiver.kernel.org>; Mon,  2 Aug 2021 10:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F74B60F9E
	for <linux-pci@archiver.kernel.org>; Mon,  2 Aug 2021 10:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhHBKEE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 2 Aug 2021 06:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231669AbhHBKED (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 06:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C918760F5A;
        Mon,  2 Aug 2021 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627898634;
        bh=akReKGJUqE3T64EJM+sE0hSyoy5AfOsjmjai1ezNn5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ezmi1wtfv/KUeKUM4cWKnsBrT1UVQqZ99WYWoodlr9a3ajFZ830A0vV1SIhMa9+mX
         hMpZe7GAxG0ZVY2LmlKqsCQi4+kTNIXT/+t2u5NhbXtynIjy45G1Jq60nabDhTHhej
         iQ3Y9NC33LTE53lU0gYndDXz+W++7+lD5HpwvNv4vvoljyTZ9jC1g+BfHy4JJ7N0k0
         fX3YmLUYy0kXszLEJZ4mFtu1RWPuna8UZIuC/Eo/3SmDZpovf+7tnNmIaQ/1LQG8nQ
         GmNZ1Ohxpt6GHlz3nt7PNR/eIuYYwq/rpOxk5UZRPggVp8dpsLaEkonG+uEPkM+CjE
         phdlt3g6I7tkQ==
Date:   Mon, 2 Aug 2021 11:03:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v8 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210802100343.GA27282@willie-the-truck>
References: <20210728080932.72515-1-liuqi115@huawei.com>
 <20210728080932.72515-3-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728080932.72515-3-liuqi115@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 04:09:32PM +0800, Qi Liu wrote:
> PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> to sample bandwidth, latency, buffer occupation etc.
> 
> Each PMU RCiEP device monitors multiple Root Ports, and each RCiEP is
> registered as a PMU in /sys/bus/event_source/devices, so users can
> select target PMU, and use filter to do further sets.
> 
> Filtering options contains:
> event        - select the event.
> subevent     - select the subevent.

Hmm, I was hoping that you would expose all the events as proper perf_events
and get rid of the subevents entirely.

Then userspace could do things like:

  // Count number of RX memory reads
  $ perf stat -e hisi_pcie0_0/rx_memory_read/

  // Count delay cycles
  $ perf stat -e hisi_pcie0_0/latency/

  // Count both of the above (events must be in the same group)
  $ perf stat -g -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/

Note that in all three of these cases the hardware will be programmed in
the same way and both HISI_PCIE_CNT and HISI_PCIE_EXT_CNT are allocated!

So for example, doing this (i.e. without the '-g'):

  $ perf stat -e hisi_pcie0_0/latency/ -e hisi_pcie0_0/rx_memory_read/

would fail because the first event would allocate both of the counters.

All you need to do is check the counter scheduling constraints when
accepting an event group in the driver. No need for subevents at all.

Does that make sense?

Will
