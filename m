Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F9C19E7F7
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 00:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545448; cv=none; b=TJU9iLVz4ZHNqRmGw0A4ndA1toFnwP7Pss1epQCkev+5fcVTb7/pF7SHxjh5N4W+6EcNdIH4XdkXvn2uDdNyu1bB6q0yDvb+rlCf4z7gnoMsCTz8iB2L1fLZslpMK2XczIUB5jPHvUC2hEyLNKFU6jvIkmu9sTizwnnBCeQXMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545448; c=relaxed/simple;
	bh=rQnIIcNW6GPOhTaqvrdQwTMIaqxO8yI3fgpZMj8F/4U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VxX78NRLAQprnzh4UrGzVjn+mVSzvHVxM2wO5BE0r1jhR4FaXn3Z5H42E2CV5lN3Uw0oFcGei07Dg9HkepIiqbHC6RchwRntiPlh/91RGu4g+On5poe7lFmo5GjfJ11+6ABH/csiy91TSkBUeOt10MfngKg99BM4hcx6uwGAPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1dyWRkX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1dyWRkX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101ADC2BCB0;
	Tue, 12 May 2026 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545448;
	bh=rQnIIcNW6GPOhTaqvrdQwTMIaqxO8yI3fgpZMj8F/4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D1dyWRkXeSuvVifCW966/wqj/EjNLPsFAfxJ6mF6aNYCzkYehqqac/4klEgcbM9Rv
	 zYtOCusd6e7CAdf5g2aOBfp/9l+KR6ghQQbu7LcmAlUDYi+ruWSfQJV6YpcJz8peha
	 IJswRayiLapJ83bhkhxYCy9/dbpSUlI6ovMk2fz03Mw4qG71spqiBsE7DXEV6fCc/i
	 aUMCIrImntdpdhNasBMAal9lxZDZ99yoKgqcJohFUff9sx4oCF7SDw0rtKZgxHkJ4Y
	 woq7lWBJNZgEbLUpoSrAVQI0KwZPs1xRXw9+xZ23gKhTvo7W/x/L7lmB1V+yWNul+T
	 Y1D3TE2mNMQ1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] PCI: cadence: Add post-link delay for LGA and
 j721e glue driver
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260511055923.37117-3-18255117159@163.com>
References: <20260511055923.37117-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:24:07 +0000
Message-Id: <20260512002408.101ADC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation error in `j721e_pcie_set_link_speed` due to incorrect s=
tructure member access on a pointer.
--

commit b3897a7e50194e1f9cc94b232c615c7f8f651006
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add post-link delay for LGA and j721e glue driver

The Cadence LGA PCIe host controller lacks the mandatory 100 ms delay after
link training completes for speeds > 5.0 GT/s. This commit adds a
max_link_speed field to struct cdns_pcie and inserts the required delay
after the link has been successfully established.

> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/con=
troller/cadence/pci-j721e.c
> index bfdfe98d5aba7..ee85b8e04f5b8 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -206,6 +206,7 @@ static int j721e_pcie_set_link_speed(struct j721e_pci=
e *pcie,
>  	    (pcie_get_link_speed(link_speed) =3D=3D PCI_SPEED_UNKNOWN))
>  		link_speed =3D 2;
> =20
> +	pcie->cdns_pcie.max_link_speed =3D link_speed;

Will this cause a compilation error?

Looking at struct j721e_pcie, cdns_pcie is defined as a pointer:

struct j721e_pcie {
	struct cdns_pcie	*cdns_pcie;
	struct clk		*refclk;
	...
};

Does this need to use the arrow operator instead of a dot
(pcie->cdns_pcie->max_link_speed) so it correctly accesses the
max_link_speed member?

>  	val =3D link_speed - 1;
>  	ret =3D regmap_update_bits(syscon, offset, GENERATION_SEL_MASK, val);
>  	if (ret)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511055923.3711=
7-1-18255117159@163.com?part=3D2
