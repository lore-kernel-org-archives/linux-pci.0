Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:64282 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751303Ab3HEMBt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2013 08:01:49 -0400
Message-ID: <1375704104.1415.5.camel@x61.thuisdomein>
Subject: Re: [PATCH -v5 0/6] Use PCI Serial Number to identify device change
From: Paul Bolle <pebolle@tiscali.nl>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rafael <rjw@sisk.pl>, Oliver Neukum <oneukum@suse.de>,
	Gu Zheng <guz.fnst@cn.fujitsu.com>,
	Hanjun Guo <guohanjun@huawei.com>, jiang.liu@huawei.com
Date: Mon, 05 Aug 2013 14:01:44 +0200
In-Reply-To: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
References: <1375692898-27476-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-08-05 at 16:54 +0800, Yijing Wang wrote:
> v4->v5: update patch 6/6, correct some mistakes in this patch, thank Paul for help
> 		test this series.
>[...]
> I tested to apply this series to Linus 3.11-rc4 and Bjorn's pci-next branch, and
> result is ok.

And I tested this series on top of v3.10.5 (on x86_64). It applied
cleanly, and it compiled cleanly. No pciehp related errors at resume.
And, more importantly, the severe issues of v4 are gone: a few suspend
and resume cycles showed no obvious problems.

Thanks!


Paul Bolle

