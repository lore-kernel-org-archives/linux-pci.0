Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:58868 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757564Ab3FFHcl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2013 03:32:41 -0400
Message-ID: <51B03AFC.5060807@huawei.com>
Date: Thu, 6 Jun 2013 15:32:12 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, <linux-ia64@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Subject: Re: [PATCH -v4 0/8] Add hostbridge resource release to support root
 bus hotplug in IA64
References: <1370412117-12860-1-git-send-email-wangyijing@huawei.com> <CAErSpo5+rj_47kvy1shG0jjRuo5t2zWu5RHqGragxPoBDMVXtg@mail.gmail.com>
In-Reply-To: <CAErSpo5+rj_47kvy1shG0jjRuo5t2zWu5RHqGragxPoBDMVXtg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
   This series is based your pci-next branch, I used stgit to format this series, I try to
git am them to pci-next, but indeed patch 4 was applied fail, it's strange.
Now I use git format-patch to format this series again, tag v5, and test them in pci-next, result is ok.

Thanks!
Yijing.

On 2013/6/6 1:27, Bjorn Helgaas wrote:
> On Wed, Jun 5, 2013 at 12:01 AM, Yijing Wang <wangyijing@huawei.com> wrote:
>> v3->v4: fix memory allocation problem and use dev_err instead of pr_err follow Bjorn's suggestion.
> 
> What does this series apply to?  I normally apply patches to topic
> branches based on -rc1, but these don't apply cleanly to either
> v3.10-rc1 or to the next-20130605 linux-next tree.
> 
> Bjorn
> 
> 


-- 
Thanks!
Yijing

