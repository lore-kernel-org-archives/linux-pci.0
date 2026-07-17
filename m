Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928ED3769E3
	for <linux-pci@vger.kernel.org>; Fri, 17 Jul 2026 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784265310; cv=none; b=obI2qkuvQQFyzN1C8dIYz9Y1hM+Ft5krinlzYnX68eDRRap6sXt0K6Dsu0f07C0NPmmKVpebDXvo9ZlvumBqdi3rHORq+B/j0b+t6nedbN6FQAO1lGty0WdFjgRjtRX8CthoFdeop/2lrIr+nstovYEBquAO70P4netin4XDwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784265310; c=relaxed/simple;
	bh=bknfOn7kJhTHNEB0qGnzLcbcs0pPH1oiXmYUdT6pGaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X+GYE7iu6bn3nj+yuplY/XdpeKB3ZYnrDvxxLcp9QK7GGOX5CEIcmteUnjlAt6R5io1C4ibzzTF6uh+ltBcgHnlYmPF8th2oZpGHLZcR44VtztwBoFDF0hYEEfZd1edhkDEtdUSUG1LJdDsqOM14I6vv6KLL4oxqt/RS2mMTp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjxRZwRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjxRZwRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052DA1F000E9;
	Fri, 17 Jul 2026 05:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784265309;
	bh=bknfOn7kJhTHNEB0qGnzLcbcs0pPH1oiXmYUdT6pGaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VjxRZwRvwMw7yhESSnG7QxOI5Knue2FjgbrioqpQy9SDxzi+U+zCoqMUZ9QMigfRJ
	 wQWrUlR+5L4680/RdfIE69KN8WYFVjtD52C1SDCX+MyhZ5MZvMfeyPb5nHyaMGkx5H
	 uR37WPFSxDvjNKyq4TuEaGntoGUH6zzbQ+AAbYnM5YAuyjYqJkO6INohUmnpY+9SOi
	 qnTuiI78tT3wboM7tbwbKPNbjjirSAQFIn9jWpcDK6152Unu9yBadttQMKNOt2zaB8
	 +msDSQTeW23+PObpy1BD6nDGLkxz9ACd79L1QosnYTOH6o8S7KtYrgGbRMpbzSgdfF
	 spyQlffCmBcwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260717050635.2145014-3-den@valinux.co.jp>
References: <20260717050635.2145014-1-den@valinux.co.jp>
 <20260717050635.2145014-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 05:15:08 +0000
Message-Id: <20260717051509.052DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Extend EPC auxiliary resource metadata so endpoint functions can
> discover controller-owned DMA registers, logical DMA channels, and
> descriptor memory.
>=20
> The DMA metadata is intentionally generic at the EPC layer. A backend
> reports the register layout, channel counts, logical channel resources,
> and descriptor memory resources. Logical channels carry hardware channel
> numbers and refer to descriptor memory by ID; reserving or delegating
> those channels is handled by separate EPC operations so resource metadata
> stays independent of any backend-specific DMA provider. Descriptor memory
> is identified separately so one memory resource can be shared by multiple
> channels.
>=20
> For DesignWare controllers, reg_layout_data carries the eDMA/HDMA map
> format so a consumer can distinguish legacy, unroll, HDMA compatible,
> and HDMA native register layouts without making the EPC API itself
> DesignWare-specific.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717050635.2145=
014-1-den@valinux.co.jp?part=3D2

