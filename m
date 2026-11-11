Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377803;
	b=BopHp1ZvLchedFhi5MjyhPV7cyh3MOwv/f+O5xyNa427FkDfwY2BGEv7hU3xWPIsRwHm
	 GI1i7IEE+0UI3JYaxICSPixMcUjQe5ZEjfLHG8j3D65qZ32o4ihAsSwxIeHTxUl6fVbYD
	 d0xdK4DI2pHDGQut8KZ9IO6XivGsrX3XyBlTK9RbIz9eSgEouR9k4bpVt3cd2UpVq0Bwr
	 7X5hLG1e9FM97cSFKy3WODxAIsjNDa0+37fodrtpJowxX89XP5q9RLbk9SBc13gCw/9bj
	 Zuo3vbaAEM7yzQQRqenT+DfSooQ0qE09rLBYxDjz4eQXFk2np05MUHT1A3Ea3l3XkWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377803;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L0nui5RoS2ttjlEXfgdf2FHBryPRYispg6KfdVODpUg=;
	b=iiYCvEV+Y3ROJGjcogXyNL5EljrMALwZJ6GfHXZwTEqgyIBS3hAzHajHPju8BAvJRnro
	 77YT0Fbu7+HSJENLBZmQNPd+hL1JgG54x8UQGots5hDBJ/OreVADXeKApI6fj4/42bUHo
	 H0oBioifjIv27iq/O0LIOq6F4ldPEUdBP3VXLUUbpsUyZodKCc6mZc+AI0iyZSL2aayo+
	 sQxL3LF8oSL/6KKyNkzhEB2YOOqdbj8TvCl/EU9P8joo5zboVLPHA1+Ql4L8sOYcMEv9A
	 qOE5+r0dV944aujMuChJAMBbhiEm976obSAxWzS05vIolBUowhekLmpC2nkgGmUnYnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXAC+krf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713360A2605
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXAC+krf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264AF1F00A08;
	Wed, 11 Nov 2026 06:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377803;
	bh=L0nui5RoS2ttjlEXfgdf2FHBryPRYispg6KfdVODpUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXAC+krf+Trv7+PS4HAGEVGxJ03mZokL/Vbm1gXYAWDZPzoyylYrFRTxaOK3f6HN0
	 PPAbIlzuFEsNPunbT3VxPFSSwKUKB0VLGVyKSdRAyiakqwo7dUGUAR5AKUy0GIjgf7
	 CRfz8UZCxBjI4u6CxrxFosCh5+76hzGfbdu+nKULjrnQHeoa1p7q/t3b3BXE+ovZoF
	 8JRnkoz54SUvVHYvWBDfR7tka2vIBsbUnh31yAuqH/brnu4fY2RrNPPcUrkGvRXbWC
	 p5GHqDi9kGDOFb2JMUXRI0J50cCEZvDWGZjCJtIrUqc1ECqyvaOdIBjUeSPygpW2d+
	 pQ9FsGCEamaKg==
Message-ID: <sashiko-outbox-208412@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/19] liveupdate: Add feature header to struct
 luo_ser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-10-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-10-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> LUO and its file handlers currently rely solely on coarse-grained
> compatibility strings (such as luo-v6 and memfd-v3) to validate
> handed-over state across kexec. Because compatibility is checked only
> at the whole-structure level, any change to a serialized structure,
> even an optional additive field, requires bumping the compatibility
> string and breaks live update between adjacent kernels.
>=20
> Precede the centralized struct luo_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Subsystems can now evolve their serialized state at
> per-feature granularity. Each subsystem groups the fields of its
> serialized structure under feature indices, starting with index 0 for the
> base fields. When a subsystem adds a new capability, it appends any new
> fields to the end of its payload structure under a new feature index.
> Retired fields are kept in place so existing field offsets never shift;
> if the type or format of a field needs to change, the existing field and
> feature are kept intact until retired and a new feature index with an
> appended field of the new type is added. Only when a change requires a
> complete break in the serialized layout or semantics that feature flags
> cannot handle, a new handler can be introduced with an incremented version
> number in its compatibility string.
>=20
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D9

