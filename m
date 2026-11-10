Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794301064;
	b=AmZmeaysTSKo2uYXIL3rYupkuLha6+mSfoxF+SRV1AFnjx7yEnvqeaRVLwADu21+n9wy
	 I4jYueD1Eq7QVTQ+2HnH3LhII/J6vBB43hAkMpvSAbfm9otWDNagKkueyhJGCaDzCnnOA
	 3zyIvqSvaYWtkTeaySjHguXbs+zHZlJ/MqtO+mo39IzBwPbw7US1Sch/l0ipjj6pXQ9d4
	 NxcpMxwTvOLC0hmIxR/z1BgXnGEqxo/4gsoDxiBsuieX+gthOBIBxjZzUl8mlOS/F9r1e
	 SBf5Cv/ARDH8t8mcaT2486ekPoWyat53KaFrAY2hHecQozgdcIIm/R/uHS1jbDRNbeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794301064;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NvDHV5wuVSsX5iSkljsSHAQllkSRsc8qL+0YHTww/pU=;
	b=o/43HgWwoyJAqLGxTppx+M6Ja+jSuyuCl1sTDnzkY/ru/+01wSOHGp3Ic/hKYIRKLOUv
	 jIBrKsGewrMbL5AJzovJmUfWIiVgiAmZGHcrt0z305ulI09azJIVkl524NQxBzvJ72CiP
	 xy4FJG2JMOkitEBQ7J6pD31S1kyHVsk+DT/lK4DrV0Gr4y9tUM6wLNYX/uZk+mXVrMMQS
	 v62z5N0kk28LZJKLPXXfKzJ+CHRKxAXKfO65QxHrGu0F60yL5Gy682/Gfdq2SmkhG/TFo
	 UEoRDEJ5d2ZYCIyoby8GR2RAhmFHS3UhVtC01uq6jjzCnKwIzEzv1/vVCqfK+9iIUkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="osiMz/qW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B585606A32E
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=osiMz/qW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9D41F0089F;
	Tue, 10 Nov 2026 08:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301064;
	bh=NvDHV5wuVSsX5iSkljsSHAQllkSRsc8qL+0YHTww/pU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=osiMz/qWRrxLm9UXgiDWDHX0PYrTFtuCp/xNGiEG6JG1LsPUmZn0PWUTSyaBOtpLA
	 BWsmxJazp/fL6BZR5yeYJ3G6y8QzZuEharST0awGz51SLy1uKe6Ny0eEdG/FK2sFrq
	 RQuvR0PyeqAJbZ5DmMkEZpW1qC+x3a/54soalXY/NJGjkfZnYVxLZiESTd8u/0CZU9
	 PXT/RbQk2znVnWxoDWTct9SLSaPpdX6ZpbM2WYyXD8VDsHzulYEwiDEIZBFWbf1SUu
	 yolTfg39r16HEuJkU5XgxTlR4MV+BhMLztXABH8sSkpg9iRCBGIJLkeyswVQvxVURo
	 tWX2/d+jrgSYA==
Message-ID: <sashiko-outbox-206680@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110082459.1798763-7-den@valinux.co.jp>
References: <20261110082459.1798763-1-den@valinux.co.jp>
 <20261110082459.1798763-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:57:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Some endpoint configurations have no spare BAR for DMA resources. Allow
> dma_bar to select an MW BAR and place the DMA ranges after that MW.
>=20
> DMA submaps have fixed BAR offsets, so a shared MW translation must
> cover its configured size. Keep the power-of-two restriction used for
> ordinary MWs. The size must also meet the EPC's alignment requirement
> for the following DMA submaps.
>=20
> Older hosts treat the whole BAR as an MW. Fall back to that layout when
> LINK_UP does not advertise MW/DMA boundary support, so that NTB keeps
> working without DMA: the enumerated BAR size is kept, the MW spans the
> whole BAR and the DMA submaps are removed.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082459.1798=
763-1-den@valinux.co.jp?part=3D6

