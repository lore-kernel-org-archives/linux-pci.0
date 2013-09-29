Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:45213 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab3I2Biv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 28 Sep 2013 21:38:51 -0400
Message-ID: <52478489.8050203@huawei.com>
Date: Sun, 29 Sep 2013 09:38:17 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Ben Hutchings <ben@decadent.org.uk>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 2/2] PCI: Warn if power_state != PCI_D0 when write MSI
 message
References: <1378974012-13364-1-git-send-email-wangyijing@huawei.com>  <CAErSpo5XWa3qTfE_p5vDqJOkrrdkcM9_Nr-u_qFYSdAob1sEig@mail.gmail.com> <1380335308.4430.109.camel@deadeye.wl.decadent.org.uk>
In-Reply-To: <1380335308.4430.109.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>> I would expect that if the device is not in D0, we should remember the
>> hardware updates that need to be made, and if the device returns to
>> D0, we should apply the updates then.  If that's the case this is not
>> an error and we shouldn't warn about it.
> [...]
> 
> During system suspend all IRQ affinities are changed to the boot CPU as
> other CPUs are disabled, and then I think they are reverted during
> system resume.  This certainly used to be done while most devices were
> suspended.  That's why we have to check for the device power state here.
> If suspend/resume is still done in the same order then we shouldn't log
> a warning about this.
> 
> Yijing, why not add a check for this in pci_enable_msi() itself if you
> think it's that important to warn about?

This is a  good idea, better than just warn a inconspicuous message.

Thanks!
Yijing.



-- 
Thanks!
Yijing

