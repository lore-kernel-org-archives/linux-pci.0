Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:39257 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbdGSHyh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 03:54:37 -0400
Cc: shawn.lin@rock-chips.com, Rob Herring <robh@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [RFC PATCH v4 3/7] phy: rockcip-pcie: reconstruct driver to
 support per-lane PHYs
To: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1500448979-93067-1-git-send-email-shawn.lin@rock-chips.com>
 <1500448979-93067-4-git-send-email-shawn.lin@rock-chips.com>
 <e1afec0e-ba1b-4721-4ddb-c6ef3b85e65f@ti.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <3e4f8aeb-d4ea-5a80-54a9-43cc6b3488c2@rock-chips.com>
Date: Wed, 19 Jul 2017 15:54:29 +0800
MIME-Version: 1.0
In-Reply-To: <e1afec0e-ba1b-4721-4ddb-c6ef3b85e65f@ti.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 2017/7/19 15:50, Kishon Vijay Abraham I wrote:
> 
> 
> On Wednesday 19 July 2017 12:52 PM, Shawn Lin wrote:
>> This patch reconstructs the whole driver to support per-lane
>> PHYs. Note that we could also support the legacy PHY if you
>> don't provide argument to our of_xlate.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> Reviewed-by: Brian Norris <briannorris@chromium.org>
>> Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> This design looks good! I'll queue this once I start queuing 4.14.
> 

Great!  Thanks. :)

> Thanks
> Kishon
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 
> 
