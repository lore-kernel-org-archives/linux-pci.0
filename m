Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:60518 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751745Ab3HBVnh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Aug 2013 17:43:37 -0400
Message-ID: <1375479815.1358.3.camel@x61.thuisdomein>
Subject: Re: [PATCH -v4 1/6] PCI,pciehp: avoid add a device already exist
 before suspend during resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>
Date: Fri, 02 Aug 2013 23:43:35 +0200
In-Reply-To: <1375469567.1460.15.camel@x61.thuisdomein>
References: <1375362389-26096-1-git-send-email-wangyijing@huawei.com>
	 <1375362389-26096-2-git-send-email-wangyijing@huawei.com>
	 <1375469567.1460.15.camel@x61.thuisdomein>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2013-08-02 at 20:52 +0200, Paul Bolle wrote:
> 2) However, this series doesn't appear to work on v3.10.5-rc1. After the
> first resume the wireless connection appears to be gone (in Gnome 3).
> iwl4965 is still loaded, but I can't reconnect. That should happen
> automagically.
> 
> 3) And the second resume apparently hangs the system. Not sure how it
> hangs exactly, but I have to manually shutdown the laptop by pressing
> the power button for a few seconds.
> 
> 4) I guess I'll have to respin v3.10.5-rc1 without this series to
> determine if v3.10.5-rc1 or this series causes these issues. But feel
> free to prod me for further tests.

Well, v3.10.5-rc1 without this series resumes fine. (But, of course, I
now again see the pciehp errors at resume.) Is this series actually
expected to work on v3.10.y?


Paul Bolle

