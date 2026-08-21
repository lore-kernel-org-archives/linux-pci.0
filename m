Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FC3859C2
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341734; cv=none; b=QemMftIpHzOBoTekILVm3pfM8AupLe8u1scp79cJaKr9wXg8atEpKaz5h015MmYkR6TzxTL+2BnBZvo3GpO+XvKYlbA51I5QsoOCdyxe+C6d1IYjsYq0TaW8q5V7/ExZXImU/loqevQWllETS1kHP7hPTpP140SCsyeuGEzApc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341734; c=relaxed/simple;
	bh=wJkts6f7LuLZoWx6jxXaL+NDti9aKd4egqV3Q9TJSuM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ccHsK7+LfLo+FzoIU17Qiq+5Pra6AUxE+CW+J8LVLDmbJyQK852c6EI784Qym+0AV1GxmxU+7ed9OeyVlZr9UQYmDfRkeDXwXh61cT8bEPU7PmnxJN7TvecaX0z2RPHyyRwN3ftlwAF/CmfbNOnGkLvYO2BukjCXfJxWO1YjlMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D70GXpgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D70GXpgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8941F000E9;
	Fri, 21 Aug 2026 19:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341733;
	bh=wJkts6f7LuLZoWx6jxXaL+NDti9aKd4egqV3Q9TJSuM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D70GXpgIBtEXpWLZKxL0ZmPTqeUXbahICz6sC1ixyFUhUGuObMJSjufaL4pxkfv/c
	 5yAwYaxIWzi8/zi9DG40loQYuUYZiq/Z1TVf6wJAz21bzjAjh59L75lxQQZD3Ruj0D
	 udnsj74WSzONuVOjhag0sbXS/OXkIPf6pXqUtemlXtqkQ7qK3xU2XW9jjVNn9Lyw8I
	 pje9UypYEDR4MZj/LLAEHmpM8MgW1+wpt1nO8whzMZO6uWPWPleyshBZyt6rzltbYn
	 rTdFE4VI67CK/win1K8Ok0W94uM472sAuWToIKvVRoazxiz9LtrF52i6sq1e0145sc
	 wZUN0cXppZQzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/18] PCI/P2PDMA: Wait for RCU readers before
 freeing state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-2-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-2-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:48:52 +0000
Message-Id: <20260821194853.5E8941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> pci_p2pmem_find_many() scans all PCI devices without locking or
> protection against driver unbind, including devices with poolless
> P2PDMA state. pci_has_p2pmem() may observe pdev->p2pdma just before
> driver unbind clears it, while pci_p2pdma_release() skips the grace
> period when no pool is present. This allows devres to free the object
> while it is still in use.
>=20
> Clear the pointer with RCU_INIT_POINTER() and always wait for pre-existing
> RCU readers before returning. The same grace period continues to protect
> gen_pool users for pool-backed providers.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Cc: Alex Williamson <alex@shazbot.org>
> Cc: Matt Evans <matt@ozlabs.org>
> Fixes: 372d6d1b8ae3 ("PCI/P2PDMA: Refactor to separate core P2P functiona=
lity from memory allocation")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D2

