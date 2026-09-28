Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F814E8E06;
	Mon, 28 Sep 2026 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614685; cv=none; b=CRzqpwlBC64D/iOjaR4XgHMcgGldWkCJUgSOH4+zYGqcEX6muHGZdeVWxNGyopEiZos8YEVYQRfeUorPIihvE0g7y1Vw4WeyKw7r6aBOZnld54pp84yNLP5a9zV7ki7gz1BWNcCZZa1ZH4TqUXQD8Ib6vEOVfGta7FqLl5Tdr20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614685; c=relaxed/simple;
	bh=CIBYKJh65cuSCX1diLoQrhPIRV88+otT89M20NO5JCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ed3tJqXG35MOn77NV77sWgg0XsTfNrspaBlWTMfJbsoS3UnimJ8hDxAoEPL5dvdsK+ka6PMpEqWYORuMF93z3qp7kKriG5J6XdEruzty2QDMOEAu+bqZgnkClWAa2VlyEY8v0QrqHcgj/cAx7iYQBp7uNgV6RwX6f2rjAr6B0bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arcK/6LI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arcK/6LI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010A41F000FF;
	Mon, 28 Sep 2026 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614682;
	bh=CIBYKJh65cuSCX1diLoQrhPIRV88+otT89M20NO5JCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=arcK/6LIWwMvVIqGaea1mWUns2ExtWi0Y0AxVel+eLBR08SJf2UmOuMyaEsXet1HS
	 hAuLNMBN8QlMqnbBRIh1C+AqjwDdxatfe1flOVFfHlB+IquqgBOo09Os+bQQN34x5l
	 37npsMXRGdHSsLKowBP5l+Zn2wb2PWRNrYy3J4fXvUZSddxrpkeVnSRUVrN+nIOQAT
	 huX8N6cTqUssbqX1GhfWPEtN0pkYKc+2JQz2TmwdcYEog1ZJcrMYaxKvACE8UDJRic
	 v7KcdS6c86fNx8wupAB4o9UH+xiu+zO4O15zX9e7rAYAPw2UCUN//xdtlV8/1puJsc
	 RSLeEGaMswhPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: PCI: rcar-gen4: Add optional
 "aer" interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928165230.3397664-4-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:58:01 +0000
Message-Id: <20260928165802.010A41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The intreq_pcim_lperr interrupt carries Root Port AER notifications,
> separately from the integrated MSI receiver interrupt. Describe it with
> the "aer" name so the controller driver can use it for Root Port error
> reporting.
>=20
> Keep the fifth interrupt optional so existing device trees remain
> valid. Extend the example accordingly.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D3

