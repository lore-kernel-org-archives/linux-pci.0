Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104447;
	b=K7iPdYT3tHlo5R7fPkXLqvSbcg2aHHpY2X9DcOry8tCJdziLOVswSfYLtJnkPbQX6GsS
	 xpWYHmDfXr6v3eot42NiwkkMFFbrrGdYfeN8qHvbk8T/Aa3+KxuOniBbLe5uq6Yk5W3Y5
	 NXUhL7jXlJ6m2+c++/b3cBMW5CQphJDoUKcnsF5BeIeM1jOIcvGPFX2flJT+BgBw6wQ7W
	 ytU6bWMZFU/bPFFUoS591pYNSl4g3VyvIFd1Ku1fTdDvGGDmqp1F1F7pH68l0y+WOXKrX
	 09pILTy1aMfvXTaYJeSByRwkoBbw84gtdKH0dt0uXjIHhectRpQnLgtjuMKILiAAykQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104447;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+C85JucvJ4JbchiZ6JBACkMO2wM4fcu1J55el9gEJRE=;
	b=l3EXQxrtd52SFDjMCz9DCAxXAm2K4TQAHgpBgSCZtw+IDlsgNZoLSxwxdTzCrOBuLF0P
	 0sye+Soa/SvH4lVZHPX+MQkNcR/9OAshZYQs9ylwwng0DkgUM+fiRv7NpkNqOQBwKBTcO
	 i83YUMdfg/5v1JomAWjzf5Djcn7OGjkpSywRDT+vFxAjoq1tge0RwFqjF9OB5F4zfqAJ6
	 J80fAsPfNF0+FCSDKIy9WW/zfMvOBrTTjgC3SEDWfSKUj/UJ2ZmQ2zE0/xqUDENRYFuaz
	 0EpVZ2ju9uh0253V5nm+bxiIb2wFaJJlyHJBJd+wUKRjlqb9MaBsJVkUTuAlnF+ukjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuibUh5p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411FF606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 12:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HuibUh5p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49131F01825;
	Tue, 27 Oct 2026 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793104446;
	bh=+C85JucvJ4JbchiZ6JBACkMO2wM4fcu1J55el9gEJRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HuibUh5pd6q9Lm9/EZbAmvCCtClf0XI+FTIn2M6d/uflG0FxbbMYp+Af3P2CAWD8w
	 NGmjo52J5WHc1cf0EYm4gzPf5UXHZWE2CMJrXIBx/7qDYCQ5LYMzO+kc1ksHOpU3l3
	 xpmahmrwEcBVUPkc3AxKPNrIAZpX2nbDYwC/SwWC2oQQG0ItBPOVVhqNQBeaS7KoX8
	 6EIAcP2kEPcOsuatlF4gHL4hZokbycAz5B99RpUT591XOs+lhBQKb8KTiz3lmn/fuR
	 3E7IxKotuv/LeKP7lcyepCrMCGW7q82ZViCoHq9Zs5IDS8SPUHecOQ6lGY2VnKpSuc
	 xlKCidmQ8ElwQ==
Message-ID: <sashiko-outbox-186563@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/16] PCI: dwc: Add pcie_cap field and caching
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027122827.2725643-2-18255117159@163.com>
References: <20261027122827.2725643-1-18255117159@163.com>
 <20261027122827.2725643-2-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 12:34:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The DWC PCIe core and its platform drivers repeatedly call
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> PCI Express Capability structure. Besides being verbose, that performs a
> DBI read every time, including in paths that run repeatedly such as link
> up polling, suspend/resume and interrupt handlers.
>=20
> Add a pcie_cap field to struct dw_pcie and a helper
> dw_pcie_get_pcie_cap() that performs the lookup on first use and caches
> the result for the subsequent calls.
>=20
> The lookup is deliberately done lazily, at the first place that needs the
> offset, instead of at a fixed point during controller initialization.
> This guarantees that the DBI read happens exactly when the open coded
> dw_pcie_find_capability() call it replaces used to happen, so no DBI
> access can be made before the controller clocks, resets and power are
> [ ... ]
> cannot happen on real DWC hardware, where the PCI Express Capability is
> mandatory, so a negative result is not cached separately: it only causes
> the search to be repeated, which does not affect correctness.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027122827.2725=
643-1-18255117159@163.com?part=3D1

