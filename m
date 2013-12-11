Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:37475 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155Ab3LKLPO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 06:15:14 -0500
Message-ID: <52A84921.4010807@st.com>
Date: Wed, 11 Dec 2013 16:44:41 +0530
From: Rajeev kumar <rajeev-dlh.kumar@st.com>
MIME-Version: 1.0
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 01/12] SPEAr13xx: Correct dt field name for stmmac phy-addr
References: <cover.1386752447.git.mohit.kumar@st.com> <1078549fa412fb34ab2c95a6232096570abee12d.1386752447.git.mohit.kumar@st.com> <52A847D1.5000409@st.com>
In-Reply-To: <52A847D1.5000409@st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Recheck the subject line, you are not doing any correction.

On 12/11/2013 4:39 PM, Rajeev KUMAR wrote:
> On 12/11/2013 3:08 PM, Mohit KUMAR wrote:
>> DT field name for the phy address changed since kernel 3.10. Set the
>> snps,phy-addr to 0xffffffff so that the driver probes for the phy.
>>
>> Signed-off-by: Mohit Kumar<mohit.kumar@st.com>
>> Cc: Pratyush Anand<pratyush.anand@st.com>
>> Cc: Viresh Kumar<viresh.linux@gmail.com>
>> Cc: spear-devel@list.st.com
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: devicetree@vger.kernel.org
>> ---
>>    arch/arm/boot/dts/spear13xx.dtsi |    1 +
>>    1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
>> index 4382547..3518803 100644
>> --- a/arch/arm/boot/dts/spear13xx.dtsi
>> +++ b/arch/arm/boot/dts/spear13xx.dtsi
>> @@ -155,6 +155,7 @@
>>
>>    		gmac0: eth@e2000000 {
>>    			compatible = "st,spear600-gmac";
>> +			snps,phy-addr =<0xffffffff>;
>
> Don't you think it should be st,phy-addr =<0xffffffff>, as the
> manufacturer is 'st' as the compatible suggest
>
> ~Rajeev
>
>
>>    			reg =<0xe2000000 0x8000>;
>>    			interrupts =<0 33 0x4
>>    				      0 34 0x4>;
>

