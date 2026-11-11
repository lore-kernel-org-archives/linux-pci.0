Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794426011;
	b=rr2WdY2V3xEmo30gJ53VeYQd1HHTvGy2F+6rkpaIXSnBJ5VgmwuzcCwzcGySxiMqo8DJ
	 ZvQ1hlkUNPIttV+Q2ApGFVIfMd+oIHAxNOM05nMst2UPtEPBhzrRVJaxfKP98BwE2QCRG
	 NRGwSamSz89nnSEG0ATWJvucd4FCh9Y4bSIXWfhpGdaD0gwo3+DYyWxGmB2jvbg21kHOM
	 wvscAifEYcKCmkD6TH5LBNDyUCbVprWXkb+33q19ksa9NYfEet/hRQc72mxhAdHFItfUM
	 wdZgtfHzgaqc26hzjOZL/l8ZsndoyPWDrEQkmCcflr/PlZ9P7Xh8pn3tw2N0QIMfYCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794426011;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pm1bcNRE/uWmBZNEFN3qJx6pFv9VqZlXPRNn85RgFic=;
	b=qLOAMFXrIbN8zMa+Hglq6pNjvfr9UUQIwwm7I+q82gleC/UwQ+2yeAuE/MZkIpH4KdpF
	 Nyzy+Qjsq9q7itnNSEO5WKwUfzxKdmOL1V00X/ntgWH97OzzpX6TWJ10bTTcWAZD8m7m1
	 fYkwL6KtUuBIgyBPFWqP8AfNuDzeplVjorfKwnA2DX9AdxvNhWEBtVnqq6nAKbCC1IyHO
	 yWFPF5z0yv7WPmWi/JcGnCj2m5lOHOdzy4Mx17ShSTq2L9TULq1fi2K6vy/Ya4oaoOk8e
	 2VGCLEH7GY4+WZwcHWw6vvrQ7cp2v6X6tlpjM3YNAZRpyqKg7jSOwTZvHoBrA82eSjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ln/5XxUG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32A606A33C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ln/5XxUG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D471F00A06;
	Wed, 11 Nov 2026 19:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794426011;
	bh=pm1bcNRE/uWmBZNEFN3qJx6pFv9VqZlXPRNn85RgFic=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ln/5XxUG+bFcM1XZ5y111kk8/ttkT371WRE/fAaPqiy/sxKD43dnqH+siWaEaEG3F
	 /tJWIzizH5ypUlaBwL0FKJtJBsmTyufzXrUJHouWAiLyyAaMD4j3anr+6EdDBQSODM
	 45Tb6CLRhwIqZOuQAH2KIWqVnhX458G7UoEzb+VUcWv66WDCdAuh59CUiTzuUkgV1W
	 qbviFnLmmVz1LFKLwwWnFFHrGl05OtAq/PpKGz7uIfWDVdGUMAYdEwwKvfwG7cQxXD
	 6ho/JY6sMADIwRL5Hpe2QZoQMfyZ4GV6UFNXkAa9jnMLjLX9OidqacMvIG8bYCeSOy
	 u9l8yRTGFGSxw==
Message-ID: <sashiko-outbox-209584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/7] vfio: selftests: Add iommu_map_file() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111192411.4133780-6-dmatlack@google.com>
References: <20261111192411.4133780-1-dmatlack@google.com>
 <20261111192411.4133780-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 19:40:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add iommu_map_file() and __iommu_map_file() to map a file descriptor
> (such as a memfd or VFIO PCI dma-buf) into an iommufd IOAS via
> IOMMU_IOAS_MAP_FILE. Also skip regions without a host virtual address in
> __iommu_hva2iova(), since file-backed DMA mappings do not require one.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111192411.4133=
780-1-dmatlack@google.com?part=3D5

