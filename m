Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728762;
	b=SWPimulQX3yFp/Ug7Wzf8DfpPopv6JeCM7cBqUvwnrzXxN+47oC3wvdmd6XyTEvnEAQl
	 RqoWKlY1WbMcn6jw5Jyozuqz92DTZbeObWSffeSqkz8J/gaphvGpdEWDQS2C2LLgWdg5G
	 W/6CFa1gFVF6V6Hdm645kBwhCZ1oXUXkEGZpmyuORUAi/7U2GtIq90MPu0X70u3JtKD2w
	 A2teSE8nZ+oMYt9UxL8b+2SfInth9f/59e+jZZmyv8jhWsjpS0mKofkXqgTcqCR3W7+WW
	 buq5fwWsL8zl4pLnhSlj0Hwbvjh4DFURtCSL3i8gvob1x79Zdh6cA1dmCtiR4rlNGjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728762;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zC93gt4mJtbhsrmyrIyMtMIOGhIGcW7B5VKwYU00pX8=;
	b=2mgNwUESYY71sS0oytJ5bA7YQD6FVqnRPuGpNdTMYOHmtFX0+gx1Dq0ziClf6MCGCtI8
	 CbuclXDsxstKhsr60rOVyb6UvbJ4DVzE+mfPbneo0EYwPGVcirEQTzEngoTShsTTIyrWN
	 Ta1hiso/7GFdnB+Zz7DpWYiXRaiA0s5KaboCH1dlO2jnd3haDwMUV6SxZFbQmgNpAR9Tf
	 3/ER28Ev6bEXxK+fDTg6HUYN/6Oa64Nhe+AXLoTjIZcABcjnPqF0A+F0AJDlzwXI2Srw1
	 5O5Bd1lCrU2CO4e57HjY0dqN3d6tD9zk59Jo27LI9p1u08XD0X2L/qVirQpfl0RyNvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIjBZuiE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECC606A328
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIjBZuiE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D075E1F000C1;
	Tue,  3 Nov 2026 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728762;
	bh=zC93gt4mJtbhsrmyrIyMtMIOGhIGcW7B5VKwYU00pX8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QIjBZuiE7zZudG0N3bgs+Gl2YHli3V660TiIatq5kEqkCHRxeMbeZRNB9EKBFB8m4
	 pGXZFCGMWvPQWFjL0/u7Nb8OqSJ5LQjslL1yisyMRgFJXfukvruf9XgWbgQB8ceYvr
	 RjJW1ldlgkoiNPNNKMzF1Y7uqMp74WqLZIb3XyhbGkdVJ715XNybSKqmUUwdWBts+/
	 NtiWXz2KN5ZVJtOKajBtV/f7esGbfV7Lt1ayL/N2h0JGyrvB4mgP5utx9e5Hiv0Tv3
	 waq8kpwAXeK16NO16GzH2WtDSaeQrGZRKDvFr1PcKmiXKYKFRInuh/vmuVWrMBVjwb
	 LRDy8kM+VjUqg==
Message-ID: <sashiko-outbox-195796@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dmaengine: switchtec-dma: Add Gen6 secure device
 IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261103175208.481170-2-logang@deltatee.com>
References: <20261103175208.481170-1-logang@deltatee.com>
 <20261103175208.481170-2-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 17:59:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add the device IDs for the Gen6 PFXs and PSXs secure switches
> (48XG6 and 64XG6) so switchtec-dma binds to their DMA functions.
>=20
> Based-on-a-patch-by: Kelvin Cao <kelvin.cao@microchip.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103175208.4811=
70-1-logang@deltatee.com?part=3D1

