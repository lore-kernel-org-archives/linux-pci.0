Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6789E4457B8;
	Mon, 21 Sep 2026 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022901; cv=none; b=Mgk+7RHDLIrwj2yIRdxrwlenv8xlN8wYYmWm9z3rvlfwnWnumYUR0i0cf6EkoWTd8pC7p1nDtiT1R9SlzVwwl+iUV+bey4g/GKdqLUwiiuTEAOS8FM8xvFVzY6qiIIlBm4oImdogJ3ciJ4Wz7Ve5l/7er8vZaufaR5xxDWmxvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022901; c=relaxed/simple;
	bh=rhs15VhWTt5/ATQgpCHCyFyxAgKdQ/FuDhnGcpdCJNI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J6H2PLNn9GYVTgmrl6oIAOsqTjXC+X/5nltQi+yY4QCQYc4n/qlDCp5FByrEm6VvYHlsEDm4FOi7ZiHMW2TLWaVLGlCvHlNYpMGWwj4ofLM833nfi3Rn+XjqYo5Y+TKioSk+eD53WYFn8xEFUQWFcHCjVlhscQCgUCJzYHl04Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5BsNRm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5BsNRm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9712A1F000FF;
	Mon, 21 Sep 2026 20:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790022900;
	bh=rhs15VhWTt5/ATQgpCHCyFyxAgKdQ/FuDhnGcpdCJNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P5BsNRm4Rp73EHdIJzYF2SmGt9aSmgGPyzwS8Zz/hg9CA6scw+YabnbgnMPmCQmYR
	 hdbBTDhawjh49Uy+2D2TIppg2DlnvHnuRp+fZCtCJ8Or1+QoTEdGbmv3OIeBQkMV1O
	 Vr9F1zHTJFsBUFBOTA3KRPDGnFeP5EYo7WgnD7a3wTbPL3aUwwcE5n8LE6Iy1WPWT3
	 tobvZjax4daWAcwkeaSHB6LgkY2tMR5kHZNApU0LHeYOWG5Ai6b8ocM6N/WogF9d5g
	 qhABbvakd3QzreduJNtGS9/Xx5gcdWnaBdxtilg0WLyChNa49KYlJ51nCS55rOwYpL
	 WM/pvX0PGCMhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] PCI: dwc: rcar-gen4: Add .deinit callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org
In-Reply-To: <20260921202823.72620-4-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
 <20260921202823.72620-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:34:59 +0000
Message-Id: <20260921203459.9712A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add .deinit callback in preparation for R-Car Gen5 support. The
> .deinit callback will be used to tear down the PHY on R-Car Gen5.
> Thus far, it does what rcar_gen4_pcie_common_deinit() used to do
> directly.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921202823.7262=
0-1-marek.vasut+renesas@mailbox.org?part=3D3

