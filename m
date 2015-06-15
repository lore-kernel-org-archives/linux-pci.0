Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:46541 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbFOAkb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 14 Jun 2015 20:40:31 -0400
Message-ID: <557E1EF9.7040607@huawei.com>
Date: Mon, 15 Jun 2015 08:40:25 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Guenter Roeck <groeck@juniper.net>,
	Rajat Jain <rajatxjain@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Use a local mutex instead of pci_bus_sem to avoid
 deadlock
References: <1434021134-6519-1-git-send-email-wangyijing@huawei.com> <557A9661.8030603@huawei.com> <CAA93t1ooSY2keDigmUPpO7LzvT12YwQjpxH0b1xA508LL+VWdg@mail.gmail.com> <20150612182013.GA4455@svl-evodev-groeck.juniper.net>
In-Reply-To: <20150612182013.GA4455@svl-evodev-groeck.juniper.net>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/6/13 2:20, Guenter Roeck wrote:
> On Fri, Jun 12, 2015 at 11:12:35AM -0700, Rajat Jain wrote:
>> [+Guenter]
>>
>> Looks good to me. Unfortunately, I do not have the hardware anymore to test
>> it :-(
>>
>> Guenter: Do you have it, or know some body who has and wants to test this?
>>
> I'll dig up the patch and test it.

Rajat, Guenter, thanks for your help.

Thanks!
Yijing.

> 
> Guenter
> 
> 


-- 
Thanks!
Yijing

