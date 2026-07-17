Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD492609DC
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784264923; cv=none; b=dsJigzEBDEzKqJQ64boxejX+06ftq/kUT7LXJYGkCWaaKEUNfO35LBUvefeVJIsJQY8jj6K+bAWjBbtRSR0uGN5mAcRXyHVVAtIo6NvdT+EhDc5w4+V/9j75IC8cGcovlkGbecbwKGd6BbW4Xd1jyx5LhVeKbtknhQUMT5wkuhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784264923; c=relaxed/simple;
	bh=/5XuKC/jkELb8Hs99RJ8weCL2VoBmicVFQCz/Odl99w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bpdlWKxiSUMRldsIl82uvTDQJmhZxS675jPqL5c22D9S+yrLwaim6FLGUmjE2dXgH2fo+ioLw+6HThiom2J8pibxIvRFgfZu/V1n7isPonBld4MmFjyfeAI5MbFlYUAV+Cy3JD9BOkNyHb593gXl6oj3gia7SIo0zeFqJP7tJuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlLlQ+De; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlLlQ+De"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49DA1F000E9;
	Fri, 17 Jul 2026 05:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784264922;
	bh=/5XuKC/jkELb8Hs99RJ8weCL2VoBmicVFQCz/Odl99w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HlLlQ+De+GD286t/FOIz/d6Wr9yaP1jBtjPl9g8qyj+0YIB1i77nU8Iw2R4RAd7PD
	 SEynQpeGHvxBtbmNyAkg0grWBamXoRIN93++rS784Wq3HmwujcXDQD/iWfJIKR7F2A
	 gTP9RbyRBv3uUPzqS4pecjoNdLw9/OkYnFae9ZpISPm0h++BO0ksV73kQUi+gS1Qti
	 BFfZLgNmAelryzkn3o52vS9vhPiHxj+v+Wp212C9EKNmiP0kCblrw9b6G7tz5D4rAh
	 q698qioqbqo1jwZlMszD269RMMhqGLG3bBiyIF1b3HwMy79WxqO6YrPu2wP9THTRMe
	 7CdltsuR5qnxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] PCI: endpoint: Define endpoint DMA BAR metadata
 format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717050635.2145014-2-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
 <20260717050635.2145014-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:08:40 +0000
Message-Id: <20260717050841.D49DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Define the BAR-resident metadata format used by endpoint functions that
> expose an endpoint-integrated DMA controller to the host.
>=20
> A VSEC-based discovery scheme would be a natural fit, and existing
> dw-edma-pcie providers such as Synopsys EDDA and AMD (Xilinx) MDB/CPM6
> already use VSECs for DMA discovery. However, some endpoint controllers
> cannot provide enough writable configuration-space storage for a
> complete, controller-defined payload. Keep the extensible metadata in a
> BAR instead, where the endpoint function controls the layout and size.
>=20
> The format describes the DMA register window, exported channel counts,
> descriptor windows, optional auxiliary windows, endpoint-local descriptor
> and auxiliary DMA addresses, and a ready bit that tells the host when the
> described BAR windows are usable. Channel entries keep the auxiliary
> window optional so layouts that need a separate data or auxiliary aperture
> can describe it without a format bump.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717050635.2145=
014-1-den@valinux.co.jp?part=3D1

