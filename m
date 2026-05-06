Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CA2D73B6
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101943; cv=none; b=TljxbmkkbzJkN2iO/gqKCV9Ie53dyt7kLNPSB/c8haULofy3r98qEUQmEJeYsdhF54/Rl+TLst2IHkUAF9SG3tJ46IlUq71+sl0KjDdi6KZISkyKh9KykNYs3NLBovevBkEP6tN65FR5hcZMg5laT40ujlIz0yt5o89EGzws56o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101943; c=relaxed/simple;
	bh=1mbHnceUkK7QyMvKzVRy9sI6RHgmN74HB+//8u6QKwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FVREdRtFD+Xs1HXqhMV8NLPdzsmaZvPmOH3/qRJMPnh/VIYNzOad/ie4CUG6uuMXwP8/VWnMF01s42jK8WthhveW4lJWU5ZxeuZ8PDkxg9DbWlhguhMCf5Y1yWFtK1to7i7NDczJaovbG3oXt3akiUC2SRGjWGzofv2OhhB9zzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/K1lMOS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/K1lMOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0096BC2BCB0;
	Wed,  6 May 2026 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778101943;
	bh=1mbHnceUkK7QyMvKzVRy9sI6RHgmN74HB+//8u6QKwY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=d/K1lMOSvYavTK8iAkwQxg79/Vxdqw7dAjceOAE7UMOsUjrjMe0Tg60Tx+4ysYHA7
	 otWPXV5WX1KWmiiekIz9irOvmysN6a0djnu9KtoZYD2EL9xG1xERhi3rxTECuLCDp4
	 ClwMMeoxaRr4ncvUvN3KAaB9haDzNtThiaICCUJOypvwkZXG/jBJ+SCslfCub29zgl
	 nmEIPz/rueVrZMfGnlFimQN+B7JenpfZIkuXnQUQrAcIRNc06fZhM8XR6+UOAcOEF8
	 5GZeSWhPEulLmq7o+krTTgJ1HrkeJ4h2kWGqy+S9RnSmLgh9BgYGRaQEJUNyVjtsRO
	 32vVvkmXoEPqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] PCI: j721e: Set max_link_speed to enable 100 ms
 delay after link up
Reply-To: sashiko@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260506152346.166056-5-18255117159@163.com>
References: <20260506152346.166056-5-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:12:22 +0000
Message-Id: <20260506211223.0096BC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Compilation error due to incorrect member access operator on pointe=
r `cdns_pcie`.
--

commit 0760ab7da4f40a125fce1efb70ebb7172483b069
Author: Hans Zhang <18255117159@163.com>

PCI: j721e: Set max_link_speed to enable 100 ms delay after link up

This commit sets the max_link_speed property to the maximum supported
link speed from the device tree to activate post-link delay logic. This
ensures a 100 ms delay after link training completes.

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

Will this cause a compilation error? Looking at the definition of
struct j721e_pcie, cdns_pcie is declared as a pointer:

struct j721e_pcie {
        struct cdns_pcie *cdns_pcie;
        ...
};

Since cdns_pcie is a pointer, does this code need to use the arrow
operator (pcie->cdns_pcie->max_link_speed) instead of the dot operator
to compile correctly?

>  	val =3D link_speed - 1;
>  	ret =3D regmap_update_bits(syscon, offset, GENERATION_SEL_MASK, val);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506152346.1660=
56-1-18255117159@163.com?part=3D4
