Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3046EC73
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461581; cv=none; b=HsdropgXiQI/QBxoqD4RFL/QbuRNvbxeJZQyM2C4glFMdGzvjey76cgahdHo5WUO47L8kmxP8ZiblxXC4Nyvw00mgo+SHZyxzxmA0OgVkmLjIXEfToVjzDBT81BbfIqASU/IiF/IbeKXPOfwJS/hXog0eEND7xnc/J40tmtZY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461581; c=relaxed/simple;
	bh=ibY38nACPek4M6CrX3x2Y5hAIOIwoMT+8AaIObi2Uoo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YLWLG4TezeBgYj+lg4ZIfTBRLsJ83aROYbbyEwU3U/nJesyXnut+k7+lyFoBaiIXXWsKYvX4/RZqAj6RPapER+lJPMsWVwzWeveErf8hRJMOtd+1O4N1GXG+O6N19YZpyUJE/LWLdLR8B5A3M4jwP2pzLC0zSLALEVjXnFsTzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVwxrOru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVwxrOru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ECE1F000FF;
	Tue, 15 Sep 2026 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461580;
	bh=ibY38nACPek4M6CrX3x2Y5hAIOIwoMT+8AaIObi2Uoo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MVwxrOrun6xn4v1Q00vRdRXFZRmHWisshLL+y17fouROMHvJDDrD35QIV9TNyqjwl
	 0INAG6WA/J+XTiCJyjC4x0KTSj3EapFwo0hsRiZqElLpmPPK1BW/igPNBcCN8+ei3u
	 w/Oay16wWrwUD32ulYL0dZ30JUBTi4BoPmSpD5U+zbnz+16kI5aWUll4bepO5MXIz8
	 bpKvw2VJQyWh5ULXgvJX0krew7WVfVOPoKZRzNDzT7C6DzZUaY9hrOXzy0ps1FnK6M
	 MsUR4K2UWO6P2ZKZEb9gAGb8k3zyAyy++1iHE4EhnEtvaYOsekh3TBoIA0l5fCb+mL
	 s8s2FxsKwkTQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: cadence: Store the core controller in platform
 drvdata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260915082826.4135665-1-lilinmao@kylinos.cn>
References: <20260915082826.4135665-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 08:39:39 +0000
Message-Id: <20260915083939.E0ECE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> cdns_plat_pcie_probe() stores a struct cdns_plat_pcie pointer with
> platform_set_drvdata(). cdns_plat_pcie_shutdown() and the callbacks in
> cdns_pcie_pm_ops retrieve the same pointer with dev_get_drvdata() and
> use it as a struct cdns_pcie pointer. This makes them read phy_count
> and phy beyond the wrapper.
>=20
> struct cdns_plat_pcie only contains a pointer to struct cdns_pcie. Drop
> the redundant wrapper and store the struct cdns_pcie pointer directly.
>=20
> Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core libr=
ary")
> Suggested-by: Aksh Garg <a-garg7@ti.com>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915082826.4135=
665-1-lilinmao@kylinos.cn?part=3D1

