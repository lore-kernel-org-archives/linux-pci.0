Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:58878 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750979AbcKPAxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2016 19:53:11 -0500
Subject: Re: [RESEND PATCH 2/2] PCI: rockchip: Add quirk to disable RC's ASPM
 L0s
To: Rob Herring <robh@kernel.org>
References: <1479096666-112668-1-git-send-email-shawn.lin@rock-chips.com>
 <1479096666-112668-2-git-send-email-shawn.lin@rock-chips.com>
 <20161115222649.uymslcg2fyfwtxpd@rob-hp-laptop>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        devicetree@vger.kernel.org
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <f9cd9cab-9d73-7749-a76e-90dd276b3b83@rock-chips.com>
Date: Wed, 16 Nov 2016 08:52:58 +0800
MIME-Version: 1.0
In-Reply-To: <20161115222649.uymslcg2fyfwtxpd@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On 2016/11/16 6:26, Rob Herring wrote:
> On Mon, Nov 14, 2016 at 12:11:06PM +0800, Shawn Lin wrote:
>> Rockchip's RC outputs 100MHz reference clock but there are
>> two methods for PHY to generate it.
>>
>> (1)One of them is to use system PLL to generate 100MHz clock and
>> the PHY will relock it and filter signal noise then outputs the
>> reference clock.
>>
>> (2)Another way is to share Soc's 24MHZ crystal oscillator with
>> PHY and force PHY's DLL to generate 100MHz internally.
>>
>> When using case(2), the exit from L0s doesn't work fine occasionally
>> due to the broken design of RC receiver's logical circuit. So even if
>> we use extended-synch, it still fails for PHY to relock the bits from
>> FTS sometimes. This will hang the system.
>>
>> Maybe we could argue that why not use case(1) to avoid it? The reason
>> is that as we could see the reference clock is derived from system PLL
>> and the path from it to PHY isn't so clean which means there are some
>> noise introduced by power-domain and other buses can't be filterd out
>> by PHY and we could see noise from the frequency spectrum by oscilloscope.
>> This makes the TX compatibility test a little difficult to pass the spec.
>> So case(1) and case(2) are both used indeed now. If using case(2), we
>> should disable RC's L0s support, and that is why we need this property to
>> indicate this quirk.
>
> Doesn't the driver know which case it is using? I don't see why you need
> the quirk property.

Unfortunately it doesn't. This is one of the pre-input clock for PHY but
doesn't get any indication from the register of both PHY and controller.
So assigning a quirk seems quite straightforward.

>>
>> Also after checking quirk.c, I noticed there is already a quirk for
>> disabling L0s unconditionally, quirk_disable_aspm_l0s. But obviously we
>> shouldn't do that as mentioned above that case(1) could still works fine
>> with L0s.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

