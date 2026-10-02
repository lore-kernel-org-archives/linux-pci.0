Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3344A41F
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939953; cv=none; b=cLd8ZV/a3+UKrQNGi4mJIgRlSX3rDs76oOL3nDlaHRLvJ0AZWHf+236bpVNWu3REgsPNDom3S8jWaNYIGdDQ054AlRPo1r9AZZWjP18eSnBKQ2R4uMc5hQXXswRem0Ked9FiLx3K5JtjHfi7YDqRrivg6urmTl9SpqMEI/72J2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939953; c=relaxed/simple;
	bh=OqczyqMx1i84l2CVMnmwkCbk/L/0xcdRUvYJseB83RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jev1gXm9sfV/UJVD4+n0Vo34FzPpf8ScGElidPVw324NW2pFKt69wWBXURlplkd2Y/NW2GUKS6TFcjhyMYn/wWSwYUruLRvl7MRt6IOhGdjZvzYIgU4CTKmRMqYf8/qY7/jeIgxGL1JZiqcEONgX76rvPGX4eMgf/ZoubICFMiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhugkzGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhugkzGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351C71F000FF;
	Fri,  2 Oct 2026 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939952;
	bh=OqczyqMx1i84l2CVMnmwkCbk/L/0xcdRUvYJseB83RY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LhugkzGmu/i8IVG/eI4ZCgfntIa9w8eOl7esRXU3zE1t7USqmtsRxks/RrcIX3FE5
	 YxzzbANArGn1pVeZURRlpZ/gVpDXd490qWPjzmfyxhpIiZrTR5Uu95gZ3lFWUVXavS
	 gvRkQ+APf+BB/yyg0Yyh9HjPjq6o8HB8aNEyMONL+eZ3DfaDDw/g4ME2Zcn1/fNjWV
	 7xd6sAKB3d9hR+Rc3vCwhdgOyzD4GQL43UGMC1VB0Ygj0sZrf+OqtBP65jYHqJkAdn
	 wpViHYHv7I2XDYkDZeZKejh3vrgVAJbxMtcDd1ZTibkNNM6+MQq9Du1aSAUnjc+DQF
	 KPWNCq/0wlU9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] PCI: rzg3s-host: Move IRQ domain setup code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261002110935.2004349-8-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-8-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:19:11 +0000
Message-Id: <20261002111912.351C71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Subsequent patches add support for the event IRQ to handle link
> up/down events. The event IRQ handler will use
> rzg3s_pcie_set_max_link_speed(). In preparation for adding event IRQ
> support, move the IRQ domain initialization code after
> rzg3s_pcie_set_max_link_speed().
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D7

