Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483321;
	b=yr43TKwKPz6eUZQAiy0J/whU4k1YzPfz86noiSFRdWgX/h3R9/Nek3n1CW2STkJn4E/b
	 x5oEQ2DU879rFh2BDjj0ermItQsaDliWa1zC34VW2ZmaYwQXzWy7TjJavYvAY0Uz81T3T
	 OHkjcijMScy5qZ4jFcgoURJtZOtuq6jSgvhGNYacxFSqC/aryKI78/xvmBjg7+zug+qcP
	 delhLGPWQ44C+IqI8UhdCnLfeaEBQwI86rCiJum55wFMVEiuym3nhJSeNOJ+IVNz08qyM
	 Rm0n2qxvNo1qbhP87etCQYPN4Sx0PKb+QTcUF9DEb19323zH/99ieKGDCBQShBj0dWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=a5szgawaqFYahDoR6WgawlMOYcIGKmjMs7XIVNwb/WA=;
	b=EXtXUug7VUVk02tVY5elW0klFLqPMW9mXCPX7LvP1x9nKWj9M0lD2+eMvRgIlT4Np2q8
	 bqK/ZmO5W4ACh2RbstYfCZ37Gmk7EAMrUIqz9jQBxju4TQ2INvKUGME3mPGgq2SBY4xOA
	 fRhK+WXs2yBoJ0ExIHnhl7EOlJyhHoy3ER0nNLNav6qGegBknUX+KtBd9YIvQBDMKiWrT
	 DlC8aUWDykKVCIa+w9ZJ8hqDhuNdkcUVT+4UW83peEfGte2VJmdrlvSHRdBcJUeEP4k4Z
	 OsGYWcAhE0IBU/6LsagS/w4ZqpA9sLxsosNaIyyzMu0q9xL8oQuMByi5O0tvXVJtLXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bTSzKRuQ;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCFF606A31F
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCFF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=bTSzKRuQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c7fe9736eso2652632f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792483319; x=1793088119; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a5szgawaqFYahDoR6WgawlMOYcIGKmjMs7XIVNwb/WA=;
        b=bTSzKRuQMaj/nUNDQiFNgbMW7VY0cz1uEsSS9LODUy0rJpJ1NcOHZpuiEdx+Pv7xXw
         JrElKjWS5h1Lp2Uz3pS/CT+/pMYXJRqTXssYsJ7wjI7R7X+qG5ciwO4xiqCQUSzcglif
         ydTELKHh+OttyFrwibpJMAdhiLwYxHPYxrOaDQgWDiZIN6J5xE/hMbtGsHcVHfYey0kv
         ZRep3ZCoqCKoD/5J7rRIsh1Xy66FLIzjyemzZWLRrsQi/OnYXLY5je/W00I2AzK5MvhY
         l5DRfcCp5zVSKq3pYqc8MEvHQKEgrjnPSD/02FuqoUXaB862DgHjp78dvjw5ER/PTxC6
         4Nyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792483319; x=1793088119;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a5szgawaqFYahDoR6WgawlMOYcIGKmjMs7XIVNwb/WA=;
        b=XZMWIw4h5ur6PvMP+el4HUWcxwc7fNZ4rZlqG0jCWWGg+qJ9G2ioSKERCOMZTZZMY9
         9J9dw3E7lgSV5xNCkNt1Txd1IrQaGKmSkXPvyAO+/8fmxcDscCCUZuBgz3iUW6C1JIPb
         hYP6H7IvijEVzQBVNiYurjlX3rbj1eKN6bHqckaHWUYAzHClXXOvuMd6/8qPzevlYsNj
         Yhd+ySSCwAb4HhTi2btXMK4W5PW5tYyyd4XHK7bUvSNdcj5fKo57s5h0Hj+O3oTt1rIa
         ocIsAvnx+JMxiVYmEDcNSjQORJ1JDa2Ml/9fDLD4bT1bwGHgwQYGz+b8CNraK/B8lWbk
         XSpg==
X-Forwarded-Encrypted: i=1; AKwUvBzFv4YJwY/wCyuyWrtzj7m7nPVt8lx5qerNlSduBvTM9lFACFeb4qDOftKm7WK9LD79rBJtrt+5xTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkHiFhMVGPI2oTzHrIAnbm6kkZ3uyo4UzFiUtPwOQu7J6FsSsP
	hTNVu+JBIswhsKBO0YIazIHCoKLVw/5MlmvYq2uHVAi0LHcYI05y2JCj2hZLZmQrciUoPWQgEfy
	QyrioV1USNfma+udFww==
X-Received: from wmcu7.prod.google.com ([2002:a7b:c047:0:b0:4a1:f37f:7f0b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:638e:b0:4a1:e6ad:baa3 with SMTP id 5b1f17b1804b1-4a1e6adbbe4mr113338955e9.15.1792483319125;
 Tue, 20 Oct 2026 01:01:59 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:01:46 +0000
In-Reply-To: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020080147.1743459-1-aliceryhl@google.com>
Subject: Re: [PATCH 0/7] rust: io: add read-only and write-only views and registers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?utf-8?q?Krzysztof_Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 15, 2026 at 04:19:40PM -0300, Daniel Almeida wrote:
> This series adds read-only and write-only I/O views, and the #[ro]
> and #[wo] attributes to register!. An access in the wrong direction
> then does not compile.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I heard a suggestion that it'd be better to drop the Io from these trait
names so they are just Readable and Writable, because not all
implementations do IO (i.e. if it's SysMem it's arguably not IO). Not
super important to me, though.
