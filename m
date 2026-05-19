Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15F348C5D
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197670; cv=pass; b=prICvGvucrftCU7Nbmfynq1HmqPORGSp0hd1KaVaYmo25vpGKgXGTZkqarSEI4eJEdHdvs5TmfguT2OuXqyjD8vtPKMf1cHQ3l7fl1NyGTyNauXMoAjQG3MFBqMo7u8zFzGLnffRu6uKvWWjXw81WDag5KuLOpz9KquYR8cetVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197670; c=relaxed/simple;
	bh=naF+eFIBVaPQxxaOGNrVUV2zt+dbyRkLeG9JHqTunLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ghcEnogt2OitBNsYdXMz627IpPLM8JyuYs4aw95Q4JBM8Qxz2aaMYmWckKXkyAQcqpDHy9Iu0dk0sN0dnc+1Q1MHj/akkZ+rsbP1voJxjSfUcTM0wY6WvsVQjc1aOty9fkoBxnYfpNshm6PaO9xFLVnHpt5p/MQdM5SguOYduQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3QKAkOH; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3QKAkOH"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-303bbf3f16dso117978eec.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 06:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197668; cv=none;
        d=google.com; s=arc-20240605;
        b=kseRG/G5cCHCV7nG39YzWvKaZQoRf9Uo7N54k0CRWRWTfKKHY4FXiEJTEBSOLLzeXt
         BqOINI3P1NAvWM3eOxLy78O6EuwpUtyrVQ9rhm2UOZufQjDCYATiRVtMGFmOlWYfTwmZ
         mW0zq9TO6KdNTQU3fQ7ddFYgRp4kS7IIqSKnHf7WwgZaZ6HiOqls9FHJJ2uCKYlznhbC
         3sU29K/06w11LXBfA1VJHkCJinUHT8dIGg24z4tUXHp3bpfJiVZzzQNKV0jAE/aS47Qf
         im4rW70k+5HNDPtIDh4TtdMo1kS8JtTGyxMesoB2dgseJ/yxYS7B7cgI+oXJ+uoKI+XE
         HMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        fh=YiL0VHNRQHaA43h7Ck3MEEg8djI82ccKLh5riauQJHE=;
        b=FnWyx6gnitC/T+UicNtaeJcU7Wp0FqCrCKWg6NhyNUh9RgB2E5yZcfD1D+Lv/usCIf
         hdSJfR5+4y9YX1QHQcRx3GIoXlvZ4+iktyqxeF+1gYOl+wosOBj4Rsp95Ywp7xZosJm5
         ANkwFRFGzuI5+XTWkUxfMYfC9ibvAnwiiXyEJ5uyIY8o0rhJOplZzJfD8nmoM6C8zdWL
         2MDSwESndlFYqnQemLTdTP0LcAEvwpaH3Mr9PgYmIefdU02t3OvcduQUz6AJWIlLt4Vj
         BfynuKodGCzgO8tZU9OdNZcukwFog9x1cQU3m5JnSLeuKlThXxPUV9fKHBtZgRgUv8dV
         wYng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197668; x=1779802468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        b=Y3QKAkOHC6LcGS5ofPga3r5bKLfejRPRa5knoWuBdjIQPROhsMlxoCgtWmEDooiLsm
         0+80J+YEhGUXdmi5bn8r2tmzxbHS18gfwjoF9FB1iKPEfkqvByO7GeN85Ge6jjDuaS/B
         UGejyckurv4npWtPDzpzm1RJ87DSXK2HvX+PxJ4BDXkVpSEZfe18oGhU0vJBd3EkhHsO
         ZULy6yrBlR05xc4N5tXJXxbjda/Jwd4iYxb4A6OPBsDNsUc35u62UEuzkwYz2yVcpC2c
         Sj8IexBkLvoJvITBQ2aWGpVgscMHQcWLFEYxaAtCXBVe6CU7A77UligOFth+txU3f362
         0trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197668; x=1779802468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dH/8yGMfRsmeb4Ra/l98WpGBn5pzwNsIBkPePz8iHO0=;
        b=QkISnhLPIpgmhC0Qzw3uGLajPaGdiDrQ+R9xSJvXceOMMtHOaKlhe77FER2QOhoJi6
         RaEbx5UW/aFk0jiB24aCrNxJTLte8eX8E2mHxDimg2c4u1sWacCKl2yGKR/w3RdpGJLM
         8YZ56x29Niz17AcqWNjBCpf1FoQCU4TnuJAC2iqHM862E0gLmZ22q8/x0u8YDt/2/Xwg
         8xf3WtI8duYJs9pb0Cv/4o88wpqwkBvWXm8BQEcMIew2cFWIrs2rpT58TY6/GC+OGmkA
         oys82TSotbIaJ6gTNn7nzfMEbwhYCQ8IyYoja8l1JMqe1jM7zZc3E+Mo8lihWozgSoKs
         UxVw==
X-Forwarded-Encrypted: i=1; AFNElJ/ys/eholmmnhjomvTpEet7BtRVg3bwrjYOiffRrvt6fhd3nVTB7h7ImSQTtASL/f1gWQbuU5FjUJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzalILGfGxm9OPAuL+bSa2vp0kWGgihrhOf30TDTrmqI9LRJv8r
	HGnN58SG8lZIc9haaHobd09Q1gSGgKLdxdxZyO3FihiywndBkd+toamcQ1T21SgguFoWL7/DTVu
	R3kBmFFP4yu3d1kTLvjLgDWAWvYti7Oc=
X-Gm-Gg: Acq92OHm3ayUjeyHhoWQPiqKOdeBBg54GZH70qeqyO7OGt3fKcMnnnNs8WGXpV/00Ct
	j/NgptT3UXDre67o6227qMuW2KFA1fNI1o/I9hXHZ9pOH1IVN4IoZEp1/0THDEX/+GAwLCw8rVv
	1kQ9mPi9wcUzIjfWVXEuP//HTl28Ri/fzictiKBB12HTFwyHgWFTSXP8bgSs0Sjs1S9F2XjhK4z
	a6yfO2mDhjvl2sXH93j3g1IAtjLsLQpA4SQIw/NJDBDzRodLC2gWwceVfyTaL++CP3Q4zBI4PAY
	T1sOgJ5H5WvpzCfu8nIkoFIrk5/WLVGHsJpofJ2fHoUjqx6qbEd0wfxzQ6GLkJvwG+RttoK3SRa
	hUoBcAmGUbxnAhHB8OHLq+O0=
X-Received: by 2002:a05:7300:dc14:b0:2e6:b55a:76ca with SMTP id
 5a478bee46e88-30397b88952mr3989391eec.0.1779197667973; Tue, 19 May 2026
 06:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517000149.3226762-1-dakr@kernel.org> <20260517000149.3226762-17-dakr@kernel.org>
 <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com> <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
 <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
In-Reply-To: <DIMO9MW468B5.2KSIVYEMY31YF@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 15:34:12 +0200
X-Gm-Features: AVHnY4K5vpbJGhCh2fM0bDGLH-gDIENRDMeBQsxYOoXtqTcl9WixZ1bWmTIZnkI
Message-ID: <CANiq72myVDq9oLyyZqUf3Se9-JLDp=qGhBJy01nOxMaZBRxADA@mail.gmail.com>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for higher-ranked
 lifetime support
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Alexandre Courbot <acourbot@nvidia.com>, gregkh@linuxfoundation.org, 
	rafael@kernel.org, aliceryhl@google.com, david.m.ertman@intel.com, 
	ira.weiny@intel.com, leon@kernel.org, viresh.kumar@linaro.org, 
	m.wilczynski@samsung.com, ukleinek@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, abdiel.janulgue@gmail.com, robin.murphy@arm.com, 
	markus.probst@posteo.de, ojeda@kernel.org, boqun@kernel.org, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com, 
	pcolberg@redhat.com, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 3:03=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
>       That said, I expect LLMs to be (heavily) used to write drivers, and=
 LLMs
>       are typically trained to be compliant. So, I could imagine that a p=
rompt
>       along the lines of "Can't we make this work without unsafe somehow?=
" leads
>       to an LLM abusing this, while going unnoticed for the user.

Could we steer LLMs to avoid that? e.g. adding a line about `Unsafe*`
items to Sashiko's prompts.

Also, a `checkpatch.pl` (or similar) warning may be doable too, since
false positives are OK there.

It could go to the ASH (Acknowledged Soundness Holes) list we
discussed some times if we end up adding it.

Cheers,
Miguel
