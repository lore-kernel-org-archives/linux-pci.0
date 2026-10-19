Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A045D5F3
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392931; cv=none; b=BFpTkIbyWnnpQG5zYpNgV0quD3bCasrHbj7HgtMWUj5WBp1eAjICcQF+lRSFB0HYnV0y+1DOVdvGQJp8ZyxxuqKUFrM+5cHB0gmnsXcsmjCAxcA8Z+HlIaUP+IyS9BXbvw9+LnV8qSOJB3agcvOe4nJ/+egOZZ/t7K/AgdLIT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392931; c=relaxed/simple;
	bh=pkGEf+OxIugxuCcaZjVBB/z3MEsZgFhBdj2G9XSU558=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V9249EUgIOETlwoI6vnxqD/FaL//MCSTArZNjU19XZj+DSETEkhSFsCBcclZFcAv97Y2pb46dp79fZHHGh7l/hDHS3cDd95x+lZD/5afxMoLC+4E2SAER5/eI784al1YUKR5MvqWPgsjdElqjs5rShreZxCCO+a3h9OmoTLfCyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEacREdL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEacREdL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8E51F000C4;
	Mon, 19 Oct 2026 06:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392928;
	bh=pkGEf+OxIugxuCcaZjVBB/z3MEsZgFhBdj2G9XSU558=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEacREdL4tvYdmjwP+O886OhXdvocXkz2TixWL0fnFmg1HaLjMrZvTC1+l1jaXe/M
	 fQKoFNnuXd/I1ucktspAfjS4rLsGqIIvkTzC9syAC0HUtnScWf+OduCZNq8b3RqtTA
	 1ruESuaEJTXi3AAwsI168T3gNY9O3QGeglK57iFqYfq0ocUbmmPpuBEZeShJ4MWXEL
	 M3CLryYByFMB3kbZAm2iJsuXKurSLha/ar971fiRzNhOz6hq17w24kv0zgKVquoC00
	 hgMkAfyWEDgYFyHryTfhozkYdIZVQ5L2G+FrtxLck+juL22toqC++dAwiyZvji4RvL
	 ojwochAN36NdQ==
Message-ID: <sashiko-outbox-176714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/14] PCI: rzg3s-host: Move host configuration code
 together
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-10-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-10-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:55:28 +0000
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

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D9

