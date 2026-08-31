Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730C39C00F;
	Mon, 31 Aug 2026 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211272; cv=none; b=IMqjU485s/Ji8fmrOlLoA5p0eZiXjKfBLXCuOLitp2Xwb9CApel1KExqcvhAK31JvGb5HmxSujP9SCnlJ3jr0pQLL2OURnZ/hMKsJqSHskYIwks1GLLl7nRyEyly+DDNk4tYkLyPfS7XGr6y0fAGD5aYnmeZakDS+/JDq6nW+DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211272; c=relaxed/simple;
	bh=3lFF+50xOQtVEFBvv/mpT10KWYPriQtvi/aqggN6hZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eKLHJwbuzoQIqCwL+WZidzI6KFTHfLoVciQ2g6BQczdLrE6twb6JL9Pj1zIRwDo7WHehV8PE+LVL41/Zkeo1U1tiBR0jqBl9w8826pMaKg4d/EkybwuCv7c5dhl+ptG6hddA5ffRYhMZaX9YsBo8fBqr5DgwTRNGk+0CkdXeRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOwAm3Wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOwAm3Wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3F01F000E9;
	Mon, 31 Aug 2026 21:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788211270;
	bh=3lFF+50xOQtVEFBvv/mpT10KWYPriQtvi/aqggN6hZc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZOwAm3WvDgwrxh+/k9yoqSB7BWPnnZ7gh5mErXU0C2Gd+YVpkO0pMHGmAcwMyxV1v
	 jLNSFZPJHFbkfA7Y3DKK3QLW6q8llYsJKJD6dlEGi1q3dEUYlP3rCf7SDwwdxRGns/
	 06QIU21bIs+N5h2na0X48w6najnHMYZB9jlUo5X1Vfo9rMEZ1tvkiMb7G7WUSKyVTM
	 BT50WZYLS9u0qP6cPS4KLln7AgEuiUcLXNkYrT/HD0xUy5hP1mISEswQGzjgEJshHK
	 jM50zPxGoS5vz6UuL3y6HIhhR5L9VRYhSAM5GD2oYBajxXZhaMsiRAGnhR5R4MHgaQ
	 b3WpxTUcQkMhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] Documentation: PCI: endpoint: Document vNTB DMA
 export
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260831182657.329614-8-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:21:10 +0000
Message-Id: <20260831212110.8F3F01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Document the dma_bar attribute and the requirements for exporting endpoint
> DMA channels. Also document how the selected BAR may be shared with an MW.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182657.3296=
14-1-den@valinux.co.jp?part=3D7

