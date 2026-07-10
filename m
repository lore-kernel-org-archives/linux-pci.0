Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083043CECD;
	Fri, 10 Jul 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703127; cv=none; b=PjkL93lT5wJhYQD4svd7OM2WN2YJc0xHiXYRcM7pcwCQN/pb+avTrrB1djRoaRFh+/Fjy053mO8qX18omsbNH6PDcGCNXl8ozDVekoRKIMuwjxBaeplTQmqJhKIK/ftEXpJ5XN+O1Hp3ahuF0oH2Kh4We29Fu5tTEZU+xwMP2yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703127; c=relaxed/simple;
	bh=SbvsEl/jsXe3pPeqmWYbcDKzyu0okp/zsXQwwWwoPfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FsA1u0kajXIoHI5y2QZvYC3vquBSd36mwZ8IHCfe9QadPPaus+dkyrAFh4HUIWV/AqYPFMxkoLo88wwSzJzEyNvsz/A089gn8MQr0/VXaOIbslqNC15GB0Ln3FKWEhew9GC5aeEH4PLgxjafonEMuV2YSlGiUZ8IHQutjVeON7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjzk1n8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjzk1n8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F481F00A3A;
	Fri, 10 Jul 2026 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703125;
	bh=SbvsEl/jsXe3pPeqmWYbcDKzyu0okp/zsXQwwWwoPfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yjzk1n8PvbeU7ahJ2x3RuzjxdsYO6uN7r3NjNjZfktRo58Coa+40cAoq+jFa75y3x
	 65dy8wxPuceP2WKWTsQTe20mjkxeakolaJzB2iCcmH9o0n3ou1MreLS+W8F5J4olwD
	 BBoAWOX4Kyw07ee3Z22Rrw2eIy7/RUBNL7wGI9C3s+cTjC3tFP+29Jcq6ZU61oENij
	 QIKpYPAitn0scl3oxwYZxmFN0CRlKjmJ9+LjuZ8sN7iOhy+je9K2tpS+EHpaxxO1TA
	 d4wRzg3oQhlqW48cch6kxf3f8YuyPcmWXVQDgiw2WZHMn+lGIF/g94oGdCEK2nSZZO
	 et2Yr3f6eqtuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260710-edma_ll-v6-3-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-3-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:05:24 +0000
Message-Id: <20260710170525.53F481F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> ll_region is identical for all chunks belonging to the same DMA channel,
> so there is no need to copy it into each chunk. Move ll_region to
> struct dw_edma_chan to avoid redundant copies.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D3

