Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC78436BEF
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 13:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246066; cv=none; b=lRCFaU4n8PbEM2RzBZlVmPfwkWKpevQE96Pa8iwvJsIEnJivwsFvstD0mNunWKQ24MwDqyoP/TwYfmo/EbRyCOgrCy63L2DksL9o/6oqoTvm6GA0Z42uPwN9OJjoKt8iiWE1gPnGs/rbC9ic2s9emAcsIofeiaClq+5hYwNTeJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246066; c=relaxed/simple;
	bh=vNK3/KJC+Nv3ESREzp7sq+ER0NB9BzHnErO5/s+ZOc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MSU+3PkPV4yD69yH0xPTy5jdK45cqYMPM8FpnE6v3eoi57Es/75hfEZlSHJahuPcYvduE1bVcE9tpA5D+IqYGxC7BMf/eBB0XY1KGkBtBl0qO2BbAcr8ygYXqWK4tUD05ntVUTNCvD+2u5999wAx73aKndLhybazR3kcNkVotS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=ydCRvsmE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="ydCRvsmE"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92edb12cdf2so248586785a.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785246064; x=1785850864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKjmhvUTztvaS0W0C4c688T5vwX1u05PK4NnDkhRFV4=;
        b=ydCRvsmEMDWq6tEnGxpJyH2IvUFh0GUzbjzVnfH+/boOFTKToyCTmR4jeAwblQuSBE
         rHL1hCBUtdjqJKkqNGJf/3/x+QMPezS2132GXC+WmhUdu4Dv1FDjxFKk2j/1qXJlFpwF
         6sssSmJPr0an3L74Syiu1sSzXGXl1S+XS9csvTSNow32qmIc0HkR/w1UO0Btxi3W9E33
         Ucuu8OtITuNi4Rp+tjZDWYWcC70j5eGPw6NA//fK/hKQwHICEu8GzkjQ0u86zukYS+AB
         +bwZzGeOB+GeGs6YQPEXrGH5eK1q8fcWPLixRDApep7UNm2UC4a0eaNAwWF193mNlUZP
         a+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246064; x=1785850864;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oKjmhvUTztvaS0W0C4c688T5vwX1u05PK4NnDkhRFV4=;
        b=pN6VXOKaOmzKh+iMHDcSQUlepTWln9ECzYU02WfwjDnGC2zfmvtdIkf/q+wSd0z7cR
         HYk6r8FpttY/KP0aceGMCOdBr1PFtBKMtAaeF7KVKb/j64+s4CaFcrM43SC96F2Wu6w1
         pGMoEVFzqOlznSNApsY219wrBAGLIh5nArjGOUOGaO8m5gJQ4Yd3m/MBNEjaRS7saZkq
         yaZZGJwtG09kJFChSCs5phY9lIAQHsm2bxRe1KzVLTrEqWiFzCyBHuJ1d/7Qqmkw+N5H
         GUrNH9ygHNOepaf8jhM2okHdVRyISFcUd9q3LON4+O21JBvmWLfqpxzUb+yfMO7khKNf
         LQ5g==
X-Forwarded-Encrypted: i=1; AHgh+RrbtQD4mVUhG0oNCyl2Wl6qIUqRcCyd+EtP3k8VDH+YCD2PHiNlZoy5005UW8L2cqEvPXMGyt+zgIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm8V1pgmcgpABkXDqKq5zpwsbRl+wQ7kxLfV4ZD+03n9Mhn2mZ
	YFlgOfC/SORtc0Udfz0Iwvm+YIhshWVQ9e99bhPyoGOGdwNG2aTHbTtDrlfiUczX3iU=
X-Gm-Gg: AR+sD12isQ6/ULl05gsdE63ldLrDNyG1YxkN9iFb2joG+Nwvvlyp+jZG1k5qvUEvlcx
	Sl3sW3iMPJSPt1ePamQNiE2lKfhH46C99tJLMvtMHXa27y5iGlCIRI0wIo4oYeiJ6xBiGNoq4lu
	v0ukMMp+4MNCXlDkQaV8C1+HN1FU1JMcXYttH6trSjomD42rmUZ0E55ameqbBPaQ2gM6L45oNv8
	jGEXCgotV2rGnwZtm7C9uoGMBAbYUBiisjVubkSZQbIY9s88vBLzusfO1bEnh/ZOfwsJxsA6DdW
	WA6hA2urtFeWxEJ0L/ARPBsgxvpnfoCWIo0vBui6qtmS+l3mh5OlsYUBIBcBXojBaq70+Lbb6Ws
	PYLhnlwpsfYh8sYnEh+6visXgtO0vDx46fqeMh+kRByX2TXnWZCR/e6EFB3VCT8lxFwgpk/nkD1
	rAkw==
X-Received: by 2002:a05:620a:17a4:b0:930:f67a:a9ab with SMTP id af79cd13be357-93302741ccamr246375585a.77.1785246063856;
        Tue, 28 Jul 2026 06:41:03 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de5154edsm846774485a.6.2026.07.28.06.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 06:41:03 -0700 (PDT)
Message-ID: <24fe82ef-ff0e-48ec-a6b6-c04d687e7359@riscstar.com>
Date: Tue, 28 Jul 2026 08:41:02 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] PCI/pwrctrl: tc9563: Fix parsing the integrated
 Ethernet MAC Endpoint node
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-2-ec4286e31331@oss.qualcomm.com>
 <5348ff47-910b-4614-a935-6e99ad3b066d@riscstar.com>
 <uavzur74w3w6d4acq4keoi42pcob4p3jez7e5p2aubw27k5geo@ccaewywqbz3b>
 <elrj4hfxzrtn2hfldhvk4ychlbmxcrksmttg45a6nw2h3gulso@4nk3lrgo5rvu>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <elrj4hfxzrtn2hfldhvk4ychlbmxcrksmttg45a6nw2h3gulso@4nk3lrgo5rvu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/28/26 8:38 AM, Manivannan Sadhasivam wrote:
>>> If so I think the DT binding could explain and possibly enforce
>>> that, but I won't insist on that...
>>>
>> It is being enforced in Patch 1.
>>
> Sorry, the current enforcement is only for PHY related properties like Tx
> Amplitude, DFE and N_FTS. I didn't limit ASPM properties in function 1 though.
> Doesn't seem to be strictly needed as no one would configure per-function ASPM
> settings in DT (mostly unlikely).

I think it's fine.  You enforce what's needed at run time
regardless, right?

					-Alex
