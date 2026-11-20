Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182874;
	b=BLizG5Y6IlPieHVgisuGpuj8iBie51qXzPLW5sh5CntCqf7h8fs+vgwukfiMFwea+6bT
	 yh2B5DuMkWrqLnKLD8r0E3xLKj3s29W+p9zl/iuLQ1Vb2J7Sm/6/hxkj27UuZAx/Ulbij
	 GSKfsP+u7uH62QxUTsCpcgnhpVxx3zog/MZe5N7ut6mK8X7nMz27Vb3zu5/aBHUkVudZg
	 3lQNwRzARLe9q6kmmbkXqZNidtheXzptTfV180j39Hl5oK47gPgmAb3e9Iu/ZU1exKFdI
	 43oR3i60FllW7PaH+Qs8Vu2SnPvH/0eBxl9wTzoRKnvTJvvyH3glpRqf7PXR6sFDGaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182874;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nK5bP5VkhTRgFse1vw4zto6q7sNlirKlR53q88XvN5U=;
	b=K9yfvDj27JO7WCLo5ftV6c0IMvOBIxB5/5qZO1wgyC8yY3qI9m6Qiyag5XSENEuaJHtn
	 DVswvpv1/jXQ+cc00epT5eic8fDXekCQpLKsCU2XI9g4N+kr0JyaU1GcxLtk/doM7d2K2
	 6HrSaLPCLWeDZOu7+88KljnlxI6UfuJEZaUFX2MvXTq8cjD/FFUqqzjzTuePv+lLTsA/1
	 fbU12teCKd0GPIEpJw29axZzM2bZlrVRP2hulGZcmnhFZK/qr5DKMTERJLwyVSaDEL7Wj
	 ItU2ISN81WX4d/FDUgzg5LCbfnc4lOknxF3tuOPRDqqtmS2G5LVcWWkzaaGV+dRfzhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/Ce1esT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D770606A326
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/Ce1esT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F411F000D1;
	Fri, 20 Nov 2026 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182873;
	bh=nK5bP5VkhTRgFse1vw4zto6q7sNlirKlR53q88XvN5U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=h/Ce1esTWF694f+BzuUIZMbteRHH/BWKA0rhGJFNlAhhAiwWDtDuAaJq4PKaWqJFl
	 uibCSvOAfnOSY4J4x880FAdT+yf6fL0o+XRRym6es0JlAo0P2zjouIhR+bt2sQP2ua
	 SHq1WeZro4X4B43u96kXakT9Tec7Ze8h2fWzErtXFatZjBkRzQtVa7LS5A3hUsMfgZ
	 saGWAenT/QpGuj4D99KUKZxlS32urRtB2T+RjIF5TVackeB1UUq8f0EyIfpASutslU
	 Rj51nJZ6ahNiAQg+cf0b4PQtH7N75oXD2RKTOd6rdyhEXwcXXNBmJZHARsYS4PyTPp
	 zExCUuVkPvdwg==
Message-ID: <sashiko-outbox-225295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/16] PCI: acpiphp: Use
 pci_assign_unassigned_slot_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-6-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:54:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> enable_slot() calls the internal sizing and assignment functions
> directly to size only the bridges in the slot. Use
> pci_assign_unassigned_slot_resources() instead.
>=20
> Sizing now happens after scanning all bridges in the slot instead of
> right after scanning each bridge. Sizing a bridge window only walks the
> hierarchy below that bridge, so the order does not matter. Sizing now
> also holds pci_bus_sem.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D5

