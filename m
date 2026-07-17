Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89626738C;
	Fri, 17 Jul 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300730; cv=none; b=S7QWID9qMSxXT9BzLdYBtsctRk//fzrBjAR+9s92ZmV1AvSE9A2RZ0R9/PyH8o/pIsPcEijgC2ctHI8A35MUlT/GWZTC7kK1OqxeouYzoVaB8u+HNJb3NFOK2NTD6Opo1O5wktITo5jmosevhlqvQcHgLa6yAms51+fEHs15rt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300730; c=relaxed/simple;
	bh=BSrG0qhARbkjPnqa4ytog9R166022Ym2Axj44bcc1r4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gKoOTIGw9YPG0cEn3iaQqFfyE7j2S7XRFaiiYnbvbj/uCtJvwooufqraaEO7IbNhO8sgQVvwqyWQ50/LZKdws65+HuatVaR+m6L/F2mWsjuKlWYPsnHbLKQDxpLtKuaDf4idfwARxKHHtrWnI6/4xVl05RUJYOxdhVtPxREykAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0AFvobR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0AFvobR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C51F00A3D;
	Fri, 17 Jul 2026 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300725;
	bh=BSrG0qhARbkjPnqa4ytog9R166022Ym2Axj44bcc1r4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e0AFvobRbzzFAZ3beQbSW4mHOAolX9Wvhi/jeTar3Alvrtq48D1lefFbPqQrqXyj8
	 QnNZDgLymJxdQMBBH5D2P2kmqdV6+mqyeLAP/+hl55hHycV0GnvBdRn7R9StSW63Ty
	 41TfikLWMZ9onyYEXqVX9kcuCXYBOEWRS/8qBVTsxSCKDrxdtxfuA9907oV/sz93u5
	 h3PkEadv/RWB6hvfHbhUzhxRLC6BRUX9I0zqixfjqnhZW5zBhpjRHkQMxoZPe3Tc5O
	 66c1fc6K48cWPfIHYcbPbipQ6aM+q33v4vNi0hpvfx9Z9NFXer/yk4yYY3F8lqLEwk
	 jUunyknM+p8oA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/10] pinctrl: cs42l43: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717145147.823749-4-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:05:24 +0000
Message-Id: <20260717150524.F23C51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode->dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D3

