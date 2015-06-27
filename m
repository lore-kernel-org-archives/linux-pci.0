Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:1045 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbbF0DGB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jun 2015 23:06:01 -0400
Message-ID: <558E1300.6020600@huawei.com>
Date: Sat, 27 Jun 2015 11:05:36 +0800
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

Hi Guenter, any update ?

> 
> Guenter
> 
> 


-- 
Thanks!
Yijing

