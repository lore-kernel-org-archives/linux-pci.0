Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8A53B5F2
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652125; cv=none; b=MR7OwHIGYPC7aZ/Vo3CDXleAf8OP/oYKTIH1JuiLNltkq7/h8agOEN2fwmlcvcmrRFJNk1rfsTUdRX029kesadzfUC7zHULakV3e4PIqS/JGKbZ6GLojK91/o9/TpxzGTDdr6TzupjqJszcCjpjWRb6LYQBThc+AWoSI2Zx+FBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652125; c=relaxed/simple;
	bh=fpPDxMsQ0sTN1coo5gmqJ9CQEUVegFgwMhiO+n9Rsvs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qoVhX0HtycxFxso7IldhnVX7e6oWaeSimAHQjs6P7dWCC2tJO+y7VI4AQQEGvMDyBHTwlobGfSLZUGt8+5m73ofCnMmJNibON1I0k2o6/pzxAWfPaH5/bNtr3IuNjzhq0HySc7hJfahkpQzSKXVsgNQJ6l9+CEMTCgJoJYbjwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWOa1puY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWOa1puY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BB21F00893;
	Thu, 17 Sep 2026 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789652105;
	bh=+dQUo5O65eMEQ1kSRqxysBvtlxM4wsVYA49bUZ2AKS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WWOa1puYGSfQ5v18wn28WajmL0bUClr9OjbBEKroq+mxUIBoZNNIB2qmOL4c+rgGG
	 4MLQk4Gyl2l+u3G7/LJIN2D6t+j6ZLu4QUAqC9InZGrkV27l20aGePqTMyXHKGoqaH
	 XmRDE62WQpT1CUl4AoDRSwczAfUdJ2FQeSI/FsehZ0G4J0eQivsOvvZh9c1EPe9m0/
	 KsAa94cXMwFor1R9wGrDyWCJyLY8mNo4bHtF3D/3dQX5A47f75ovnTRsRtn6ktXpsF
	 HmHtYHs5WqDBck2vdIHnjjrW+4tBBoJXMeOnkgqgoRLtXAj4qrYGl3eaqRoTmSw6IN
	 6lYkvjpSmaAUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] xen/pcifront: Fix PCI device reference leak in
 pcifront_common_process()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917132944.2153421-1-vulab@iscas.ac.cn>
References: <20260917132944.2153421-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 13:35:05 +0000
Message-Id: <20260917133505.97BB21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcifront_common_process() gets a reference to the PCI device with
> pci_get_domain_bus_and_slot() and only drops it on the early error
> path.  Returning directly from the AER handler switch instead of
> recording the result and falling through to the common
> pci_dev_put(pcidev) leaks the reference on every successful call.
>=20
> Collect the handler result in a variable and drop the reference on the
> single exit path again.
>=20
> Fixes: 34ab316d7287 ("xen/pcifront: Drop pcifront_common_process() tests =
of pcidev, pdrv")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917132944.2153=
421-1-vulab@iscas.ac.cn?part=3D1

