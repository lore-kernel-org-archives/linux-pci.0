Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441234;
	b=wA+wNlr2XNpzx+fL93s1BwTqHzTtTG97brbVr9jipM0Y/ZxF1wyQncz1Lv/ct+xu36op
	 TUy+VKXvAhDX3n5a5bPTRPWEIBIoNoYyAUHbzYJsUAorbfKuDnUnGkCPGfVBhT35xNdsd
	 5EAKnb0P6hwlxLiw0nonce+PgB4Bpdy5ifdMixResU58A0+5hUF0Rm7FNfrP0k+kvo7Ka
	 IFalzHPRWOXt7KfsgkeBpZ6olj0ojO/XbrWRP+Zet41RePO6UJHLvNSbvvoXLnfPbUnNv
	 +b6Nrz7OaF0ySesLhPcFQpbmzvBbYI+SNaZfFlTol+setbBxD16yZ2wXjqU/sNKBAow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441234;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eEyJoSlfbGcMFMoTjqG5bjCcDvGf20u5b7V29hJsISg=;
	b=Y84kDdOmb4iIoibIkKTssO/odifVt9VK3buAw+u6avwXiQsSQc8a/EHAIctW2EtuVuek
	 jW8c57wBa4jZdthff4HbxakxT66yW1HX0ydeetSXC3ticcCVWWXTHWAuirZmcgjrM/vgF
	 pAu893RbSlxMq3nJO/LoGzZucWIqFJ4LBLafOxIKiwKEDUgGas3OzQgUk1FHCUVYYIgky
	 nRsvchu5QMUQg3IvldWgM1vlWuCxbQKLdya4pBWh5XT1ffyuZWmtWe31FtP2AxlgX1+hH
	 l6RzIbrhXqjUUfEh+67yphZ85rb4w37NupWtvhxaJylS9vZyTJujh91J7tXFPSufe6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A1f7Eq/m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09F606A324
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1f7Eq/m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E661F00A06;
	Wed, 11 Nov 2026 23:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441234;
	bh=eEyJoSlfbGcMFMoTjqG5bjCcDvGf20u5b7V29hJsISg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=A1f7Eq/m1At9bNC4dzU344iPMTIy8m+J1Z/7riEFIPo0BmDTchmbWmJCZ5VfbKEhq
	 2g16hnPJs5MYow1wIG2abxsMpZPI7TgAXDy6ZDdYW5J7LJVhF2PGpCxpf/yFiHKMn7
	 UD44y1jflxK7YJWHrtavdcNQfQ4fq0dWXshWMpGJ+eTzf2yoZhHU5Sr4cOhJanykGq
	 pO7CNIMWzL5kZJ8vj7WAlfrtWEMtf1t2fHTTQVy+VOVl0IYzi3V30rUWQEj4niAaig
	 j5cGhfK8PAw037D76yZ7qG8l7YTJxlkCI5n+I8S++ILdw80Xq2m1RQpJaOpp1kaNBK
	 0EFTWjYZFVLgQ==
Message-ID: <sashiko-outbox-209864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/11] rust: pci: add internal SR-IOV enable and
 disable helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-2-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-2-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:53:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Wrap pci_enable_sriov() and pci_disable_sriov() on Device<CoreInternal>
> for use by the SR-IOV callback tokens and their rollback guard.
> Keep these operations internal so drivers can only enable or disable
> VFs through the callback-scoped API introduced later in this series.
>=20
> Stub both helpers when CONFIG_PCI_IOV is disabled, so the SR-IOV API
> builds regardless and drivers need no configuration guards.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D1

