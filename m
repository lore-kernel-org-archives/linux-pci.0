Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36133 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbbLRJ5c (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2015 04:57:32 -0500
Received: by mail-wm0-f50.google.com with SMTP id p187so56247419wmp.1
        for <linux-pci@vger.kernel.org>; Fri, 18 Dec 2015 01:57:31 -0800 (PST)
Subject: Re: [PATCH v4 5/5] ARM: dts: ifc6410: enable pcie dt node for this
 board
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
 <1449149725-27607-6-git-send-email-stanimir.varbanov@linaro.org>
 <20151217215553.GA4000@usrtlx11787.corpusers.net>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
From: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <5673D885.30803@linaro.org>
Date: Fri, 18 Dec 2015 11:57:25 +0200
MIME-Version: 1.0
In-Reply-To: <20151217215553.GA4000@usrtlx11787.corpusers.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/17/2015 11:55 PM, Bjorn Andersson wrote:
> On Thu 03 Dec 05:35 PST 2015, Stanimir Varbanov wrote:
> 
>> Enable pcie dt node and fill pcie dt node with regulator, pinctrl
>> and reset gpio, to use the pcie on the ifc6410 board.
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |   26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> index 11ac608b6d50..f203b94ee460 100644
>> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
>> @@ -47,6 +47,18 @@
>>  					bias-disable;
>>  				};
>>  			};
>> +
>> +			pcie_pins: pcie_pinmux {
>> +				mux {
>> +					pins = "gpio27";
>> +					function = "gpio";
>> +				};
>> +				conf {
>> +					pins = "gpio27";
>> +					drive-strength = <12>;
>> +					bias-disable;
>> +				};
>> +			};
>>  		};
>>  
>>  		rpm@108000 {
>> @@ -123,6 +135,10 @@
>>  				pm8921_lvs1: lvs1 {
>>  					bias-pull-down;
>>  				};
>> +
>> +				pm8921_lvs6: lvs6 {
>> +					bias-pull-down;
>> +				};
> 
> Please don't duplicate the labels in the dts files.

Sorry, I based those dts patches before [1] has been applied in -next. I
will rebase this patch on top of [1]. Thanks!

[1] "ARM: dts: qcom: apq8064: Declare all pm8921 regulators"

-- 
regards,
Stan
