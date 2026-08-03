Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1231C3B9DA7
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747680; cv=none; b=CJRfQwU8gkn/EXSulip9IFbAIkMKdVLZqG3rXXpfpD3yRbyQj35rKu1MdwDHmiGFyESpPT+rHFlgDF5IouE00GtFChFGK/sx+I6JujmR53mj6o4QvcrgccPwZ69BHrack12GsKKnrooAwSzcNsGLBlbZx7dNvgKPmYH7/IhHYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747680; c=relaxed/simple;
	bh=A6jrGJQtDJIL30mxb3XxVFNiY/hbrxZT0aR9eyUYw4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INBfCGDJPGM4VCuE5hg+47Xtc5n8lzBFFo5fRcAH8akq5csdCMHPdIOgLHf0voJpiLJzm6hgtUo9863VN8zDmWzkH1+T9W/odvcgw1chOj7G514kCD22Fk06xnLEoon+VA9SHIE3rwRiRy9sjeEyVc8rkcIM2NqmIsSovau3uyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXmt8Plc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXmt8Plc"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4798bea72f9so2195831f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785747677; x=1786352477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7c8ajU7Bc5fO7IMCQU0cwsLx5uJDTGm1qTHU9/J8vs4=;
        b=dXmt8Plc4V8OFjKUyT1OcliVle3n2TVjN0Vu2NntFGVmm51aEyF1EyTQr6tGG/s8Dd
         UX4qnmfCUOJa9Y4heC1+/lbLnntTZcGrz+3Tk3cL/EMbA21G5H0J0YRi/2ZADaOIagRv
         O4js0Qd1wgFT79ID7AmY8ubZhbm3jqMw8JHg8/gsXcUOkKm1SdSoH0BRT2YObncQzny9
         QqDGtNlURng41GZHIXh4Ke3IY1pd/wGsViVzZXCMIgbQkK3ccLsivVGnA0VqhQo99Lxc
         KId99/VBnGAYIEoKC4Bv62PO8tDdCiGzYZmOPqU0BjNx7Ra2v96fDoHv3IhVU5GI6InB
         GREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785747677; x=1786352477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7c8ajU7Bc5fO7IMCQU0cwsLx5uJDTGm1qTHU9/J8vs4=;
        b=E4pqNBd8NpC1HMgmKW+jNtHIf6MrrfZC4FFq3c0y6RQgVQOTaHEhsCwCRcfKZF4dG+
         k3mJ5Zaw+9Dz6lb6ro7C1b4p1LuQCnWRP+QCY7cOq6B83KNXW58SUEn/vMVjrwxhgSvP
         0sTqpMNrsWRdX2TGEpNvbuwjwWGaI3t4yqnz9AhhAXRb/o43tO2xr1J4QCb9/s3msWrI
         IX1DkDH31US45v23mpGlO1WnAjFxt9kvK3KWZ0GV8Kbhnal5J6VWGDQlmsFFu449S+vA
         yZJYslPwmPkhayhigCjm4XoOam2R6Ew75PZljZGpb/DB1gZfkYkDi7bV4O/DonTPz+y5
         5B9w==
X-Forwarded-Encrypted: i=1; AHgh+RoYxugFo5PybTy0yIdjfIBQWIZEEa8qDk/fvksImAd2ydO5tfsqjJyZ/yQGiyMhzKESqxOVEoruHrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySD8T/NVw4Jq4fu8aypwgsqNaJCS2Nt76eUbgKG4A6yQ97kxiV
	yeFwEmriL3pO/3VXHOo9Q+rhJL+GjrarcNzx4W3RUnxdghmfl5vOJlxtU3/Us0SG9aE=
X-Gm-Gg: AR+sD10FAHsKm4ubvr6q5d1fKFl2qggVTso9xdDmbgX0xwIwsbsBljgiDbVd0jp/Hfv
	/LvwST/fhzY+7tjFmMYfvzDhDz3pSm6D26YeVLekV8K6moziydjt/AeiYfrPGrG3QaT6C3UsyOF
	DFWGp+moq4TOViRj95sDawunN3utf0fgjg7wlT3ezC6HOngayYJP6AU//H4qfse5ZbZT+omnf2R
	VnvLcOx8rk/usK2HX2AoI2cLXoDY/mf+A7wJP3gtwDiJolJU5SEqCeJa/dOdr9NuIl9uRlnpzkm
	9lpsoD3jbTbYZRrBeKjUtair03T+JKW1s2UzyRRxohYx34QXl0ZE4Je8mjN6QLT52tbGpn7iLmQ
	62NaqyO9JcXn49QKfl0ub+nhz7G2WAtcRAw7FS9jFnitTFhj3qtTo2qjCQTMku7WjyVkt/y5xw7
	pkYXMQHIhDk1ffpW8dx2FQSFLEoKyzgb8t+92bOgD+TVOgIPU3qex1XI3op2j4ahNm+qNLDNyBb
	84UH3CH4r14MiYhqFgtUpSIQ3PlRcbeXwv3JTsCVG8GNfoTF6Ojm8n1spPr6jg9xalT/DbVmcDO
	KUz3jX6TqOFa9QF7oZb2KrF9MW2Rpt4=
X-Received: by 2002:a05:6000:481c:b0:47f:8ac0:ccd3 with SMTP id ffacd0b85a97d-47fd9fa5e61mr20758749f8f.2.1785747677195;
        Mon, 03 Aug 2026 02:01:17 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458b73asm29125053f8f.29.2026.08.03.02.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 02:01:16 -0700 (PDT)
Message-ID: <7b24e554-0f13-40fb-bc04-dd64cdb93528@suse.com>
Date: Mon, 3 Aug 2026 11:01:14 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] rust: macros: remove `THIS_MODULE` static from
 `module!`
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <20260723-fix-fops-owner-v9-9-c1c3af7f7bcb@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260723-fix-fops-owner-v9-9-c1c3af7f7bcb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/23/26 4:10 AM, Alvin Sun wrote:
> All users have been migrated to `ModuleMetadata::THIS_MODULE` const or
> `this_module::<LocalModule>()` helper. The `static THIS_MODULE`
> generated by the `module!` macro is no longer referenced anywhere,
> so remove it to avoid having two sources of the same `ThisModule`
> pointer.
> 
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

> ---
>  rust/macros/module.rs | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index aa9a618d5d19e..23b6a1b456b80 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -497,22 +497,6 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>          /// Used by the printing macros, e.g. [`info!`].
>          const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
>  
> -        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> -        // freed until the module is unloaded.
> -        #[cfg(MODULE)]
> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
> -            extern "C" {
> -                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
> -            };
> -
> -            ::kernel::ThisModule::from_ptr(__this_module.get())
> -        };
> -
> -        #[cfg(not(MODULE))]
> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
> -            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> -        };
> -
>          /// The `LocalModule` type is the type of the module created by `module!`,
>          /// `module_pci_driver!`, `module_platform_driver!`, etc.
>          type LocalModule = #type_;
> 

