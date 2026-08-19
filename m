Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7642342C4E3;
	Wed, 19 Aug 2026 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131810; cv=none; b=CAlAWJxWGAABt9CtXN09BjYgL6l00q+GsZtluhNtz91dhNn8bLYt/w9N97HP2WFt73ku+FJxIxL3zPYzhvRyoJAJnKy8gg5Gr0dpi2Ca0UFIFcPXm3jhdjrmuw+GJXjnXxthuSL9WCNHbHMrpXYhOqjBWlsnkGLydFTnABzQ7rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131810; c=relaxed/simple;
	bh=InQuKoPn7KmaV4ZxWCr2fWKPhtgjpnAJ7T3PWeExiMg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gj6IKUb4397SkFRS9glnvicn7bfx5GhtF3OljB7ijdphnSvADO41YVntsltm/QRm98bfLXhF7fWv8hYzzYTZuCMZz9I6mN2hLlgLjuYza+GM8+tpVopnkKN3Ii9ygXlXe5OC+1Dr6P1KEoAmIacfIHxB6IDJoPLySEZTQhR/RqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeTDJb9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeTDJb9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9471F000E9;
	Wed, 19 Aug 2026 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131806;
	bh=InQuKoPn7KmaV4ZxWCr2fWKPhtgjpnAJ7T3PWeExiMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oeTDJb9+HnpWt2ObrhVp/xSAtLz4qjO19F8bRe3+kPNXlX8uaFJYslqTz7lGvqUdb
	 WEIrXrAmV9bnFLnFXi8TUt/v71foLh/b7Kbnjez902REpJvrwPyQhcFJmcUkTeJm7y
	 RowANbO+29DiM3jb8Pjn8tybv8G91rFEoakaTCwOyHiLiO4MrnniQ4gb01hOBG0kfc
	 P38dW25eTMf3TysfwckLlQP6FaaQ0OWIwkr8VUzbVGIBl2WPuBpUIR49fI9h1V5rqB
	 1PgaUQwBVOEu99mbagZkFI+HcA3Ha2iSpN+PNnyeobpUAkLn1MG4s+ONSgp6hgYw9c
	 Ycm3S6hiviI1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] dmaengine: dw-edma: Cosmetic Changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260819092407.4150321-1-devverma@amd.com>
References: <20260819092407.4150321-1-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:30:06 +0000
Message-Id: <20260819093006.6B9471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> o Arranging macros in ascending order as per the bits represented
> o Cosmetic changes, typo corrections
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819092407.4150=
321-1-devverma@amd.com?part=3D1

