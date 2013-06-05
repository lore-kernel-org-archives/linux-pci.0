Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:63975 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756511Ab3FER2P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jun 2013 13:28:15 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so3080060obc.17
        for <linux-pci@vger.kernel.org>; Wed, 05 Jun 2013 10:28:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370412117-12860-1-git-send-email-wangyijing@huawei.com>
References: <1370412117-12860-1-git-send-email-wangyijing@huawei.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 5 Jun 2013 11:27:55 -0600
Message-ID: <CAErSpo5+rj_47kvy1shG0jjRuo5t2zWu5RHqGragxPoBDMVXtg@mail.gmail.com>
Subject: Re: [PATCH -v4 0/8] Add hostbridge resource release to support root
 bus hotplug in IA64
To: Yijing Wang <wangyijing@huawei.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Jiang Liu <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 5, 2013 at 12:01 AM, Yijing Wang <wangyijing@huawei.com> wrote:
> v3->v4: fix memory allocation problem and use dev_err instead of pr_err follow Bjorn's suggestion.

What does this series apply to?  I normally apply patches to topic
branches based on -rc1, but these don't apply cleanly to either
v3.10-rc1 or to the next-20130605 linux-next tree.

Bjorn
