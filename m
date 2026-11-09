Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258770;
	b=2D8KBay9IVL3DoGp945BiyaoEP0DjWR1Ozpan0zPjGBsE3WtxAUKAs+rsVP9uGZEAOJ3
	 e2yh3F2fsDxLiA9rUwNAYXmwB9idMvtn2C7RF6SDIuSIr+RmzG65rX9Im4haSD+1o1x3W
	 o7hsYYaxmvGjigbyhIrNRHBNeWcI4Q5xuBKRziyEFe6KjXxbIvX6IdBVfO940V+auxyU3
	 mDObO6kmNXQSH395YdWyDaf7cI5JlAIT2wZirXH7HIGgv3wynI98E/MdEbfGTyPQ9lLHK
	 nahPVV0LKADfrdmk6QVlRNno5eL6WQUewKzREgb2eRfuNrk8lfGUVEGWRcfgaWy0WBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258770;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pTfxP/ikPvU+wxVHAHRHe3LaRAimU9P2F2Czka3oymQ=;
	b=LqyXyJURJf/qaVyjpWaC1zy3KQQnUaoYRoecE8A3m3wjLTM66AUosjQxmkruYlsErp4E
	 sD1d4J0Er9WDX6FNLCCxBQs5asOdl1aP48pZlJEg5jy614TOBal1YbsTmwbxPf5Wwmic8
	 sha3NEP145eD4DuSco7a8WZTZJrfeoZP72LawFBnjSBu8DNTHqhY8lo/0cg4hMcWQ68wZ
	 s1qgdeVi7+tuee6sWTTiaf9wrhPbcJ4jhmt43pTKSDzbB14J5HnxoKjKGfLYWMAMA3iz9
	 CrOT4e8iX5Y6xM0ZcwVZxqpZTKLwP/hdlfmBJu7BbcB8/fALex5tbK+Y1Kg2Dt9Yjmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRF6dLW6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6588606A326
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRF6dLW6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C4B1F008A1;
	Mon,  9 Nov 2026 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258769;
	bh=pTfxP/ikPvU+wxVHAHRHe3LaRAimU9P2F2Czka3oymQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=TRF6dLW6UHkL/ZNQVDdPNaaFr69zs4KFsPjm184q7BjQyAu1gyI/csC/hRumaaLbM
	 YKBiInF1xaAqkLG3OxmMnrCc1lzpL/gl38ony7gT3YvNt0I6dhJlwz0Lm1nNgXm0j3
	 DHmzS9+jAmET0/VD5OpPMQ1+A4Yky+S9MOvxV8VhwoNe6SadW6CX1S0H8wUXDw5SzW
	 Jj/SDI2xid0I3g1npQTtFacSBJvJ8lNB5V0mSNMTVHQqkxp6Cz52BKe1Dw8/i17Qzg
	 KF5O7ftw5ciKyFPqM2rXqDLpD0viccjzevcd3iGaVmkyENDInyfHo8DU9dL6wsaK9R
	 R12B7RwIAxolw==
Message-ID: <sashiko-outbox-205642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 07/11] pcmcia: yenta_socket: Always select CARDBUS
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-8-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-8-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:12:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> YENTA selects CARDBUS unless EXPERT is set, so with EXPERT, yenta_socket
> can be used without CARDBUS to support 16-bit PC Cards in the slot of a
> CardBus bridge. An upcoming change makes the PCI core ignore CardBus
> bridges when CONFIG_CARDBUS is not set effectively removing "partial
> CardBus support" from kernel, which leaves yenta_socket with no device
> to bind to.
>=20
> Select CARDBUS also when EXPERT is set.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D7

