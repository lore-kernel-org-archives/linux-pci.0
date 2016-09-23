Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:40812 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964977AbcIWBe3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2016 21:34:29 -0400
Subject: Re: [PATCH] PCI: rockchip: Support quirk to disable 5 GT/s (PCIe 2.x)
 link rate
To: Brian Norris <briannorris@chromium.org>
References: <1474565478-27242-1-git-send-email-briannorris@chromium.org>
 <b9527acf-e3cf-19d2-b8fc-0a59637e9598@rock-chips.com>
 <20160923011518.GA97876@google.com>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <2f111fdf-f4a5-2f8a-0121-1a566e6527c8@rock-chips.com>
Date: Fri, 23 Sep 2016 09:34:15 +0800
MIME-Version: 1.0
In-Reply-To: <20160923011518.GA97876@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Brain,

在 2016/9/23 9:15, Brian Norris 写道:
> Hi Shawn,
>
> On Fri, Sep 23, 2016 at 08:27:35AM +0800, Shawn Lin wrote:
>> 在 2016/9/23 1:31, Brian Norris 写道:
>>> rk3399 supports PCIe 2.x link speeds marginally at best, and on some
>>> boards, the link won't train at 5 GT/s at all. Rather than sacrifice 500
>>> ms waiting for training that will never happen, let's support a device
>>> tree quirk flag to disable generation 2 speeds entirely.
>>
>> I was thinking about could we get target link speed [TLS] from the
>> end-point when finishing Gen1 training, but it seems that the location
>> of ep's TLS is not fixed.
>
> Indeed it's not, but we could probably handle that if absolutely needed
> (get a reference to the root port pci_dev somehow, then use the existing
> helpers to walk children and get the computed ->pcie_cap offset). But

Right, we could probably walk through the ep's cap and get this, but
sure, it's not the problem here, and that is maybe what I want to dig
more later.

Thanks for sharing this.

> that's not the problem here; we have 5 GT/s devices, but they are not
> running at 5 GT/s because link training can't pass. We have been told
> there are still SI issues, and so you wouldn't really be able to turn
> this out at runtime anyway.
>
> But sure, I suppose that'd be a way to (for chips/boards that don't have
> SI issues) determine whether or not to attempt gen2 training at all.
> That does sound better than just timing out after 500ms...
>
>> Anyway, your patch looks sane to me as we leave gen2 as default and
>> people could drop that feature by adding rockchip,disable-gen2 to
>> their dts if they are sure the board would never supoort Gen2 devices.
>>
>> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> Thanks.
>
> Brian
>
>
>


-- 
Best Regards
Shawn Lin

