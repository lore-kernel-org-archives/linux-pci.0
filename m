Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E05519E1B;
	Tue, 22 Sep 2026 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067330; cv=none; b=HaPQmzKypj+NYGvWj96yDSBCTkEEySTXM9Vu5BgbFiRcpIMR0FV05SOhTWGhA/zO0gwWTisG8onBk1xQWZjI3YPsbWzuPkQwkHnq1d9741CIOp4LeFcexWac4x+nhqJ7vhjeQohJ1o5mAm/W9Ve3MOTcSCpnk+N8TLUKxFERs+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067330; c=relaxed/simple;
	bh=VcHzN2Y5Rh1yp8oj7EplSfwJ5unKAfkTiO2YOmDFtag=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqgphZIZFh+aVvsd3h3sanq9jTWXXWx/Ood3x1rIJJfh4pW3ZidAVgdXblCOZUuaqSHazocEL/w2zTHY0TIvNnkFKbqGUiIhIscFIciibp5c91RDhq9Cn667dxLP+bnQ+IXwuwfkkTFb4WvXbLacdPhgfMUDyCZnBxWLD+PKIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjOWSt8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjOWSt8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C241F00893;
	Tue, 22 Sep 2026 08:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067328;
	bh=VcHzN2Y5Rh1yp8oj7EplSfwJ5unKAfkTiO2YOmDFtag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjOWSt8Fob+NCsDeltDvJUgQ/2DBa2yqOeHZByxAq+sx388cL+3cuONk8Py6Q6VNe
	 gcASyaRzU68JmlF5cd2preWdM3U4Ng7QtaEJMex7N2bil8abqxRc0ocB3m3oGgE+fU
	 d276hixgOVo86tlM3lmfMgA1QrEsPxDP05221Yr3IQe9BoI4JNyUwlot52XQKd6LWj
	 kp2Niwhm5dSuH+hDCjhWL099VzkQJ6xG/s64z2lF2Ep2WjGQ+D0gZQLmkQn7V0EmI9
	 Wk/gxJjtHY5NsMTyJTZGgzX0+HzDwyJMBJLVa5cCmCNLnOt4ideSLilqcy6ygHwRAy
	 w3BJ0r+kDgsQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 13/15] cxl: Restore CXL state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-14-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-14-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:55:27 +0000
Message-Id: <20260922085528.46C241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Restore the PCI configuration needed for HDM access, followed by cached
> HDM decoder and CXL Device DVSEC state. Recommit a cleared locked decoder
> before restoring its lock, but leave surviving locked state unchanged.
>=20
> Stop at the first restoration failure and preserve a disabled PCI command
> snapshot. Keep IOMMU exclusion active through restoration and post-reset
> cache invalidation.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D13

