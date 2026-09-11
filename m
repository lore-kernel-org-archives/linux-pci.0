Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F49443C2C
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130585; cv=none; b=SAOXCmA79aBVdfrV2ylj9g4FRApG0fSbSWR0uieebM0dGoHWxGAaRkFZAdA00Txw4/fW3M5VS07QRKFpGxOIUcsxkz8EdYmTG7NzZZE2Ed74iJCsyumU3p8PMq72LY5eRSY8xUhz8AnTbsVFhG4WSPsYYxR0AzzCZv+dqaRC7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130585; c=relaxed/simple;
	bh=f6iHqpLevlxdX5LWCP3n7Q/8co0OHUEaWFC+npfrX2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GvzS5BelAb+tRrrA+LJiIRK9PeZeR1n0tJrBn1KVbd5jkJV3a1kfg/8k72cSarKStgS6N8PxFjv2EP63UllWVsb91qJ3e1Kfk2Ezsr4xJiv4hAI/F77aDYo3Joer23IsqLAYKonB/zItnJtyzQP/gTJrxZRpQrXAd775JMLTI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwVTJMRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwVTJMRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A581F000FF;
	Fri, 11 Sep 2026 12:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789130584;
	bh=f6iHqpLevlxdX5LWCP3n7Q/8co0OHUEaWFC+npfrX2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwVTJMRF0qaHazNtPrb7C59BoNKxsaAuiLEr0J5d7m5iixtvnnpdii5qyh/2eG+G/
	 WJrOfsaR1zcSpBMupJmXlRk+w2ECuW7zbhUAl/VjAO1FE1Sk/yD/+XhO3HhcuVyYZC
	 36AsokiFHn3HeQ4+LFgZe3Xgqq/sjmE33/jDKcTnN4c++qMfqQVxM588o1sDXCr9dH
	 yXI2gwAK6JBc09+ZzeYSjDoS7Er6nVfMWA5W6oQwsk7yaj7DK8NGJWoMB/UoI2TPCH
	 YrO0pQPuJhbtnBxNuXtW7AjswUI57zcJzfTtlpm7mSLVE05h+br802fyucLBq7jnUq
	 +21x+UlR5XgsA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] PCI/IOV: Initialize virtual functions in
 parallel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavol Sakac" <sakacpav@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911123335.7558-1-sakacpav@amazon.de>
References: <20260911-vfopt-s1-v1-0-693271dc0226@amazon.de>
 <20260911123335.7558-1-sakacpav@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:43:03 +0000
Message-Id: <20260911124303.C9A581F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Serial per-VF scanning and device addition dominate SR-IOV enable time at
> large VF counts, and a kexec-based live update re-creates every VF
> through this same loop. Distribute the per-VF work over the kernel's
> async machinery.
>=20
> VF0 is added synchronously first because pci_iov_scan_device() writes the
> config fields shared by every VF only on the id =3D=3D 0 pass and reads t=
hem
> locklessly afterwards. The rest are fanned out over async entries
> sharing an on-stack context with an atomic id cursor, scheduled on the
> PF's node with async_schedule_node_domain(). A worker that fails records
> the first error there and the enabling task unwinds every id descending;
> when several fail the temporally first errno is reported where the serial
> code reported the lowest failing id's, and nothing in-tree consumes the
> distinction.
>=20
> [ ... ]
> past the failing id before unwinding them all. VF probes run in async
> context, where a synchronous request_module() WARNs.
>=20
> Assisted-by: LLM
> Signed-off-by: Pavol Sakac <sakacpav@amazon.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-vfopt-s1-v=
1-0-693271dc0226@amazon.de?part=3D7

