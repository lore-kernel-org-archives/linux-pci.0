Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C444E652
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138267; cv=none; b=S7d7EQ6DVYGkNLEia5QBDN3DM7b5BUIec5ssV1A2unCbOZtNGAyeZdiScD5kbgTkLpNrUN2gaxqOyBHTfk17Jo5Xtup8bPR0Q0iXY1hxCxHu8o8HSz9+hgd/+KhreLo774DL8FV/qeUXTNuo3+eYjMdErQiVbudM3rhdcCczHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138267; c=relaxed/simple;
	bh=xlnQQe6AuL5SsTfa5Tfv+DX6zxUR9nrQdQDL12txUks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n2RPoAfXb5q/207cZkL9Ocwh/3UtbqDSdH9cnPN6fCIB/82wTFanW024qWueRnejPkTxCGBOj7QHm2vgzjPab4oRu9EMosBL44+/s5K5rqJERk/ufwimjymZDOkvIpN5koP6I23jqPjypjFc9MmFVzxmLA3fsziICLfavQKBCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLRwncsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLRwncsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B106A1F000E9;
	Wed, 19 Aug 2026 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138266;
	bh=xlnQQe6AuL5SsTfa5Tfv+DX6zxUR9nrQdQDL12txUks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cLRwncsngTVN59YGPu0COGKN5topBVNpetUqqgUanJ9n3kHzz9p1YPJeLR7D3FgeP
	 lY2bD27EVilVE6/IJdeICf+HhJFI1E3Cx9JKdO1T9ztzkfZd+rjFDWNnmW5U1Gf7Om
	 n//i2L66r2OUI06NeFNxOe6Ts5aID/tuDHkXN7zij35ofw+Fxl9pu5zUK4UGd/882g
	 plhLImC8YV/CcZirAcDr6tjGzMwQcRX/bOKoKrTh6XteMc5iV27DPV07aIFYJsCTU+
	 fJHkiIsb6N4JFah9XAZu2sns4NxKSfMqP4khwWtBLkK9mVkJoEdOfqJybQ64oxMURZ
	 LevqSwQKq8Nhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260819-typed_register-v3-12-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-12-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:17:45 +0000
Message-Id: <20260819111745.B106A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` and
> update PFALCON and PFALCON2 registers to be fixed register on them and not
> relative registers on `NovaRegisters`.
>=20
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D12

