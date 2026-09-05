Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C9C35C687;
	Sat,  5 Sep 2026 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643937; cv=none; b=Pks2/cKbeNpru2SRb6qHOvL/24S3g3uyZUKcQG+fqh2Z28tL4OBCsOQYcHd1CBOPwZ+0znnjK3sUTpfJxy7Rs7zHhR4OB4lrPWg21LRzlVoQeYyPVZL7MI+w0fx+mGrVtR5eiy7IYuKmW+UalPqw65YbuFRQD/nn2h15OVlwc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643937; c=relaxed/simple;
	bh=bYm4Y2/r6gIswOjaDEaGzyn7+fge6zDWoSg9xGS+PAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0yl7ERrtzeeiUXqP+vHgdtFYs1jur3cdKSEZkekcbi2iHMBlOmP5J4JuJ6ecXAKRRd1ni+L5N0NMesNmFOgvjLVeEhCmDBMvfaGUOyZtyCLONCq2TPT97M+vlriVaHKZCOGf7cO5D47Rip2HiQZ/5L376LiW5hr/YdVE23TGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3iIF9Qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3iIF9Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225881F00A3A;
	Sat,  5 Sep 2026 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788643936;
	bh=bYm4Y2/r6gIswOjaDEaGzyn7+fge6zDWoSg9xGS+PAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3iIF9QpJhOWk9LHTIL3osKhvuB7DhldDmIqqVHFnPqVY22uqisIziSWRSzAvYVHE
	 cfd86tH7+XLEZdqk6kr2VYjmtoH61udljHbHS0Ry/Wy0YuxFU3qTIugjymUUJ8p7Cj
	 x4cVuM9BsLCrt4x1wO3LSReCaEm3Ld1HUhlS2P2kiLit1Nl8zMhXYsylupt4Q+DrG0
	 BgL+mT2MJQ7u7DI4XxBz/SVdol9v4v+uCrL5NMwlICnXQZA0maEEgrR6lYzzyvdRgP
	 XXKePm1bjIwNUax6FoIiKAPmrUBL71p3Dv63bojFm+RChXULOPalvj5N1Y3x93Cupd
	 SUkKrNrApsvQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] PCI: dwc: rcar-gen4: Split .start_link into
 ltssm_control and speed_control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260905212649.360498-5-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
 <20260905212649.360498-5-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 21:32:15 +0000
Message-Id: <20260905213216.225881F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce new .speed_control callback and implement it on R-Car Gen4.
> The callback implements the second half of what is currently present
> in rcar_gen4_pcie_start_link(), and rcar_gen4_pcie_start_link() does
> call the .speed_control callback. This is a preparatory patch for
> R-Car Gen5 support, where the .speed_control implementation is
> different.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905212649.3604=
98-1-marek.vasut+renesas@mailbox.org?part=3D4

