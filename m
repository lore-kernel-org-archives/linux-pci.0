Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794060164;
	b=ZeShJFnhIQru4K1IoTRwPQmSj8I5x8huCYr2rN56lX5dyzOShvieZLIHWYJNow7VIWUL
	 8gxmthPJfjwOOA3uEH+0LnPaHbFf0499vvEUwINaCo/GC3Cb/P9J9FEdkgogL9DRefIdx
	 ssLO9qb5/CfI6zGhfun9OqDArTMly3hLoBxbtBV77Ct2hiT05PHel5a+c0mkF+XGAP+Xx
	 IoIAXQs6nCpHhDGIGOKyKLWumjfXUi5+R6CX2YvDAsHFGbhdsuPD9zj0tFizRuRu+TRdI
	 Dr/llj3H+Aj4nZO1OAlx/9haagAzYHTw4B3LepM9BIDvwl0SUkMBmQ6ZLWcAQvHl4+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794060164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1PeRdJ4BOeRza2imsKRJ532YkviuJV5wTq0WwQ7n0P8=;
	b=WYk8z47ptR8/ckFQCV2TU3sGMd8LKYq/k5huNWhYtiN2zj2q/aFv2dL5j5F5V5UosHRQ
	 VA6bKBoGaFAqR6g49pJ7QRmKkl3OFapaTE+KDPun0slNPPMAP0aFsitRLwu0xGFLevLss
	 YeGQXjct2wh1LUmBe0JraufsxvRqsIR1riDkXFBMWw14Vyxb/YqXCvPj2qR0Vz6IAyT+Q
	 BSq/5A1iwUcLVloOTN0+2/kqnrJaP+/hMF/TbqoiOQW9k+NjHlJ0hsrglV/XC7wKajQDj
	 EH5UVQY6x6mJvDPA32vgLQKuxOWO3ifY3hkc0P3yX1Wr2MBmGq4yr/M92fICxvJr3Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c17JYYrl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770C606A32C
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c17JYYrl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690401F0089F;
	Sat,  7 Nov 2026 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794060163;
	bh=1PeRdJ4BOeRza2imsKRJ532YkviuJV5wTq0WwQ7n0P8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c17JYYrlXujchYfXUZCCtqKTqujlNvzIMTUKk0lEvbFSG+j/L//QfWwfMWGd8pLPL
	 P24h/2AOIHRC7+qUbzKHBqPK/R+8l7MTo861gi6tSoCf0G47ExZJMSlxDRb1KFj5te
	 JOHHBbgMRR5jRq5orzFpxA6+Ib4TNcV/Lsyx978PgUO1+5e+xNIUc4M4/ZW6cQeBe6
	 qvS6t60TqZqrcA2/aJLd9Wpklv1ijcdyYtwzK9hWEnOaRAkT3vHbE8KE3FzBx9/fiP
	 xHyunsVvqsmVZ60VO3CJUKWmUpyHHghIpH93v9ELEfUmI3UZgLRjKWK7NpMiiN7Y2K
	 ToHQxt+2jrc6w==
Message-ID: <sashiko-outbox-202937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107133027.364237-5-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:02:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> With dynamic appends, a DONE interrupt no longer means that all
> published LL entries have completed. Prepare for this by using LLP to
> advance ll_done and complete descriptors in issue order.
>=20
> Reclaim completed entries and refill the ring as space becomes
> available. Restart a stopped channel when published work remains. This
> also allows descriptors larger than the ring to run in batches.
>=20
> Hardware can keep running while the driver handles an interrupt, and
> LLP does not always track payload completion. Use the following
> exclusive completion boundaries, where idx is the raw LLP entry index
> and prev(idx) is the previous data entry in the ring:
>=20
>   State/event          Meaning of raw LLP               Boundary
>   -------------------  -------------------------------  ---------
> [ ... ]
> - On pause, stop publishing new entries and enter the paused state once
>   the channel stops. Keep unfinished work for resume. Reclaim delayed
>   completions without restarting the channel.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107133027.3642=
37-1-den@valinux.co.jp?part=3D4

