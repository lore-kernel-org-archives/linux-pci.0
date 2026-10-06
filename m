Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAA2931CB;
	Tue,  6 Oct 2026 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276650; cv=none; b=ufVnLNts5DHPzikvaAR4NzU4iYs2Rcy2B1wo/rDlEmovd7ybFtc3HUr1JHsNqQquecZ7tyF3bTiT5Sn6WXsBtOs2Bf50xv7GaS3jVvTG72Uq1eIem6L+7yJu8MCHtk18fPzy8RrykhL5peBFlmOGd4ZMymmQjD+fB6e/Tw1X0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276650; c=relaxed/simple;
	bh=emf9t6ZxD9aARM+SkSd3yo8QxXdOSQYh93V04+qk4fo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QKGjk72+xJMDA7g208BrMbqEfj9qj7E1pShnQpE0kfaegKTR3MLzd1Iqk+zSK5Fe1wqrh3wtQIPNEJZXOKwruKYUlLxYHWnzJbfdO69vjEYw9Vdp2J1ds/QsmqUo41rn6XrUECl7pT/ux3ma8IiAnWIKwolXcCJqtQVM+uaH//s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frgTPXiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frgTPXiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475DF1F000FF;
	Tue,  6 Oct 2026 08:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276649;
	bh=emf9t6ZxD9aARM+SkSd3yo8QxXdOSQYh93V04+qk4fo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frgTPXiIU9NQIVrTkKcyTeq4szL3LUAfCxEh2QzYjwZ3QlxXvtm0QcDJ6RUZ5/ndu
	 FZjqEj5OV34Z1b18Wus//gBI5SllSr5PMPZAJwjnUYC946SaGGTz5jzQZxpjRjD3hK
	 6tbZz5olO13nsTZ4QLKrv3Dz8za6MEkcFKhBvNI0AVAUVyZhzDgoZ30C0Sx4NEzc7/
	 ki0kC5qNsPdp8GAmuhxjduJcBnIlEQBHdIIsJR0tqjCVWyk1NIpNpT88Etvif+ApnD
	 Groj4uwxdjln2yRmlSyaH6c8toCtkWiwAsOrt3bZBKM8skurqCOZ/3fzY6tnjfZyyf
	 a85qbSdJbYcOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/18] PCI: dwc: Add Renesas to the RAS DES VSEC list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261006084638.3821710-2-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:50:48 +0000
Message-Id: <20261006085049.475DF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Root Port on R-Car Gen4 SoCs (DWC 5.20a) carries the RAS DES capabili=
ty
> with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
> not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D1

