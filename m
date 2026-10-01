Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B244F7CD4;
	Thu,  1 Oct 2026 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847013; cv=none; b=rmBtOySgvaDDASxPacTtrtTf5AdX94uQAZxrKBEykB4IbzsHdXz/bpQFfUC0Fo2XME2eo2FAoVAxi7m0dWFG4NaihpJdlb+q2uP6pTisGgmskyrGlTYa/jVaUmVXpbdYiGSqWInP3cOElVcdECMU5bMax1/UwhHIATsFZj98E8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847013; c=relaxed/simple;
	bh=N7vXkAbSdnUrBO+7jZr83sFxlePVx8HF9vj4oLM/r1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DBrj5RLErRmo9CD6Oq0YJIX7BLAW8yfE0S9RRUNJc+oCyDzuUoKWzNrFz7GzM9WRzU+ir7BqxHm4gj7kkbCaYFZr+A+v+aPjOjWD5i9guHpj+llYarF145BMaFN1u+lUqpehfsz5nDiQVbkUBCWdphvNJD10Ohjrlf3vALr3d2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S39Kv7OQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S39Kv7OQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9571F00898;
	Thu,  1 Oct 2026 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847011;
	bh=N7vXkAbSdnUrBO+7jZr83sFxlePVx8HF9vj4oLM/r1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S39Kv7OQ/sSF4J8GFgM/Uf1WyQB0DgbdtwaJI3BwwDwLdL2FXRk9KnPa6RxmtCs7l
	 fut6SPCI+ZNLwRPDMOO2NYpaoIt2LWRYR/+RuxZAzfGxg7eMeG2xHOw5n6QHPdg8ah
	 jPdJoVQZNpncPlSgv6za8TKBVHoYlBWIbhdcnbZlm2HIOInGGwGSbfqj89x0yQYV1b
	 ZdXLk9/b0ucaOPbezOGRrAFzNsAF1STtEK+EFfjI4/Tbx7DhwHyuW/56PEp4QCovfM
	 ft3Jn9sOyF1zM7uY+JP2IxMl43k1z9Kvew1eZeOF3HWke8KNZD9OJY9vp7YOWhiQxt
	 WIx26lhj9r7lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 02/16] cxl: Share CXL port upstream PCI device
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-3-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:30:11 +0000
Message-Id: <20261001093011.8C9571F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
>=20
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenc=
ed
> PCI device to make caller ownership explicit.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D2

