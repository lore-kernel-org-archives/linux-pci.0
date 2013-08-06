Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:57502 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab3HFBXg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 21:23:36 -0400
Message-ID: <52005000.9000200@huawei.com>
Date: Tue, 6 Aug 2013 09:23:12 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Paul Bolle <pebolle@tiscali.nl>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	Rafael <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Hanjun Guo <guohanjun@huawei.com>, <jiang.liu@huawei.com>
Subject: Re: [PATCH -v5 0/6] Use PCI Serial Number to identify device change
References: <1375692898-27476-1-git-send-email-wangyijing@huawei.com> <1375704104.1415.5.camel@x61.thuisdomein>
In-Reply-To: <1375704104.1415.5.camel@x61.thuisdomein>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2013/8/5 20:01, Paul Bolle wrote:
> On Mon, 2013-08-05 at 16:54 +0800, Yijing Wang wrote:
>> v4->v5: update patch 6/6, correct some mistakes in this patch, thank Paul for help
>> 		test this series.
>> [...]
>> I tested to apply this series to Linus 3.11-rc4 and Bjorn's pci-next branch, and
>> result is ok.
> 
> And I tested this series on top of v3.10.5 (on x86_64). It applied
> cleanly, and it compiled cleanly. No pciehp related errors at resume.
> And, more importantly, the severe issues of v4 are gone: a few suspend
> and resume cycles showed no obvious problems.
> 

Hi Paul,
   Thanks for your test very much!

Thanks!
Yijing.

> 


-- 
Thanks!
Yijing

