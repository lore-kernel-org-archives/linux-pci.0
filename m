Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843331;
	b=LRzbSC4X/OqbARDUV0iPYO9dswsiBVvFGLsxqXtcH1DotR2JxFoGULld9xY8dw1HeU+b
	 ofrNFAwl4GDebFkhHryoLFT+cwrBDGB6NH4z4W4h13GCeBytX+0hOA5Obt+eEYoSwbgNz
	 dsnad3U8zbC0qpX2UjmpaGs41wticafL5TTEhAOQxh1O7Xp1/KlVq5zX8SyIjSB/xXzo3
	 znTtuEEi6b3vBE7zv/9kexR8wFb9eN+ETsbfzIRaYlsINUzBM4KL9ddC7QqswW89L15iO
	 xYqzZSCXBaAIvMywhuYz9aDp+D0B7RKbhgVmzvCBo7vtLl/ZHFQHxcocFa0+cyElzkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f99RHdEYwl+u9sZwLi8l93FHQ+iHah449dn4nwVPkng=;
	b=SNaaL1FjX9GQcR5Tpyy3u0l2uXho2Hd2W7dqsWzyEsWP0Qa3q/XcCtkoFuYosFcIeE5I
	 wnJSwmSz0W+K6HcK0aDJHa+74vfPicxOU2Fec0ltBs5phfkoLE/g8U3r1H3bJffPaA4b1
	 BWp6eH5echYmfbqSs14o3dQpczNG8yTnT9pbnWt/6a35ZdEqryLM+Mmjx0GUNBKFuY9xR
	 ebDz1NAfKCAw4ZEkUaAIfqj2ct7L2ed7jd1dg3tVHg3KvnHaWrx4KK4FhsfNb0qnGaYA+
	 +2uoQsnacoNeQeMSe2Ue7xE9X+mrM6dluJf9IUaT15q+ku9yrAzOxSYFs1Pm1TOmq5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNi6IzLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8EA606A334
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNi6IzLk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3071F000C7;
	Mon, 16 Nov 2026 15:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843330;
	bh=f99RHdEYwl+u9sZwLi8l93FHQ+iHah449dn4nwVPkng=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=FNi6IzLkp5dGjwwdO0cqg4tEKIyygn9rMoNbittTcmWSQIsVBU4B7cC71oie/LYNE
	 XriWkKOEPNDUE7tm5OtaomLFcMTBXnORov1CDojQU8CM1dzSQSdSYnyhpbRPhb4Po/
	 2ToCAqmy5hJSKPabZ5/o2c714p4o1qAL2KUj4v3jKggWFPO3f0HmJy1CWv1Hnulmw9
	 fp1wJus8kEGlCFrYPwDtJ+rubzKxon5lbILxMwy1b6EHaLF0l3pxbfFy3StrDl0HhW
	 jE/GzySXlivpZL0fVY5SwYf9r10MhdouoFNTQtDn/7Uy+zWvS3yRKLl7eHIPxAtfRu
	 Op+Gfr45WJWiQ==
Message-ID: <sashiko-outbox-217297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] PCI: hv: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-13-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-13-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:35:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The pci-hyperv driver scans the bus and assigns resources using
> pci_bus_assign_resources(). That function makes bridge window sizing
> disjoint from the assignment phase and is going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D12

