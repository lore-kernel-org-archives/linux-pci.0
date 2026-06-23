Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53533264F6;
	Tue, 23 Jun 2026 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782185695; cv=none; b=fqKhkseGnJG+ca+BCQe4gkn7wPyIzrwwSX89MLshlrWx/i6XFWN7Ixov2FZ5aupShN7WgnZ2+sNZqNroTzm1U9X9zYcLj2rr3iBwBY6lSfMySIYRgFa5pVLiTOt+6AfLtmNhHcQZla1kEj1sl9WmqTgxrpawXl73PnE5SwfL7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782185695; c=relaxed/simple;
	bh=JkqXjE8EmU1CkJoyYXYRbHi6uzv0VFkF1GAuuMWXy28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aFAmPaFcoCn9HcamgO2tJRaANY2+yi8uv84w0yUq54JX4iTA5KJYnbfg44oE680sBoBmsxlxKBC8Y1zq9us/AY0sGgy7wSTxPUKMdGzNJPhB5W+ChCXW2lch3Dmd0/x+OyI2zVkjUgwRlCtGqEQ8r7e6HmGsRPqVDjtxkV7laAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObvxXcug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObvxXcug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0941F000E9;
	Tue, 23 Jun 2026 03:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782185694;
	bh=JkqXjE8EmU1CkJoyYXYRbHi6uzv0VFkF1GAuuMWXy28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ObvxXcugSoR78Ab9G4UgH/NYk9edBtMifj+z6WRq55fCojKslPxXgTbp3OjqBfnuB
	 mQ/tXdBFp/lzpXfWJ7xzTupA+wk0F4Q7cd417aRFLRhN6W/rxUbiMv4SNSvmbMWFYf
	 ae3Esf63RajsC0JFcasPlGvYQzpb9UpkovXhSJOqQGOtRdA/Y6KmFKnwUiSUyXMBXI
	 4vZwIV1ia1gxTFmdR9aO8xzejnsF/469Ki7JKZwGSRcaPHaAYLkP4KI41yjbwyCzqB
	 m6eQPX4r2d/HnYbErdZ1//aB1ci3ihC9JNwxVCRp7RblKe1FqlcFgZGEzwVhywKf83
	 R6lu6GucFxVow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/11] PCI: Export pci_dev_save_and_disable() and
 pci_dev_restore()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623032453.3404772-5-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:34:53 +0000
Message-Id: <20260623033454.1F0941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Export the standard PCI reset save/disable and restore helpers so CXL res=
et
> can split that lifecycle around CXL-specific sequencing while preserving
> driver reset_prepare/reset_done callbacks and PCI config-state handling.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D4

