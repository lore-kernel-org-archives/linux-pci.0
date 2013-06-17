Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60766 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab3FQXLH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2013 19:11:07 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so4192222oag.5
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2013 16:11:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+8MBb+BSNnLtR8jZinTh9h01f3=Zeu+kX6xke1Ei08HYzRQvg@mail.gmail.com>
References: <1370504093-14908-1-git-send-email-wangyijing@huawei.com>
 <20130615002224.GA21643@google.com> <51BE7AD5.5010300@huawei.com> <CA+8MBb+BSNnLtR8jZinTh9h01f3=Zeu+kX6xke1Ei08HYzRQvg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Jun 2013 17:10:47 -0600
Message-ID: <CAErSpo4PhY5gzdxK6NSRxOquuQMojnBX9wRm6Pb-uxq6t3i=-Q@mail.gmail.com>
Subject: Re: [PATCH -v5 0/8] Add hostbridge resource release to support root
 bus hotplug in IA64
To: Tony Luck <tony.luck@gmail.com>
Cc: Yijing Wang <wangyijing@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Liu Jiang <jiang.liu@huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 17, 2013 at 4:57 PM, Tony Luck <tony.luck@gmail.com> wrote:
> On Sun, Jun 16, 2013 at 7:56 PM, Yijing Wang <wangyijing@huawei.com> wrote:
>>> Tony, what do you think about this?  It only touches ia64, and I
>>> have no way to build or test it.  So maybe you should handle this?
>>>
>>> I haven't reviewed it, but I think it's the right general direction,
>>> at least.
>>>
>> Bjorn, thanks for your comments!
>>
>> Hi Tony, this series mainly to make pci root bus hotplug happy in IA64.
>> I cannot test the first two patch(SGI related) in my IA64 machine.
>> But the rest patches has been tested in my ia64 machine, and result is ok.
>
> I'd like to understand the dependencies on Bjorn's pci-next tree.  If
> this series
> actually only depends on Linus' v3.10-rc6 I'd rather start from there (because
> then I don't need to coordinate "please-pull" messages when sending things
> to Linus).  If we really do need things from the pci-next tree, well that's OK
> too, but I'd still like to know what they are.

I don't think it depends on anything in my pci-next tree.  I just
applied Yijing's v5 series to v3.10-rc1 with no issues.

Bjorn
