Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39481 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901AbbLQSne (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Dec 2015 13:43:34 -0500
Date: Thu, 17 Dec 2015 12:43:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhou Wang <wangzhou1@hisilicon.com>
Cc: Dongdong Liu <liudongdong3@huawei.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com, gabriele.paoloni@huawei.com,
	qiujiang@huawei.com, zhangjukuo@huawei.com, haifeng.wei@huawei.com,
	yisen.zhuang@huawei.com, "xuwei (O)" <xuwei5@hisilicon.com>
Subject: Re: [PATCH] PCI: hisi: fix the hisi_pcie_cfg_read bug when size=4
Message-ID: <20151217184331.GB29500@localhost>
References: <1448600280-83695-1-git-send-email-liudongdong3@huawei.com>
 <20151204224334.GL20125@localhost>
 <20151209161643.GE31930@localhost>
 <566890D5.2020007@hisilicon.com>
 <567293F3.6020004@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <567293F3.6020004@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 17, 2015 at 06:52:35PM +0800, Zhou Wang wrote:
> On 2015/12/10 4:36, Zhou Wang wrote:
> > On 2015/12/10 0:16, Bjorn Helgaas wrote:
> >> On Fri, Dec 04, 2015 at 04:43:34PM -0600, Bjorn Helgaas wrote:
> >>> On Fri, Nov 27, 2015 at 12:58:00PM +0800, Dongdong Liu wrote:
> >>>> Current hisi_pcie_cfg_read code read the RC configuration space,
> >>>> this has a problem that the output parameter "*val" have not been
> >>>> assigned when size=4, so we fix the bug by "*val = reg_val" when size=4.
> >>>>
> >>>> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> >>>
> >>> Wow, that's a pretty egregious bug.  Was the hisi driver ever tested
> >>> at all?  We use dword reads in pci_bus_read_dev_vendor_id() to
> >>> enumerate devices, so if those didn't return valid data, nothing at
> >>> all should have worked.
> >>>
> >>> I tentatively put this on my for-linus branch for v4.4, but I wonder
> >>> whether it might be smarter to revert the driver completely until I
> >>> have more confidence in it.
> >>>
> >>> What sort of testing have you done on this driver?
> >>
> >> Since I haven't heard anything about whether this driver was ever
> >> tested, I dropped this patch from my for-linus branch and I reverted
> >> the entire hisi driver.
> >>
> >> Let me know when you have some testing results, and I'll take another
> >> look at it.
> >>
> >> Bjorn
> >>
> > 
> > Hi Bjorn,
> > 
> > Very sorry for late, I am on business trip at the moment so I have restricted
> > access to emails and my replies can be late.
> > 
> > The driver has been tested extensively based on internal version, but I did this
> > mistake when upstreaming :(. I will send a test log ASAP.
> >
> 
> Hi Bjorn,
> 
> I made a test based on Intel 82599 networking card, this is the bootup log which
> contains PCIe host and Intel 82599 networking card parts.

Thanks!  I updated my for-linus branch to remove the revert and add
the 32-bit config read fix.  I'll ask Linus to pull this before v4.4.

Bjorn
