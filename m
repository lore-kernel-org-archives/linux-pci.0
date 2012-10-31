Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:59331 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422661Ab2JaLYw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 07:24:52 -0400
Message-ID: <50910A76.9030308@st.com>
Date: Wed, 31 Oct 2012 16:54:38 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Cc: Shiraz HASHIM <shiraz.hashim@st.com>,
	"viresh.linux@gmail.com" <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH 09/15] SPEAr13xx: dts: Fix PCIe core address ranges
References: <cover.1351492562.git.pratyush.anand@st.com> <6ed9683e3149a640b4333cf3039ae31063b23e3b.1351492562.git.pratyush.anand@st.com> <201210302155.05206.arnd@arndb.de>
In-Reply-To: <201210302155.05206.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-15"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/31/2012 3:25 AM, Arnd Bergmann wrote:
> On Monday 29 October 2012, Pratyush Anand wrote:
>> sible by
>> AHB and used to communicate with PCIe devices connected with the host
>> controller.
>>
>> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> ---
>>   arch/arm/boot/dts/spear13xx.dtsi |    9 +++++----
>>   1 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
>> index 9ff4f5f..b7990754 100644
>> --- a/arch/arm/boot/dts/spear13xx.dtsi
>> +++ b/arch/arm/boot/dts/spear13xx.dtsi
>> @@ -76,7 +76,8 @@
>>                  #size-cells = <1>;
>>                  compatible = "simple-bus";
>>                  ranges = <0x50000000 0x50000000 0x10000000
>> -                         0xb0000000 0xb0000000 0x10000000
>> +                         0x80000000 0x80000000 0x20000000
>> +                         0xb0000000 0xb0000000 0x20000000
>>                            0xd0000000 0xd0000000 0x02000000
>>                            0xd8000000 0xd8000000 0x01000000
>>                            0xe0000000 0xe0000000 0x10000000>;
>> @@ -194,7 +195,7 @@
>>                  pcie0@b1000000 {
>>                          compatible = "st,pcie-gadget", "st,pcie-host" ;
>>                          reg = < 0xb1000000 0x4000
>> -                               0x80000000 0x2000
>> +                               0x80000000 0x10000000
>>                                  0xeb800000 0x1000 >;
>>                          interrupts = <0 68 0x4>;
>>                          status = "disabled";
>
> The code that I'm looking at in the upstream kernel looks very different, so I don't
> see how this patch would apply. Also, the version that you are patching as well
> as the changes you do don't actually follow the generic PCI bindings at all
> and should be done quite differently.
>

Yes, this was my mistake. I rebased with ST repo. Will send V2 with 
correct rebase.


> Please have a look at how to configure the PCI ranges in the IEEE1275 PCI
> bindings and in examples you find in arch/powerpc/.
>

Will look into.

> Most importantly, the compatible string used here can't really refer to both
> the host and the endpoint mode, you really need separate bindings for those
> and have only one of the two used in a particular system. What you can do is
> to put both into the dtsi file and mark them as "disabled" and then enable
> just one of the two on a given board file.

Yes, we had though of this limitation and had decided to do exactly the 
same way you have suggested.

thanks for your review comments.
Regards
Pratyush

>
> 	Arnd
> .
>


