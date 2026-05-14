Received: from outbound.mr.icloud.com (mr-2001f-snip4-7.eps.apple.com [57.103.68.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABF3FA5F5
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.68.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778768984; cv=none; b=Pe9sXuWbnSCGBQFSk7gtRiBsY5H8ntPQmjE2c53i0XRRQji9FjR9toQnYVeYRMQO+c96y7XECVOVa6I1vpT0hS4iRifzVPBEcEzzfHsY6CIGCsOMTb/rWbxcoN6ZkuzMnpmcMIQ3ImDMoTiHL/rlJ9HjiEeotte7zIJrbjBTT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778768984; c=relaxed/simple;
	bh=apfiA1cyuebfnJCwwK+v2w0GMpzMc1iTPf97Sc3qVZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZxPK5PZJ8iUf+Tu6oYlL2d4BrDoQYOiTEErPnpl3yc9S+F27SpGMtX63O2g3d26a3/SZBYiOL7Lerw2LDU3YG3AKbMpcXG5s9KpOZPBLy3ReplDZ1187ZGRB9eZTLHXYC08uczEdBXmWrSX0Ls6XapVZ19aco+9T2ZVeO4SgccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=j6DBgwRx; arc=none smtp.client-ip=57.103.68.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="j6DBgwRx"
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 646211800136;
	Thu, 14 May 2026 14:29:41 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJC0MCWBxCCUAdXA9cEhVdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWFUJCgNHAksBXgxZWQBBCzhaDlsERxQXG1wAFxlRTQxYWwhbBA8fTAxRAkIFVl5UCh0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQRUAFYHlZeWhdeTVoCVk0FSQJaBA0HEwxVUloDWx9EDU0LQA8OAkgUSlBZBVxTRwlMAV0AK1sTVRdGCRkIXR0HWEcURw4PGVoUXBhT
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778768982; x=1781360982; bh=xdOFhRK+BndMXFoccb5KRWPPSr0SfUNYq4YCKjDeRD0=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=j6DBgwRxhwc6NsD8oQyOTekj7woRqNM6895kDcQ0X3QAetQDeQ4WWFYa/yfqbTZESyfCvPoFXC1PvJJg33VH4md8GTnHJ5DBQ7FtyK4XeF1smkxOXen+5sRamwJx98T1Bh839/f9353tiKLU0KoaEreaxR7MBNjq/9zsH6HyYodLtJungsBs67MTnpadyfagbHdnEm421Dvb29Bp3JDr00vPzFibRY2UNpIRb/PFpshKh+cq4muM8sQ8q8LEMMFLEW41fc3l442a6iLX3qWHY+yFl+O+5LH+BoPcjhdBTNzQ44NyDvxjx2mxxqODImnKRapy1ZLtmVhk98UuWHeKXQ==
Received: from [192.168.89.3] (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id 0540218006C9;
	Thu, 14 May 2026 14:29:39 +0000 (UTC)
Message-ID: <1173f5c5-a740-4458-8e08-2c427a704207@icloud.com>
Date: Thu, 14 May 2026 23:29:36 +0900
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
X-Authority-Info-Out: v=2.4 cv=Uqpu9uwB c=1 sm=1 tr=0 ts=6a05dc55
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=z0MguAZywq-667BnQBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PgRulw5oR9JgysbTFEid:22 a=oa2-kN79Xhin27rcel9q:22
X-Proofpoint-ORIG-GUID: W6ODzCiIRAmxc73BlqpCyQLG1kjttXL_
X-Proofpoint-GUID: W6ODzCiIRAmxc73BlqpCyQLG1kjttXL_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0NiBTYWx0ZWRfX8fsNMcdv6CsL
 VMMxVHn4LO1M7eTXwvVSCiBIKc2yN7xflFOHBg00vKlUCJsfw2KeAlDMu+AtupuLTP6S6vInGY8
 LicgSQpPbMkvnPXETv1CQ4VvLuVAVd/l5EhfCPqSwFeLpqOReNhYfozE+qxLELGXYZCLHXs2eLb
 ABpIE/4yQXEF1a6AaPcg4CRf2WcbzI+Gu5QvZ7fvB+W0T0sFKOWD2Dth/WzJrSimaoC9yu95CC7
 5lMSWRZK0H3e5lvrcsikorJZIsxApi9wM0lpLLJrhmIqQQlZUJnIQaZnaFwAKShFk1RQkd1T09z
 9uM9Ff+oGtNbSzPSHUwww3RomDaFgN+RTuLJoXsQNxYjaT0p/dXrmOm/5W9lGg=


On 5/14/26 10:20, Guenter Roeck wrote:
>>> +    prom21_auxdev->auxdev =
>>> +        auxiliary_device_create(&pdev->dev, KBUILD_MODNAME, "hwmon",
>>> +                    &prom21_auxdev->pdata,
>>> +                    (pci_domain_nr(pdev->bus) << 16) |
>>> +                        pci_dev_id(pdev));
>>
>> Does left-shifting pci_domain_nr() introduce a signed integer overflow
>> regression?
>>
>> The function pci_domain_nr() returns a signed int, which can be up to 
>> 0xFFFF
>> on ACPI systems. Left-shifting a value of 0x8000 or greater by 16 bits
>> alters the sign bit of a 32-bit int, resulting in undefined behavior 
>> in C.
>>
>> Would casting the return value to an unsigned integer, such as
>> (u32)pci_domain_nr(pdev->bus) << 16, avoid this overflow?
>>
> FWIW, I don't think that is a real problem. auxiliary_device_create()
> takes an int as id parameter, so the result would be converted back to 
> int
> anyway. Maybe use "(pci_domain_nr(pdev->bus) & 0x7fff) << 16" instead,
> but I don't know if that adds any practical value.
>
> Thanks,
> Guenter
>
For the auxiliary device id issue, after thinking about it a bit more, I 
think
a simpler approach is to avoid encoding the PCI domain/BDF into the 
auxiliary
id. The auxiliary id only needs to make the auxiliary device name unique;
userspace identification is already tied to the parent PCI function.

So instead of:

   (pci_domain_nr(pdev->bus) << 16) | pci_dev_id(pdev)

I plan to use an IDA-allocated id:

   id = ida_alloc(&prom21_xhci_auxdev_ida, GFP_KERNEL);
   auxiliary_device_create(..., id);
   ida_free(&prom21_xhci_auxdev_ida, id);

This avoids both the signed shift concern and PCI domain 
truncation/masking.
