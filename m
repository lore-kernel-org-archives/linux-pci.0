Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:56960 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754342Ab3HEDMT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Aug 2013 23:12:19 -0400
Message-ID: <51FF1803.5090202@huawei.com>
Date: Mon, 5 Aug 2013 11:12:03 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH -v4 1/6] PCI,pciehp: avoid add a device already exist
 before suspend during resume
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>  <1375362389-26096-2-git-send-email-wangyijing@huawei.com> <1375469567.1460.15.camel@x61.thuisdomein>
In-Reply-To: <1375469567.1460.15.camel@x61.thuisdomein>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 
> 0) There's no 0/6 in my mailbox, so I reply to this message.
>

Sorry, I forgot adding your cc into patch 0.

> 1) This series applies cleanly on top of v3.10.5-rc1 (except for some
> odd problem in 6/6, which I mentioned in my reply to 6/6).
> 
> 2) However, this series doesn't appear to work on v3.10.5-rc1. After the
> first resume the wireless connection appears to be gone (in Gnome 3).
> iwl4965 is still loaded, but I can't reconnect. That should happen
> automagically.

I found some mistakes in my patch 6/6, I'm very sorry about that.
Will be more careful next time, I will refresh this patch, can your help
to test it again? I will update this patch and resend it soon.

> 
> 3) And the second resume apparently hangs the system. Not sure how it
> hangs exactly, but I have to manually shutdown the laptop by pressing
> the power button for a few seconds.
> 
> 4) I guess I'll have to respin v3.10.5-rc1 without this series to
> determine if v3.10.5-rc1 or this series causes these issues. But feel
> free to prod me for further tests.

Thanks!
Yijing.




-- 
Thanks!
Yijing

