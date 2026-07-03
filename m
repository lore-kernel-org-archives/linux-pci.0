Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD7241C8C;
	Fri,  3 Jul 2026 02:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044831; cv=none; b=X773ijbaV5Ob16JF4VGA249HyGmxoxoC2K/LGwwv2kpb/YwlgkR+tKfAD8st4iGr4HpWSMW7yEk7RoY5OtM+36z6dwGiPVsE9pipdDCNAEwFWpOgPB4H5IWagQU0/u81pUh8oMxmAAsNl23wZvMHCS/Q3wFk8msNL1SVNPHROtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044831; c=relaxed/simple;
	bh=1OVt7jmQtGfP16Tk4mxdo+wn4A2mMhX77Yfh9zS4BLY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EbXiH9c1jrXFib8t/l0TFk2PMd1u6acoQsyYHbGjGSfenaKQnDF4J6Ai6DUnvhBEhQJQ25X2SsJ2PS6m4aZdqb+Y2muy+3jVD/jlKt4gZalFy5TJp0EjRs/xJT6q4hRstltheEytFtcDi00KEfdxD78hDuMCp99V82FdojcdYH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGPoQluu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGPoQluu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C41F1F000E9;
	Fri,  3 Jul 2026 02:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783044830;
	bh=1OVt7jmQtGfP16Tk4mxdo+wn4A2mMhX77Yfh9zS4BLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FGPoQluuXdfUw13PUhwbgYwJOPoeqGKYFIFZY2COs+vSdGV8UqQT5+bxk4vEWIvE0
	 qzl2WfuHyZkGhohpxEq8i6Zzt5iAw5jZjoGPtW/VYUTuDwD4r+4oOK9VYGjoEABLwa
	 WLa7ypJSgn1YvktOTYvRCmsILlto0w8ChWnnfAMMYVwXugGD+VJuHBSvgNYnJf8qHx
	 43y94JmC85aligofDdFsZrAYOswI6KUYoTtzxMgFOSzA+VUoaR7Aaecq5zO51MkUa2
	 m0L0Uhx0nYGZBoUZi6rpVaoGy3x3Xq4RINJ4Y3fkQZZ5louzZde0JpDE49LM3HAQAC
	 Okeo+pNwqHrQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/6] PCI: spacemit-k1: Add device id update helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260703020003.485436-4-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
 <20260703020003.485436-4-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 02:13:49 +0000
Message-Id: <20260703021350.5C41F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Both K1 and K3 needs to set vendor id and device id, add a helper function
> to simplify this.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703020003.4854=
36-1-inochiama@gmail.com?part=3D3

