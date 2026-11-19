Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087934;
	b=TfpM3elasFnI4p8SvWbvibyMfNAgmWdx81lCGxeWMal2R7+ZGl4W52RbSQyGzgeZUmDE
	 B6Pxm0OU1to1L6Hju2bEw+tHrvXMrFARLZhIN6CNqCULn6wP4uqsnb9rRX2Q6OlsKvagP
	 ils9RM9e0u/2zf5fIbB5U1Fv5hACUAuV1cDMT/1zNkJ3C4e+p0q4rGyX1HwekqI+9uSyt
	 zKWIrll1awiq5XpGczCdd1B/UE9yoeWfkZr6mE6kFnFNOcdZiEy90FZaK4uBij1QjyttK
	 N6wX5biE1lAXXyRQro0Z05YtCfsDY00SvsM0Jhq4SM4lJnXGEABNIcgJ/6zlUXRJ19g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6k3tH9TKN1TnGT33CUyucHXJ72SzaR3qOUPA5Uz5d38=;
	b=qVJzeuJRl9Ny/cHjs1Yke2yvsWtP+NhEHXobotjEMLxQIWZV8SUNrzsRCvFPTA/L3z9F
	 FBCgZa6DE9VSRTwvPo6jizYGW3oiMpwTqaGk9icKAHsrV2XjXvkxdRuAoAmr7CEoZ9oi/
	 meSNphPRxchBkRjdYuIi0SzLSgp9bIXK1nkHur/3jV4pMHIoNn37pleUj6THSqfw5Q5O2
	 VxnBaXK43mifyBEAxqGPdoKmn7XSTLh7RRYKq0THjZMbtF7WV8wSwNhWF5LX1VEM/lrAm
	 itG1wTQ6UZqLwg1JH4oPjxfIreLf0FfbfjVIh2LewU3t/3xKiui3Ph9U3dif00RbvDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqTUw5OF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA72606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqTUw5OF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D989A1F000C5;
	Thu, 19 Nov 2026 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795087934;
	bh=6k3tH9TKN1TnGT33CUyucHXJ72SzaR3qOUPA5Uz5d38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UqTUw5OFZ9qNm1M4Fk+DjcBKgGo1XyRhmB3tynRh3BMMVi1hKqpLjQEjTH91wGi38
	 qNXIz76lU2yfMyTvKAgoJ4rKvfoztSgjJ1CraGqNbEfQZLHVQokB0Indu67UTWcVhR
	 FcKQgsWMJXBAb30SF8GNHnwO/EbbWuH0cuBQDBmXQgVylaZTVtIREF2QwE8KTX4eO8
	 t1ih8sKFry5iYekJQS2d3hMtP/6vkJeswNExIuFdTkY3bC/faFiWm6nzau5Ku9A1lv
	 WzSZIDG9hePf0GdQFU5nL7AGcJpCuBm2Sh1SiT/I53nNejl3KvB13GYDBNwMbfI6Oc
	 emn9kNhqVbqbg==
Message-ID: <sashiko-outbox-223042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Enable 8 GT/s equalization
 fine-tuning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Kumar" <abhishek.kumar15@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119-tc9563_fine_tune-v1-1-b83c74bf1e94@oss.qualcomm.com>
References: <20261119-tc9563_fine_tune-v1-1-b83c74bf1e94@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 11:32:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI/pwrctrl: tc9563: missing Fixes trailer for 8 GT/s EQ
  fine-tuning fix
--

commit ae3834e64204d960937f7bf637e84695589097d7
Author: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>

> PCI/pwrctrl: tc9563: Enable 8 GT/s equalization fine-tuning
>
> On some boots, links on the PCIe switch report a continuous flood of
> correctable AER errors (RxErr, BadTLP and Replay Timer Timeout) at
> 8 GT/s. This happens because the 8 GT/s equalization fine-tuning
> setting is never programmed: max_num_of_fine_tuning_iterations_at_8gt
> in K_EQUTUNING_033_028 resets to 0, so equalization only selects a
> preset and never fine-tunes the transmitter coefficients for the
> channel, leaving the link with marginal signal quality.
>
> Fix this by programming one fine-tuning iteration on the upstream port
> and downstream ports 1 and 2 at power-on, so that 8 GT/s equalization
> adapts the transmitter coefficients to the channel. With this setting
> the links no longer report any AER errors.
>
> Signed-off-by: Abhishek Kumar <abhishek.kumar15@oss.qualcomm.com>

[Severity: Low]
This fixes a missing initialization step from when the TC9563 power control
driver was introduced.  Should this include:

  Fixes: 4c9c7be47310 ("PCI: pwrctrl: Add power control driver for TC9563")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-tc9563_fin=
e_tune-v1-1-b83c74bf1e94@oss.qualcomm.com?part=3D1
