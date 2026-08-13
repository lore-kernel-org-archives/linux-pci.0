Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D041D104;
	Thu, 13 Aug 2026 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786603209; cv=none; b=oEJr0e2F7ySGRB5gFzs0/GJiKVgFfK5t1QG9jTW9RzO5fxH2rDL0NOA98i2NXfGxOMsq0GBPdDd05mLaZGwV+wENlZqnHMCvJYLZO23tTmndeiw9e+3MC4mpJ+E0UnnLDxEjX2ycRb4/kz8fPVUBquQ610v+9Zl+zGIIjDdMkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786603209; c=relaxed/simple;
	bh=ILWRNqlNuRW/FjGjZ5X1XxdDDUfuFaB070lIgq/o8Kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qS1x3S7Plzumye480lY5ME6HlK6C1De7Vfy1KdDW9I0YO4YfU+IDqy2fm2AHEIVUSXfjLIhrcN8HfjHY0EXvPZra0FDuIKFb5OIuqnaKGZw5oeuFLd0/o8vnQDi+9c0oqh3sqfWojHOPdFDHH5IuJWsNdbWTG02nKTmNWaZ7544=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGS6x95B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGS6x95B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6904C1F000E9;
	Thu, 13 Aug 2026 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603202;
	bh=ILWRNqlNuRW/FjGjZ5X1XxdDDUfuFaB070lIgq/o8Kc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZGS6x95B1SN3BKhyP8vtmMlqhqk+tmnN8zhdMyRNvd2kFEGyvcfPqCb0B1OYQcrbS
	 lWylvWZsticQVJbyZG+QZH2IGpbdPRYZDbUmx1YkVp5Np1hQan3+V5X0FmZLjpHcey
	 e5Kfn8SdDsLTxQvpOsYEXkXPn489F0lkFcs8NQ9O+WAQAedbPFc6/oXk4CYBErfBl6
	 k2vwMtJoxmN+GCWQe2HmW5POSZH1e7EPoQHO9lyU/9WOa1xr4us7qS2ja7HuQIbBYc
	 FqM8d/Srg3lWmL6t/G0S1Ftd2QVlIwc3vIi+DXZ/VreeXx71AqpiGrYLbsORH4Ue+0
	 GZUNaFgID14OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/10] PCI: endpoint: Define endpoint DMA BAR
 metadata format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: vkoul@kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260813063757.3131865-3-den@valinux.co.jp>
References: <20260813063757.3131865-1-den@valinux.co.jp>
 <20260813063757.3131865-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:40:01 +0000
Message-Id: <20260813064002.6904C1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813063757.3131=
865-1-den@valinux.co.jp?part=3D2

