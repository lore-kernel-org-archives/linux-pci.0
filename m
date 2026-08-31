Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0238F24B;
	Mon, 31 Aug 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207782; cv=none; b=dpsGfG7zKnhSpsd7K7vr9FtKnRjT85RJ+zfBpsnuavgX+ikRs4+ZiQLSSJlpZCUrg9DnPwUu+6a2pgbwiJjFNLZ4UhJAYBtgourWC1x761fHPL4824IcEbb8hYRRKUjJaHdAXfUSfWiZXwmf7+XBASQYdbFoNp570RqRg1A6dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207782; c=relaxed/simple;
	bh=WKkY0cEhjc4QXxYUnMJVLPH4yRsmyftuFa3NsyidTZg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TL/xq46dVsMuh703vHZu/spuRfhFXFEJnjI4FdHkjdWp++XKepLtGe9wyJjXMs4NrOeWqaR4P3dISy9OaRpJ6BSYQ4Vmgre1NTnqlWoq/v40RUVLiBfkQfb512GTNSTvil8rY/xgtMUk1YtJ9Gq+P/QzmHT0eElcVeHoaT70nIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLkP5vs9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLkP5vs9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB851F000E9;
	Mon, 31 Aug 2026 20:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207780;
	bh=WKkY0cEhjc4QXxYUnMJVLPH4yRsmyftuFa3NsyidTZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hLkP5vs9y3/spH2Ik8LIwpoS/n+Yl6icFMRHP3OKfJX/3PbODmilfb79pEmNcbLBC
	 pUwH2voPVHVOTJPJOsllWBoXXdlsCsUndt5WDGu5VAIc85HEq2L9DoZ3QNgSvuhcVi
	 bf42km22e8Rrm4L15pq4O19JuEkoVyBnbSJIwGOvn6SSZw2xgqtSduwaQN0DWDCB6N
	 Rrk6ZoZ51SxKnwwkRSG4+Qkb84ZwmF0TWXDMzatIcxYstLBNZaFKJ5d2Wo+0too3F5
	 Z3RFBvFeMIS4UAvRaKsoSZSOqUzn63Hn5DoF/sQSL6YGTMgAEeWUdZwIW/AWadBAHs
	 jLcAdMcktBw0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260831182657.329614-2-den@valinux.co.jp>
References: <20260831182657.329614-1-den@valinux.co.jp>
 <20260831182657.329614-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:22:59 +0000
Message-Id: <20260831202300.5BB851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>=20
> Add DMA control and descriptor-memory resource types. The control resource
> carries the register layout and channel counts. Each descriptor region is
> associated with the static channel ID assigned by the local DMA driver.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831182657.3296=
14-1-den@valinux.co.jp?part=3D1

