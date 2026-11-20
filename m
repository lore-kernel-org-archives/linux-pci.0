Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150273;
	b=iS4xBdtx+UvP9QHTbXbzUPdHa+lu9JUZzwY8ofXblwSq9WGgTKXc5x+IQgeguW/5i8My
	 9Ed6ybequJ8oRtkQ0SvFajnAczzpQWxj1Ot0RML4AlckdWWNMsoRv0KNqg7BlAKI5TFiU
	 aq0mfuisFpvtMtVmo+GSwgcc/G/W8CuKfO9zRm+1E51JjAmKRUQ8bDjh6YxMTzPxQ7XjC
	 a5P6OaR8nNBA4HsMzT6Njkhhiv7GjItt3xa+ApeN4pfuwoRTP3MeHkMbvzxRFZU92m5Rf
	 jB+Dmc0VDOl87px9+3NFoCVomthK8RBU4J8XNATfOqWxxlBO5lTNhltPL1YzJC1uMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150273;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3j8jAewe9Fmuh95eiwVaJu9wUny9vnWw2RMLrOIN4sc=;
	b=2MJMjPkow9NPxRZ98UrmRWIjd5X5lY+IntY26Od58dvI97NNOWZsPFUTIBP+hwxZE+ZN
	 qIfqTbkSzNdfBcaStsEo2uf46hJdO0uwvOSZ68aC/YhKyOsnZLxCfLuJaGec6QwclCd5m
	 SdcjoFpMV4AAMz8oSBe1Skl1oTYrnlWCY12+sUrz9+3P3UMIsPnuhPOpJDTSo3DQz74Nb
	 JuxTzDsiSrW5Dg6QJfey4GPNWYAfg2i4MJOUtH/Hv6LhYBeOeoIFQDOcx3FKz98W4BDKE
	 sU75eAQtdll/XwiEefYkwh12CnB408RHa+Mq7grmZ+7BsFE0zkx5vBgkHVCB59eUD3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNxwpp7J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B080606A33F
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mNxwpp7J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA1B1F000C4;
	Fri, 20 Nov 2026 04:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150272;
	bh=3j8jAewe9Fmuh95eiwVaJu9wUny9vnWw2RMLrOIN4sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mNxwpp7JHad+5sSrKHM1GHltSTw9T3gij6pBcB9vGc+TNaaQA8e3L15fy2FNhQ2Ee
	 KXODwpmRwLGj24Bm/YR/W4zTBarqYd/iEkOmuxMRYlQvgYCAYfsGC0gHcGXjppZyFq
	 dEKJI29qaa208i+zwuYu2fnDW9/tGXquCv3CtHrJb1ZIGXaAfg3O+TpOUJ69TKsaOs
	 XDP40a4qdo3VlrGeyDvfwjsRmWsDUsbwcjbXJWt+dLYhCt0J8qpudOPtyL1X5/+BJR
	 8Gu/Z2SYsv8f/GMOOg/DY+9FrBJaQeg2rSj9xBIS9teH/7lUspNgxKM+6C7yqgyxKE
	 aS9wx/iaUy27w==
Message-ID: <sashiko-outbox-224477@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] gpu: nova-core: gsp: add the load-and-execute event
 dispatcher
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-10-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-10-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:51:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The two load-and-execute events of the r000 boot protocol arrive as GMC
> events, and the command ID of a GMC event names its kind. Nova-core has
> a handler for each of the two events, and no code that selects the
> handler from the command ID.
>=20
> Add a dispatcher that selects the handler from the command ID of a GMC
> event, decodes the payload of the event into the parameters of that
> handler, and rejects an event with any other command ID.
>=20
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D9

