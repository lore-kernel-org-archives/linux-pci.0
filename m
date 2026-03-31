Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B4E3A9DA0
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953501; cv=none; b=tu3piUxzJcEWM9F8OWvOCLDqE/gJwmrs/uac/IU2WIEmAsTkvMvMhY7pzws4YtMFyUJkYlRBXO4A0AIVPmlUa5oJhRCqJ8AbtZsWXFen9CW5TZ3cc1w0KFgeLDZCW/nsAkz75d2Dr1DzQCpcftn+dqMYEhEBQqOMFnOizKD+yr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953501; c=relaxed/simple;
	bh=EchK1OhTgSh8S7cgMHy7fOb1l+kJpOBAiQ+NkOjsT/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ/v9WJGS4r+aEM2mJGLfAfwXxnCIwuvTa2DY/rb2lwQZUQJc18BHtZcvybv7MQZeHE06NF+3fK+ZurCZfpNgXthYy+A+nGzDI7mn4Gi7UG6I/dXUwiqNi4Zbukg0Vgz1waWY/Rpt4kaWadZ123knaufxtfWlJy935lg3SLLilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c3NS/ahf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c3NS/ahf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso47156175e9.3
        for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774953498; x=1775558298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j1GwY5PsDoqBTLy6YsGXd3gbj61OJIiAY2NVv6n/DA0=;
        b=c3NS/ahfG27c9ix2wu7ycDtUlNtNBE3J4sQb05btFMaVz6NRrioAm2XPsqPXaiMf0W
         osZD1kvwg4TutNUZb+Oz6MJMPh0HaEULzFsyZPOOar2lU/rw86x5dzqo+q0rwi88Qns1
         SnBgNVF+LQaLTQggQsewqI8KPzm/Q7bGSg3qN6iX8vkag5jhK2Hdi27y3MVhHtwqlIxl
         JSh9SCZzo6e9ydfGMCW6BqYTFCC2bS8HlmrDP8YPW9YlP1Kzoam4cw9bG0LccOy8VKIF
         U+eYydvGKSce/+5u0pbs7L/m41AoL6DmzzYpAeh89+21/TPDgVQm8arKsSEgv7j78keK
         0lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953498; x=1775558298;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1GwY5PsDoqBTLy6YsGXd3gbj61OJIiAY2NVv6n/DA0=;
        b=fcXEeXYoMdl/5eJuqsjzcxvECVaXjfQGmxXkaCb9GexPnl0q94U78BsR+aaDh2TpSa
         25SkGovA71ytxkbOrgJexZSSCK+dYFtnClazRo9GgZ4qh1PXTU8Rq09V/G+tc+HCgA9H
         NsMC0ufZ3edH/3Yyfb2s8UazD4/9Zan/iGfTBXhD6lNT9QCW9JKYfWWdSpLpt5blz3U9
         s5C59Ewfje2iXJGaGv1WYIkvl6niy/aEh6VRZSt4ZwolOXaik93uu7hQvExwzWXGJCAU
         mGMX0iuPWeTiUVs9K58ywHSWajLST+7WjguFor/TSlTJGdxKkphtCtOFc91do1OwGvTo
         9DAw==
X-Forwarded-Encrypted: i=1; AJvYcCV6AtS0OK6icMjyNUWpNRrw84rFPLohX+afoFcI3L9iz6WZOrL6OQrV984HwaJhJW939EWiqX8h9dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZPO3l7Pmkipo9001zlJuJMIO6mjmF55Q5K3pi1UirauE1rvZ
	0IP8NCY8NUPv28ZdUSxKRnYpX+Wf22CDjP/yRbrb8CHtXF5G7n/0+qArKtEGycJo2E4=
X-Gm-Gg: ATEYQzyz1MLOYO8/kkpMe2YcyHIq+6uKL+2keQXw8V3692BfKtj6p1+h80aNbtpU3fY
	HSKoTYaxDgQZ8uOTP8ieIIxdMWqNYmhepw/GZnB/DOmhy4Vwc7GeX9LyfrSN1UE2zPOTCrYssoM
	d5ABql0hPRkycUwnTauILN+LGIIZH0zRI+4omnd/hBurjsdn454J7Y0ALF582C1MoFz2qLPNbRV
	VkzE9L/zbD+TmG8Mo6QDGc/RsmjJ5dwpy/5bS5dVL2xZpNGjgOmy3DjyPpXtyGUMXCk41zfyRx9
	SYz+/0psondii5My+4mm23aoEhf006zQ/8pe1AcbHicMcj6/HSWEOwyHlurXghIAMiZW6m2aGnP
	LBg5EU6BJ6vzE6frp6BJ9nS8irVuoIIvjKYC/wxNcm/kYGO5yHuZ+1xiP35Wg6a3D32z14chcbf
	9fEgqVGfMaGHpn0qlUaKFRFGB7bA==
X-Received: by 2002:a05:600c:a00e:b0:488:7b85:b16c with SMTP id 5b1f17b1804b1-4887b85b27dmr34221595e9.29.1774953498161;
        Tue, 31 Mar 2026 03:38:18 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.133.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822078sm32745645e9.9.2026.03.31.03.38.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 03:38:17 -0700 (PDT)
Message-ID: <730feb0b-7022-4d22-9ead-3efc4b4ab4ab@suse.com>
Date: Tue, 31 Mar 2026 13:38:16 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/31] x86/virt/tdx: Configure TDX Module with optional
 TDX Connect feature
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com,
 yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org,
 rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org,
 xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com>
 <20260327160132.2946114-9-yilun.xu@linux.intel.com>
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
In-Reply-To: <20260327160132.2946114-9-yilun.xu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 27.03.26 г. 18:01 ч., Xu Yilun wrote:
> TDX Module supports optional TDX features (e.g. TDX Connect & TDX Module
> Extensions) that won't be enabled by default. It extends TDH.SYS.CONFIG
> for host to choose to enable them on bootup.
> 
> Call TDH.SYS.CONFIG with a new bitmap input parameter to specify which
> features to enable. The bitmap uses the same definitions as
> TDX_FEATURES0. But note not all bits in TDX_FEATURES0 are valid for
> configuration, e.g. TDX Module Extensions is a service that supports TDX
> Connect, it is implicitly enabled when TDX Connect is enabled. Setting
> TDX_FEATURES0_EXT in the bitmap has no effect.
> 
> TDX Module advances the version of TDH.SYS.CONFIG for the change, so
> use the latest version (v1) for optional feature enabling. But
> supporting existing Modules which only support v0 is still necessary
> until they are deprecated, enumerate via TDX_FEATURES0 to decide which
> version to use.
> 
> TDX Module updates global metadata when optional features are enabled.
> Host should update the cached tdx_sysinfo to reflect these changes.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>   arch/x86/virt/vmx/tdx/tdx.h |  3 ++-
>   arch/x86/virt/vmx/tdx/tdx.c | 16 +++++++++++++++-
>   2 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
> index e5a9331df451..870bb75da3ba 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.h
> +++ b/arch/x86/virt/vmx/tdx/tdx.h
> @@ -58,7 +58,8 @@
>   #define TDH_PHYMEM_CACHE_WB		40
>   #define TDH_PHYMEM_PAGE_WBINVD		41
>   #define TDH_VP_WR			43
> -#define TDH_SYS_CONFIG			45
> +#define TDH_SYS_CONFIG_V0		45
> +#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)

Since newer versions of tdx module apis are backwards compatible with 
older ones, and v0 are actually deprecated why have both definitions?


<snip>
