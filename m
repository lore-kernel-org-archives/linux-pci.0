Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E173002AB
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035296; cv=none; b=uftD/XYLLE6hj35p5Rngeovw8JTy23n864BpmfNZ5FKgFvLjag5v5HiFPGezs49C8u0le9d7nmQYu2OcC5HEHwbx8CYb+a2YEVlv3ergn46gS/1QPBVLMveuHhC2cLnBVeA/I0R7Lb7Qr9Z8kYjQscOw16YPqkme2//x0IIqeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035296; c=relaxed/simple;
	bh=V+OfgN/r6ZT5f25zIzxIgj7DtLCOOEHGPmZih30cBFI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=J+dzeZfh/KcGtQoLAG00vBIwXVCHKfwGtYHavhS6XdENMYiImWVqmWTmGJGnzaVfxVwr75GDTW9vZ9XLqktk4Vcvba0xQA4hUB6pM0+NtmDOgDepb0e253xoRx73XhcyvNdgsYZ16h49GWiLqe8uZ5Ry9+bT1SjxsE48cECbNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3UPtNJq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3UPtNJq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AB51F000C4;
	Thu, 15 Oct 2026 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035295;
	bh=V+OfgN/r6ZT5f25zIzxIgj7DtLCOOEHGPmZih30cBFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3UPtNJqIUYnMShnY6Q5kkkhC4l6GgtounSZzQTMFfwiwZxH1NkgDQPLhRTXIrRCQ
	 2e7ODFg8dOpZOx0EHgfffDNNDCWEJcoXV0wyFPzT8iJzQ9eNWk4+xYsLhpPrAtWTr1
	 1AktHrX4YUj+GSHg4TJsx3vzwdsiKN7FHbi8hlBgI5bHygWa5iKBgs3GE6xe9hrPuC
	 B/G0WK0a7g1IVXq+6UpTAVuHJ44aPi2RcfeBhbZZSGrTDFK76JnGrgc07mLg1VFKE9
	 7PrApzL8lj14iUyXuRQvPvDPZv+aio959ql8R0BMKVfAqhT+4UzApO2TX60drh5i3y
	 +z6uxprV3kpOA==
Message-ID: <sashiko-outbox-172200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/18] PCI: dwc: Factor out the PORT_LINK_DEBUG1
 link-up check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-3-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:34:54 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
> no .link_up() callback. A callback that needs a platform-specific check
> on top of that register would have to duplicate the register read.
>=20
> Factor the check out into dw_pcie_link_up_debug_check() and export it
> for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
> link-up events remain latched after the link goes down, so it has to
> combine them with the live PORT_LINK_DEBUG1 state.
>=20
> No functional change.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D2

