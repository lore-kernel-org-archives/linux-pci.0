Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D530D401;
	Thu,  1 Oct 2026 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865783; cv=none; b=FCnQt6kB04ncj0f77t50hIbDN0LjplNKCPhnaXTZGHFG+oBRXZ/Rj6D28FNs3MZMvolVEjnPxqNRh3j9J571QSuwPfvhvWxYwPwOO9hVgViLBsw7kfZpU6aJOqZBR3aPIX0InqgCxVMIH692pk/ynPNA/blvJwIh6fZOadgLcoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865783; c=relaxed/simple;
	bh=5KSd4hPY3e/12g+/jEjuvaIAC8Km1dILdYrnyMdVTLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oXhoJ6s/GmvFr+gpAkgB+64suTNBsmpafVobxFr6eHoSJXeSvEjKjzv/TqDX2wGOYe+Db/OcRU3P+dzJLeamO7L/hQELaZvMRudy6J/ffDK1HBRUzVE9JCKtHevRFIdEO4kCNaqJ7RSnPWFI1F11p3phmVBOaJ+sH0sxWElsAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDCZdmxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDCZdmxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDEA1F00898;
	Thu,  1 Oct 2026 14:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790865781;
	bh=1QH29HAYUEf7B/MDfzswUTQtSnJ1BAHRh7C9vjPg890=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YDCZdmxWpSFqOEhZEtXIwqPJIxhsQivMiCiu3YVjyCRXLiHmmP7lC/4hxX6+n5/8O
	 thInxuj4ypoklx8S+NWBfNS7K3hgmj4QD7hZdU0CR/MZaY2mTfXdtYA0/kGe2q9/t/
	 HhhBqb968WAevhTdFx4Bhwg+xq/6GE0SzwGJWdm7yUVCZwp2eO2YdM4QmbNUHiEHYC
	 Bqwm0jqO20OA6Yyui/cVrNEVccYLLbOWT7GU82g+zVNkLyQT0WLS5ngBKYsf5yKvcq
	 hEf+AwJovy5HfleQ82cbyFVZzhVQRsdTtTLzAuKy6XnRo2Gl0pMxlNyf8GzotsBBXf
	 CV8fZPYQ8wIEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 07/10] PCI: of: Clear fwnode->dev during root bridge
 node removal and error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001142815.277550-8-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
 <20261001142815.277550-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:43:00 +0000
Message-Id: <20261001144300.CBDEA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the of_pci_make_host_bridge_node() call, an OF node is created
> dynamically and its fwnode device (fwnode->dev) is set to the PCI root
> bridge device using the fw_devlink_set_device(&np->fwnode, &bridge->dev)
> call.
>=20
> On removal, of_pci_remove_host_bridge_node() is called and calls
> device_remove_of_node() which in turn set to NULL the related
> dev->fwnode.
>=20
> Later in the removal sequence, device_del() is called and runs its
> cleanup logic:
>=20
>     if (dev->fwnode && dev->fwnode->dev =3D=3D dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
>=20
> [ ... ]
> error path.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001142815.2775=
50-1-herve.codina@bootlin.com?part=3D7

