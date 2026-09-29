Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832563DDB1E
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676836; cv=none; b=L0mCRI08NPVhAqnVK0MzA2HLfXiPwZxsEn9fOU8KQanSay0WLuF95WFqZqIHbtcizrIfx0dS9o/g+nqG/rrA+bEk7PxmfuNFBfi9RNZN3Y+trug51hHId0ipMij+iPo6ydilD5DBNdVZ6jNzC7Tox71F5yi1EW5I5LT6YTM41DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676836; c=relaxed/simple;
	bh=J/dx9HEjWpn/ORYG/MV3V2FZUFF64oVdH90m84NrzFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OcDs2h4ESGJLDnwNt+irN7JDccQKUzYHC7LSzd8JHv8c9Owrsyp6cp60MxEhvZV8YYJZ4Hy8ka43pTOvO+GcF+CiNUvJER9NIJ/dQOiwaYinRLhUwcsHnjp1WV49rU2wZoh+0Ek2oIg0dkYTXEe6/op9olBo+e6zpv/zzdZCbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SAbDdZzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SAbDdZzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0F01F00893;
	Tue, 29 Sep 2026 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790676816;
	bh=J/dx9HEjWpn/ORYG/MV3V2FZUFF64oVdH90m84NrzFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SAbDdZzDA5SieeWZJ6zmoW2n7jmvIKJPSPd1Lh9gYUM4d6Asq88YQrMVJWqrR9udz
	 DKr1cTQ1/PGNICLa/XgK0SqhdbEqbeZiyIcKScW0U9R9uNa8vrgdClMhCVEmtq7NUR
	 mc60l9rcUvgpxTnjYhSWh4UndON05pVZls/2ES/WZ5WykuA7Tv3mBk0HWWJQwweIFx
	 kjqWs38seWaG3XZZPI+LEc2ioFsh32TFKs3mb0eQ8SqREuVJBXEw/zAN5C9wb2/ZbP
	 kCkeMxdqMhyBQM8sW2KkUUkX97klVa0zEXTVPtI5KfHtdjbnc1vttUbZCNWIkPp0Ci
	 71Kvh1iNSTvew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] power: sequencing: pcie-m2: Fix leaking array from
 of_regulator_bulk_get_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexey Charkov" <alchark@flipper.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929-regulator-get-all-v1-3-e887c66a47f1@flipper.net>
References: <20260929-regulator-get-all-v1-0-e887c66a47f1@flipper.net>
 <20260929-regulator-get-all-v1-3-e887c66a47f1@flipper.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:13:35 +0000
Message-Id: <20260929101335.CA0F01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> pwrseq-pcie-m2.c never did, leading to a memory leak.
>=20
> Add an explicit kfree() for the consumers array.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 52e7b5bd62ba ("power: sequencing: Add the Power Sequencing driver =
for the PCIe M.2 connectors")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-regulator-=
get-all-v1-0-e887c66a47f1@flipper.net?part=3D3

