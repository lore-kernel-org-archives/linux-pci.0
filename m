Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC423839BE
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719501; cv=none; b=bvjGcoSEUkwV7zesbDknDc4zMlY2bbaTe2Us1aMVd+fACW4iq/c/oLVKlhveVEMwZkcixhU/KhsN2AZ72WlDWc7tPlZaktCki+BqnxCGUCN+Vv+uSuJW8uJJfwz719vqkzS3rfiGs+J7q16yocAEepRpEW25eUMZ5Dz2TdPKQpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719501; c=relaxed/simple;
	bh=kByi0QECbT7uTMIvEKHWtz+tt1Szl/QaL40WaW5zp1I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ms/Q+It3/cdp+xUcVkkJri6QSAHzpoF48kaD9L/NXS7nOe2te7/e0XmOPbz46ZTuyC3M7u9NqqjcbYDl8BUcY62WJvM4Tq4K6u0FQbfSfcfG+IR1l0N1+lmaIdbeNwlJB2cKhpJ9b2rvZICRtlU/hn5NfJEbw1i22d7B7IjCGKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PP8fXXtl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PP8fXXtl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F1B1F000E9;
	Fri, 10 Jul 2026 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719499;
	bh=QHRWwUw+1qhGo2F1to8l+AI2Ylse53msMJU2+eM5Za4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PP8fXXtlpfgSYThBtEkHEg2lWFE7hVyLdbwzX57KeIUVqL7aQh1RUHyva7MRPPcX8
	 9LskwroUNg6nApdVY1DTkfYv6ouXMl3XeKgC1Zvt0mqOBWVtmR2wvDn/QH6u/Ker00
	 9jpywn7+JV94LwxigoeIAptCqEIc/l+9eV9BjHqPAJ+KFBlOuhkHxG28C+z2cmRCla
	 9BKQvA++nJ3cr/GP0+qJXrXuZFsS/c4t0xfx1JWVxgii0rZ+CE3XFZbRgXBsAaQ6AL
	 OkqxUgCt4zUrypr0ki3JEaSkuqV3865Ym1cx/RLd3sFvCh9YQKzajKc5EyImotYEOQ
	 0nkjg0Ay9F3Wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/12] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-12-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:38:19 +0000
Message-Id: <20260710213819.B4F1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
>=20
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to ensure continuous operation.  Clearing the bus
> mastering bit would prevent these devices from issuing any memory
> requests while the new kernel boots.
>=20
> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D11

