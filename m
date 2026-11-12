Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493716;
	b=QNNnu6PzXwxlskITbXpCGQk3wkZxQNKJBth5GFFvxQTCj5HADUQPFd14D5IuvbgyGEAv
	 WSMBuyNrnFMDPdktW+t76ATE/GskpCvJNaoKHCjzdKcZdJYGcEkMdRmAmZl39fGcOF6QN
	 i5Ix7DQHEE3sXUw8QkAg2rkaFjuAYf88JkLP+59jlJfMESG9R/0cUw1p+VoG2mGeVQFe4
	 SxJVV1tQyc+BRer+xYpUeyhNRCEIEUunxkn4ZnNMjNap3hRLZaeZ9YKS0L3aLUxFSNu2n
	 Q/QXG1OtQ+1HPT1tMdfBNswZGWTVEw+dLrwZLVBH7gIO53sr6HyEBEK33ZzcbKF5Ubg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493716;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jhCmYhvRhxrDKcwFsORnoTu9FX02HKFShVjAgk48GSU=;
	b=s1Me5i4O9/y0r7KoVbFJaW46AP22qwgflFSThOnqAW9Mkg1vORAGT6/EqSpIGfbE0TBA
	 ZjyW4D10PixwI8bppq3d5+jEhITVrRUz36LN7r1bR4DYz/yvmCn13EEG6O6EMzCUMmNw6
	 rjC8U6e05GqEOhyqEjjKmA9TjOCcJo9HNBCF1Vj/1HWdgWF9Okl4kbS1TZYPhTOl0JEjm
	 JfVaVz/2LfG81ZBcInXx5CG4mkrCg3ForKfiWmv13NRmHAd/mFmmEe+lnONmYweb+pKy2
	 yEYUby0hgOxbRsl8VvzhpFcR4KOrteT9s++7uiKoiG9dglvIoAYrGY747JBV6vr9SGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxE+eXY6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F9E606A321
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxE+eXY6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16991F00A05;
	Thu, 12 Nov 2026 14:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493716;
	bh=jhCmYhvRhxrDKcwFsORnoTu9FX02HKFShVjAgk48GSU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PxE+eXY6TwNUtJwrGyaohymVCyZNBdEQithJpJIC9Lik50gmE8Amk7QMnNpEDi+0Y
	 CF30Xgrh9BdbYyb8IInAtK7y6t6B7zMmfgL4rzL1eKXtkbkmbVl2qwS1WgmdFdljk9
	 e78Eec0vemqpBP3KqZDPEy0V1vTprRt3EP8bk6ucVHi2VWWSA7ybvsA0dcD1E+R8Z1
	 QSFHB20mnl6g5I7KRtGAbMxC3ASWxRXP2olNy8oowiTFCTDz613dJzsl6AoqSSZH4j
	 wPiAK3Lg6BuqvrIcHoSyL7SpJvLYB0HkHehL6UUrk9gscvcpq7aWcC8vutb5kTbYa1
	 PKUI4AvxFheDA==
Message-ID: <sashiko-outbox-211317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 07/20] vfio/pci: Use access ops when mapping BAR
 pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-8-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-8-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:28:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A BAR page fault can race with recovery and install a mapping after
> recovery has removed the existing mappings.
>=20
> Insert the mapping through the SRCU-protected access ops while holding
> memory_lock. Recovery can then wait for pending insertions before
> removing mappings. If access is blocked, return VM_FAULT_SIGBUS instead
> of waiting for recovery in the fault handler.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D7

