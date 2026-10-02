Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027044A41F
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940011; cv=none; b=d9sepo6SDCWvGnxNKZNqAruP7isTcVjfACuzsVPAw0b8cf1dog1BHtGOuzabzWn8aofBA3Bpp9N35TLPWsuUD5al3Jx8GIuFrRAouIsDQrctgNuKXB5ebZD09lnJat93tMLg73yGzbHoTRqkg79XFja5gJs+uFkPKrw6aSAAyFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940011; c=relaxed/simple;
	bh=rUcdCLjsKEHInHslfeCugYMnSyMNxytu7Gi4HDgZS8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R9930sAYHa2s/5sOlcwuRxwHCGm3gPNJrNKIxkpcDO193zUukvGcC8AgtpjCHTjAKwPznQBCo+4AsCu00zHfpfSSvpRfzY6jJa3suklYNQ8WQpI6FFwwQ5VgnsZV96idU3PkmGg/N3FjTQcny9mazDOg/OFVAGSgn4UvdEOIqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAjm+JO0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAjm+JO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C4A1F000FF;
	Fri,  2 Oct 2026 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940010;
	bh=rUcdCLjsKEHInHslfeCugYMnSyMNxytu7Gi4HDgZS8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IAjm+JO0qN1EC0QrLiWnbPU0+VrRiVbIv9jV6rFGXozZI/Fk1iampSoWphj0GQSHK
	 eetXn6S+HoOqf8b1JOUNRcF+vS0MXebbEqbXZsL8ulUktOkk6q/E5vlaTfNU81GwWB
	 tqmtVoK1Yf0WzfIa4mck6HhQ5kArsE9CDVKxaYmQ0hNkB5DSAf4H+n7yA9FI6eC1BG
	 qdwUHKVurnYfiU7qzHveZeTgOgu0eWd4+3fccQAhd6tp/titv3lYacDz5k1pwsU/py
	 GELlAc9IUa/XcQrS/erf+lu15X1fsuem86r1tqyXiJYp5PnVfwAPCJo8zR/KXggoOQ
	 k9K/rtSSIR22A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] PCI: rzg3s-host: Move host configuration code
 together
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261002110935.2004349-6-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-6-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:20:09 +0000
Message-Id: <20261002112009.E3C4A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> Move host configuration code together to have it grouped. This prepares f=
or
> the addition of hotplug support.
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D5

