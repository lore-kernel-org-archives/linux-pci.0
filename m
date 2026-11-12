Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493989;
	b=alOCrd0nb9NCwXbK/+VJ+ek/kj5FdkW+0C/he7jX7GSl+03C6KTywi2kqJ3DEdCRkWZB
	 tvwHI5jxs/5juKXW7wnWofjSgU7a5BBfKpPHIj6ZJY4N7amt3h7oPeARRhJWXJN0aYLId
	 vn/yPu4CoTAF0lpjKCt9f2+pOzEivmVLmsnrzPEgPBdtXOYUKPw39JFsGWPAdZ8OyxxLD
	 D8crW0kLxCsw3Hwk6hsyXJ9HjdW10cnMyX3ddkGbzspuf9ej/MLMlqT1yFJD11AGiLxDD
	 O5Wn5bk3Tzpah7Ag2p6Qt8WtlCsuITOiLJ2miQpoTTU1osxVbrF1sxFdv1YQ9vbocXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493989;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TyhmxkXe2xSDq8t4nKlbW+i5b/vMvo4+jHr3tEdLk8I=;
	b=aDLNMNIqlTJhYvGOX2iH4uRpCY+Gv34IK0dKKlPWgXdLcIJdkWeInPTf8kq2RBmptrmA
	 HeHODC2ula4vuPFUgYkBwO8qatrXLabGxoBf7FwvutYmqouSYjylNgkvHDAYYzhIGJ7kZ
	 el339V7NSMQ0Rax6Z/FZE0A9m+xctIEpfwwo3rWW4U0NMyAIjf38GjR+rxOYVl/wN3cGn
	 07pkGkuudQ62ouTRNs65diIE8XYmshZMMjXgnz/OLH+khbbZ0uFRzEVw2UkbJGEqIfuv6
	 sAu55SlWTGyqWAYuaFW4TvHug4t7Bxnr2zyltIESkcsNiJEH7WBg3hhB1DNrWKLFqEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLERL2Dp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B878A606A88F
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLERL2Dp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DA91F00A05;
	Thu, 12 Nov 2026 14:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493989;
	bh=TyhmxkXe2xSDq8t4nKlbW+i5b/vMvo4+jHr3tEdLk8I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TLERL2DpY8PR/ui1U1Anm94HAI0lFo/0DDWDWACuxaSsY0FNvhRLwWZO6L5NOz2Y9
	 yE+dMSdZES6NtlzU2jDKaDNAvZq9hE3YzEmgyakr6eaB/VwAcuzO6k/+DrDzhz+XED
	 cFmlFbov9X8jUNd5l9N86v2BmmNIqzkd8MPKObeNpA+3wLu0HHusQdCyflKzZJpgeI
	 jDJnVeyF6oDAM2GcarlUaw+VpEjqbOdF2bCrPsTWGp7SaL7S6TX1wHEhTs4cCy6pPN
	 m7T6Fv9jQJ42nquHhKIKFfhhDGGmnNynx+kgVz6F7PaH6NNRDm+bMWNNnjra8GKtYl
	 38rxz/dpBhexw==
Message-ID: <sashiko-outbox-211340@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 10/20] vfio/pci: Use access ops for runtime-PM
 requests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-11-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-11-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:33:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Userspace low-power requests change PM references and device mappings.
> Run these requests through access ops so recovery can reject new
> requests and drain admitted operations.
>=20
> Validate userspace arguments and obtain the eventfd reference before
> entering SRCU. Release the reference if entry fails. Keep the existing
> memory_lock protection and PM reference handling.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D10

