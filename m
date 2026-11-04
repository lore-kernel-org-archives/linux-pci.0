Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809769;
	b=hN1FKw7v5nBCBzOv7fdb7P7w54IjbEPwk2c9q8Pw6r6LpkxqjKu2ZI6j6K/fRPihjU6T
	 IoZHG4FicAoao6c1z5JG2+M1FHkLx5KULqJ0XYNeaw5Nmh6tIiPkCpiO6+ZmzotJW1af+
	 thhjwqLmdSdr7P0oJqjuHrfVSTYCmhsr/R34sC5/yUpTvwabRR4lis9hHXZndbrfgnwmV
	 366jQyYVI0FaMKejrMQVfzvNpG97FKygAmEtEQyzXY98X8eT7xcP8JGAIsiVLRtg+ZA28
	 LE67RaQ6KaIRTcXfJzJRTzKRmQXpv3/sMOKwtYxaD5nadQIKd/NTp8i94SVfDuuHFag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V7K5u+j99upniufw0ZN1RUfNunnEQHihU6iEn7dvhCo=;
	b=v1j7Y82KKpGGMLbTjEM+s0HP7l3RM99FSDshsQqrDNe3ALq23Q5XH2vx1+M7rltHNlsv
	 Gae4vtfC7zQ6wC+3fzVEZY4jbstmKxGB3HssZuQVT/U0cHIJI6NhrRXMi1zr6RJhziRTc
	 Z/CY2VpwCVE2ZtPTq9oO2B8RxBlH4TEk0BdgSGzCZeuw+zLFYTbURWXvb/di3qS9U1Wac
	 issL4D5qBb5iIBSLxHhBlUPPzS5rtbmD8gKaOXDf3Ohngb4GdaiL+VySvj0N2eIX78oL7
	 R9d8UNWCdWD3pZ96wwpMEXB97RS6YuJxOSbZzk8do7Xwxe3AjAy2lgXNLtTFhfLetLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQjRlIVN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512E606D801
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQjRlIVN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D1A1F00A1B;
	Wed,  4 Nov 2026 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809768;
	bh=V7K5u+j99upniufw0ZN1RUfNunnEQHihU6iEn7dvhCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oQjRlIVNQFt48SJsePx69NePWMyPCbvmcTiey2Qa2AQXtj79rKWNyHIbsFIUXSflP
	 26O6hm3YnF/EmLBnhyVJ8gcVftGr9pdHsqxvYAUL95EkPQ3DwOvTbUDByCh4YyB/Ps
	 8KXvE/ZTTSWZafNmhzNtaS5NItjyqoioCmTwCVZNHcoY1/u+Owde8x5UQKHEObT2A9
	 DTUMyoJIZ524zNA3aJ9Zvta3Aw3RSP+dnXHJdWwImVE6SYsUcYabLWzzAIRy7161QC
	 pVORfQItypXWuGQsThOeeqcquUtSHJFOIlDIg1R9Z9pZmatp6bKamFhJbI+U4HkIZe
	 8CqcGrrOGsHjA==
Message-ID: <sashiko-outbox-197611@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/7] dmaengine: dw-edma: Reclaim LL entries from
 hardware progress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161227.1742005-5-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-5-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:29:28 +0000
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
>   without callbacks, as in the non-LL path.
> - On pause, stop publishing new entries and enter the paused state once
>   the channel stops. Keep unfinished work for resume.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161227.1742=
005-1-den@valinux.co.jp?part=3D4

