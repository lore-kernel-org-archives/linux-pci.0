Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] ARM: dts: dra7: Add dt node for the sycon pcie
To: Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	tony@atomide.com
References: <1450172346-11890-1-git-send-email-kishon@ti.com>
 <1450172346-11890-2-git-send-email-kishon@ti.com>
 <5670140C.7010906@cogentembedded.com> <5673DE42.9080407@ti.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linux@arm.linux.org.uk, rogerq@ti.com,
	nsekhar@ti.com, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
	t-kristo@ti.com
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5673EEE6.7080706@cogentembedded.com>
Date: Fri, 18 Dec 2015 14:32:54 +0300
MIME-Version: 1.0
In-Reply-To: <5673DE42.9080407@ti.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello.

On 12/18/2015 1:21 PM, Kishon Vijay Abraham I wrote:

>>> Add new device tree node for the control module register space where
>>> PCIe registers are present.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> ---
>>>    arch/arm/boot/dts/dra7.dtsi |    5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>> index fe99231..e38f63f 100644
>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>> @@ -155,6 +155,11 @@
>>>                        compatible = "syscon";
>>>                        reg = <0x1c04 0x0020>;
>>>                    };
>>> +
>>> +                scm_conf_pcie: tisyscon@1c24 {
>>
>>     Please use the generic node names as the ePAPR standard says.
>
> something like  scm_conf_pcie: syscon@1c24??

    Yes, though "system-controller" would be probably more in line with what 
ePAPR has standardized.

> Thanks
> Kishon

MBR, Sergei

