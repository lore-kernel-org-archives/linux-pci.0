Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:61170 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753230Ab3HBSwt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 14:52:49 -0400
Message-ID: <1375469567.1460.15.camel@x61.thuisdomein>
Subject: Re: [PATCH -v4 1/6] PCI,pciehp: avoid add a device already exist
 before suspend during resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Fri, 02 Aug 2013 20:52:47 +0200
In-Reply-To: <1375362389-26096-2-git-send-email-wangyijing@huawei.com>
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
	 <1375362389-26096-2-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Yijing,

On Thu, 2013-08-01 at 21:06 +0800, Yijing Wang wrote:
> Currently, pciehp_resume() try to hot add device if the slot adapter
> status return true. But if there are already some devices exist,
> namely list_empty(bus->devices) return false. We should not add the device
> again, because the device add action will fail. Also print some uncomfortable
> messages like this:
> 	pciehp 0000:00:1c.1:pcie04: Device 0000:03:00.0 already exists at 0000:03:00, cannot hot-add
> 	pciehp 0000:00:1c.1:pcie04: Cannot add device at 0000:03:00
> 
> Tested-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> Cc: Paul Bolle <pebolle@tiscali.nl>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Oliver Neukum <oneukum@suse.de>
> Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>
> Cc: linux-pci@vger.kernel.org

0) There's no 0/6 in my mailbox, so I reply to this message.

1) This series applies cleanly on top of v3.10.5-rc1 (except for some
odd problem in 6/6, which I mentioned in my reply to 6/6).

2) However, this series doesn't appear to work on v3.10.5-rc1. After the
first resume the wireless connection appears to be gone (in Gnome 3).
iwl4965 is still loaded, but I can't reconnect. That should happen
automagically.

3) And the second resume apparently hangs the system. Not sure how it
hangs exactly, but I have to manually shutdown the laptop by pressing
the power button for a few seconds.

4) I guess I'll have to respin v3.10.5-rc1 without this series to
determine if v3.10.5-rc1 or this series causes these issues. But feel
free to prod me for further tests.


Paul Bolle

