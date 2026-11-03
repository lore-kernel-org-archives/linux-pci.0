Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723640;
	b=EG5GMua6QqU3eiHZtoBpLa0s3HjE2sM+XTD9KvF0Z2MrlwbMVSQQ9x1G5WK35pEw72Zs
	 ycUQs86FHch1rtyPRjj7CN+24EXjD8G06O6DmCkDRmHd0cyFYCsuSFAiqhMyydkXoq7wy
	 inojrKTdXMJPS030vHvAig2qEYktlCI1V+jc8D3EsrOK4TyyJ5inbOkdORs7g56ibp9Qc
	 u0t1FFrgxj+Gor5fNMx4WpfPjFdR+3fpJ5s2lqW4xAJRXNn+LiPjgc71v2GPeOITdbeSF
	 mgoC+c/85Biw43FD3qLOSAxfwaBZcR7HkSa0/C+MjB9N1MMOj0pjAV6ppN+ejexTy4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i2hgCtnojLERInC4l/UFO0Zf/9FJTg0Q3a1T09wWnpo=;
	b=bYTcgXtjMyHmuFMJHToxvkXixSe0bzVYfYdM8PYGzle0w7HSBiFGVKRPOjvPQ3qNgj79
	 jGDoeRtABIoxYU93hjgJDLnJG0eluMgIZzl/+MHqDSx0WB8j9qBtbH//cp/k6sX5yhGWY
	 0GW2WH84Y8OYCzaYsNXuH+j25NiYE1F65zfCaWhNvQX94NFm8NwOWGce+vxCwEQ5omeDf
	 +lKq1X3il0/SlQEHEjRCXn0kimG5buzY+6+SGSSyWk4M9EEI66YZ/zgArMa9hyQX2UObW
	 s8w+DmhKDthihtESzuoxI76rkUTtvTi7hpyGzLidyvfC8ve9egMbJSE8QOofaHwkPzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMnre9RP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9485606A326
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMnre9RP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BDA1F000C1;
	Tue,  3 Nov 2026 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723639;
	bh=i2hgCtnojLERInC4l/UFO0Zf/9FJTg0Q3a1T09wWnpo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JMnre9RPfw8RWnvi9ET/UshFg9d6f6aQ+68oIz36zs3Z2WjIIB2uOfd1S2VeEpN+3
	 2H5KOqt2JXr/hikw4zH8rVNCRZwcvieFfHpFUIaX4i33nB1aUVhqWTR41+D322TowO
	 F7hVv8mUaQ1QbOsp9R3TgLeylkjt7N1UgFJbNu0XWTiU2+3JvCfzsVOgjVlrktInT7
	 0PRdFnUAXV6vOinsKKqscSZnaoRLueUStLGOt/U0oA9CQVYODafIacB/Cc6ZKIGtHW
	 ZC2UFPsKlSFvaJ75jMKLHU35snc9F/HgG2CfEgZqF71u2cbjCb+1dIuHOVccPAHLRO
	 phggdxsuORtAA==
Message-ID: <sashiko-outbox-195730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI/DOE: Don't busy-poll the mailbox when HZ <
 128
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Clapinski" <mclapinski@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261103163101.1696520-2-mclapinski@google.com>
References: <20261103163101.1696520-1-mclapinski@google.com>
 <20261103163101.1696520-2-mclapinski@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:33:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI_DOE_POLL_INTERVAL is defined as PCI_DOE_TIMEOUT / 128, which is 0
> when HZ is below 128, e.g. with CONFIG_HZ_100. pci_doe_wait() then calls
> wait_event_timeout() with a timeout of 0, which returns immediately
> without sleeping. As a result, doe_statemachine_work() and
> pci_doe_abort() read the DOE Status register in a tight loop for up to
> PCI_DOE_TIMEOUT (1 second) instead of sleeping between reads.
>=20
> Make the poll interval at least one jiffy.
>=20
> Fixes: 9d24322e887b ("PCI/DOE: Add DOE mailbox support functions")
> Signed-off-by: Michal Clapinski <mclapinski@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103163101.1696=
520-1-mclapinski@google.com?part=3D1

