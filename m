Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33573 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbHREJt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Aug 2015 00:09:49 -0400
Received: by pabyb7 with SMTP id yb7so123014091pab.0
        for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2015 21:09:48 -0700 (PDT)
Date: Mon, 17 Aug 2015 23:09:43 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 25/51] PCI: Fix size calculation with old_size on
 rescan path
Message-ID: <20150818040943.GV26431@google.com>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
 <1438039809-24957-26-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438039809-24957-26-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 27, 2015 at 04:29:43PM -0700, Yinghai Lu wrote:
> On booting path, we don't pass realloc at first, and treat all optional just
> as must, in some case we can smaller size/align with optional than must only.
> 
> 04:00.0 has four child bridges: 05:01.0, 05:02.0, 05:03.0, 05:04.0
> pref layout after booting path like followings:
> 
> pci 0000:04:00.0: BAR 9: assigned [mem 0x84000000-0x9fffffff 64bit pref]
> pci 0000:05:04.0: BAR 9: assigned [mem 0x88000000-0x9fffffff 64bit pref]
> pci 0000:05:03.0: BAR 9: assigned [mem 0x84000000-0x841fffff 64bit pref]
> pci 0000:07:00.0: BAR 0: assigned [mem 0x81200000-0x8123ffff 64bit]
> pci 0000:05:03.0: PCI bridge to [bus 08-0f]
> pci 0000:05:03.0:   bridge window [mem 0x84000000-0x841fffff 64bit pref]
> pci 0000:10:00.0: BAR 0: assigned [mem 0x90000000-0x9fffffff 64bit pref]
> pci 0000:10:00.0: BAR 2: assigned [mem 0x88000000-0x8800ffff 64bit pref]
> pci 0000:05:04.0: PCI bridge to [bus 10]
> pci 0000:05:04.0:   bridge window [mem 0x88000000-0x9fffffff 64bit pref]
> pci 0000:04:00.0: PCI bridge to [bus 05-10]
> pci 0000:04:00.0:   bridge window [mem 0x84000000-0x9fffffff 64bit pref]

Unless 07:00.0 and 10:00.0 are relevant, please remove them.

> so the old size in rescan for 04:00.0 would be 0x1c000000, and align is 0x4000000
> 
> during remove and rescan:
> 
> pci 0000:05:03.0: bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 08-0f] add_size 200000 add_align 100000 alt_size 0 alt_align 0 must_size 0 must_align 0

What is "[mem 0x00000000-0xffffffffffffffff 64bit pref]" telling us?
Surely that's not an actual aperture, is it?
