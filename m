Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408338D404
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275215; cv=none; b=LwFimmrr4Lsr+u1KaG1g/bmwXS2shUJmet1bjYEBsPjwqtXpenZ8ho0PK2XxVlb3FxD5SqCtU3laiTdYFJFCbiQaqFULldG8kc3lsf79DMyrTRB4RIfsQnkA2wSm3WxpOQXxuKOyQiq23uW9XMUOfBznrhKbcqLo+0/JBBSyTDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275215; c=relaxed/simple;
	bh=qz8LHkAJ7U3dZtc3VbcFQYjQUihuw3anVG7gPnSIiV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GiICSv/MzVE+pFk81oVdk3gc9VZBDsLDJURMObZYROvcZ2Yd9H2H2EzOGn/C+A842H/XhugS5PRpK74/9rC3FH1DynO2gjp06hXiBBuIar+AlMosN0NN3nROYzLbHUtvOPM86srv3DWl/PNiM7y5UGKhASAjWosxR8hRPkg5qjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQp8WCIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQp8WCIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7111F000FF;
	Thu, 24 Sep 2026 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790275214;
	bh=qz8LHkAJ7U3dZtc3VbcFQYjQUihuw3anVG7gPnSIiV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQp8WCIxh/k2z8P12lmH3RRmefRxfFNnXj4WCY08bWZqzTAqqBG1xD2BAyIq30diV
	 mKAN0Sx93fQPVaecte38x4N+Qh+EB/co5xNiH6VUC2KxcatiMqwpe/Sf6QPStDWXJv
	 5aK4bOXFK5Q/UdYzjHgbrWImvsrjuZPtTcT/SPpouVmRT5vLeQ2WMKg/RdyEJEfouM
	 G3WtoR9IQOyoCoOR2FqZsrPwjKtwiwrxViRD1mtU126n5R1nduwlkzXz6ddE/KlIYs
	 7Hzs7Ps3fDHZyinbvh9LtuAvIAk6LdXEZz9od9HdPQRqGJb0pQOL3hy/Fg8E7kZvuz
	 d4VpNBteGvwJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/15] PCI/DPC: Save DPC state in the saved capability
 store
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260924173501.856380-12-dmatlack@google.com>
References: <20260924173501.856380-1-dmatlack@google.com>
 <20260924173501.856380-12-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:40:13 +0000
Message-Id: <20260924184014.2E7111F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Save and restore the DPC Control register through the per-device saved
> capability store instead of a private pci_cap_saved_state buffer.
>=20
> Key the save and restore paths off pdev->dpc_cap rather than
> pci_is_pcie(). The presence of the save buffer used to stand in for the
> presence of the capability, which the store cannot do because it is
> addressed by configuration space offset.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924173501.8563=
80-1-dmatlack@google.com?part=3D11

