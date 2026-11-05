Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878808;
	b=1AXOEO7oGJmoKYoqeKdO3tdUpCkJ0N/JOlwnN+M36iB4dKYzbcq6pywDB3j7VZlsF9po
	 sWJ73gsRXro+wr5E+aioBLbQUYQ6thQEbGatupDAVqtmnTM57anID55kdVKUYhoDaxP43
	 0ZyvxWQMhlxjF7PHuM0iLl2g4GRTvrm+b/SJf7Ga60DluQucxMc8e4RLTlLH+Zo/L0qsE
	 yWL9MNyuOpuGSqgwGughtwL+iLuEpecXnXjXBiKsE2rRnT2IJfjpaavsWHDJNqiE6xvpz
	 q7OgULwTl+OUmJSCnIU7iBSBXGYd2bgycmXJdS9gCOV7DtGsgTCYVlBv1fiAKgclz1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878808;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=baENL9ZlkGrWfOniXZjnprqjx+tpHyBKuwgLp7FvurA=;
	b=v1SLr3qVf+2W1p5ZEf1WEzS0rPApmNGUqztTKbrDyzQJXgdY4g9vblCK4nSQ7OFFJ2wO
	 N5dGFj+LbEpRg7KY0sUGh1JVLrXMLZphfYNR8nhzHJ33f47PjBq42dA6jftR0ITy6MAKA
	 PRg+UPPu1/+Y9rA5T5f2g6OR8d8tFVBeGVOJW+1fh2dKZT0JX2yyIGHWdsJBRP1bbnInZ
	 5sY7oC8hKINcFPLlOx+OwvJeQy735u3zzZ1NY6YDxg8gz4IpXX2ZZkEODubQ+ruNdltWf
	 K4VqJRfN8ZJNQDRA0uLeBtFAHDPb8FXPjSsLu3HDysjwLcogme2SRCNKpw1wLNv1SOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OofZo2Ji;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F6606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OofZo2Ji
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670041F000C1;
	Thu,  5 Nov 2026 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878807;
	bh=baENL9ZlkGrWfOniXZjnprqjx+tpHyBKuwgLp7FvurA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OofZo2Jif77dkmy5KRgANRoQbdDgw4CwXBQxys3jrurXyvrx0W6v+W0FRkLJcX42Z
	 ZqTGpeO+1zxjPORfUXGwQA+S1cQCmYPp9+JZayBzyBbLxG3qaKHEZCuHTgRFNgS4PO
	 OEgQ0L1HrwPP1wJDweRWo8PgG+7RYGISktEhdwQbMCMcrOSydn/rJIz1y3SmTwKoMC
	 4iRvznSCXH2W+8zgs8KbQ6CFFvOvmrga3K8dK9Jhqoc6kGoGbBT6xT57wN8mPUQYzY
	 /Nux9JMLNrys6frDmqGAnHBZ4jSRINE1Zyt1W7Pb+ik/e44uI6GgUG+gtWotnNnp9T
	 /u2QnniMDxvPQ==
Message-ID: <sashiko-outbox-198964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] arm64: dts: apple: t6031: Add PCIe nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-apple-m3-pcie-v1-4-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
 <20261105-apple-m3-pcie-v1-4-e00a72a604f8@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:40:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Yureka Lilian <yureka@cyberchaos.dev>
>=20
> Add the PCIe controller, its ports, IOMMUs and clock request pins to the
> die0 M3 Max/Ultra .dtsi file.
> All M3 Max and Ultra devices use port 0 and 1 so enable them and their
> IOMMU.
>=20
> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-apple-m3-p=
cie-v1-0-e00a72a604f8@jannau.net?part=3D4

