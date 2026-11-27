Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795762335;
	b=DVCUmEcZYJwNVplW8z9PKzQXySosLzS01FIVulgRKKXE8o39vjty81300a7TKp+9dGf+
	 NutZVStNju7/xzDcI2H91wL6BBypqOyitTb+x3fGXJT1lV3ZbA7i2wNglI7Zz7x1EwbL4
	 y15yxYQCxaE3v/PYUO69zPstdQAQC0SqbjVrsLNmE5NSghkKpBmKFuUBaOlcoKqUqmal8
	 xAw32AqCz5XSPKQmneVelfFd+1rL4kNTKkcfGOtHOsa3zYoaUUdlWEIvDR3WcWQFJerQD
	 7Qq5V5X5/n7hMLY8Fe+eRA7XRerXbdLrLCb5Dn0ru3Hgw1B+uYeaQZV16YipcyAYSQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795762335;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fzqsvc08lFbOyy8QMA/tumCYXeve4vNjcPUuQlJ6jwc=;
	b=i0UJBnAkiiAShnoVWzS9adMBwkvg7adHNt1j62juS49YGLm2b8kJWYlAJjW/LTAjm9NW
	 0nl7KMoxQNiBzdyXVtYLJP4TaifupoKhNyH7x9oI8tWM8aR1co/Ppzxubcf0abTQJmLTa
	 0bI2kxWUnEB9hTu+W5Gzfqtnwr8w2SbfMgW8igFdLEBq9vNP9s+o13f2Llt8bYPV8su0z
	 hprCjWqOoCF1WuiZ5tXH8igvdZaxkmvm7lvu2RzPpCj+0P2N1PrN+BZTiRa7yju6b24PL
	 J98Tiu32jIJEyyoIpzd1ya0ojDrSrLLuDgum45QFh+1bN2KrBJ0qZ/FIXKDyXOmUS6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORdvXZfu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0488606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 06:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORdvXZfu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5158B1F000C1;
	Fri, 27 Nov 2026 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795762335;
	bh=Fzqsvc08lFbOyy8QMA/tumCYXeve4vNjcPUuQlJ6jwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ORdvXZfukh3SZrTePMsSNRvqUSS7rhTiDH7W9GCIJ/lJQoJVhiqvchdU8g0rqHwmB
	 p75L9mGeRJ/j8k/5CPIZbNJU9yqJASOhESpNasdlLNTFVYy9SOk0p5TxRyJtZk/H0B
	 95a4uQKVPEvjMsJzZl43Gdy0pBoPFR1f7ilYdpGFAa3SHcnfPMsKSSktLKaCdYChYw
	 fClqZ6WiX78XVPzkIP21dgStQtsSzU7+TmF54GKbVrp9qrX+wDbelaQ3dPA8JDnscF
	 OhPdSbg1Io/LQlDweljrjTru7vCi7L/gSSngnsqwiR0EnUmJr+QYghHjmQ9blG+Khw
	 QXTlvGP71c+NQ==
Message-ID: <sashiko-outbox-236771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] PCI: Free released resource after coalescing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dickson Wu" <dickson.wu@certik.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127-so5-pci-515-v1-1-58c7cedf2a45@certik.com>
References: <20261127-so5-pci-515-v1-1-58c7cedf2a45@certik.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 06:52:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Ross Lagerwall <ross.lagerwall@citrix.com>
>=20
> commit 8ec9c1d5d0a5a4744516adb483b97a238892f9d5 upstream.
>=20
> release_resource() doesn't actually free the resource or resource list
> entry so free the resource list entry to avoid a leak.
>=20
> Closes: https://lore.kernel.org/r/878r9sga1t.fsf@kernel.org/
> Fixes: e54223275ba1 ("PCI: Release resource invalidated by coalescing")
> Link: https://lore.kernel.org/r/20230906110846.225369-1-ross.lagerwall@ci=
trix.com
> Reported-by: Kalle Valo <kvalo@kernel.org>
> Tested-by: Kalle Valo <kvalo@kernel.org>
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: stable@vger.kernel.org      # v5.16+
> Signed-off-by: Dickson Wu <dickson.wu@certik.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-so5-pci-51=
5-v1-1-58c7cedf2a45@certik.com?part=3D1
