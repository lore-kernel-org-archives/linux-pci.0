Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFDE3603C3;
	Wed,  2 Sep 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788330509; cv=none; b=c+DIXT2VUjGItWOmy0cmI1tdAXCSCFqrTmGYtZybPfNQU4BEEsAK7OcfeTZpwDOzy6/3C2gzPPxeNgGlegv6vfAt/y44WGXA64h8tdlRxBj3Ypa+K5dUy/cF+xqvK1w2L+JRF6S5spCaeZsygn5eWWulwAkjxlwzEwE4prPlTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788330509; c=relaxed/simple;
	bh=sV09xtQuJQyw+2/JNAePEwU2g2qVzBg6LjvKTz+RAD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hQ4eZrv8xjkl1jltECJCQRHm+TY3HFa1MNTx3X8DD9CdEdHkCHQRgeBMxB92HEmCIgZrxkgNMq9BgcTIDqGgbCVXcCa9GIbMIaWe6B/2rhx3NUuw0Kdjsl7sIqL049LfOvNdtd/1RxDqdzWNZp3iatb8/a8CKq1gb+uQGsT1qjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lq4Cz7e3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lq4Cz7e3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC831F00A3A;
	Wed,  2 Sep 2026 06:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788330508;
	bh=sV09xtQuJQyw+2/JNAePEwU2g2qVzBg6LjvKTz+RAD4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lq4Cz7e3skJnJ6rAUqaAotE0l9oqDkFGgtoFEElv/NKdXjqMaQGtJQwGQhJOviqwK
	 XL97wq1RFIcINSKxZ3JUzwkJMSsKYjBzVnm28ow4E1onFwrT1O/RxGMLCiOrL55S0f
	 p/eR13yhLodxdRxHjds3wlpORVlH9ojikgL3cfQvN6I69rQy1H+AkvUAWhFdocDwVP
	 qxPiiKN5/plz6jMYS673ipXkCYpUa1LssQLSQ24f9Z6zX/cB4LqgNdDF44dBhm4xjZ
	 Jrwxz0aJcyNUj3Y1bA0AlwBfMnNavp3dvDYaDUI/UBywTosvlC+8d741qZXiSp1a6P
	 O42ggvvvl41Ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] dmaengine: ioat: use sysfs_emit() in
 per-channel sysfs show()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260902062153.31048-10-logang@deltatee.com>
References: <20260902062153.31048-1-logang@deltatee.com>
 <20260902062153.31048-10-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 06:28:27 +0000
Message-Id: <20260902062827.DEC831F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert the sprintf() calls in the per-channel sysfs attribute show()
> functions to sysfs_emit().
>=20
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902062153.3104=
8-1-logang@deltatee.com?part=3D9

