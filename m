Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1363033CC
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 13:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784295876; cv=none; b=nOOjJl3Wo2dSBonz1txBtbt9pLhCJG6EQwOMWBvEsxY7mOviFsh25fXq4eTP2iiWZU3ulnLeX6rZKcu7AE0dWL71AOYZ2CpWRTFc4dZ8R7jrg5cv3gLvrOfz5jT7YWK3n2rwrsWVsPnCKylaLRyABgh5tKLwKgeiQeihOtfREJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784295876; c=relaxed/simple;
	bh=gHM8gxxIGrtelmB4ciSq93JB3GHtaROcZU3f2k2iz0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6KNSTRg5tTCKkq29Uaa6rI5Pe6IeVpLNlb/FwW+7xy+E61+JptI7PT4JZP5+SFYaSKMxnlax65JR+iiBzsKiJdjfPPeHXEvYL9IrjmqTHyf3D26iKoDtxCQ9sAti5Qy9VY9/5GS6vMzGbbvy+NO4fcalMUx7+a/fAVY/WaX2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f7ybhoPW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f7ybhoPW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso4879245f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784295872; x=1784900672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IgmxxxpCItf1KZzWIsCn5rVL7exNYDJuWybs4ZYZUDY=;
        b=f7ybhoPWoqDiNy/HiEbJveqVrw1TjPPVL7+dHPij6G6K0pAe0w0kRg7TMoy1s1cH65
         CKwYXAb61WNuKBYs6xtuz1Y4GPsFKsOt+78GIeHFfXGuRJ4ijKuFlKRTo5qtXjCR/qya
         8GsrK6PNEL2dWwVRcwgRtmjdhZy3AKzFl8Sve1YiZIHMAwkxbs9J6Ykt0PmE0O65N3yq
         yTh7d4/rO94VYp6g1rrLWdph028P/GRBDvbBJyfQhxNJLA7mQSeMp980CI9B+r/d+jWb
         EwWXw7V6wyh/4/P3SUzgswdJjEy+rY2b3QJlLlC8thndE/QYlsACGrZPl6rq90NGOBfr
         Zuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784295872; x=1784900672;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IgmxxxpCItf1KZzWIsCn5rVL7exNYDJuWybs4ZYZUDY=;
        b=auQpJZmilmRYlkeS5vF+fRar4Ba8kydYSltZPc2c14I9ZGZoAegUcxab8KWx1d8c1S
         VF0fOz59uwZUt8Y2rCJI7xPWszqRcq2SEAIRp2b4xyqEUE6NixRtEv8djqqnxi9COYJq
         8o5v8E1UplHcfP1GKJrJSgH3OPFDqL8ZjO+Lkey88A/+SygOdtInjdb2pPvQ+JYM5MyO
         Y16+HJdXum1fjlLfNFyMDBM9os2Jcqjbres26uV/7kALeTK9oWMjQGHhNLPiYjZ5XE4q
         xv2ro3A0PlGXqwl8wyVvJBg5Ff0NZKyaPInlttyx+mWhIbuawk1fm+9tBIbmHxY5PS2g
         5Syg==
X-Gm-Message-State: AOJu0YwRKcifjdMSdu+VGEfT+z7zBbq6ihJiM/4dQaieiuzEEabQyJpi
	Su8YqbmrSMhSrjw++lqV2FysmITMnCRH64WmYthANZZOP/dUc6oad5wUgsZTDRQQf/Y=
X-Gm-Gg: AfdE7cneHdj1cYq5kiFfPMyUeuJflCvAZLLjPN19O9up6jnpOc7NiErQ5+lEDmdGu0S
	os9LLmtchStt47VLEj/GrrVO9kK1JN8p3XBtBdbLdn/tnKLf6GLEBBJYLFFYt2WBYq4Q7NHd34q
	ExBSz/OcQsZid5anUiY1B9VxnXGGFGHPnPSmRQKBrJeRi1/D3lmBQ5qu7OXtPc3ftD8bjqPWtsi
	AcIFyxxUaESRKgg9HmdMJSy8cuqs6+mSmRTHnLKHxrGVZMyxkOb8a/d9e6CWX1NRw7fuh0iWEEG
	4/jbNR8FkgdT6xW/ZreaO5Ino7RAdGCG+3JuglxAp55NpAKyhU1dxouhEQolPccWleHG09Z7Um8
	MrFceJtWMWqovNIdXH6rgTKGmT3j5eQqCWZaQRypE85KiTDgVfTmIjzcnMpq17qEasw==
X-Received: by 2002:a05:6000:25f0:b0:473:8f65:c978 with SMTP id ffacd0b85a97d-47f623065f7mr4074816f8f.1.1784295872194;
        Fri, 17 Jul 2026 06:44:32 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f66df025csm2145172f8f.0.2026.07.17.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 06:44:31 -0700 (PDT)
Message-ID: <0c2f40d1-f695-45d5-949c-cd173c641c84@suse.com>
Date: Fri, 17 Jul 2026 16:44:30 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] modules: Document the global async_probe parameter
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Saravana Kannan <saravanak@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-8-djbw@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 xsFNBGcrpvIBEAD5cAR5+qu30GnmPrK9veWX5RVzzbgtkk9C/EESHy9Yz0+HWgCVRoNyRQsZ
 7DW7vE1KhioDLXjDmeu8/0A8u5nFMqv6d1Gt1lb7XzSAYw7uSWXLPEjFBtz9+fBJJLgbYU7G
 OpTKy6gRr6GaItZze+r04PGWjeyVUuHZuncTO7B2huxcwIk9tFtRX21gVSOOC96HcxSVVA7X
 N/LLM2EOL7kg4/yDWEhAdLQDChswhmdpHkp5g6ytj9TM8bNlq9I41hl/3cBEeAkxtb/eS5YR
 88LBb/2FkcGnhxkGJPNB+4Siku7K8Mk2Y6elnkOctJcDvk29DajYbQnnW4nhfelZuLNupb1O
 M0912EvzOVI0dIVgR+xtosp66bYTOpX4Xb0fylED9kYGiuEAeoQZaDQ2eICDcHPiaLzh+6cc
 pkVTB0sXkWHUsPamtPum6/PgWLE9vGI5s+FaqBaqBYDKyvtJfLK4BdZng0Uc3ijycPs3bpbQ
 bOnK9LD8TYmYaeTenoNILQ7Ut54CCEXkP446skUMKrEo/HabvkykyWqWiIE/UlAYAx9+Ckho
 TT1d2QsmsAiYYWwjU8igXBecIbC0uRtF/cTfelNGrQwbICUT6kJjcOTpQDaVyIgRSlUMrlNZ
 XPVEQ6Zq3/aENA8ObhFxE5PLJPizJH6SC89BMKF3zg6SKx0qzQARAQABzSZOaWtvbGF5IEJv
 cmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPsLBkQQTAQoAOxYhBDuWB8EJLBUZCPjT3SRn
 XZEnyhfsBQJnK6byAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJECRnXZEnyhfs
 XbIQAJxuUnelGdXbSbtovBNm+HF3LtT0XnZ0+DoR0DemUGuA1bZAlaOXGr5mvVbTgaoGUQIJ
 3Ejx3UBEG7ZSJcfJobB34w1qHEDO0pN9orGIFT9Bic3lqhawD2r85QMcWwjsZH5FhyRx7P2o
 DTuUClLMO95GuHYQngBF2rHHl8QMJPVKsR18w4IWAhALpEApxa3luyV7pAAqKllfCNt7tmed
 uKmclf/Sz6qoP75CvEtRbfAOqYgG1Uk9A62C51iAPe35neMre3WGLsdgyMj4/15jPYi+tOUX
 Tc7AAWgc95LXyPJo8069MOU73htZmgH4OYy+S7f+ArXD7h8lTLT1niff2bCPi6eiAQq6b5CJ
 Ka4/27IiZo8tm1XjLYmoBmaCovqx5y5Xt2koibIWG3ZGD2I+qRwZ0UohKRH6kKVHGcrmCv0J
 YO8yIprxgoYmA7gq21BpTqw3D4+8xujn/6LgndLKmGESM1FuY3ymXgj5983eqaxicKpT9iq8
 /a1j31tms4azR7+6Dt8H4SagfN6VbJ0luPzobrrNFxUgpjR4ZyQQ++G7oSRdwjfIh1wuCF6/
 mDUNcb6/kA0JS9otiC3omfht47yQnvod+MxFk1lTNUu3hePJUwg1vT1te3vO5oln8lkUo9BU
 knlYpQ7QA2rDEKs+YWqUstr4pDtHzwQ6mo0rqP+zzsFNBGcrpvIBEADGYTFkNVttZkt6e7yA
 LNkv3Q39zQCt8qe7qkPdlj3CqygVXfw+h7GlcT9fuc4kd7YxFys4/Wd9icj9ZatGMwffONmi
 LnUotIq2N7+xvc4Xu76wv+QJpiuGEfCDB+VdZOmOzUPlmMkcJc/EDSH4qGogIYRu72uweKEq
 VfBI43PZIGpGJ7TjS3THX5WVI2YNSmuwqxnQF/iVqDtD2N72ObkBwIf9GnrOgxEyJ/SQq2R0
 g7hd6IYk7SOKt1a8ZGCN6hXXKzmM6gHRC8fyWeTqJcK4BKSdX8PzEuYmAJjSfx4w6DoxdK5/
 9sVrNzaVgDHS0ThH/5kNkZ65KNR7K2nk45LT5Crjbg7w5/kKDY6/XiXDx7v/BOR/a+Ryo+lM
 MffN3XSnAex8cmIhNINl5Z8CAvDLUtItLcbDOv7hdXt6DSyb65CdyY8JwOt6CWno1tdjyDEG
 5ANwVPYY878IFkOJLRTJuUd5ltybaSWjKIwjYJfIXuoyzE7OL63856MC/Os8PcLfY7vYY2LB
 cvKH1qOcs+an86DWX17+dkcKD/YLrpzwvRMur5+kTgVfXcC0TAl39N4YtaCKM/3ugAaVS1Mw
 MrbyGnGqVMqlCpjnpYREzapSk8XxbO2kYRsZQd8J9ei98OSqgPf8xM7NCULd/xaZLJUydql1
 JdSREId2C15jut21aQARAQABwsF2BBgBCgAgFiEEO5YHwQksFRkI+NPdJGddkSfKF+wFAmcr
 pvICGwwACgkQJGddkSfKF+xuuxAA4F9iQc61wvAOAidktv4Rztn4QKy8TAyGN3M8zYf/A5Zx
 VcGgX4J4MhRUoPQNrzmVlrrtE2KILHxQZx5eQyPgixPXri42oG5ePEXZoLU5GFRYSPjjTYmP
 ypyTPN7uoWLfw4TxJqWCGRLsjnkwvyN3R4161Dty4Uhzqp1IkNhl3ifTDYEvbnmHaNvlvvna
 7+9jjEBDEFYDMuO/CA8UtoVQXjy5gtOhZZkEsptfwQYc+E9U99yxGofDul7xH41VdXGpIhUj
 4wjd3IbgaCiHxxj/M9eM99ybu5asvHyMo3EFPkyWxZsBlUN/riFXGspG4sT0cwOUhG2ZnExv
 XXhOGKs/y3VGhjZeCDWZ+0ZQHPCL3HUebLxW49wwLxvXU6sLNfYnTJxdqn58Aq4sBXW5Un0Q
 vfbd9VFV/bKFfvUscYk2UKPi9vgn1hY38IfmsnoS8b0uwDq75IBvup9pYFyNyPf5SutxhFfP
 JDjakbdjBoYDWVoaPbp5KAQ2VQRiR54lir/inyqGX+dwzPX/F4OHfB5RTiAFLJliCxniKFsM
 d8eHe88jWjm6/ilx4IlLl9/MdVUGjLpBi18X7ejLz3U2quYD8DBAGzCjy49wJ4Di4qQjblb2
 pTXoEyM2L6E604NbDu0VDvHg7EXh1WwmijEu28c/hEB6DwtzslLpBSsJV0s1/jE=
In-Reply-To: <20260705220819.2472765-8-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/26 01:08, Dan Williams wrote:
> In preparation for adding another /sys/module/module/parameters entry,
> document the existing async_probe parameter.
> 
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>   Documentation/ABI/stable/sysfs-module | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
> index 41b1f16e8795..397c5c850894 100644
> --- a/Documentation/ABI/stable/sysfs-module
> +++ b/Documentation/ABI/stable/sysfs-module
> @@ -45,3 +45,13 @@ Date:		Jun 2005
>   Description:
>   		If the module source has MODULE_VERSION, this file will contain
>   		the version of the source code.
> +
> +What:		/sys/module/module/parameters/async_probe
> +Description:
> +		(RW) Emits "1" if drivers from loadable modules attempt async
> +		probing by default. Emits "0" if drivers from loadable modules

nit: I think there is some tautology happening here, i.e a module is a 
driver, no ?  I.e perhaps just remove the driver word so this reads 
"emits 1 if modules atempts async probing".
> +		attempt synchronous probing by default. This value is overridden
> +		(in priority order) by: the module's built-in "PROBE_FORCE_*"
> +		requests, the "driver_async_probe=..." kernel command line, the
> +		"async_probe" module option, then this default. Write a valid
> +		boolean value to toggle this policy.

