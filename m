Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f169.google.com ([209.85.128.169]:34211 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3LLEH0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 23:07:26 -0500
MIME-Version: 1.0
In-Reply-To: <52A934A2.8020101@st.com>
References: <cover.1386752447.git.mohit.kumar@st.com> <1078549fa412fb34ab2c95a6232096570abee12d.1386752447.git.mohit.kumar@st.com>
 <52A847D1.5000409@st.com> <001b01cef6d2$9104f7b0$b30ee710$%han@samsung.com> <52A934A2.8020101@st.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 12 Dec 2013 12:07:05 +0800
Message-ID: <CAGb2v67tK7W12Ljb-j+KJhGQkZ_k_p0WK+kcYiRqOuQujJL1HA@mail.gmail.com>
Subject: Re: [PATCH 01/12] SPEAr13xx: Correct dt field name for stmmac phy-addr
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: Jingoo Han <jg1.han@samsung.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	spear-devel <spear-devel@list.st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thu, Dec 12, 2013 at 11:59 AM, Rajeev kumar <rajeev-dlh.kumar@st.com> wrote:
> On 12/12/2013 6:09 AM, Jingoo Han wrote:
>>
>> On Wednesday, December 11, 2013 8:09 PM, Rajeev kumar wrote:
>>>
>>> On 12/11/2013 3:08 PM, Mohit KUMAR wrote:
>>>>
>>>> DT field name for the phy address changed since kernel 3.10. Set the
>>>> snps,phy-addr to 0xffffffff so that the driver probes for the phy.
>>>>
>>>> Signed-off-by: Mohit Kumar<mohit.kumar@st.com>
>>>> Cc: Pratyush Anand<pratyush.anand@st.com>
>>>> Cc: Viresh Kumar<viresh.linux@gmail.com>
>>>> Cc: spear-devel@list.st.com
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: devicetree@vger.kernel.org
>>>> ---
>>>>    arch/arm/boot/dts/spear13xx.dtsi |    1 +
>>>>    1 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/spear13xx.dtsi
>>>> b/arch/arm/boot/dts/spear13xx.dtsi
>>>> index 4382547..3518803 100644
>>>> --- a/arch/arm/boot/dts/spear13xx.dtsi
>>>> +++ b/arch/arm/boot/dts/spear13xx.dtsi
>>>> @@ -155,6 +155,7 @@
>>>>
>>>>                 gmac0: eth@e2000000 {
>>>>                         compatible = "st,spear600-gmac";
>>>> +                       snps,phy-addr =<0xffffffff>;
>>>
>>>
>>> Don't you think it should be st,phy-addr =<0xffffffff>, as the
>>> manufacturer is 'st' as the compatible suggest
>>
>>
>> Hi Rajeev Kumar,
>>
>> According to the Documentation, it guides to use 'snps' prefix.
>>
>> In my humble opinion,
>> 'gmac' is a Synopsys based IP. Thus, if 'snps,phy-addr' is
>> not ST specific, 'snps' prefix can be used.
>>
>
>
> Very much true, I raise the point just becuase compatible =
> "st,spear600-gmac". Check the manufacturer name here.

As documented, "st,spear600-gmac" is there for backwards
compatibility. It should really be updated to
'"snps,dwmac-<version>", "snps,dwmac"'.




>> ./Documentation/devicetree/bindings/net/stmmac.txt
>> - snps,phy-addr         phy address to connect to.

About the "snps,phy-addr" property, Florian recently raised
the issue that this is !standard. I am currently implementing
proper DT ethernet phy node support for stmmac. Just a
heads up. :)


ChenYu
