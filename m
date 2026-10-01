Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE24F457E7F;
	Thu,  1 Oct 2026 14:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865285; cv=none; b=XsiZG/u4KykZEtVVTjnEIeKqg9pIYzo3YN1FJDpPYpcgpgiBGLBJZ8JtWjoYB7Fxv1cCGOaO3CkfsSSn3MhZPOGKT/gFIQ8d4aF+AYQHADd3pz9SCmlD4WjwCHvol5Om+9HeCOusQaYgNkJk+7lrvG61yWdYrnQVX3pqn2/kh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865285; c=relaxed/simple;
	bh=Z0zdNOmW4J5WptyIzwMl0IVidgv+WsHXF2aUSjLM4dw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dd9iT2vqIgEeVo7GTQk0sjisOOMKANspVM1m/ygd5bZe01Dxc1wxxHLixWo9rDQeBxdvoXpSmmbPRv4vqJqpyra/rgwTQYVFdU/dCKR7Rzxxuuxpz78MBgTNguMAv7Ph4PFx44AXBJ5CNpRJ99nHWvEc8giYae5YkE5lm88MP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHDAkRFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHDAkRFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6444E1F0089A;
	Thu,  1 Oct 2026 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865279;
	bh=Z0zdNOmW4J5WptyIzwMl0IVidgv+WsHXF2aUSjLM4dw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GHDAkRFCnqF6EeDZmx43HWceqa2wWh6yyPuJyrQv8m1k4IBWk1Lcr1c0j02dHO9Q6
	 L3fWZzgEyj9C3r5WdMrmUGwZrzt42HAWTqBnwui8s4wNuleLlu7uBsIqkeWbdAfDkM
	 7hvj3IsLnwSjkSaUJf0L72phQCfv7uQImjR/zpWA4O4vWr/7aWrWfJ82N9uI1XBxUq
	 rwrj+GfLX/Fpr9ZXCXRYNr5d+cUHlwPp8Lt7+4saCGSEGlTz/kdyk3ru52fNamCb/W
	 d96Gv0/aBf6ciL34gUyudph9baYeq0JlPX7uF3kFQBrQSGNB73/R/5QAgQ9hQXlYc9
	 lGsSahwYl8C/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 06/10] PCI: of: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001142815.277550-7-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:34:39 +0000
Message-Id: <20261001143439.6444E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D6

