Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885804;
	b=u14lLQuiTZZsqKwHCYcam9nIyP1VubNEsOyPCHOWfo9eykLL2USZC/tpPbsv/adXSnuQ
	 8a4RiPYpHj3EzvIWIrO4ewWZJTutvESu8MIll9rGOtwMNOb/gJwlzNa9kDz1r2puWWmHw
	 rQBYtB5a2fnI2H0/tl8P5P7A2ldAbeBsNxiO+x7p3LR4f3++hVZk+Q2C5MlRqdYl9uvdO
	 mYg5I9tOtY5qWgjBRVGClN+u077WE2Z1Sth9C/bBCZiPMULL5toaZPGIj/4HjHGdHXyvf
	 LfIOgn6yKVqcxwCcj60095qgiDn/pQpnQGXIjBTHIzm0e/ESj1cMMHvhFJNftTYyXqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hx+kUulacyX2ZksTCWVNNYBMWrQbWgrQ+V+Sqlq79OA=;
	b=ryPC3PYSdCYX+6mBC6lKjLNt/jz79+iTotEcrUOLEWPeToRfhrTAvYUpfzuEwwRmSjnW
	 7XYkAlSTfkVjqu+WD72mmhQEsoPKw/d9/g75zqqpQM8681yWsLVNMYtwcOd24rnTOX59y
	 8VniBoseT9lxI5ki9Z97NcZgwb8NvlVulncu022xLuAZTkPjj5bbm2RVh02HJz1nqbaFP
	 3aahavnV2SNMyE/IMsSgI7K2FtFqhBhdK8p/9P/afiVdF7UL85Cnec+O8nyayOOyToG2U
	 04IvD9ecFMf6haH2yQ7HFrNkQvUUTpkMq1uq60obolMMAXf6hxLooNASJJflFL8rmuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MV8NGgW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB2B606A32F
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MV8NGgW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CC01F00919;
	Thu,  5 Nov 2026 13:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793885804;
	bh=hx+kUulacyX2ZksTCWVNNYBMWrQbWgrQ+V+Sqlq79OA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MV8NGgW+RfNamUzDXBWjFoD6Q/dk8FmbDaWZcicohFIsVxX3b6i7OF7V2LmwpO1Uc
	 AeAbWQy288/c7hYoiOmkPHic6p06ZrUjboFHpGOjI6JcL7iQyQjndHtu1eynKXuRMt
	 1M9qnKNZWvfkC14bS4up7dTxMotyb1HJoYjyYeTQEPmWWv/56XUGEMkKFWr0fpTxoS
	 WzxCXJcTZOBhbBUh+f9YSV91/yw7odTvYkW9Ei/rLxuiH90t0csY9smeF16RDleOBc
	 Jk+ymnj+PzIA8U6aCXMrqNHt7wOAtiFrN71lQG7F2Q/Q292YzqQw+oqAotec/JhXO5
	 Vs4v3WTVtg6Pw==
Message-ID: <sashiko-outbox-199165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/9] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-2-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v9-2-a2e55846649e@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:36:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> This reverts commit c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator
> setup with devm_regulator_get_enable_optional()"), which nicely cleaned
> up the code.
>=20
> The vpcie3v3 regulator handle is needed to disable the regulator during
> system suspend (to be added in its own patch).
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v9-0-a2e55846649e@collabora.com?part=3D2

