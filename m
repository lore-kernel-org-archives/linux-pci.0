Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v9 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1470297128-6213-1-git-send-email-shawn.lin@rock-chips.com>
 <20160818210237.GP27353@localhost>
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <57003143-d52e-154f-458a-5a3aacbf2684@rock-chips.com>
Date: Fri, 19 Aug 2016 09:15:14 +0800
MIME-Version: 1.0
In-Reply-To: <20160818210237.GP27353@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

在 2016/8/19 5:02, Bjorn Helgaas 写道:
> On Thu, Aug 04, 2016 at 03:52:07PM +0800, Shawn Lin wrote:
>> This patch adds a binding that describes the Rockchip PCIe controller
>> found on Rockchip SoCs PCIe interface.
>> ...
>
>> +- msi-map: Maps a Requester ID to an MSI controller and associated.
>
> And associated *what*?

Ah, will fix it. :)

>
>> +- vpcie3v3-supply: The phandle to the 3.3v regulator to use for pcie.
>> +- vpcie1v8-supply: The phandle to the 1.8v regulator to use for pcie.
>> +- vpcie0v9-supply: The phandle to the 0.9v regulator to use for pcie.
>
> s/pcie/PCIe/ (also elsewhere in this patch)

sure, I will use PCIe for the descriptions in this patch.

>
>
>


-- 
Best Regards
Shawn Lin
