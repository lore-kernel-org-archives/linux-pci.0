Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63853F8886;
	Fri, 17 Jul 2026 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300329; cv=none; b=S06B73oyg+SqFXlji1Cdc3Osqmg4ZnAytjbUe72ZN0zI0IbK0Tq/3hptuGensx3reIBgMojpSirNS5iS3o0dhhOV5mDS+S6aHUsoB5+isRO2ODpn3bIJ2kfGZrjGa7vyWt0WYxGPG3f5ocRULLeaqqTqzU3je7fOJBcJnhgkTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300329; c=relaxed/simple;
	bh=s2xVTioxVpxogkPIBkKdQPjtOF/QHroHOtXWFSoSiQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DPz9caOGvBbs0G/Z1fIhYJYLAHfO1Rh/S3E/wlUe4SMaeSRa5/cIG7evLtUDRd50Yux1H8FWkQ2Vft7hExr2aOEAlcNnF1r3iDObwDvPP+9f3k2WnMAn97Ew69nu8gfDb9fvkSsZJiAdIQY6QUjkaQf58EBPve989rMkv2VmxcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDp0dwB3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDp0dwB3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1810A1F000E9;
	Fri, 17 Jul 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300325;
	bh=s2xVTioxVpxogkPIBkKdQPjtOF/QHroHOtXWFSoSiQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDp0dwB3f1lxh6eQbsGFQ+HiAuPNLgsBZkyoGOh6LwVGwctTNKMSw7iWCUom1R04l
	 8cgKlXd4wrq/YEhL43k73YGHjdbAoQqLiUO/tAGzo4EeI3ks6ZOyLV8mtrHkATZaFn
	 pP/5trUtJagTcAttzINLGslAbBx60Ctbxek2SObdgMLni6Gndruqn0kJqIfzUZ87Vi
	 HVNaQCogtIMjQ03FXtJ2ugZjUFkyoFmce792vEfC3YLNc1krzNpLEdQiWK76Hw/R4U
	 LwXD/XCFteILyc8WcjKFm/YKQRJ0nbgYESFOghvuitmxGNXH6r5TXvcr7DIk318VAF
	 QAF3WExmCfV8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 05/10] cxl/test: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717145147.823749-6-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 14:58:44 +0000
Message-Id: <20260717145845.1810A1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D5

