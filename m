Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293FF3911B2
	for <linux-pci@vger.kernel.org>; Sun, 30 Aug 2026 11:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088930; cv=none; b=k4AeDtiFQqy3y1ZztyCa+c7+EnlhLOwRrP/TBALMiTQZ+uhppjlJTtN0AbX4sKLV2dKAAK9ffDMz4PSWwf7hyruYjXKIlRgLDVwCZdyQR30YR74vBUlG2z8SRLt5qR0zTddcpsG/kIGqeeNYDmBn7TCFI8rBYDAsZTW/1qXZ3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088930; c=relaxed/simple;
	bh=eATVPs/sawk5Zls5M3xBg4ZU7K3qTfG/6pVe+wDLm8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pLBFUuGnD32iH2xm8sUdi10aylEmDzaGhYkRZI8xv/kRBy5N0dvNm8kACOcpwQYyoAqwbT3RIcZ9yxrOEILTPdJQrweEbe3EE4UXNHmRwk5uibr9p6VI7tI/0iV9yyfSbSWpeuzOpCgl67N5Z5Iv2fFcV0Jnk4Fll1LbdMlCQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pafa9yjo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pafa9yjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0621F000E9;
	Sun, 30 Aug 2026 11:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088928;
	bh=eATVPs/sawk5Zls5M3xBg4ZU7K3qTfG/6pVe+wDLm8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pafa9yjo/j23syklMtay2wJrLT6/mT0P7Ze/ZvQSOT712QBLkyDS8CK8/y8gBfLTL
	 8BoQfbEuHHpqVbSh/1YxkQAVYRr1kTEtmbF+/yFRTJHsbuUxsIN+jyVZGy+5Ibhq9v
	 Dm89vgMUPwLRg9c6Px0H9+3RNYMDcenNsXFe//xLlYxt+xAGBfihov/CgaiFGB9QIQ
	 AEXwOtPXlWO7QO+uLPD0rOP7RMHpDDUb7+YD6vc1Wyi3NN2gzuyWSMG2y/5gxiAEja
	 2Q/Xt9On89eCmT74K2/t/2T6lhHmEohXn+tBdmTSG10ZSS1B0ZpoZL+YqC2OgcR8YR
	 0iimOamxl9NUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] PCI/P2PDMA: Safely terminate ACS redirect lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260830-batch-p2p-fixes-v1-4-5044e8dfbe2e@nvidia.com>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
 <20260830-batch-p2p-fixes-v1-4-5044e8dfbe2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 11:22:08 +0000
Message-Id: <20260830112208.AA0621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
> path unconditionally writes a terminator to buffer[len - 1], so a path
> with enough ACS ports to fill the 128-byte buffer writes one byte beyond
> the buffer when verbose diagnostics are requested.
>=20
> Use seq_buf_str() to terminate truncated output safely and remove the fin=
al
> semicolon only when the buffer did not overflow.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-batch-p2p-=
fixes-v1-0-5044e8dfbe2e@nvidia.com?part=3D4

