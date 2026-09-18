Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664533B71DF;
	Fri, 18 Sep 2026 03:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789701887; cv=none; b=uZI7g0kimQtz3aT9lm6vxtVrIE8yb/7H4/2dGoOkVNhdWBAj6oPcxQXQgEWxaXM5RJ0UU4uaWcVLK15b2009iEgI4kbvbwjhRlFIaShc3qFNs1IFWk6fGwG4QIYLChmJ85YVHlGTcO4xERUMMq0FLdkpTb0+UhQ70iKyW2+dSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789701887; c=relaxed/simple;
	bh=7LbmaUf0MAmYROZrcao8dx+yVYiCbM1QelVHVNLRQOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XHvDJRGP25WwzygblHLq/m4Oq0xfOB3nZKmltn0anFTi9cIRTE6+UOODtoOryNigPnq4ye2lufjC1FXdT1ECoGa3cdw2TO1zDDEfejUpojloHYqe+QChbXcMVedgk5Ft+hmC8E3DF6+T1xVKbpFGRPKZwYQp9jCgJHPt6vRsbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mepp4g+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mepp4g+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E29B1F000FF;
	Fri, 18 Sep 2026 03:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789701886;
	bh=7LbmaUf0MAmYROZrcao8dx+yVYiCbM1QelVHVNLRQOw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mepp4g+bVcOFY9egy7vBjYdt5608MBSYom0WXotqeiIcx3xq2FV0YXvXlLEdBG5e3
	 85pD8qdPRw0YVY0782C9OA4MD/tM61yNzGR9HBpt14/hgzQ42wVd4cKd3ATDfCNYKn
	 kQmdFcaumrGTzAYc/DpWt7pp9VAtq007pbrkTpUAjBtX9d7sFZ3/5bQ6Gr185Sd6HI
	 GnoU6gfN45nhvw+5/rqou+G5I2GlNvexhm2PQ/OvGWAhfMDiqXmh/S8AXwmn9IUy+a
	 qqepQ/G/O3MjmFiCu3SLKFcf5Wd4cEjIDTWypDyYVdxPeFWYKFEwMwmpZVPqgahy7V
	 ndPID3nRnzxbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] PCI: dwc: Add Renesas to the RAS DES VSEC list
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918032038.2216471-2-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:24:45 +0000
Message-Id: <20260918032445.9E29B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Root Port on R-Car Gen4 (DWC 5.20a) carries the RAS DES capability
> with the stock DesignWare VSEC ID (0x02, rev 4), but vendor ID 0x1912 is
> not in dwc_pcie_rasdes_vsec_ids[]. Add Renesas to the list.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D1

