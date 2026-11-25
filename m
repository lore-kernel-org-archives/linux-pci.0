Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596205;
	b=DyFs6t3z7NOVMgRLCj42RNnIBT+RqKUUzCvMXLovvpAzGPGsARJegFIfBq1EtgRdTdzb
	 PD8inFdNl0cMhDaki8FxMoANvnMcEiZpqbRaEnaP0Wd8nQqCNaVVlzCe0dBAldC4DTegc
	 LAMpHV7crJ+Ghn8o2lXx+IoOtaUnRBvx/UIi2OlCu/1wyGMsm5/w4v+gYWocZcTDD8lGy
	 K78xWBkmRW3l++4HHzVsRxtF0PCVuLRHIxs1qgfTG0EWkgUF3vOpf06PtQ8ys4M/9OMuX
	 9VKKf3/HQtjxu7ix31phMciq8TMjTjYfcoGc+5gBqSJ5hIOoVrRhZdRba/GI97+8Jwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596205;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hOwwxvZre1MCLKF3uct44L/YZ+BX/ny+Kif0k4HwKQ4=;
	b=39osTz9bH5XIUhYvYIvQ+x+83+B9uYYs5zk2VFlK7fnNm1JRG+Kq19MYZdIh5t/OzTxw
	 FBlS7Gkctnaezu/d8cZTmKBZOQcUMT96/54OJ9HXTRfO2vzZmnNvij1/GsxKq3ej2Z9BJ
	 ezq0ZuHaoPGRRlQ1WqxeLjwDeRwAsrxfFgn1R+s9Ev7Nn0Vu6F3xE6iY/UXLfi1J2SUmm
	 oVlS85otMExLcPJR0M1qtM8PfpxPXvyFcQgQFDUE0qVaBy7mfmGIY8G2q3IgpDuq94uB/
	 bXuCEvhE986aB+0r3vW3HJLjcIl1XxvevboGyBns3CdcK/4mrxGwglK337+jIB23m+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXdMTftG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3C606A69F
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXdMTftG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47E71F01567;
	Wed, 25 Nov 2026 08:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795596205;
	bh=hOwwxvZre1MCLKF3uct44L/YZ+BX/ny+Kif0k4HwKQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXdMTftGZzGfy3CYOz0adQN1py2AOcLpFY/Q/v+AavawPyZCz01p8OMIh/cP+Hrs7
	 1fXj32LTy6fxsCwcswEGo8XKYkllhQ8evVUfkNqlN4Tc8udwVQQ+ofA0Gp1jwC2psn
	 XD68/64RevMSkm6s2IZ9ebTHMIpD0Su2cq9VeG/wY5mr9GnQA2DiYAffmLGYdWbw0m
	 q44RQaCfGb7pMN9D1HJOnXqhHMHWI2HJckBEg65Ho06gQ1LTtnxvUmMTqWiWkGFfpm
	 lJeAopaBcN5pn1DVQEjBlalS9HRW7SLk6psACbkJ/BVOoLgH1l3JZhi+ehFeu6m/pI
	 HEMAIYRg5jaDw==
Message-ID: <sashiko-outbox-232930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 00/18] iommufd: TSM-backed virtual IOMMUs for
 confidential guests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125081121.379481-1-aneesh.kumar@kernel.org>
References: <20261125081121.379481-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 08:43:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 18-patch series:

- Patches 2-4, 6-11, 13, 14, 16, and 17: no issues found.
- Patch 5 ("virt: coco: tsm: Register the TSM class before devic..."): 1
  potential issue (1 Low)
- Patch 12 ("iommufd/viommu: Select vIOMMU operations before allo..."):
  1 potential issue (1 Low)
- Patch 15 ("iommufd/viommu: Allow PCI TSM backends to provide vI..."):
  1 potential issue (1 Low)
- Patch 18 ("PCI/TSM: Wait for vIOMMUs to release the TSM before..."): 2
  potential issues (1 High, 1 Medium)
- Patch 1: skipped (not reviewed).

Detailed reviews have been sent as separate replies to patches 5, 12,
15, and 18.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125081121.3794=
81-1-aneesh.kumar@kernel.org
