Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037737EFF4
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782707975; cv=none; b=tANGbF3oA04FVftZjtjD71h8GV6/SPRHe51iVPh/LYu9MwWQJFPjD4532Disi/NHOwY2kJhVhdjOiHPz9GYithAQ44AT15F8seftgt0eFSlRBDqxZylL3mqdevLplwa8nG7oEFaqLPOvD1dMaRcuXEHbWIGuCvYkg6V32xq6Hps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782707975; c=relaxed/simple;
	bh=1eU+2bDqdzNluinyylphYvQVh/IYBb3LxR6xoSyK7UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk7Gt215LEoJMK4CjWdLUx4DcDMLEz9bhmc9Sm/IISYcUDu5yjkBa3OeT50gD8AkCF8CFGwhROo2Ad19OrdytvNAgeLOqATPCRo/48334GNgJ7Sy9N0KCL6aG8ZFSuIAfjHHVKGNJTnbao0u+pbkSj4vFF7R8RwqEZibfpHlMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hn+E1MsJ; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hn+E1MsJ"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30c99ccb1afso2693793eec.1
        for <linux-pci@vger.kernel.org>; Sun, 28 Jun 2026 21:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782707973; x=1783312773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
        b=hn+E1MsJrcDHw4L7JMBDRGaEVWJGa0ETOsmQqVkAezoHqRNCzAOGRuGGIvFIzzgKAj
         5WbmJiHasrXBsw2nHoHF1trp0cS9knpAh085FbvxF1XlG/DPaHrEmcR5qOONpWipekTI
         b2pmR3DACgvrHz+t5K24F1Klul23PedHMKZDFVxRkjraR01Q2lZwnkB4VEOAS38x302C
         RZiSAD2L8UPyAhNhq9GeEbgcAxM6bpc8M18GprrNeMR9TQXwcNyYWNbEZe2Iplh0nXwf
         JkyvAD/bQHrPjowwEaqS8/fiHVxRV9+9F+3y+wWGAbHlMLR/ZbracNqgYEj3tkzGnPPZ
         Cm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782707973; x=1783312773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAkDY+MQvqYfr4IaXyrXZrjWk09q7w3/qlUx+mpeOiI=;
        b=CMTmjv9A/cWxsb9r2UuhB/RVCz0t4gtby4kq79xqDvMYy4Ih6VL445wUA+c0WznOnX
         w/ghZ3t8yBdiVTQF/hAHepawVhzjE9xCMsYGtKaGYFXacDDpmLlG1Dcx8kfeWQQqT29s
         bht/s6GGb26r2UKsnTAumpRYXA//VtBpNvS1o6CIb4GoK1Mf6Sr4BT6kNpttQEHpwMtu
         eAcr76/rttMABjwZZkzDt726RHB3Dvg9QltUTZmD3glYeN5+ZMoVPp4j5pxcNtwI0jJl
         0O3ZxZKpqb1DPSmzfM70VQjyrlB3UqD7IJPjJvC3P+dZJbkhWjxhyhhnABg7RVeuR2lL
         S1Dw==
X-Forwarded-Encrypted: i=1; AHgh+RqPYzWIpX+XAJKz7CJuX51pw1n996maNvQoBSIFghC2Qt9NFastSRS9ZDdd5sPPBhV9uAdM+Utc3v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaUeZd8BwdX8rtbOCBagiVrPcXQIdEKx3z8sg2ZcvQozr6I8ZC
	/wilpjdXjBm/tuKg8JKl7SQI6VE8+O1lujkXdy/l7AdHP12HecEtNLY7UmAh37Lknd8=
X-Gm-Gg: AfdE7cnIxXSPkqKd/yC+R8X3rFUii97btYf5hEs+84zmiJzq4uIYLHlxWwHa/4th73f
	iSwkxB2kPAqSzZQrTdoy9qpD7mg0F2nLw5JCuakAnZL40HMeIQPCtuVEDos09eoafc4Ocvt9BZp
	ihl8H6XZUnawSpVXBVvEtBloo10SrpnlYeY83B55jgX7DdPFDXTbjPWaLVcVljpKHLmgD42tzsZ
	WHE1hN3AbyWqVURH80v8mFJNl7bLzP2Nmpa79KlmCAN4xdV6OrBL23WW/QszX5Ga8N3UjGAdHvf
	4TdBWXFxH/d20aPnbKonX4KTA9gVehoZLbQMj99WKJCNq4sjtnxF0ueAirK4VC082/EuBX/aOjJ
	j/en2KrtwY8b6Aunv9nk53NybipjNYpg3zKghS2c/0QsxNGBCtjdlgNwyLB2UWIP9KHDvXeY12d
	REhDwJqiD6iucd
X-Received: by 2002:a05:7300:5341:b0:307:d4e7:b177 with SMTP id 5a478bee46e88-30c84f3cb8emr16773092eec.16.1782707972936;
        Sun, 28 Jun 2026 21:39:32 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30cac1b9751sm23319860eec.3.2026.06.28.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 21:39:31 -0700 (PDT)
Date: Mon, 29 Jun 2026 10:09:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Trevor Chan <trev@trevrosa.dev>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	ojeda@kernel.org, a.hindborg@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, 
	m.wilczynski@samsung.com, boqun@kernel.org, gary@garyguo.net, axboe@kernel.dk, 
	daniel.almeida@collabora.com, shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, 
	lossin@kernel.org, acourbot@nvidia.com, markus.probst@posteo.de, 
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	david.m.ertman@intel.com, iweiny@kernel.org, leon@kernel.org, bjorn3_gh@protonmail.com, 
	tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, ljs@kernel.org, 
	liam@infradead.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	ptikhomirov@virtuozzo.com
Subject: Re: [PATCH v7] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
Message-ID: <xak7wil2w2wdnmkfh4e4ijhlgnudzuh5y3ltlo72454e52tocv@434kdjz2eupv>
References: <20260628100731.64885-1-trev@trevrosa.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628100731.64885-1-trev@trevrosa.dev>

On 28-06-26, 18:07, Trevor Chan wrote:
> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index 62e44676125d..84802f22b652 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -1043,9 +1043,9 @@ unsafe impl Sync for OPP {}
>  /// SAFETY: The type invariants guarantee that [`OPP`] is always refcounted.
>  unsafe impl AlwaysRefCounted for OPP {
>      #[inline]
> -    fn inc_ref(&self) {
> +    fn inc_ref(obj: &Self) {
>          // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> -        unsafe { bindings::dev_pm_opp_get(self.0.get()) };
> +        unsafe { bindings::dev_pm_opp_get(obj.0.get()) };
>      }
>  
>      #[inline]

For OPP:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
