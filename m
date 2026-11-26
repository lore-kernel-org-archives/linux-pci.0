Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795706171;
	b=EM2MaD+0e73qKx0luPdUt/zLLcpN2pM3Nz6G+L3cyIuDwWpReJbN+2GKPwlEWrs5A7EZ
	 v+x4dzEM+TdQvQL5bTr26NWeBVdj2i8H7TuazDTrC8eDmT8zk8EcBlQwsMUMBAWp7yrVB
	 ThbdRR1YyR7FcFc607WZRA2Erz+5ozC+bm2vR2LbtqkIaqQMV7i3cUAdPjhSDXirw57uE
	 OfysNDopXg7HFehLT/dxrs74ewoVdvBep7rvpc0BiYqgnj2hRR9scSgj/2vGZ6UgzTUhD
	 b0HwwxBsfoFMegmGZnGHjm9DNbwnKaCcjwCT5F5LAwAnwZIXyNssK9323UMneptHDkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
	b=sX/ozUP3X84Xp9lD8xdZLcmEOwYSs4Ts+toRf7UHyOJrieQhzh8w3K/yMmBdJEh+yFqU
	 S86hlvArk0Nw1ypJXSOMU1hN4Cl3eejSO+D1GaHUb5BClsdZOjMw0tTohFj/Nur0+Mz0b
	 SvN4hOMelCY9UUS+nZU3Voj3iSdSWvQCBpLC0YKHd96FXsWtOoduAmwtM9f7B8YoD153b
	 ThDCnFNPd6gSbfq7dYxYJxdtXzymR+JpescN0koOju8GpsqviysZ0q7ESHW7TGHXUDXId
	 dNy/68ONUa3iqBwuTOqL6rlG+OvZXXFfzODPtWyseZYRkWYrVsxGz/o0b3x5QeMk1eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GhoTT+3h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB39C606A330
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 15:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB39C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GhoTT+3h
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso71116545e9.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 07:16:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795706169; cv=none;
        d=google.com; s=arc-20260327;
        b=f8Y8ZDSqdBneLpM44Qm/PydaV2WS3yfPC2q13+jyo9eRhEYHdSZC0uE7wUi1FIO123
         zTwYigxaa45c7QfEOyRQsNVR+JSM9/QJtf6F5tnwxanGEN79FdqjFS0VyhNHH2qGZUlA
         F9xLRhO+Q2/XRntZCa8PfSYdLBUccIcEAYvGhdEvwUD0/XWu35rTiWQUQUBO1JoT/qPz
         9BK75PzNJZElLjTG/VCoxIkR1E7iPwOijC1WulRC8sRJDQ2UwKY5A4PpUzLYw2jjOEWS
         5m6/5Sji2Z09qXV5QKzNFrZWIfaoIWaVfJucOOaIudTUL8Wem8lnt1X+6TgGt4GP0FP6
         qNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
        fh=6NdDwpekt3BTQ4bG0kjdQQdHkIP8TZ9vQepnIc6Jej4=;
        b=dUJiPONiO0GntiiQbQaNAaiL0KRmvuSmRyjwpeJ6nPr6v6DTEJ29Zqyk0F7vnww9zJ
         RMzbPshlUMTfvAal63DuI/pqOljevEAePF06TEjeTL1+F3VN51HwUB23pV7go0BwfZL/
         hTgifUjwC2zJM56SslnXT2QYG10y0Qiik1LVD2DRWd38S5NPZIdkBd6VP3/Dc+fdgx2T
         TWL8AegfSK35VNK0XSnnWntS2/E2xD9Y2kmHBLu369ORlKqM2itcrBs8S4bdswbaWlgD
         9I1G/izhxfau2bTd+n+ZkoRnO0AW3QYs8ko1FMxZ71G02MDRCFQyA62SMR5RLGrdVSjq
         lJzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795706169; x=1796310969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
        b=GhoTT+3hqhyTVwyAIWWrKhhvS3ulJ3gnLZmpoO8ekmItLfPnswvDvTb1d9fxSE6ODK
         qbifDHjnqj1LYSaKPeFKR/bKkcyOsXV9khDMPqKx8EhATt2qmZ+UAUJfF1Aw/JaA/+fh
         HcgqFxa26KkfxEzmerkJAymeRBm4huWFkkX1T6fnTZae8pq5GCUe/dt5h6QgmU2uxKTE
         USj8hNiuIfDuRFhTHvfAzTq9iJ8CPvgDkIQzlE4J5lOYX/YWKbNikkf+iDWCn/EuWI9s
         H71z0k9M1ab2zlQOVd/hiwXjMpT83N0jDbdgVatlCoMUYfjwt+5tyY+dw5mrugVQeRli
         R9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706169; x=1796310969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBvXmBLkI+5ZVDxMnAotYXXXMOB1nSxF2QoCNRUPkp8=;
        b=Fv/Jx094NCdnoL27ZJO18BV/0aDt8JNWSketKNuXkQQDUO7LY+myDEcYlfRydMJUE+
         YHJBedoTOlFUrRrGn4hCi0JAFUoU+R7d0XqRzyhfWjN/AulOxWM9sZ3aOxxO1r+HJhmD
         ngP0GYJCkODzDDwmsFxrK2SQhdtLefSQNDxy3RHOtjByIu6/xd//Ylp/9jiqUf+J+8I9
         iY70HscLkGzTJCeYJjH+gMgZnAFjFvhNRgYBmTqMVwLpGZL6U9H9kudzrQCHr8LzFnXv
         vBIGerrE0BwWqrdUJV3MgbI0Hcb8ojdnkHr6lpOtbb1F5hnzajXkuYAkIV9uBpefgQ3P
         puZw==
X-Forwarded-Encrypted: i=1; AL+hErHOr9NuWypGu8RZvpGL6qdlV0YDyhCG20alQl4M9HAl8K695fVVle4Q+zLJimmI6GcW0hg1rLcoGLs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MAC4S4pvVacNYQFqDWuAUzlNt5qdn1d+gYzqg4bNfZnQurZS/
	BMTNK6pYdTHX+hXX4DEal+RLHpbPcZTgwEskdr5CkV6StCBTi5lzGhOFCDzs9yV4QVI1iO5wcy7
	aKEKU3wrWdgFjY/vMhr8Sv4ax1SD39mATgoYPkcpU
X-Gm-Gg: AZFdTZePAEToogaIaRd3Dq/NMWBq4hlFxlBax97xtBjlSytEPUulCAPtEg3FITW+uc6
	tdfwWAhIyPrzkExfnCSiXDycCLTSNQJmx4TwfN25GSPnRS7fNZ3vVATo99M5wEekqIO4C2lbq3n
	Se+eBVLaY1erJyADsskioEXA8ejCM21jLLAdTRrxhhND/sRBZkZtv/mQXBOMgrCih70YOCgYICc
	W8hmfyQZRwSMfXacmU1Ivw6vtq8NmX4IwsyC+R2C1BXGlKsivmq/EBEfuXmzzmuu86kMojxmuA2
	sE6UQLYAAA5gFAS90LcDsvD8UdAOBsyVPdHgxKUqApAGJueeeS/DoUizKqVqoqYTfSCJgQIwEYD
	QKytM+bSyuvv6T+MPjtpQKc8TpWXlNCa3HrviT+DY6eCzSRmseE/+H4VF7LCdDHNW6ex0urh8BO
	935NYAFI6m5/SBaAfI7ariMZxMzoRWKPyT7zsrjDzResyr
X-Received: by 2002:a05:600c:16c9:b0:4bb:7ad9:311d with SMTP id
 5b1f17b1804b1-4bb861692a1mr332818735e9.19.1795706168571; Thu, 26 Nov 2026
 07:16:08 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119215046.2892839-1-xinmengs@nvidia.com> <20261119215046.2892839-8-xinmengs@nvidia.com>
 <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
In-Reply-To: <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Nov 2026 15:15:56 +0000
X-Gm-Features: Aa3M54o7yVaAHH6adwEWSabFuYapgO-QYKd3fskOtzrfMLGKtESTl7nq44reziM
Message-ID: <CAH5fLggYpTiLKDXMQ9UYBGZ9VuZBWbNfCZn9fs=i82-xf6A-1g@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] rust: vfio: add PCI variant driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: Simon Song <xinmengs@nvidia.com>, acourbot@nvidia.com, kvm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
	linux-pci@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com, 
	yishaih@nvidia.com, skolothumtho@nvidia.com, kevin.tian@intel.com, 
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	jhubbard@nvidia.com, ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, 
	kjaju@nvidia.com, alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com, 
	kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org, 
	zhiwang@kernel.org, zhiw@nvidia.com, boqun@kernel.org, 
	daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev, 
	jgg@ziepe.ca, bhelgaas@google.com, kwilczynski@kernel.org, 
	dri-devel@lists.freedesktop.org, peter@colberg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 11:51=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:

I suspect Mapping<'a> should wrap a VmaNew instead of VmaRef.

Alice
