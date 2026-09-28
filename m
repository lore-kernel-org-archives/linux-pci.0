Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F46360ED0;
	Mon, 28 Sep 2026 01:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560042; cv=none; b=C2Ho/nQWJdtRdwI96gE8Uh9FEMYagyDiBCYtN/ZI8Ss1dLhhFxWdXja0EIfOtK6XOPK3yZWd5PPqlarhztzL5wF33O37TvBJBM/ZcQrdlEEiERQKm/jdcabfRCN8XAAIE6nwhDrQGJqg586Cwpi26M868GXOqWTb/rMwBVA3dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560042; c=relaxed/simple;
	bh=45UZnj4pb8I74EMWo14ztAnZ0B5QwuTZAvCkzT2e5iU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=crBLV9c+TwxCJnOcjHtSeEI3UtX83uKKcutij1ADp8tU86X1N28Xb1Mqb79S57kk7WSX9zRJkKCVI+8VKj73fn3HH9Tx7rThDLIrYpe/2RuNtYItucCp9lGWash2MwVrNKF8N4IOTramXrM4mI5KMODYJn+5pGS8UQ2En5aVB2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gu3w6TW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gu3w6TW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C11C1F000FF;
	Mon, 28 Sep 2026 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790560040;
	bh=45UZnj4pb8I74EMWo14ztAnZ0B5QwuTZAvCkzT2e5iU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gu3w6TW/AxNx4PzgMxVaZI4MBbLBYYiLkAYQw0HC3LGHS6M0Q6F6ThrhBCachbu2+
	 2grdY35xoF6S78lDHKqSV1so3gVigaLn9imhVlxn9xAKJK2WnwOTD0GudBbo65L2AB
	 W0FLmpQI82bHMqKdj0GM9yNZp4UI/6S9AQRofM3a3k3ZtMxipNEmjVoaZ5j+8vLa7y
	 1F7bS8rbnJaRSLL/2vtgTDATtFPaRKWWqpn4AvRbm4rgDaNCN+HH5OYnU8dqCLLEYg
	 kEK2DuAnclgZTw62Dt3AKS/ZrvXAHwFIenjHBJUFPflBNKzEF03S4c1mCbLqj4XZ15
	 kFMnYReI+ua9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/22] lib: rspdm: Support SPDM certificate
 validation
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, ojeda@kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net
In-Reply-To: <20260928013123.566184-2-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928013123.566184-1-alistair.francis@wdc.com>
 <20260928013123.566184-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:47:20 +0000
Message-Id: <20260928014720.6C11C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alistair Francis <alistair@alistair23.me>
>=20
> Support validating the SPDM certificate chain. This only performs basic
> sanity checks on the chain before we continue on. This does not ensure
> that the root CA is trusted, we leave that for userspace to check and
> enforce. Instead we just make sure that the chain is correct, uses
> supported signatures and that it isn't blacklisted in the kernel.
>=20
> We then store the first leaf certificate for use later.
>=20
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D20

