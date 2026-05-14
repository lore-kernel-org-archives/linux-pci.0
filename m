Received: from outbound.st.icloud.com (p-east2-cluster3-host5-snip4-10.eps.apple.com [57.103.77.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987563DDDCA
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 13:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778765918; cv=none; b=MAWgwKREWUwMAc3G+oYIMwiSix5CCFrAaOIr+V6ef0aN+twWUtnAhw/Nnrru3l8S0KD19OFgCpg2cxkTPziiV2lxdtZLU5D++x9KTSOCssUxxr/hi4/RabXVN2SfgqaUqCx5iXHh9DCwjkcSL6qGMDKYAblR1+IPGpoU8+eHwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778765918; c=relaxed/simple;
	bh=O/doFj7csfg18ZBGJFGri6BLgKvth+2y3yd7NviIpHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nw76Ty+xpVroxtr9EUXrL6ZTYMuQeGUG/9odLnqpe7sCTn6HYA/jmUpvjVoemm/fG0EFYMPGfUiFDgKfXQTMCL5QxfhzqdxnytMFyDBCx46rmVG3pT/rRVHhc/gYlqFIHd/TjLYxxUe/RaJgjBebU9/R2YekvWZcaAuVhlmIFJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gSPdbxXz; arc=none smtp.client-ip=57.103.77.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gSPdbxXz"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-5 (Postfix) with ESMTPS id 677141800106;
	Thu, 14 May 2026 13:38:33 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJC0MCWBxCCUAdXA9cEhVdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWFUJCgNHAksBXgxZWQBBCzhaDlsERxQXG1wAFxlRTQxYWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQRUAFYHlZeWhdeTVoCVk0FSVVfDl1WQgBVAAkDWB9EXRwAQFVcB0EUQFJdD1IAEg1IClhWK1sTVRdGCRkIXR0HWEcURw4PGVoUXBhT
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778765915; x=1781357915; bh=pJ03J3gv+pPu0pE4n76DoaNuYNMVHpq20sg52l+h1M4=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=gSPdbxXzjQ6B2AOwax0njk04KDn94DiL8+e3FSkFIAuBGTDFv9CGKA5fN7nVYJ5ievXt/CeYCxpkynZvyR/CZu0DVwhXcmoCkTACx1WN60vw2u7fIKgqC9cfFYTgNrq91m7tOK1WzPEkAWGh9zWwirzNuMQNj2aJqKbLyclj3/ehQuRauN9Lz1KtWpUd+qHZintbyNnTDSMULQyFsIUM8mm+mxKuRsuad4zLjsH8uW5WBjbDoj9kRRPLRMwU9ezKRcc5WhkXhpaaGlIqJUPWdKgt3zaQaL3VLlP/PsmikqqbHcJy4lPXOmVU9y9US7Qo7QvI/eLIhoK1RhV0bu4SFA==
Received: from [192.168.89.3] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-5 (Postfix) with ESMTPSA id 426FB1801205;
	Thu, 14 May 2026 13:38:31 +0000 (UTC)
Message-ID: <1f296d29-3d43-4dd3-b751-8a0892b4095a@icloud.com>
Date: Thu, 14 May 2026 22:38:28 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
To: Guenter Roeck <linux@roeck-us.net>, sashiko-reviews@lists.linux.dev,
 Jihong Min <hurryman2212@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260512213910.871859-2-hurryman2212@gmail.com>
 <20260514004055.1BBCAC19425@smtp.kernel.org>
 <110e9a0d-bc91-4959-8a7b-1a055d0b49f7@roeck-us.net>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <110e9a0d-bc91-4959-8a7b-1a055d0b49f7@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEzNyBTYWx0ZWRfX+4t04ZTY0sCP
 HBpPPU+0/DF6XjAP5v8muFLKJ80mHqlY+mH5TrQUIxgr+57rgpphH12Dan/NSVU3++KafIqwhqk
 EWHhbzn2halTk/q5FlFuO5QMlOtDjAn5cP6ACOGf0niInHpLJYvVVMVKYXDC1qmd/hI0ChhaH+Q
 ozExATlW8/whNaxDDtBIuyPowXPsSTWZGM0TF6NmvZ2vW+7xf6KgiTmtfd5DDoXGEB7tIjJJzqf
 LbrQqkM1t8ElkjvY4vKxLSSCDefeuBfEea2kSxVkjSmT14z7coyL2wdf+zxyiFd17IIgRStjEw6
 lAPHDXRNyqerU9ZElhaDvgxI9bBBE+K52vSL7uE6QNrgEEHcGMCODry1BdAcEA=
X-Proofpoint-GUID: v-KqTNKEOFx4hDELZLGLOy1NjWYxPSoB
X-Authority-Info-Out: v=2.4 cv=d5f4CBjE c=1 sm=1 tr=0 ts=6a05d05a
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=s_VNyIFniyjZU9L2bDwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PgRulw5oR9JgysbTFEid:22 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-ORIG-GUID: v-KqTNKEOFx4hDELZLGLOy1NjWYxPSoB


On 5/14/26 10:20, Guenter Roeck wrote:
> On 5/13/26 17:40, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential 
>> issue(s) to consider:
>> - [High] The Kconfig dependency `depends on USB_XHCI_PCI=y` 
>> completely disables PROM21 support for systems where the core driver 
>> is built as a module.
>> - [Low] Signed integer overflow when calculating the auxiliary device 
>> ID.
>> -- 
>>
>> commit 20f4e35b2f88ebe2b8988b4f07fe7cc28199096b
>> Author: Jihong Min <hurryman2212@gmail.com>
>> Subject: usb: xhci-pci: add AMD Promontory 21 PCI glue
>>
>> This commit adds a small PCI glue driver for AMD Promontory 21 xHCI
>> controllers. It binds the controllers, delegates USB host operation to
>> the common xHCI PCI core, and creates an auxiliary device for optional
>> temperature sensor support.
>>
>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>> --- a/drivers/usb/host/Kconfig
>>> +++ b/drivers/usb/host/Kconfig
>>
>> [ ... ]
>>
>>> @@ -42,6 +42,26 @@ config USB_XHCI_PCI
>>>       depends on USB_PCI
>>>       default y
>>>   +config USB_XHCI_PCI_PROM21
>>> +    bool "AMD Promontory 21 xHCI PCI support"
>>> +    depends on X86
>>> +    depends on USB_XHCI_PCI=y
>>
>> Does depending strictly on USB_XHCI_PCI=y cause a configuration 
>> regression
>> for most distributions where the core driver is configured as a module?
>>
>> The driver source appears fully capable of being built as a module, 
>> using
>> module-related macros and module_pci_driver().
>>
>> If the intent is to prevent an early boot mismatch where xhci-pci is
>> built-in but the PROM21 glue is a module, could this instead be a 
>> tristate
>> option using depends on USB_XHCI_PCI and depends on !(USB_XHCI_PCI=y 
>> && m)?
>> This would enforce the boot constraint while preserving support for 
>> modular
>> kernel builds.
>>
>
> That makes sense to me. That would be stronger than using default (which
> was my idea of dealing with the problem). Restricting the code to 
> USB_XHCI_PCI=y
> seems to be a bit extreme.

Hi Guenter,

I looked more closely at the Kconfig part of the Sashiko suggestion.

The concern itself is valid: the v5 dependency on USB_XHCI_PCI=y is too
strict because it prevents the PROM21 PCI glue from being built when
USB_XHCI_PCI=m.

However, I do not think the suggested expression works as intended:

   depends on !(USB_XHCI_PCI=y && m)

With Kconfig tristate logic, `m` is a tristate literal, not "this symbol is
being built as a module". If USB_XHCI_PCI=y, then:

   USB_XHCI_PCI=y && m  => m
   !(USB_XHCI_PCI=y && m) => m

So the dependency becomes `m`, which limits USB_XHCI_PCI_PROM21 to `m` 
instead
of allowing `y`. That is the opposite of what we need for the built-in
xhci-pci case.

The combinations I think we want are:

   USB_XHCI_PCI=y  -> USB_XHCI_PCI_PROM21=y or n, but not m
   USB_XHCI_PCI=m  -> USB_XHCI_PCI_PROM21=m or n
   USB_XHCI_PCI=n  -> USB_XHCI_PCI_PROM21=n

I see a few possible ways to handle this:

1. Keep USB_XHCI_PCI_PROM21 as a visible tristate:

      config USB_XHCI_PCI_PROM21
        tristate "AMD Promontory 21 xHCI PCI support"
        depends on X86
        depends on USB_XHCI_PCI
        default USB_XHCI_PCI
        select AUXILIARY_BUS

    This supports USB_XHCI_PCI=m, but it still lets a user select the unsafe
    USB_XHCI_PCI=y / USB_XHCI_PCI_PROM21=m combination.

2. Keep it visible and rely on help text to warn users not to select `m` 
when
    USB_XHCI_PCI=y.

    This is simple, but it does not actually prevent the bad combination.

3. Use IS_REACHABLE() in xhci-pci.c instead of IS_ENABLED().

    That would prevent built-in xhci-pci from rejecting PROM21 devices 
when the
    PROM21 glue is only available as a module. However, it also means the
    PROM21 glue/hwmon path would not be used in that configuration 
unless the
    PCI device is rebound later, so I do not think it is ideal.

4. Make USB_XHCI_PCI_PROM21 a hidden tristate that follows USB_XHCI_PCI:

      config USB_XHCI_PCI_PROM21
        tristate
        depends on X86
        depends on USB_XHCI_PCI
        default USB_XHCI_PCI
        select AUXILIARY_BUS

    Then the value follows the common xhci-pci driver:

      USB_XHCI_PCI=y  -> USB_XHCI_PCI_PROM21=y
      USB_XHCI_PCI=m  -> USB_XHCI_PCI_PROM21=m
      USB_XHCI_PCI=n  -> USB_XHCI_PCI_PROM21=n

    This prevents the unsafe y/m split while still supporting modular
    USB_XHCI_PCI builds. The actual user-visible sensor option remains
    SENSORS_PROM21_XHCI.

My current preference is option 4, because the PROM21 PCI glue is not 
really a
user-facing feature by itself. It exists so the common xhci-pci driver 
can hand
PROM21 devices to the PROM21-specific glue and so the optional hwmon 
driver can
bind through the auxiliary device. The user-visible part remains the hwmon
sensor driver.

Does that sound reasonable to you, or would you prefer one of the other
approaches?

Thanks,
Jihong

