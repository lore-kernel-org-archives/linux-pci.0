Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bn0105.outbound.protection.outlook.com ([157.56.110.105]:14750
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751894AbbF0DfT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jun 2015 23:35:19 -0400
Date: Fri, 26 Jun 2015 20:19:46 -0700
From: Guenter Roeck <groeck@juniper.net>
To: Yijing Wang <wangyijing@huawei.com>
CC: Rajat Jain <rajatxjain@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Use a local mutex instead of pci_bus_sem to avoid
 deadlock
Message-ID: <20150627031945.GA27813@svl-evodev-groeck.juniper.net>
References: <1434021134-6519-1-git-send-email-wangyijing@huawei.com>
 <557A9661.8030603@huawei.com>
 <CAA93t1ooSY2keDigmUPpO7LzvT12YwQjpxH0b1xA508LL+VWdg@mail.gmail.com>
 <20150612182013.GA4455@svl-evodev-groeck.juniper.net>
 <558E1300.6020600@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <558E1300.6020600@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 27, 2015 at 11:05:36AM +0800, Yijing Wang wrote:
> On 2015/6/13 2:20, Guenter Roeck wrote:
> > On Fri, Jun 12, 2015 at 11:12:35AM -0700, Rajat Jain wrote:
> >> [+Guenter]
> >>
> >> Looks good to me. Unfortunately, I do not have the hardware anymore to test
> >> it :-(
> >>
> >> Guenter: Do you have it, or know some body who has and wants to test this?
> >>
> > I'll dig up the patch and test it.
> 
> Hi Guenter, any update ?
> 
I merged your patch into our images. I have not seen a single failure since
then.

At the same time, we tried to reproduce the problem Rajat had reported
originally. Unfortunately we have not been able to reproduce it. I don't know
if that is bad luck, if we did something wrong (most likely), or if something
else changed in the infrastructure since Rajat did his tests.

Either case, I would appreciate if this patch could find its way upstream.
I don't feel comfortable to enable AER without it. Feel free to add

Tested-by: Guenter Roeck <groeck@juniper.net>

Thanks,
Guenter
