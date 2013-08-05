Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:41559 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab3HEDF2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Aug 2013 23:05:28 -0400
Message-ID: <51FF1660.40002@huawei.com>
Date: Mon, 5 Aug 2013 11:05:04 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH -v4 6/6] PCI,pciehp: identify device change during suspend
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>  <1375362389-26096-7-git-send-email-wangyijing@huawei.com> <1375468943.1460.4.camel@x61.thuisdomein>
In-Reply-To: <1375468943.1460.4.camel@x61.thuisdomein>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> I ran into a problem with this change. This line, removing a line
> consisting of only a single tab, appears to conflict with a patch
> earlier in this series. I had to manually remove just the change that
> removed that line to get this patch to apply. Any idea what's going on?
> 
>>  	return 0;
>>  }
>>  #endif /* PM */

Hi Paul,
   Thanks for your review and test very much!
Because this series was based Bjorn's pci-next branch, so maybe this is
the cause, although I don't find any difference between Bjorn's pci-next tree and Linus master tree.

I will refresh this patch.

Thanks!
Yijing.



-- 
Thanks!
Yijing

