Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282028;
	b=q60IkLabObiAYJ0IcqTwvvMOOXaUy7BTVmHvDIBZ4B7Fdro47mBNAsqX9HNpCEwIwIUm
	 fNNGzhSiWJxyQCLrvlDR1tnouOcGNwAEcBh5Yw+ChCVLWrZ/GHMgXAAVbPwCiZUS+bD6T
	 STCHBH84B8NXghlInv/kBNl/gjnM0aIO0lnZ0zPZSmluie+0xgp0trh6eoFoHUcx1mLZk
	 YMZYNhh9FqvP/ckp7bNY8vrOa7YEM7YLqDsqOP0O7KZoEYEEId5id/x8HiSfRpGJfr/3H
	 9j5kiXbDiRtr0if1xfhGOwRLR8CkVnN5XdygazEeti2oatCh2P2ElQ2uz+SZyQoH+Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282028;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZuylRQ5pylJ0JkAU1kRqhsApPrMdeXwhsuydxo+uGjY=;
	b=Q2TgTX0uxpJJQsI9UYUrTFfTLyqEX+s0BnLa48h19aAlDteyvak3YBrwNl7gRP8tVItT
	 NDUZglC8pfdR0LhQ1FSLXIODoAfqQBugHPtjj1sd0TrAN41kPs6dAQymKkR3c8iI/iE10
	 tMx4ZvpGEHRJQK5vvx3BGbUsv9zNm/HMjTzzaxO8MVcW5H4nG6esS3htgjn5MlHadRL5l
	 H07A+dUdqvJV+F2mxMyYYE91XlXb4z81x+T2+LUHH5rovZwsAd0hr3d5dKyQ63jjpsaKr
	 mjQ69QeNdwNdHzU+vlsFPh04FKLIrOvOAOJWHQSM6h+yO63ZFNF3tjnZGNiLblttLJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1HJKgxs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F281F606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C1HJKgxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1ADE1F0089F;
	Tue, 10 Nov 2026 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282027;
	bh=ZuylRQ5pylJ0JkAU1kRqhsApPrMdeXwhsuydxo+uGjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C1HJKgxsYLqGxQL+rBmmDifHaUGIRMDk+maACGEkGuwHTixCyGh6EZ+YlzVsl6wxn
	 t9261gUFODRH6mJDLDzY+Q0lQBQzZvndidMYueXZLUkY0W1HN3XZxUZ++93444P5YH
	 51hAY0L26IHxg7vZpiCVOP/QZPlUEin+EPa9AxYITJ0fpu2MywAU+qzfyHHcYwHNmQ
	 ayi6TOC8Yx53QZjdS9zdZaSK/UOt4XAnQ9SIDZHKlQvrUP+pmIaprn2zkJz556z2/Q
	 w3NpU2iViu1mjWPi6qBdV4HrTGF2MyhKm8JcVa2dnf+XZjH+KsxQetarbqVGHRVEn0
	 +8ASW2MRfCoFA==
Message-ID: <sashiko-outbox-206134@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] gpu: nova-core: factor out and expose
 Falcon::is_processor_suspended()
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110033655.148487-3-jhubbard@nvidia.com>
References: <20261110033655.148487-1-jhubbard@nvidia.com>
 <20261110033655.148487-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 03:40:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The r000 boot protocol requires the driver to wait for the GSP suspend
> bit after each load-and-execute event. The shutdown path already does
> this.
>=20
> The boot sequence will soon need this same functionality, so factor it
> out into a method, and put it in it's logical location as well, as a new
> method of Falcon<Gsp>.
>=20
> Also, use register!() for this, instead of manually masking off bit 31.
> As usual, that results in much more readable code.
>=20
> No functional changes.
>=20
> Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110033655.1484=
87-1-jhubbard@nvidia.com?part=3D2

