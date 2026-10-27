Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117844;
	b=RYYf367vPdGEY0M0F1S40TfvHXbS+cJ5yZyamHZSyBWwL1yGfoBJBfWByfyKjzpX6FVZ
	 WHAvwYVD9rCbHgx3I2zRfd2rmLmmahRhdcJ6cJ77eYqlW6gM88/lGUax2E0qijOQ2xx+k
	 viNdkVk0AFIBGDejIrl4P3AkxZW8Pk03/XY+TsiybQqmzhrTuLxvfZRXgOSkRmBe2QKZh
	 zC6fUsLRy7R3on5JY9bh9JCSix4GiUpw690SsF8uGlzGUSxWZWUi548YKiyOGfShazndy
	 3tLXsqHuYfVaTJO8FcE5fae0OuNqgpFCPqfBMHpmadrYqHgjbUZue0c7D+7SfYtYJKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hQ6griwY1povcL/S7rVhEafYJGZ71sz9ZMs+RoDPnUQ=;
	b=GllPxboKNiaZK47Uz5AEkrs3qcQP+COhsmUBeGaUuIvOk++NZIt/PiCITkkvRiuttqMM
	 mT78AVyARIs6zQGk4tgTP+Rypaa5NZuLDqhMJEOpPA5X9jQ9NmV45oa9pCt6T2gurq/f4
	 9c7MahkwCAzsZPHW0khx3sE8bIiCBdzvyaV0u/yieo6qWz7al9EpVMvDYhZfrKKKVVi1v
	 4eIO73f9z18xPQ7sBdr34kRR+n5s00Xa3Mj/tQPXWqwUJxWKHgbozMjjb3CJDxFuUKEhF
	 CmKOLxrh8Ktuwp7Br0r26AUpaZpWO7vsirzZJNqA3HIVhnCGRLmx0bizZUjXAk2ZbNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oA3jHBgy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA7606A31B
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oA3jHBgy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8DA1F01825;
	Tue, 27 Oct 2026 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117844;
	bh=hQ6griwY1povcL/S7rVhEafYJGZ71sz9ZMs+RoDPnUQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oA3jHBgyJBiy/TyYd7Hoe4T0NEK3np4Lvu5CICq3u4VuWTmwpbph61LllC4PkcRLe
	 mKEraXGUpPwuVL0RkRmXsidgL3B/whyOxMWEFe07C5ab/HGZe+yA3/wvFpOSNdmlA/
	 O9Hk0q/fInNVwE+MmgOk7xDV0FGVFx8WHcuIH+mKkO/t34GQscJQGAKuAd9FMk62Jz
	 YwoMYPIylcz8xoSahk5q6JelDef+kysfMhuLxjPET0QSqWi4RDrBSusExcXErS9xgz
	 F4FCY+Xcwl15pqYfahcUhpirMyyZxs2g2vv7naqEubccz4fY1LeTPtaJ/weQcTjNPE
	 KD5aLBPxFM75g==
Message-ID: <sashiko-outbox-186895@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/13] ixgbe: Use generic VF iterator
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-11-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-11-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:17:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> ixgbe_get_vfs() finds the VFs by walking PCI devices with the VF device
> ID and checking that they belong to the PF. Replace it with
> for_each_pci_vf(), which iterates over the PF's VFs directly in VF ID
> order.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D10

