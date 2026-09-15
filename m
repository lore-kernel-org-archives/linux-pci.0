Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1A3C6A38
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476564; cv=none; b=TLbvl9htzo1tAyJf4i90QIpN/+Ld4rk5Zh6cBWXLQxujbWJO0uLGnb8UosUJU5zDRSywASvyBif1t7N1iBJo9YCXwxKfhDYeLqzEs7yvhkbcuEbWEYsWKjfjfCYSFDy1hDidBVdd/oYaPr1zkpI+avvj2lu2Zs4+4cDAHG2aaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476564; c=relaxed/simple;
	bh=1CfyMB2h1Lp5gQE5pFkDas8JqDgo931tl90o9e2+poE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5GaotWANkU1pNYQewk5W5gqYMM8tNTRfzjMYLKGSF8c7VMtUFkDDHbUnmte/wDMU3fWZA+PCl74oDnzbJckTfFPrLW6qBsrx8flCYFWyZfI2Sn1iIH7da0M2x0ktGFYWrPcH5TmePrpPoD/OkN2DDA5CH9Ux8y16jjEz/o4aB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=YPGzebp8; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="YPGzebp8"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafddso263474485a.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789476560; x=1790081360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLVX/S0EuVLiFJIa1AXRvkqCpIEN2ZZSYIPfhR/fxMg=;
        b=YPGzebp84QnP86R4DB/p71+CXJigWjxJLbu3ccIc8W9emX+CLx2S9odNrwMoPs3Kmy
         180iHI9rJTxuShT3mKiziQXxf36RpzwGFwYakSRTQH7eA4nNIqyFSTJ99KMHT8wGm6QV
         plasUKXQWRNhXtjC9sLPUmp6Hsr7T1h4hWQniJLKVykNUvSSSuA5BQD7ddc9CdxX6Mli
         nd7CyWokdn2FeTdMuv6D53k8XE+V0W+wGWq4xrZa4lyw/mNRm/4saYUJUXzNGgLq5j6l
         5wW58OkrMSOL3KwrPjOOJG7bwnZVh5p/NuiOOElqTNpZ/rPV4tgluGO2VvJrAZfqIOOb
         wYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476560; x=1790081360;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YLVX/S0EuVLiFJIa1AXRvkqCpIEN2ZZSYIPfhR/fxMg=;
        b=xDp73SpnzddGxaPsst+y7ngeK+GsHbzTMBrEaOFOxLVcfPOV5elRrXwtEG3n2ej8fF
         TwZiO8q26uuwPrna54qKmqcbD/MWFJKsyYq0gQregoIOdoq6DMZhoZML9dQBTIApEgaD
         XPFFVPcHBb00e5pxQ3q6VRXy8NXTIB0lTqcYP6BDqARbzYR8piLtlBexOOIIQxCY4sx2
         pfXDd2UHwjajMpdK8K/xpigagpcK7L9YhAS6gm9fUl61hbnBgo2z7tebG8sJMnNuM9S9
         9Ib0kkHx740DpOrKEI+dkMjhgps1nu3jgB34niqyrQSFYhKool2O+jAX2RlYZfMcGrSd
         Wn6w==
X-Forwarded-Encrypted: i=1; AKwUvByVUGYdVTzxWibwTDQicijdIaEBvyaGoF3G2qQkN4LU/yPu1kRq9eqUpWypy92q7i+YSvlV8tvsBW0=@vger.kernel.org
X-Gm-Message-State: AFuF++lg9Y+ASFw2c6uEx09pk6bGs32wQ99YAA8IDcibYcz8ObvmzkCI
	NeK4bN9fuSp/8+0tcTBo59Y/Vqo3tjx9/R9XRzjomAYlD9FZXrSKB5CHUNup4elG2MU=
X-Gm-Gg: AYBFou1ytRJMGpknb32Y0Qm4XP5yo6tWPLupny0WXUGe+mJcAOSRhQ4wqvxk+4h67E/
	oynZRBR3TRtI+ITBdfz5054MR7SEVhpt7Vp0EnCtkXErUwDz7m/rKu8K0HQkrxSWqqK9PFTpWZI
	BjesuiqmQ8ZOw0gobCRqLAT7WATmyjt2Vm0dRqrmljDk+SXjIVaXr2dI3m5V8imPFYN1yzj7gcP
	arJGh30DoP4rwLP0xbvdZo7FRvdCRASpZAz6G6y5pKYw7JWlxVv6+eS9GjVeHoB91oXXMlRDP4Y
	jF9E90zJG5TTts7iUl883K8bz90gVYKylBjnrFg+MG3g5gQHoM728bBXDt/XDITTM+wzKdqiL13
	WqnaIVo8IHK2GoNX8efVjSdYAVxRTnT7viBtW6dK6f7Vwt2O4//W/1siJlPafKFQMdPnSlTYlfv
	w0wlp7DIr8ACETPCYyuyeHDC/5CCoEgBltIsyGwnqSz8+xFajBQzM2jWonhhJXTAEZ9aEeTYA=
X-Received: by 2002:a05:620a:43a2:b0:939:eb65:bd38 with SMTP id af79cd13be357-93a29a820aemr1092541685a.35.1789476560394;
        Tue, 15 Sep 2026 05:49:20 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a382ab7b3sm169560185a.19.2026.09.15.05.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 05:49:20 -0700 (PDT)
Message-ID: <7de28ce3-fb1c-44cc-96d4-47d21f6a05aa@riscstar.com>
Date: Tue, 15 Sep 2026 07:49:19 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: misc: introduce pci1179,0220.yaml
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260915031038.1087264-1-elder@riscstar.com>
 <20260915031038.1087264-2-elder@riscstar.com>
 <20260915031552.179121F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260915031552.179121F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 10:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dt-bindings: typo in compatible comment (TC9654 vs TC9564)
> --
> 
> commit 8118db85b05b7b5ac32fd5abc0d4c0b807fa8de2
> Author: Alex Elder <elder@riscstar.com>
> 
> dt-bindings: misc: introduce pci1179,0220.yaml
> 
> This commit introduces a new devicetree binding for the Toshiba TC9564
> internal PCI endpoint function device. It uses the pci-ep-bus model to
> represent sub-devices accessed via the function's BARs.
> 
>> diff --git a/Documentation/devicetree/bindings/misc/pci1179,0220.yaml b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
>> new file mode 100644
>> index 0000000000000..fca3d331097de
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/misc/pci1179,0220.yaml
> 
> [ ... ]
> 
>> +allOf:
>> +  - $ref: /schemas/pci/pci-ep-bus.yaml
>> +
>> +properties:
>> +  compatible:
>> +    const: pci1179,0220         # Toshiba TC9654 (a.k.a. Qualcomm QPS615)
> 
> [Severity: Low]
> Is TC9654 a typo in this properties.compatible comment? The device is
> referred to as TC9564 in the commit message, the file title, and the
> MAINTAINERS file.

Again!  I fixed the previous typo with a new one.

If no one else offers any review comments this morning, I
will send out version 3 this afternoon, fixing this and a
few other things reported.

					-Alex
