Received: from outbound.st.icloud.com (p-east2-cluster6-host11-snip4-10.eps.apple.com [57.103.76.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6002541322D
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262034; cv=none; b=LKeltXbiKarUgKPIvpu8oWwi48GsYQiOBEbtB3urTKJOxyDzzZmlz7EgZbI56e0bG6qmotZxnp4j6NYpCa9385kVaeBwk3spNVxXu9Pas/sUX7nS7KVKYD9rj6x52NeW57l4i6il6stSPZ+lGV87IJrYLmWMdiuzSYGAYTT+wHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262034; c=relaxed/simple;
	bh=sSo0MgVGHg6sujfoidXV1jooMx78c4nS2ln4QJ43EFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUCmyuPnsZwjcUC3S8c6vTogMgQbbJt9zJbpq+AbaMba9mbmm6weE405YMw0V3bKt4Pp7hhv1FSwhRrZ4iNGQkI0pPSC997vJv0S6E1btCIJqPrRznJf9CQIY8zf5/V0t1FjOJ7S9kXT1BQJYwRAPbjJTIOTuCfsWvg5ObMVXXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=cUPNlmbY; arc=none smtp.client-ip=57.103.76.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="cUPNlmbY"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPS id EC04B18000A4;
	Fri, 08 May 2026 17:40:29 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhJBkMDRQVJF0wBTVIPDxhMCkEUWgpcQgtJAS1eCF4fTBwdDlgGEhZdRVsYRRlLHVgWAV8GWXIZWhRcGFNFUR9UWEEOCloBUFEdXwIKBEcEWxdGA1NFQQQXEVABWB5WXloXXk1HH0BNYkkBWhlbHEAXSm5NUw8PGVoUXBhTRVEfVFheBFNWDkALSVZUVV0DXQ1OVVQaXwZCAFULWFUOH0INSlEPBllXRwkZBy1eCF4fTBwdDlgGDFBNAUMICgJRHFYNVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1778262032; x=1780854032; bh=rvYX763umxFx0VQGORIEx96cyb4wpDHfqn79Q5PBAww=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=cUPNlmbYeZBDFc/K5kAjYI4Wv0ESfEheN/XfFsb2XNAZfLMmpiB4WoDxuqt4hB/X/DJ+Ehc8zu5yW32xA8H0YkPsj8wvGJUofRGWbMLP8RDpz+I/Vq6ZJ2Uf4AsHO+Kt1TvwQ4gwCK/FBI1DlMX0vg8l1tL9wep/tktqMoDXTXBqQh8stULJ/uslWqmtwhek5GrvcBtmlLSxJXJLtqY9+YQ7kwtwnUD/BwJr0VGLM5RRWf6YMix4CAchIZlcggjlPtIb/KIses1vvUkNWVkmbQlIyAE1k7leL0mxyezgUziSQgKv0Spd/2JSjAtap+aeLrSa5cHwUCaXH2jf6uB3BQ==
Received: from [192.168.89.2] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPSA id 85F7C1800160;
	Fri, 08 May 2026 17:40:26 +0000 (UTC)
Message-ID: <021e9b61-46f9-4429-85be-242bb12e70a4@icloud.com>
Date: Sat, 9 May 2026 02:40:24 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
To: Mario Limonciello <mario.limonciello@amd.com>,
 Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260508143910.14673-1-hurryman2212@gmail.com>
 <20260508143910.14673-3-hurryman2212@gmail.com>
 <f682afbb-e816-44e6-9b18-fc7e2335706e@amd.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@icloud.com>
In-Reply-To: <f682afbb-e816-44e6-9b18-fc7e2335706e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: V8RT7b5aKlJS5F51g1NUi2RoLo6NL3GJ
X-Proofpoint-ORIG-GUID: V8RT7b5aKlJS5F51g1NUi2RoLo6NL3GJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3NiBTYWx0ZWRfX/0IR7APOao5Z
 03VK+LlSf2TKM9ABzANrbGECkxe+B6bNyviWRL6z/vTv0grPRvI2dEGsZ35QUdxvB9MaBefEpaI
 WQL9otpbJ5zlA045T7MoOmzG9/KuFPs1yrllv21WDUOYFVSxyBY0euek4+kKRknNVti+InTVCnt
 GiE2dVjnWiUovKTyUdukdPjHS/f+5AR4knPpKCoulnVU9HTzvgmd7+swKFemdNQ52IUdKDTEvsy
 Rg97E7Y24Ftpi3Z+oHsD/zmoieki67N3VgMvoSDmBWv5q7jw8+R6noiPzP2HqkzMjLPHFip8pST
 p8WhPQbW+2hswYcgvzNGNwBfT6xcicpJr4NUMYH4rGZjTVtaNCf5Xk4EnUU/0c=
X-Authority-Info-Out: v=2.4 cv=OZeVzxTY c=1 sm=1 tr=0 ts=69fe200f
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=x7bEGLp0ZPQA:10 a=5jDBv52wX64A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-FalU_6Lp0SrYWVKIWsA:9 a=QEXdDO2ut3YA:10 a=PgRulw5oR9JgysbTFEid:22
 a=MienORt8HT0FiJ1vGQZ6:22

 > Rather than using pm_ref as an output variable to indicate whether you
 > took a ref - how about you instead always take a ref on success and
 > return an error on fail? This would feel more logical to me.

Agreed. I changed the PM helper so success always means that a usage 
reference
is held, and the caller now unconditionally drops it with 
pm_runtime_put_noidle()
after the register access.

For the runtime PM disabled case, pm_runtime_get_if_active() returns 
-EINVAL.
In that case the helper now allows the read if the device is not marked
suspended, and uses pm_runtime_get_noresume() so the same success/put 
contract
is preserved without changing the runtime PM state.

 > guard(mutex) perhaps?

The private mutex is gone. Guenter pointed out that the hwmon core already
serializes the callbacks, so I removed the extra lock instead of 
converting it.

 > You only care about the first byte, right? Just use readb() and make
 > data a u8.

Done. The data register read now uses readb(), and the local data 
variable is
u8.

 > I personally don't really like changing the pointer when there is
 > potentially an error case with it for -ENODATA.

Done. The raw output pointer is only written after validating the read 
value.

 > Does 0xff actually happen with your runtime PM handling? Between my
 > suggestion above to use readb() this can turn into:
 >
 > if (!data)
 > return -ENODDATA;
 > *raw = data;
 >
 > return 0;

Done. I removed the 0xff invalid check. Suspended devices are rejected 
before
the MMIO access, so the read path now only treats zero as invalid and 
assigns
*raw after that check.

Sincerely,
Jihong Min

