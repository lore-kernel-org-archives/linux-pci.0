Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2871827B35F
	for <linux-pci@vger.kernel.org>; Sat,  4 Jul 2026 14:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176152; cv=pass; b=B+DewhXA+9RAuSm7NI5QqpJ80wnGcJZX2cCB2rHg+pFlMGG7pbDNPOoeCJ6ydvuisM9NVPwbvDhBl6en8WjipDvFxWhv0G+C8S8vNzihxbnCaezWfuw9zZ9U9edegSz8ZBOA7YLHQq5vyclW5MuuSZXjzoCOmJRt1i5DkgUt9CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176152; c=relaxed/simple;
	bh=MoaHjkaWH3mVoA4yYUij+2yJ1onRPN8dEfQ18Xxn+3Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxUXF2pnG6UMMbydcj1a/lmnoG1M34HUe4cNVCGQ1ATQQimsCEdmomUcpxHphyO9aSmc17kvw6yHzxVSNwIZM0H8oHssQLD5ODgMwcILun23q9Ed2J+gQE1f+wnFKClI/9PYsq+6PiJLmy/+9kAizvqdZNXdIpDPiB59iiZxzOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Li6WiCbN; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Li6WiCbN"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c821a50615so11876355ad.0
        for <linux-pci@vger.kernel.org>; Sat, 04 Jul 2026 07:42:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783176150; cv=none;
        d=google.com; s=arc-20260327;
        b=ALC0tLxwhxBaTIBABpB+3J1i/rN86FN18Bg5Re2WuERm/7XlTx3dbAEFg045CmX8x0
         S1mo+UrTa6AepmTqSvvdWuVDO5TsOkbjTOsUNPskfStHMVOynFQJEK0arPB7c1pnvwmq
         Qv9ne3/aqIS9Rth0ynO5HN5PGzs4drOkN/2WySA1HmmefkWlm5MKXgf+7To00hQn8Zwo
         XxJiJKSxWQZmzraF0A2qoXHOH6GKi72YjUSttSLCURWyzk5hkGucilV6M+Avyr3gSUyc
         ZeNMxd6x76NjhZiaO6zoZOYbULU3ZDoQ2MT4AtpTqrLmwo4c7sLz6NT7rlZ5C0WsLu/+
         7zBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=3hO7xVm3JMi+xvznWIzbCWLHGJef3ve9nJtp5Srpwow=;
        fh=WZ/8IvPSw4wE0DGB2fsBp38aFYtLrezl5s73dXmeTxY=;
        b=bIROcZsX9dEk/p+I6kLUczti7mgIyj2XuFbxAi8EhIWlYjJ9g1MG6XQaw1hTgZynTV
         7eOLFsT8EU9rqLTVYhbSyxF42juPiwzCvjPnVEjxC7fNDhFOaQ71JmPQY/JjnhJ2ISYW
         doVrYzzDNlUhBKlqEot9RbdMQ8cEN4bXdotRMMb+cYR/g0UuXQOJAclfA4+pkUGE1M8Y
         BN+zLAhWO8wRVGJesHGowyz0dYMa8QrdBAxFDscgxEC5urVvAlPGWWUGyD3Y2R1BXV8s
         EMlonCTaX1YGcCpZ+A8PURKbC/NZNmEQ1e9Vdx+TWd5set4o1n51R7gR95Gn6cuJvKnr
         UDCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783176150; x=1783780950; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hO7xVm3JMi+xvznWIzbCWLHGJef3ve9nJtp5Srpwow=;
        b=Li6WiCbNOvc9ahPrkT1co3mKd7NdYhIuiCEHiqkrr/k8cpMAxKLFXx2nBwhg+newWq
         BgRhvm6Fp2FsutzhydMzHY17stSZzgLOPwc2s8UPtGFl7azqpU9RlgLUmvAoD75DkteX
         4dBHqjaWJQ/wMYvUXTRcQJwEYF5rIRuYC1XEAMzGJyZN16WjUs7t0PACfEZq9gl2QLBD
         TwaXqZKsT04cywkPNLAbTk4KhU8YJxQwZqb/BCDTHuTMVtdQFmkIjlrbO2WHzm7Yj/vu
         BMaIhx0cdlf0RaMy9vpegsR2wUdOztnJnNuB6Jlh/PzA3sPmEWx2nTDvP/3wEd1mDnLs
         5jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783176150; x=1783780950;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hO7xVm3JMi+xvznWIzbCWLHGJef3ve9nJtp5Srpwow=;
        b=NM1xXfZ0y24UE57G9oK9dvpiH1ohCu2cfD+fqLAQuC9rOdicyQREn+6f9iF/QC5axl
         0ZZYhGAfgkDEGkJQQLt51BkFjwa5j2HoTHNRR50qfO/XQJWxKgna0O5p/y7WfzItFHs+
         4SY65a9J2QPJAZoW4jMEYkbZc2dEE2L7FbEPEczn9hEljpO8FYyq0573wZaQ7FUA1C+R
         9PGkBtEH/YAVEaJjoZG2xjDJmapx49liBkjSvCsAdWTj4Eykv6H65WfSq2waCCbRzEsI
         OC6EKDzn6t3t2/6/HsKLdEh+iFrKVkby/2h0lRH/5AK5SFZoU9KiECExcZk6RXM/oSJ/
         CzwA==
X-Forwarded-Encrypted: i=1; AHgh+RrFrwiW4hwW+ZIgt5B8WA16mGVav53MXoPkQZqh3UjE5M2TKnbZ1vEynY9n1vbI76sGFkJb7xAsYAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8p3w+mmC6IrheDSNYmntSy3a0OVqYOqhyQ6WoQl+5UGUjtrtX
	bTXY5/uPdVK/hhqFFRXyGNwAixufkivUU0dfXHpfeSd5cApI1Suhpf0BzCv03MYtwNm6KbjyCHJ
	bUh2kysW5B/NRc42CTUCIUKy86ceuRWA7qtCq6Y0z
X-Gm-Gg: AfdE7ckJBcXJu9cKNcURGbdNJTC+/ghSgs69ULZ4kCLAKXSDc4vDYs+Nvzkl733UpPx
	Rq/EP+LPKcOJXPFwk8cgioe9AHXm2bMu8LDjFygMBW56oPfRzID0YSGQKFTMRp+Soc04aWa8aLb
	vwzSEqGqn3McOOcYLwIsxjJQ5Mjo2psEW6Q/5idXqqqjSYdc6Ffro5Lrm66uy63ax07JLKb88t+
	ubyXOInQhAMy9KP9LcBtZw8ConSVVVAUNnHWyeMb2YKGHZ/LiJ7ROmPMAwD2OJSlE3v9ULmKSU1
	sNSTOMkHjNaG9U+YXpbJTPcyyIC9rlU/Yf6gIS8=
X-Received: by 2002:a17:903:b8f:b0:2c9:ed16:8d8d with SMTP id
 d9443c01a7336-2cbb9eededcmr35313175ad.38.1783176149804; Sat, 04 Jul 2026
 07:42:29 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:42:28 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:42:28 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-21-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-21-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 Jul 2026 07:42:28 -0700
X-Gm-Features: AVVi8CfswepA6TmyRRV0hFxy-bS0yysLNcHLp77b3888QFULsM5J1mmJGvtogqA
Message-ID: <CAEvNRgGgTkOPWELeg5U3pjjw9NZOBQ5zswWy=MRxOXsUXXuFhQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/31] x86/virt/tdx: Add a helper to loop on TDX_INTERRUPTED_RESUMABLE
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Add a helper to handle SEAMCALL return code TDX_INTERRUPTED_RESUMABLE.
>
> SEAMCALL returns TDX_INTERRUPTED_RESUMABLE to avoid stalling host for
> long time. After host has handled the interrupt, it calls the
> interrupted SEAMCALL again and TDX Module continues to execute. TDX
> Module made progress in this case and would eventually finish. An
> infinite loop in host should be safe.
>
> The helper is for SEAMCALL wrappers which output information by using
> seamcall_ret() or seamcall_saved_ret(). The 2 functions overwrite input
> arguments by outputs but much SEAMCALLs expect the same inputs to

Did you mean most instead of much?

> resume.
>
> The helper is not for special cases where the SEAMCALL expects modified
> inputs to resume. The helper is also not for SEAMCALLs with no output,
> do {...} while (r == TDX_INTERRUPTED_RESUMABLE) just works.
>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  arch/x86/virt/vmx/tdx/tdx.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index cd0948794b6c..294f36048c03 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> @@ -2084,6 +2084,29 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
>  	return page_to_phys(td->tdr_page);
>  }
>
> +static u64 __maybe_unused __seamcall_ir_resched(sc_func_t sc_func, u64 fn,
> +						struct tdx_module_args *args)
> +{
> +	struct tdx_module_args _args;
> +	u64 r;
> +
> +	while (1) {
> +		_args = *(args);

Is this copying meant to ensure that every retry has the same input
args? Perhaps a comment should be added so it's obvious that every retry
will have the same input, and outputs from each retry are dropped.

> +		r = sc_retry(sc_func, fn, &_args);
> +		if (r != TDX_INTERRUPTED_RESUMABLE)
> +			break;
> +
> +		cond_resched();
> +	}
> +
> +	*args = _args;
> +
> +	return r;
> +}
> +
> +#define seamcall_ret_ir_resched(fn, args)	\
> +	__seamcall_ir_resched(__seamcall_ret, fn, args)
> +
>  noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
>  {
>  	args->rcx = td->tdvpr_pa;
> --
> 2.25.1
