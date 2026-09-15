Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BE451983
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789456132; cv=none; b=odxT4a1tXNu+7Jr4MolKwWggKG3O3+3iPvWsajVgxqZ//lTcKjSrW2hRz6xK3uqEAUwInGm4MDmtneqPEhwC4xbJeIKS3tX3QK35klHWFJanEAd9dE3fO+Xdsd9B0oXMkrfOZF+tHmf8zcnYdZfuv2RBB5uMyMClcG2Yaeb9m4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789456132; c=relaxed/simple;
	bh=JE7lS3u/jUI39RDczRz6cYIHPYRdrQ/m5c8wxAjzmfA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwsM598Y67rHA5AMKJr67rH6F+lyUswWYMx2B31lILIdEjKGpD5moH9oS6Gcq9B070/nM3tWgkXj5J+pTLbARRfwsyX5Dwh8FEsJKHzkYjXThnVZW2PuuogxumkiwSIYr9/51cf37diePUH4bhAnU661AoAAaJrv2ILWUe857+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoA4v9Dq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoA4v9Dq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A59E1F00893;
	Tue, 15 Sep 2026 07:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789456129;
	bh=JE7lS3u/jUI39RDczRz6cYIHPYRdrQ/m5c8wxAjzmfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eoA4v9DqdUt8dM+s4V5aPaaCDveoTOKLLOdu6PcaLfLTW0DxZnFhicfvM7y7zbTa2
	 v7uiodWF/K9o9GOvljxcJ5OQPBolpIZcxW9Hz58FLsIEx9nBv54DxWgT5rpaG1Q6JR
	 DadPHpVetHzEfWuNkEpEDeXDyhlNH6RXzREyHGzhg5WtTG+voZR1DYw2X+kMo4TFDx
	 hddFxoY+PjrdoxxOipVpUHhBtIk6IX6nwlR1a/ZK9qKYeTZoNOmvkjp22ylaIH6Sfk
	 TDLR/YZB7WV6Fm1AZQtc+E0SVrn4iKWCwfK50INPKCrgG3//5OLiBlapvAfD3on7GU
	 7zv4USWmTKVBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/PCI: Fix device reference leak in
 pirq_find_router()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260915070310.1733310-1-vulab@iscas.ac.cn>
References: <20260915070310.1733310-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 07:08:48 +0000
Message-Id: <20260915070849.1A59E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_get_domain_bus_and_slot() takes a reference on the router device
> looked up from the routing table. If the device is found but no router
> handler probes it successfully, the reference is neither stored in
> pirq_router_dev nor dropped. Put the device reference when the router
> probe fails.
>=20
> Fixes: ac7cd5e16df8 ("x86/PCI: Handle PIRQ routing tables with no router =
device given")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915070310.1733=
310-1-vulab@iscas.ac.cn?part=3D1

