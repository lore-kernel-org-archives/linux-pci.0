Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90F3955DB
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686284; cv=none; b=B76rRZHR6PyCuRGarYvO/fqZvENAUaUAVUh9CsmQwPBAjxAqv/17bt2tWubYmlrbbUvlRwyRWzfR4QTOnj4bvy0B21Sy9LTxgzsODtfdJC2KWKDY8cuKg4hCrI/+1RFCVnqfDOZaTipgKJcrwo+Mi4/uKFKWnN5t+B+unIfd/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686284; c=relaxed/simple;
	bh=jX7ITSUMMIsMLEFbd/Fo/jUc3Q7+5Qkk/2kLm2MEmy8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqcuNriUs5nuVKR4CLZwjpsQNw1RO+KMwPYWjb339tbZGjU23tUGPxck0CdwixFjUZW6a/0T0mHMv6EVQA1/XCWXc6C+8mUZEVdTEaFy3zxoJp/s7Vk77UVJ+eI8u+UoxMSIYCwOtmVlmiw8+zJzi3WrAUubayXZW/Bv9qsPwMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf1NESmd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf1NESmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526D81F000E9;
	Sun,  2 Aug 2026 15:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785686276;
	bh=jX7ITSUMMIsMLEFbd/Fo/jUc3Q7+5Qkk/2kLm2MEmy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cf1NESmd6MDYLY7UhzLAs/MKD7dt6c9AtxFuZCBcXRag6ZZcuDW3nWLAdJWKKTf9c
	 Czm1Rk9sfpkpmpmsb2PCnrfmCQaiN5Trb6GN42WUmdLNAOTc0z9zDKbiSlRT/NjnDq
	 4wrAqrXfRfEP47ft2jsGis53RHnVsUx9waANWUSky+9RURdI7D/7IbDhrW6U0M1uCU
	 8LIHO9i+AbNUQ2QBUIq3N4c+8LXTq/JrzNwEiCQdC3vTetY1DjoDmuIB2dqIAotrkf
	 z97addGTV6xYb/ttPv1o9lpSBT2vpr0+PudKKJLjSVNby1ZDc4uUx5isGTQFoQKIHx
	 bXuJj8UuTBkkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] PCI/P2PDMA: Honor ACS egress control vectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-8-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-8-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 15:57:55 +0000
Message-Id: <20260802155756.526D81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> An enabled Egress Control bit does not itself send a peer request
> upstream. PCIe r7.0, sec 6.12.3, table 6-11 makes the outcome depend on
> the Egress Control Vector bit for the target port: a clear bit routes the
> request directly regardless of P2P Request Redirect.
>=20
> Read the vector where the paths diverge below their common upstream port.
> Keep a clear vector bit on the direct path, subject to P2P Completion
> Redirect.
>=20
> A set bit with Request Redirect clear is an ACS Violation. ACS acts only
> on peer-to-peer Requests, so route it, and an indeterminate vector,
> through the host bridge.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D8

