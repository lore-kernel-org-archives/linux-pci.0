Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:30475 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbaBOAye (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2014 19:54:34 -0500
Message-ID: <52FEB98D.4070001@huawei.com>
Date: Sat, 15 Feb 2014 08:49:17 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	David Airlie <airlied@linux.ie>,
	<dri-devel@lists.freedesktop.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.ozlabs.org>,
	<linux-pcmcia@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 1/6] PCI,acpiphp: Use list_for_each_entry() for bus traversal
References: <1392297243-61848-1-git-send-email-wangyijing@huawei.com> <2601738.3Ek05F9oo5@vostro.rjw.lan> <52FD7D3D.4030409@huawei.com> <2512180.zyEb2tzySd@vostro.rjw.lan>
In-Reply-To: <2512180.zyEb2tzySd@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>>> Does it conflict with anything currently in linux-next (the linux-next branch
>>> of linux-pm.git in particular)?
>>
>> Hi Rafael,
>>    I applied this to your linux-next branch successfully . No conflicts found.
> 
> Good. :-)
> 
> Please feel free to add my ACK to it.

Thanks very much!



