Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504913;
	b=yWwbGR9wpldcG3ILrhDvdM44tRUli2z21KDxGxPg57yc3gU1XlH3oGgxa8taA0pfg2hB
	 tD9nzdvRVoLyDZUZSjtVjU7wxNqCw23WwgBhseabSJpehHjUp/c2bWFDDUHfDYxXn6l+I
	 Jkk9GulBRvD5JCuTDavxNdDeLUSwZbp3Mzv7+cLHqTFiPUvimXqg8PC2B/ZN5jH8l5QUQ
	 h3BXKP+Wtx+8x8Eo6Hhtc0Yqs/Kh+uQPnU5GKj2R1bUCskTS7KIsvSRsgfIM0YZnpddpA
	 7ZH6He35MeXEZCvrX9hP8yQzzpzCTBOMVAGbm5DZSlPYbzw6hKi+xh6xKPW/FrdG5Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4WqTnmYwNtZuc8yE6m3Wj6x4W67f77rHRf4agpevk0c=;
	b=lhfOUpCmFl2HN1I9vpyzroMAuJ+Pyz7vrrFx/1cH6IT0G8WTHaNl9bgzZVp2x0gateCa
	 icxfZAjV5hiWCCUffcBR3yjKSznBt6EgazrtroQTgUpkUn2+06hy3COAIAstI0krnGuiE
	 eTHLir7qcDcWZ4Czy2R9+I1OpwcwBXifluefPKeqmhozDg9et1CJrM8L1WLOlXz/zWrTi
	 447R7pqa0OAOq9zZfA+S67bPk0jFuWl6AnrkRWm+Pd7Ad5W85fAUS9aW58OgNP+/g7y6F
	 FDiA+ryKvbgjeG3mWRvI2w/ZHBDT3v28GchDTFv1Kp/Fwiwku2Utg/lAS9F3zHh4Hxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=de5rgw+k;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882C2606A31D
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 14:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 882C2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=de5rgw+k
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so27706415e9.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504912; x=1793109712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4WqTnmYwNtZuc8yE6m3Wj6x4W67f77rHRf4agpevk0c=;
        b=de5rgw+k1ip+RCToB/0zFGwdEzw6BeOZ2hldM8GnpgRW5HItuajq1CB2OZ12a91oI6
         UbLuHxn5jG14aXCRRM2hRvhkbFsnaoZeb57mzykK3ZGVKe3/1iwEJOSKW7vIihvIRF1d
         YgVrEbUv9Yi7Cm/Hkol9PQmqddnBUf9JHCU2gTuKaLvuebg+LYdywGrBaMs6MjzfJ+GV
         mUfZdnZZ07tRCgpvR5t2zQ0IcTcNepxuwJBYf6YGe6Me6Mqs129kb81o+AwlwePxrqRx
         8HBQHf9hjJ49kJtPAZPJ3gDhEMzLFqRVHeORumP5l0zcoxyah1mMb/yN+6f07egIszKm
         Lp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504912; x=1793109712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4WqTnmYwNtZuc8yE6m3Wj6x4W67f77rHRf4agpevk0c=;
        b=yx6Kp8uvICMardGUztz4O01LC7Gak18eQXe702g0KWc3kSpyPYDjFTzFZxll2B0Ll8
         EkRK0l2hKWV1KkCTOTudhm/1tYcQONL0Q3yPgmD8sYZOEGqJ+nKabZWoNPGqyIgHTw6p
         jnVNb9AzPDNFyTz5OrUvDjKB5AP00C5Of34GYGP+t2gSE7z0p4Wv6dPI4iSLXzNXxT9U
         efGwpUhgo2rwNRDWFrX1t9n6sh+AUWC7JEq3QBDEl16T26Z9Xty6BT5nANPVy7gvjG8D
         DT8GaAIwcWHkbOejSpeiRA/v/tpiRcBHwjKT+DzObp3QoawZXGW7RNrKYeu6Bt/zIw1P
         7EeA==
X-Forwarded-Encrypted: i=1; AKwUvBxuXgT9RJb0ygDRR4FjO3gdEokkSM3ldKbbOsy9nx15dODCCFB4Ikb7gvKTzYBCCDK659l37s2ZnS4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLo01iGypPxyUxjBpgprR/nVYkeF0V++wQ4rF2WpYHwDONWKJj
	VFXUbXvcb/30/1wngNyCtGPvoDNUoW8N/y0v1ovpPN1pPnLtUcMj7k4N
X-Gm-Gg: AYBFou3J5TLUdZj2T91HKctNoVAyc4ZS6x4gZDkUKow7db/g8RPsdInki3QqBIK82Cd
	ulrMsVuslht3xABGdzu0bregJ9frQm/3ZRW8pHBvwgdP/Mhn19VgKYae9V24F+UKLiTBgxVACCK
	JoQI2/OOMEaIASzW0TWdL7B8hd03R/8UvRbt54RY/K/M6rgH/ZBocncprbqVpgyACXusFzHk/7Q
	bCXnxJs+FQ2oztMc1gRgFIAaAOwNmQqjws4OegHYo4ldVAMnn9A1Xj9ONVxMzFuNH0JUrG2+qzY
	9FryhgsSnF8ACpFOPFsRuc525Kqj3h5jNhmuCqNjX4iRDz8u8uN1w3Zi9k8+5eWYMMAP3mYCoSr
	Lo6Zm869ntGLo0Q7ruI+wCcb/EMUfAmzoodpvD5m6Qsrg53qhNBUH4Kur0EmdcQl/57ym5mWB56
	Q6NN/hOexOankBw65jmgys4yCbzfGyjZ/8D5na8GRZACwLrjrEE6kE3THru51tEiIrB9VW5f6h9
	39dGcNgKjW8qwcGrbVc+QA48ikBL6vtx8wTNrWA3b5T1EErnr1b9Iuf6vM=
X-Received: by 2002:a05:600c:4f95:b0:4a1:7bae:d80a with SMTP id 5b1f17b1804b1-4a1d75e3c9amr244362825e9.9.1792504911471;
        Tue, 20 Oct 2026 07:01:51 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([150.251.170.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d324f8sm67581075e9.6.2026.10.20.07.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:01:50 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:01:46 +0100
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/7] rust: io: split IoCapable into IoReadable and
 IoWritable
Message-ID: <atd0SnEL1ZLXHxVU@C422HJQPQG-Fractile>
References: <20261015-io-access-modes-v1-0-93611b84b5e3@collabora.com>
 <20261015-io-access-modes-v1-1-93611b84b5e3@collabora.com>
 <DM9NGD5R8AP9.C4K59HIUYFDQ@garyguo.net>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM9NGD5R8AP9.C4K59HIUYFDQ@garyguo.net>

On Tue, Oct 20, 2026 at 01:04:03PM +0100, Gary Guo wrote:
> On Thu Oct 15, 2026 at 1:39 PM BST, Daniel Almeida wrote:
> > `IoCapable<T>` provides both `io_read` and `io_write`, so a backend that
> > supports accesses of type `T` supports them in both directions, and every
> > (non-copy) `Io` method that reads or writes a value requires both. There
> > is no way to express a backend, or a view, that can only be read or only
> > be written.
> >
> > Thus, replace `IoCapable<T>` with an `IoReadable<T>` trait holding
> > `io_read` and an `IoWritable<T>` trait holding `io_write`, and implement
> > both for all existing backends. The non-copy `Io` methods that read a
> > value now require `IoReadable` and those that write one require
> > `IoWritable`. `update` and `try_update` read and then write, so they
> > require both.
> >
> > The copy methods use `IoCopyable` and are not changed here.
> >
> > No functional change intended. This prepares for read-only and write-only
> > views, added in a following patch.
> 
> I think by Rust convention these should be named `IoRead`/`IoWrite`, but we've
> aleady named this `IoCapable` and I further made the mistake of adding
> `IoCopyable`...
> 
> So I guess I'm not in a good position to ask for name change, but we should
> consider it. Apart from the name:

IMO the -able part is quite important. As a reader, seeing `IoRead`/`IoWrite`
doesn't tell me enough about what they actually mean on their own.

> Reviewed-by: Gary Guo <gary@garyguo.net>
> 
> Best,
> Gary
> 
> >
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > ---
> >  rust/kernel/dma.rs    |  12 ++++--
> >  rust/kernel/io.rs     | 101 +++++++++++++++++++++++++++++---------------------
> >  rust/kernel/pci/io.rs |  10 +++--
> >  3 files changed, 75 insertions(+), 48 deletions(-)
> 
