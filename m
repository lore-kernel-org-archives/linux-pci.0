Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150176;
	b=MgECNe1f65dwVA2fN4HE+TYNTbcuFcwZPVXNKH/QxgKP4OHyfpvpHKG36Vr+59F/An6l
	 KEK7mYDAJvwP2MWEyaeqJHdN/oFvqPq3ccl65YIEJgrX0ZnQNitI1c4gxYK63z2zEuUCt
	 4c04QJZVZgEGnFvA2mP+lYbINAbJjMrq77X+XQ5lyO1wfNbv/VkHN6qRtOwClC023Fyh/
	 VsYu/vC1Tm+EFE9kODkZo6VT/mgMxP9Dp6JOSDW8zp2hNeh1MHUooW98mido74Rc9F7ju
	 IEUqIR63cy4AGuD6scX4udy/Mcv5Py0NN8Yh8ifVcF0c5zBaKTPnW974ccbieFq1GtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gl3x6BZjRXAZKj62Tx8sgb2w9vrizPuXmx78evehn7o=;
	b=0P/de3NqQBVxBRctdvLiYPh3ZB4UEoUH5Q1bCpTC1N01Lno32E6o4/VeKK1JII8QaUDl
	 3nr5po8SC6t4KDA/VECRTE4RaGU0hvwh5zH3fVprh+pbrHjo/lr3y6QLUnk/BMWR1bDG8
	 RqCWV/z+8KfL2JgB8K/c6/KPMpL/tAGJYVqagk1XK4cqwQ2DAMksKkdmrjvknlNIvEazj
	 Tif9nNZM2G6KkMidNgacRI9bfc82qTte8G+k4Ovf9/sodT4SVkF4XpFzz9AZz2DgLbams
	 kcYZC/eg/nlAv1UH9ragaPLkOzVz+K7n1ZwIpQWOknYjqfaoY62dp+xZeU8jivydRCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1DBeWcm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0F9606A33F
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1DBeWcm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180661F000C6;
	Fri, 20 Nov 2026 04:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150176;
	bh=gl3x6BZjRXAZKj62Tx8sgb2w9vrizPuXmx78evehn7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U1DBeWcmh0JXlZhulHaMaVFHpL0g0wnCS7j07X6NknkrvasMeLKKGR6hEkwCfQ8uw
	 Py7w6ugglKGBox1IqR4veI+64e+f/v+C7B6vCax50Q98VqgIcqkxp9hFXAUlyKeNsB
	 uy3KREDxQUgdZLdig9KfP2V5SaJlMdDQYmipmRzAwGopAuSQOL4q1JY/kVSrt2m6PP
	 wRxaeyqLqmS5AGARZNSr4Xo5Q64pzHUq9nGWbZYF3OoLX0YbYD5tlLmNRWo7XdQK8f
	 q4b8PfAql5RsUE3Zw1ER0CWy3utFM6GMBwaRQ55mnZsl5mg+o31jT2zsSpVNgmyXLd
	 slpIr+gyti0KA==
Message-ID: <sashiko-outbox-224474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] gpu: nova-core: gsp: factor out the core reset and
 the core resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-5-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-5-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:49:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The r000 boot protocol requires the driver to reset the GSP falcon
> before running the binary of a load-and-execute event, and to resume
> GSP-RM afterwards. The core reset and the core resume commands of the
> CPU sequencer already do both.
>=20
> In order to make the core reset and the core resume available outside
> the sequencer, factor them out of it, into a module of their own.
>=20
> No functional changes.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D4

