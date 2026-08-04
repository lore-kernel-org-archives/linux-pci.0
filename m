Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DFF374170
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814921; cv=none; b=agXkqhQ5mASandgc9SRZhWrgg+l/NMGKvtOXydyv/+F80VsKY5SvVrYXmEBnSH2v7TxSC/oNGgKdYZzQhq7ChYX/Wy+WYHmUPLbwg03AWK/gc05JFgnrOb76z/lLtXomHOjcwQZUMWD+adkj/4yMyVyeKQSThX5ey6EY3GQPjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814921; c=relaxed/simple;
	bh=4x6aBSsxe4AcFUEyDt6IM8FNEaCcbx+psZMvKY5gwiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CmIlftPpY/FS7k9k37RdxwctgW27kjYxT18B1owH/UoUoJb4QjnVaW2Fq8KRKGlXneK7PM+EkTuZf7tPG4WmaHCtfS6MRlVxDoezK/XLMVVMhDEAFd+b+fRFALoHTuDBMoldZj4SJjXN7qjiVE6mFpLlukI6JJwz5tBW1NxIO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3q5f8NX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3q5f8NX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB24E1F000E9;
	Tue,  4 Aug 2026 03:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785814919;
	bh=4x6aBSsxe4AcFUEyDt6IM8FNEaCcbx+psZMvKY5gwiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X3q5f8NXmt89B4CZB7bpKTaLi5ZJoUmgFJqvh67MabgOgZ6v/NIK0mMTWzDRvJHBx
	 y6LI89kS16B5RqHcHk30jNcvbDqPPqzNfaqhWeVyqdIYuC3QfoJVc+yUkzz/rLQ8og
	 P3VJNBh8USALgsRI2DA+QAJedQReKKJFA4LOPiVjfJHMgt4HM/zDGvaLVTO9z38YDk
	 LEDTNlgbgQL/csPVkXm6KoBIdOf/SOC4FwFzJ+Xn/oufPAOUevY/ag8h0RJx3O6zEV
	 JyuK9196P4z9DvzeFL2FPTz/BT21jOYd/0nDzfkNm+rqHzDFkHTLZNg0vvZje2fNIi
	 90cvwKWLyXLsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260804033855.2115817-3-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:41:59 +0000
Message-Id: <20260804034159.AB24E1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804033855.2115=
817-1-den@valinux.co.jp?part=3D2

