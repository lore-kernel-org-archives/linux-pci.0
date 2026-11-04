Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793780862;
	b=Le7eMk9skyc26YGpAfJpvM21tPzZqq85EJI8cwHmQiArAWnHaZROQJfq/FRC1jNBjuM/
	 xJJiyhnCTw/yjVLEM7wXOXaiPILZ7j+n43kPARHy+8UcA9ptEOOniDYLqZ/Wf1uOCyoov
	 umh3BGPpKP/7yCTmLrVRWkKk+PYWclZ6fwtzwuubQ5cNuGy3DqxK5OFvYgwXot7fDptGS
	 Y10AiLtMFMEPH/YXxe6nfSX+Hmj9TXSyRV+qRIt1hY6j6HuyjHR9T/8k9/u6HhOzGQsit
	 yyguHEWzYaDycxDXa1MOmV1un5RwoMOhLnsYNhcwHos7gAP7d4hMIyuf7xhFp9u/V/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780862;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=znf8wNis6QnD6Ccj8p2IhxvCPFxSfNs5BrcZlomgFGs=;
	b=NrUG5L4l4CwBB6W45rStcRvT7lFqB8cuwk0IIKs2zUX9jwcFwsy+PhAcnp4jyt4WIlnR
	 CutvkGGfdD+g0Y/Alie9mN4LD92DmjFH41V85ki5zV28R+cdIIkYJ5FjVzKunyfru6+2A
	 j3141pjie0Yg1n9X34av/0qdiS2So7TNKpCDgECsXK6xN/UxB+DRAFLHstrYdA2n88jsY
	 9TtTu6HKq4UO9o9UzeqpfLkhBszmnf5HiJUefgisLekNySu57+D1HTnld1a7Omp5mJFST
	 WfxWt15xdvKi7q5PveqtwnnGESoOPr1tFzFUySnd+yRimqgfWb1CeCRmsyVIKoNNPfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ff9FHVmo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6D3606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 08:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ff9FHVmo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782CB1F00A17;
	Wed,  4 Nov 2026 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793780861;
	bh=znf8wNis6QnD6Ccj8p2IhxvCPFxSfNs5BrcZlomgFGs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ff9FHVmomL6PYCYVfGrWPgG0ijerRd5AXQECetDU4kl4EaS98cj1AM3dUkm3xGJ2N
	 /WXvzvyOYHtsDHrJDLzWW6nEXwi8LR280/aekN831rIooomP0pNJXJU8GzDlKjjMVm
	 QssBBn3nnD9Tsza5Ja6PsZo4gWxQJaNURGchqMuuLbyIC8M0qnmso7J/l4G/Egppza
	 w6wL9d3K0sm1UER27Rw1YApL+U5JdpCsVGKh+3bRmuEFEcxlVRtbDu6CVsK32gXAvA
	 Q2x0W+kH9LTSxJbGsebUR6WfyHpVAUpFWDBTorja7NdcLWdj1aBH878zgm4gY7ySo3
	 +Usyhff53S7kA==
Message-ID: <sashiko-outbox-196876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v3 2/2] dmaengine: dw-edma: correct IP name in
 xilinx_cpm6_dma_data comment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104082302.3819409-3-devverma@amd.com>
References: <20261104082302.3819409-1-devverma@amd.com>
 <20261104082302.3819409-3-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 08:27:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
> fix the IP name typo.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104082302.3819=
409-1-devverma@amd.com?part=3D2

