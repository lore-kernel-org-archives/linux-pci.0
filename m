Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C192361DB2;
	Fri, 20 Mar 2026 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000188; cv=none; b=JShwizMdLF21LTGMZFhTw9upJksmrvPfk56QWt2Qkf5BWZQTgiVTAIMf3wZZW7ZKFDSafAiz6sNuUCGREItGNOTAGxcTaU7UrPZBJytR3NMo4aiAoEfr1ELr2PbSKTMXfC3hpLH4Thbu2Axcu6Fmtqko8IbtNQWzlQ0xKDiBXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000188; c=relaxed/simple;
	bh=/xlFgt29IWXWdp6cPa+Deh2J6xoN/Ur1ogGJgzj3LUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UaajYRFlrPYFEus5Dibwhx3dDnpEO0Hb5RcL/m9u+GPagAwY57SCwRtiwsBiQGWWbLui42O1i/ljK4f91zhJHJ+6m+Pt2MNs9RGMbjMp5uBOKlObCJ+L9pEGgRJIqc5lye/RVkhdA13LUtGB8lVFgtbJAiDIfq5jaVy91FstMbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxvssoXi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxvssoXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46902C4CEF7;
	Fri, 20 Mar 2026 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774000187;
	bh=/xlFgt29IWXWdp6cPa+Deh2J6xoN/Ur1ogGJgzj3LUo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SxvssoXiT+PQifzXrWliQURLhwUMT8FAjsOIRMOP+wqdJx1MGOUEP+eVDwrCFHarE
	 xItClGnSFmSVzROIFuy79U7kCEV8alatSL7rRJCpPHv1Qsg1nBvzuOdamFQsDwiur4
	 nJrMyQvZ7DYin3KApJr40rjfpTVbTru9mrIy5qh4MxGiRHKn05u4DnHlLHuTLuH7Dp
	 Udp1yrvsH08U6InkzGYedaeR6bhMiMxf473Vl54SbPVCNm5b984jpOZYAveF3jc8Eb
	 B1r+U1e4vuyN9p8VFm8XOwN7C6glMJPJW8j7zIracPSJQ1ZQf9XQtOdKlHsFBbML2K
	 kHE7cFO6Vs82A==
Message-ID: <e238644c-132a-43fc-b735-70f04ef3f212@kernel.org>
Date: Fri, 20 Mar 2026 10:49:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] soc/tegra: Update BPMP ABI header
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-2-thierry.reding@kernel.org>
 <435095b4-ce29-4c8a-9f63-300ff94e419a@kernel.org> <ab0T_0Pyio2SYrzq@orome>
 <1357d59f-7c38-4de0-9cc8-b40be3d7ce5b@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <1357d59f-7c38-4de0-9cc8-b40be3d7ce5b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2026 10:44, Krzysztof Kozlowski wrote:
> On 20/03/2026 10:34, Thierry Reding wrote:
>> On Thu, Mar 19, 2026 at 05:15:56PM +0100, Krzysztof Kozlowski wrote:
>>> On 19/03/2026 17:01, Thierry Reding wrote:
>>>> From: Thierry Reding <treding@nvidia.com>
>>>>
>>>> This update primarily adds various new commands and MRQs for Tegra264,
>>>> but also contains a few new annotations and fixes.
>>>>
>>>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>>>> ---
>>>>  include/soc/tegra/bpmp-abi.h | 4565 +++++++++++++++++++++++++++-------
>>>>  1 file changed, 3671 insertions(+), 894 deletions(-)
>>>>
>>>> diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
>>>> index 39bb3f87e28d..6cf6442395f1 100644
>>>> --- a/include/soc/tegra/bpmp-abi.h
>>>> +++ b/include/soc/tegra/bpmp-abi.h
>>>> @@ -1,6 +1,6 @@
>>>> -/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/* SPDX-License-Identifier: GPL-2.0 OR MIT */

I missed this part here - that's license change. This has like 10
different authors, so you must be explicit about it in commit msg and
you must get their acks.

>>>>  /*
>>>> - * Copyright (c) 2014-2022, NVIDIA CORPORATION.  All rights reserved.
>>>> + * SPDX-FileCopyrightText: Copyright (c) 2014-2025, NVIDIA CORPORATION.  All rights reserved.
>>>
>>> You just replaced correct syntax with discouraged (as in not welcomed
>>> upstream) SPDX tag.
>>
>> Fair enough, I'm dropping the tag. I didn't know it was actively
>> discouraged and I don't see this documented anywhere. I suppose I should
> 
> I am trying to get it somehow documented as permissive, v4 is waiting
> for some time.
> 

... feel free to encourage/review my change to get the tag officially
supported.

Best regards,
Krzysztof
