Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9C39183A;
	Thu,  1 Oct 2026 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865181; cv=none; b=BlYmZRsQaL6Q9dJo3IAvtCCALSkoNAAMObFvNs1pSalNWs5nsoAXt6w4c55SWokHMaBPFRxg3S2s45bDbz6+UJfJ/y5J/Yej3UNX7u+nXwHrR/EscDOBEKGDAMvuziQwDcjvlhtE8iU54XPpRCos54pwUDt3AuC1RfoC+K83Xyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865181; c=relaxed/simple;
	bh=uJD0LPcuNMEigqLY/x0HxK96M4VNYGf6As1hTJ5dXuw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ph5T3mlwgdAS4QTO4G07BhTqon796CK1sLeoqT1tyKlmKc06VenGUGjIBoQVMTUnFJ59BhtDsCH9wrS+BfXjtKB8rTQrAaHq0a3LvyQYaO5u2oaQQkNtTsBRF2Bp+29RdjqCPff/v6vqmM6qLECQ621ZM/kAbliHfpuXj5J1/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0PIOedR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0PIOedR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C76F1F000FF;
	Thu,  1 Oct 2026 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865175;
	bh=uJD0LPcuNMEigqLY/x0HxK96M4VNYGf6As1hTJ5dXuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N0PIOedRcK3unSEggtkne9BiTWMt/cDie39A4jW8hXeQmREFBrT7fQwMjWjNGKgBa
	 QS2Zx2j588+FBu+/JZwfl8498wX7qSnt6dzXgYIxapqmhWt0M/y/VotFhdpC/Tzfhw
	 7TokYJenIlvNYsKBazb9JkuE2VrnwFVj1A6alBjcaEGfJA3kgip+faaPoN2bvTrVce
	 Tx0e+qwzpNV7jJC5qAqO2GXXDa7a7al2NozU4QJRpH386AAO2SYMX5D5jJZzFJ+QOs
	 fsvwHIR4U+jCM5RjtEpBt+nSGYhecwuj+C35bSLHGZTL6BIUBUR4idZ3a1DtKLYH5y
	 aTpJAUE52o5+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/10] cxl/test: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001142815.277550-6-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:32:55 +0000
Message-Id: <20261001143255.9C76F1F000FF@smtp.kernel.org>
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
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D5

