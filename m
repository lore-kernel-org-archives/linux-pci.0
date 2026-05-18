Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1FA36C598
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 02:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071417; cv=none; b=SeaCP1XUFkktKtcPR8Xl/eojoHQoGcLiTJ9gOTjHqhfQqMLnfTclqj5HUF7zGxVyCuWUFQ6FuZ1mtDwdhOrmqcjlMof3chQlwOlt8VWRWaHhTwLA5TqkUyU/G+p9hsqk39TliHpSjBCsd//qBTjwt0Zl9937Zt1vHVfxO8qBvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071417; c=relaxed/simple;
	bh=tPc7pU49QwkfPEJJqKeVC7Bs/1LP7Wq8d93qSO01DY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AZA60QCS/OLzsYJZy782w6kaDt65o1RVvrbQ84F3b8JMyQIJXIuGwZNFzPZyu2gnC483nCRupYnPBGp8J01kM2XbDd0C6SYtwkozktDIGTzYGcYrVlESVzRjYn32SrREFCGpWu6kbQZpZj2YBx+nKXPty0JMyogR58uiw/zf8nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twZUrX4o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twZUrX4o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A4C2BCB0;
	Mon, 18 May 2026 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779071416;
	bh=tPc7pU49QwkfPEJJqKeVC7Bs/1LP7Wq8d93qSO01DY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=twZUrX4ogtlgWtG7vcmY4aY2I7n6HpB9vTGCsUYOpacJ2+j0F4MhdoM2Y5xmG/kx1
	 fPnebUNWUXEUrw1iIixWRrVG6ls1LkVXQLiQZRSAti70mkVtkfILiiHVca26fPeXog
	 bjeI6ssOOoUj7vf0ADIg3ztH/Xv2ib+UT3lL58sjPhInb5SBxP42Dq19cPZjYtHKIF
	 Awm5EjbgXI49FN0f++U5qQH2BmHxLLYJzLgnYyD8sMFFHVG+4XRcTJY0Qv6zDK3UQj
	 GqELQ2C3CYtPL8wJwXZU/fOQuPriC8kViUYv8+r7zJxjYti0+CGdviwxucix++bb3s
	 7Vbe0KwmUh9DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] PCI: mediatek-gen3: Add 100 ms delay after link
 up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260518004246.1384532-7-18255117159@163.com>
References: <20260518004246.1384532-7-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 02:30:16 +0000
Message-Id: <20260518023016.B32A4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The required 100ms link training delay is silently bypassed when t=
he `max-link-speed` property is omitted from the device tree.
--

commit d0afff20acf31b3fe5b43926c6609e07c2edb1cf
Author: Hans Zhang <18255117159@163.com>

PCI: mediatek-gen3: Add 100 ms delay after link up

This commit adds a 100 ms delay after link training completes for speeds
> 5.0 GT/s to comply with the PCIe r6.0 specification. It calls
pci_host_common_link_train_delay() using the max_link_speed value from the
device tree.

> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index b0accd8285892..5abddec4e9bec 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
[ ... ]
> @@ -570,6 +571,8 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie=
 *pcie)
>  		goto err_power_down_device;
>  	}
> =20
> +	pci_host_common_link_train_delay(pcie->max_link_speed);

Is the 100ms link training delay silently bypassed here when the
max-link-speed property is omitted from the device tree?

Since pcie->max_link_speed defaults to 0 and is only populated if the
max-link-speed property is explicitly defined in the device tree, a missing
property leaves pcie->max_link_speed as 0. The controller then trains at
its native maximum capability (Gen3), but
pci_host_common_link_train_delay(0) will evaluate 0 > 2 as false,
completely skipping the required 100ms delay.

Additionally, due to a pre-existing inverted check in mtk_pcie_setup()
(if (max_speed >=3D 0 && max_speed <=3D err)), even if the link speed is
limited via the device tree, the override is usually ignored, leaving
pcie->max_link_speed as 0.

Does the driver need to determine the actual maximum link speed of the
port (for example, via mtk_pcie_get_controller_max_link_speed()) or read
the negotiated link status, rather than relying exclusively on the
optional device tree override variable?

> +
>  	return 0;
> =20
>  err_power_down_device:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518004246.1384=
532-1-18255117159@163.com?part=3D6
