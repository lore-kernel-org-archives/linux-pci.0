Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9441A508
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476568; cv=none; b=qFSgWMRyyIf0vVnsEjpFkXwWyhTRklMAJzzkKUE3E9qMehC4KmQ3lKn3wb61hPgg0tYOXafCA3yIylPylHTQFgKJ4ICTrMCDnU9mL9JkKK81lsMrnjhILrL3vR7kumg8HoEa0tr95cDuJ93gQ9E+qU3P9ke6sj9AD591YXT9VYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476568; c=relaxed/simple;
	bh=cG70onBw4K1F8vOWkzaGZgUFF3MV3PGnMgKqrTQh6MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUom7OBDUziKXh4M3zmanJH3ptdelv62xtEnUUFG0OG8MAljh2Sesg8B7CK8URRR5YMzEBa8lcw+eX5DUVv+1ZhpoC+9TOqzfmKwV2OZnLrZtor6xqQcP+2fQ8HTrGvAviEmk0MuCAg1ImbI0BPIPptLISl79dTEY85cHdQS2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=K9l9qLzu; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="K9l9qLzu"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb3so12923385a.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789476565; x=1790081365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=azse08cG3HNfDP41RvTE/erEtfq8oj7Wmpy5TufdhRg=;
        b=K9l9qLzurpThwn24CYpynOpb2iyr0z+jwuGZYN6Wqv+Hs3PPH/JKFx6srx1eFK7Iql
         Cis9Dw0b5btrmO7NMeCunV7er6EDxPuLzHZac6aNyoEis3R6gP+2DC3iFXiapVVkwWAu
         VSVBWxJlmXtb39drMCgyESs4qRLYWurfOJvMvidcgFyS7x+4wZF9RY5hm8PrdpbaFggJ
         JcqBxPRyj+lp+BdshJ89lwsVVpARPKve0JiTKc7cYV7wgdXf2kLfwkAS9sfg5LjvHiD7
         029fxBFRfiI/AVF6I17A289+OPjbl/9nZCjg9BXRD88I23XaGQhj/FZJDvoQJllIG7WW
         Jjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476565; x=1790081365;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=azse08cG3HNfDP41RvTE/erEtfq8oj7Wmpy5TufdhRg=;
        b=SGPaHzegEZpFb1QTDmZYPiR1F3SzPiguu9ABCKxfYejXU8PDGjaFsa5wCBdbEtGliT
         8UB7dS+H2pND/+am0c+b3ieR3dT20JxcM4mCxSgf1DHzOjBf+3MSlOgtzgWUNl6M9fSt
         KRU136aALJJOGPfdmWlOg+G7MYI0GLYCBeGSufEBMOzqGabWJPbFh7pPJsjsE4tyWhtS
         DenBF5vzlHr9T1RQZ2l7Y7nFmBhc1L3aOquTzgU57kVWrGDD6VcbToOOlr/huWxicGiD
         yu2I4Eiasagu0fY19AyXQXWgLFt3asMCksIm4QWBsROHJh/kZ0OoJWXJr40uLHn0tX3a
         g2yQ==
X-Forwarded-Encrypted: i=1; AKwUvByRuI09REftOWuEDbskeIBwYLSQqIAC23+P4fQVZ8FjCZ3kkcZc9BhrBVu8f50wylXJ1SJbG70pVfQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ld5sEtedvNmYgsG3mGQFwdvwEfL9wMgwwQoRps1XTiaGO/XKES
	eO9l2LRBgT4NbIO8A0SMb/YjeC03bZVUG+PEcbMCskBISJ40lmyfBzyOZY2wuxTgiFsAPJF+jqv
	v4utjbYI=
X-Gm-Gg: AYBFou2t5ZMGxWdi8dtnhimbYHOo1kEt5BHgeeSYPx3JkJ7HUg1GPwxDYy7YTlJL2wX
	SM+GGobrff/7sM/Hl5VmI23bnr/7zikJQhKe1GjGBWyW9In9a4kKKJ7OStYxwDy/eL6apjdkBkY
	DizgZTdjgWn0nxKOgXi16hlY1SZiZZUU5yloHv7X/F5i5Zm8ocnE96u0frRyaDV7uCocz3edE2r
	iTut60s/E98PL64x2efa+TlWHes+q0d8DKlbo/2mJLLAr1Dvs+qRnUO0IsFDFz+XWNTehUv28xL
	mwbEqSGI9ievnfqvSeu901RazPhFDc8FIamHpybTznc3kIdI13jbTUJwcDMha3g4lYqJ5FXmkb8
	cCcU+JL8aF0HKLAQdK0XdjcvExu7kvkIycqaetsNA7Lv9i9JR8B3WaaFKhHI4t/ARdWUVlF32vl
	IGZh8PdnFg489Ufx4LPSbilMR8P1aP+L4aPsruZmSL4yTt/7a/ucuZJMMXtzjezvKvcV86d+0=
X-Received: by 2002:a05:620a:1a1c:b0:939:93a1:1383 with SMTP id af79cd13be357-93a408176f8mr108459585a.32.1789476564973;
        Tue, 15 Sep 2026 05:49:24 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a382ab7b3sm169560185a.19.2026.09.15.05.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 05:49:24 -0700 (PDT)
Message-ID: <ed783639-05ed-4ad9-b881-d1689a8b2418@riscstar.com>
Date: Tue, 15 Sep 2026 07:49:24 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcs6490-rb3gen2: add endpoint
 buses
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260915031038.1087264-1-elder@riscstar.com>
 <20260915031038.1087264-4-elder@riscstar.com>
 <20260915032023.6D7C81F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260915032023.6D7C81F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 10:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] dts: pci: static ranges will not be updated dynamically due to existing DT node
> - [Low] dts: pci-ep-bus node has unit address but no reg property
> --
> 
> commit 1c7c7d7922bcd554a385a9dab10bfbe2a5cf71bb
> Author: Alex Elder <elder@riscstar.com>
> 
> arm64: dts: qcom: qcs6490-rb3gen2: add endpoint buses
> 
> This commit adds endpoint buses for a PCIe switch connected via the second
> PCI segment (0001) on the RB3gen2 platform. It defines devicetree nodes
> representing these buses, including the mapping of each BAR's address
> range to its local address space.
> 
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 3bb5fca8e2b13..59fbb0444d9b7 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> [ ... ]
>> @@ -955,11 +955,41 @@ pcie@3,0 {
>>   			bus-range = <0x5 0xff>;
>>   
>>   			dev@0,0 {
>> +				compatible = "pci1179,0220";
>>   				reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				/* Ranges will be updated dynamically */
>> +				ranges = <0x0 0x0 0x0  0x83050000 0x0 0x0 0x0 0x4000>,
>> +					 <0x2 0x0 0x0  0x83050000 0x0 0x0 0x0 0x80000>,
>> +					 <0x4 0x0 0x0  0x83050000 0x0 0x0 0x0 0x200000>;

Looking at this now, I also realize I neglected to incorporate
another change before sending this...  It is erroneous to
specify the same parent address for all three of the ranges
as is done here.  These ranges are only representative
(because they *will* be dynamically updated), but the second
and third parent address entries will be 0x83050000 0x4000
and 0x83050000 0x84000, respectively.

I will update this when I post version 3 of this series.

> 
> [Severity: High]
> Will these placeholder ranges actually be updated dynamically at runtime?
> Because the dev@0,0 node is statically defined in the devicetree, it appears
> the PCI core's of_pci_make_dev_node() will find it during quirk processing
> (via pci_device_to_OF_node()) and return early.

This is a correct statement based on the current state of 
of_pci_make_dev_node().  Things change when another series
(which is a prerequisite for the present one) is in place:
   https://lore.kernel.org/lkml/20260910021919.3421449-1-elder@riscstar.com/

That series changes of_pci_make_dev_node() so that the
ranges property in the already-existing devicetree node
gets updated dynamically, taking into account the addresses
assigned to the BARs during PCI enumeration.

So although this is a good observation, it does not take
into account the other series that must be in place before
this one is accepted.

> If that happens, of_pci_add_properties() won't be called, leaving these
> overlapping dummy physical addresses in place and potentially breaking MMIO
> translation for child devices.
> 
>> +
>> +				pci-ep-bus@4 {
> 
> [Severity: Low]
> Does this node name trigger a dtc compiler warning? Defining a unit address
> (@4) without a corresponding reg property violates the Devicetree
> specification and will cause a unit_address_vs_reg warning.

I don't believe this caused a warning (though I've had problems
when checking bindings and DTBs in the past...).

There are two other examples of DTS files that use pci-ep-bus
(with a unit address, ans specified by the binding), but they
do not add a "reg" property.
   Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
   drivers/misc/lan966x_pci.dtso
   arch/arm64/boot/dts/broadcom/rp1-common.dtsi

This suggestion makes sense, but I'd like to hear it from one
of the very human DT maintainers.

					-Alex

> 
>> +					compatible = "simple-bus";
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					/* Map 0x0-0x1fffff to BAR 4 */
>> +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
>> +				};
>>   			};
>>   
>>   			dev@0,1 {
>> +				compatible = "pci1179,0220";
>>   				reg = <0x50100 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				/* Ranges will be updated dynamically */
>> +				ranges = <0x0 0x0 0x0  0x83050100 0x0 0x0 0x0 0x4000>,
>> +					 <0x2 0x0 0x0  0x83050100 0x0 0x0 0x0 0x80000>,
>> +					 <0x4 0x0 0x0  0x83050100 0x0 0x0 0x0 0x200000>;
> 
> [Severity: High]
> Similarly for dev@0,1, will this static definition prevent dynamic ranges
> updates? If of_pci_add_properties() is skipped due to the node already
> existing, the dummy physical addresses will remain and could cause register
> corruption or crashes if child drivers probe here.
> 
>> +
>> +				pci-ep-bus@4 {
> 
> [Severity: Low]
> This node is also named with @4 but does not define a reg property, which
> can trigger a dtc unit_address_vs_reg warning.
> 
>> +					compatible = "simple-bus";
>> +					#address-cells = <1>;
>> +					#size-cells = <1>;
>> +					/* Map 0x0-0x1fffff to BAR 4 */
>> +					ranges = <0x0  0x4 0x0 0x0  0x200000>;
>> +				};
>>   			};
>>   		};
>>   	};
> 

