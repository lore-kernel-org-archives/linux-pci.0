Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1D0436342;
	Wed,  1 Jul 2026 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903407; cv=none; b=Kza6lF1qLo3hE6PDsP3D3RB6tq9Hi2j8QbvJYS6/dGxVgNbjRPWsKIY4UMoF40FgsVrQmE3puanax0H10RPTt+eu9nDsu055KAbcwI/lLPcIyYnZOz3kVtv0rIVIM0GJQDrv79p2rUaPc7VuL4+AHSxAIK4o6bLwjNFzquPwCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903407; c=relaxed/simple;
	bh=JZHNwiEFoqMy0eUxliqddsBpM7vtaRRwIWG7nVPH2fk=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KkIePvj2PVPvRI3vxsCSS8FG7ZLh1B2O34nHxbDR8NgxUYBWOWjRqOqR48R2A3ozGJzjXFWgwIDU+KT2UoHlVuWe9mdWfGK/MkG7hPI3VnJRvxCNrrKvRGyrNme1jNlKiHcTLhP0vrEucFH4l0fEUl0csEQOu97Kdvf3UQw6Ybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKccQH1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKccQH1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAF31F000E9;
	Wed,  1 Jul 2026 10:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903402;
	bh=JZHNwiEFoqMy0eUxliqddsBpM7vtaRRwIWG7nVPH2fk=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=VKccQH1Yb02k50hssvzCG1acfAp5P2p4USvBcO0MRJI5hPr/5MRgvDAtdauD9km+W
	 es5xS2AeeB3GmrUBrSEfFJHbeE89Pol+vWRzds8oFG5lqKMJeMFuobLaDhFTuUvqHc
	 XxwvjSw4+xbXAjTGgF+iW9WgAzjnZI025ysshrjvkFW33v+UsmgWGVL36gBDU9Pk2/
	 Uxyj84A6r1XfospaCTP4e9JaKcFy5u9Mdjzk7pGVwWjxcPOTaAPQ0MgvNtWPVf2B/u
	 1ha+jEKTmiq9jNI9jCGVIudNH29mCsut3WyggJqk+4vau5YzCxbZ0s3gqLwW8FzkUf
	 aKazgIOYXuoOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 3/7] arm64: dts: imx8mm-evk: Add power supply
 property to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260701105234.198987-4-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
 <20260701105234.198987-4-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:56:41 +0000
Message-Id: <20260701105642.6CAF31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Add the power supply property to the Root Port child node to support the
> new PCI pwrctrl framework.
>=20
> Legacy power supply property is retained for backward compatibility with
> existing kernels. New device trees should specify power supply at the
> Root Port level to utilize the pwrctrl framework.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701105234.1989=
87-1-sherry.sun@oss.nxp.com?part=3D3

