Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058375;
	b=PmxgXU+cvJcYmgWguBHB32xqJBPgzo+pv8W3QEsoyLU7tMOLlV/DYCIusjFgCqgYMXOS
	 TMh33fpQf9KmXqnxgggQ8QWrJ7tGqlZ0EHxCGlPt6rLi04iEV+amnRSpC/2RfAfNE1bmq
	 bTZaaa3/8Dm2zxiCbWAKKzenZMEnhqVSFs+idtW+nSat7JDr/1pDqVgLnPYXWGevWYRUq
	 JT8lJ+fV+/sf+zwTI3JuuPrs1km5lae4GEAP5MCgkqcsG4iQI4Y4gw4drV+owBvnVgXiz
	 9cSdwAGF13AKF2vS5at64pQLr2hKIetsVLqdA4ukiCsQi1DgSPL/lKcSQVrREETGLXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058375;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6LDSMFwJkVn9snMNdO4BXMf0HS/Crr2bUgwW1UICfK0=;
	b=UtCK7u/Rdy9j/oj52ypL8/QcnvfPaMxO7UlZN+4kDzWqaTsodYPwMp2RutHXFrWagrDq
	 vPuxRaiXFHVSpT2MvRj8QJnyRyQnvSLHjyDabj3NxuSZrdR0SdbE9s1yh3OeRkKSMAaic
	 G+H86wu83/kD+kb20N6uK9CxmVIUsroqolSWSbW6/XUjPAror/p99E5vg9RdwAPUcN7t6
	 JUpC7lH5coedZMyp3JlnwCTfAKbOsR1B5cTJ0+x09RFZJT2b09RKjGy8Q92jbKNg/laOR
	 3KeVscS3oqbI82qjsJz0oLIside520ZAXXrmOoJ/BupWrUBjUOSocvWvfZ3VpOn9f1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctyt5XLk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE1606A326
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctyt5XLk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8221F0089F;
	Sat,  7 Nov 2026 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058374;
	bh=6LDSMFwJkVn9snMNdO4BXMf0HS/Crr2bUgwW1UICfK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ctyt5XLkBNoJdc0JLc0OloBUT9tetYbgY/ideB1uF4Ix021tr9yD+FnikYBuu6u09
	 YvUDFPwmsLyOwX9fAnd5I5J+jdLhT+RZnze4KkttHNZdPiJi3SsuPeDao+Nmbc6hgV
	 CjDz0dpvkxmDimsZA94dLFP/hZ0sCGY7oIUrDdSiBAXcDLQhAV+IPo0NhBoJoNnT5P
	 LavYaDCIfzYL+OF6k5FSK2AZKXQeBviytLD/W3ktePmGAabNUNEFLXnnheNqZPeCuk
	 rWlshAcM1Vd1lcHfrKaeHcL9zWvyMaX3lGqAJxbJ39oVG0l+LRMir82jl9wjMe4lZQ
	 mTZBFMxZuz69Q==
Message-ID: <sashiko-outbox-202928@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] dmaengine: dw-edma: Factor out descriptor
 completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261107133027.364237-4-den@valinux.co.jp>
References: <20261107133027.364237-1-den@valinux.co.jp>
 <20261107133027.364237-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:32:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Completing a descriptor takes three steps: record the callback result,
> unlink it from the issued list and hand it to virt-dma.
>=20
> Factor them into dw_edma_complete_vdesc() to avoid sprinkling
> vchan_cookie_complete() calls throughout the driver.
>=20
> No functional change.
>=20
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107133027.3642=
37-1-den@valinux.co.jp?part=3D3

