Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515442;
	b=zqT3pSnYcFbZianUuSP+43YEh+51Y964yQU5A3ZQE07gouwDfpu2ThYR0G3t1hQ0mWse
	 Gie+Sdx1YVotmi+f+khQdB2EBsxA3ZTCusnRDXI7qqOwuvW55D8PiBd7elj1enEKlRnOA
	 rSfX7iSdPgONzDn7nPoRh6mry+WSMTUuXwOWe5YnedEJpW1LD6/hJkkyXaTnnd2NZxnQw
	 qOh8HJrPBDS8cIqmVNdCz01+3FLjrLfPAQIdxBRHmXuHNyB1vP7/acoyh0OUWPVZs+AKk
	 plr4mOBA/zieWNcwT+6Pt1y6jlk9yj8142DIgNXGQ75KLKYVPgZl+SrRPgtlCgmP4Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515442;
	h=Received:Message-ID:From:Subject:Reply-To:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DYyeC4wsrvfiAfaX9Rid1EdH8JoC7B2jLyM1UbegR+8=;
	b=JHm9jKFsukP7uKYMs929xpieg4mGtDiuhpheA2GRY6ZL0oi7jtDtMMzy5mKjnE2HemCb
	 uLfM+B6RaB5D0WevKRmWlTI/C4isFFxq6Hnk6ZB17SUoBGNqJWDq3XhkWvJN3gpAt6IKE
	 xFJNaLhq0+iz/eqle3v4tkT48+I7xF48deKauMphU/anv/6vgtixThMibJ1cljxrIPgD2
	 hWAWJHCDBW1B97Jjddc7VZSivXvCX7Dd/Xiku1/3ryRSg6qt6JE/C84lhXhZfSofl0biC
	 VynFBkAO9yxhIAgEMGX2PP6PlnXhvuO1BW6Q0yqX/NuGPgtyZeIS0BFtj0kzckUcLdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EBF606A320
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 16:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD9A1F000C9;
	Tue, 20 Oct 2026 16:57:21 +0000 (UTC)
Message-ID: <sashiko-outbox-179389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] driver core: rely on put_device to free dev->p
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Jeffery" <djeffery@redhat.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, "Tarun Sahu" <tarunsahu@google.com>, "Stuart
 Hayes" <stuart.w.hayes@gmail.com>, "Laurence Oberman" <loberman@redhat.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, kexec@lists.infradead.org, "Ewan Milne" <emilne@redhat.com>, "John
 Meneghini" <jmeneghi@redhat.com>, =?utf-8?b?TG9tYmFyZGksIE1hdXJpemlv?= <mlombard@redhat.com>, "Bart
 Van Assche" <bvanassche@acm.org>, "John Garry" <john.g.garry@oracle.com>, "Jeremy
 Allison" <jallison@ciq.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, "Pasha
 Tatashin" <tatashin@google.com>
In-Reply-To: <20261020164435.80499-2-djeffery@redhat.com>
References: <20261020164435.80499-1-djeffery@redhat.com>
 <20261020164435.80499-2-djeffery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 16:56:50 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Tarun Sahu <tarunsahu@google.com>
>=20
> device_add allocate private_data for device and assigns to
> dev->p. If device_add fails in later steps of the function,
> it cleans up this dev->p which is not necessary because In
> the next call, put_device free it anyway (if reference to
> the device is 0 which will be unless someone concurrently
> get the reference to this device).
>=20
> This avoids unnecessary races introduced in system. After device
> is added in device_kset->list by device_add and later steps in the
> device_add function failures occur, it will free dev->p manually,
> while in between there might be a user of device_kset->list will
> take reference to the device just added by device_add. and might
> try to access dev->p. So relying on put_device to free dev->p
> prevents such problem.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020164435.8049=
9-1-djeffery@redhat.com?part=3D1

