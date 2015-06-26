Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59401 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbbFZJAx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 26 Jun 2015 05:00:53 -0400
Message-ID: <558D14C0.6030001@arm.com>
Date: Fri, 26 Jun 2015 10:00:48 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla@caviumnetworks.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sunil Goutham <sgoutham@cavium.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Tirumalesh Chalamarla <tchalamarla@cavium.com>,
	Robert Richter <rrichter@cavium.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/6] GICv3: Add ITS entry to THUNDER dts
References: <1411573068-12952-1-git-send-email-rric@kernel.org> <1411573068-12952-3-git-send-email-rric@kernel.org> <9184A2BB-2852-4B73-B964-881A1491EEA8@caviumnetworks.com>
In-Reply-To: <9184A2BB-2852-4B73-B964-881A1491EEA8@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 26/06/15 00:19, Chalamarla, Tirumalesh wrote:
> Hi Marc,
> 
> Any feed back on this. 
> Do you want me to submit this as a separate patch?so that it is easy for getting acceptance. 

It looks good to me, so you can add my Acked-by on it.

I think you should repost it and get it merged through arm-soc.

Thanks,

	M.

> Thanks,
> Tirumalesh. 
> 
>> On Sep 24, 2014, at 8:37 AM, Robert Richter <rric@kernel.org> wrote:
>>
>> From: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>>
>> The PCIe host controller uses MSIs provided by GICv3 ITS. Enable it on
>> Thunder SoCs by adding an entry to DT.
>>
>> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
>> Signed-off-by: Robert Richter <rrichter@cavium.com>
>> ---
>> arch/arm64/boot/dts/thunder-88xx.dtsi | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/thunder-88xx.dtsi b/arch/arm64/boot/dts/thunder-88xx.dtsi
>> index d8c0bdc51882..9cb7cf94284a 100644
>> --- a/arch/arm64/boot/dts/thunder-88xx.dtsi
>> +++ b/arch/arm64/boot/dts/thunder-88xx.dtsi
>> @@ -376,10 +376,19 @@
>> 		gic0: interrupt-controller@8010,00000000 {
>> 			compatible = "arm,gic-v3";
>> 			#interrupt-cells = <3>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> 			interrupt-controller;
>> 			reg = <0x8010 0x00000000 0x0 0x010000>, /* GICD */
>> 			      <0x8010 0x80000000 0x0 0x600000>; /* GICR */
>> 			interrupts = <1 9 0xf04>;
>> +
>> +			its: gic-its@8010,00020000 {
>> +				compatible = "arm,gic-v3-its";
>> +				msi-controller;
>> +				reg = <0x8010 0x20000 0x0 0x200000>;
>> +			};
>> 		};
>>
>> 		uaa0: serial@87e0,24000000 {
>> -- 
>> 2.1.0
>>
> 


-- 
Jazz is not dead. It just smells funny...
