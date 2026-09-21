Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F0441623;
	Mon, 21 Sep 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023002; cv=none; b=jdDm+ifJB5diTVvRzg4Oadf6BldgCUeFjA23fk+pV1XcHDfEET5yWtPIccOohhN/NPRRvaauJvWKvYqcp4Awe1rX85ZY5vUZ+Z2m+KJzIc+nMAI+pcofMK6YNEqDp1TEtg9XeSJn0ouPWEF5DkSNAIafGXCgPhNu5XYOyrwL3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023002; c=relaxed/simple;
	bh=cNAJYuMspUAN+QqORlFoq3wFo1ggZvwOKH1Z/zTlrss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y8/V8d0fNJ3oYOYroBsMvf0gZgFNLD0mROfPhZaVGy691ssS1WqOX8hAnPgDOH2slsvxSfyDYqEhRisP2VeR1QLKIu8AEJ4rJNQip2giueOd4JZ7FkGOxKL4qpPH/aKUVwqpeOEMIgQCULMtceBq58i/G9ygwD6ioHh5D1XOYLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5n6W0/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5n6W0/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1292B1F00893;
	Mon, 21 Sep 2026 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023001;
	bh=cNAJYuMspUAN+QqORlFoq3wFo1ggZvwOKH1Z/zTlrss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O5n6W0/2tSFdE1mCpmEq8KdnjwgCLq9otq2VcGnnYMMeoNi9u6mFC8M74yOyMW33n
	 WkIypV+lLc9xSnmkHeNcTJEkFlYteekwPaqM+JP2kXRv/boulAGFDXX3trXR2mSAKb
	 DeskrCFxyFypIYaeIrQlfsHkZkWkcsqjIsrWNsEJdPy3H+MHGeElR9sXYzVgl/Un/V
	 5yrqQ8MOXWX4sthpRFEOV6AGkEE4BuZg5m1niTWIiuTmlipyDfVwP/JkUkTPRlH7Hz
	 8Wc9yfe8TmLbQ+GX1/Whg2c7O6NjZpQn9sj+ShoaWkOhHYfa0LBLMCQSd9GlsaMJ3N
	 CdJZpwTMjUkuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] PCI: dwc: rcar-gen4: Handle PERST via reset
 subsystem
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org
In-Reply-To: <20260921202823.72620-6-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
 <20260921202823.72620-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:36:40 +0000
Message-Id: <20260921203641.1292B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Handle PERST via both GPIO and reset subsystem. On R-Car Gen4, the
> PERST signal is operated as a GPIO, on R-Car Gen5 it might only be
> accessible via SCMI reset via reset subsystem. Support both options.
> This is a preparatory patch for R-Car Gen5 support.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921202823.7262=
0-1-marek.vasut+renesas@mailbox.org?part=3D5

