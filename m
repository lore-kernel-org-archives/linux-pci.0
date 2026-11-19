Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795092191;
	b=gAvtU8nlSk5cTCJYAy59ujeH27uioz7tSyLuHNHj+zFAw8ha6go3/xWNxqSYs19n9+jM
	 lMp/ilm9FBW15mXqJ00QOs6qmEvITQPWE1w5ID5TDEnqZwJ3Y/kJ1SqF76IatL2Hu1zAo
	 ebGuUmuwokYC/bxf1OnAHF5SBlzDlp7YJM9XBbr7dspcqFlXFBIw/fLix4xvINo742Fec
	 1W7u2W7VR6KwJ2ZZNdS5mEc0rawdWNK9C6biASdkuVkvfVigCPD8P82CfwiHTfYKPpWYL
	 M4UUK8AxQ6DqUfu/Zg8FVxySf4T6nFR3s0BhcT5h6Tx7bkxCnze2YVEtXWw+tFZ67KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795092191;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IFtqVH88O25FS/6K1rECxpH89bT6cbuyt35iwlIln6A=;
	b=qYDUnof9+EOa+5iB29H916VGUyRzCu7ugbUxY5AFgQ25/rSIwqm/OD/bCFxShK5BRVYR
	 o4QLQ5qe+sI3P7PZriDn7ZnhtTL/qKOcoEmj4v5Iro6YJTLz9+D2ncx7/QoIkLGITToiE
	 LuU+mDhkO+e+MOVPLDMPlIivt1Sl0tmpSUoSwzv5+NLTY6OSq+sfmBAwjxrqO5Kc0l5d3
	 i85xat9bCzd52Ca4Qt7oH94LKt8IRvcYlMJvPga+iSsr/RHZ++S3S38azO0rpUTEQEQ6o
	 ecGnE880znLtRA5vsi34qfqPtH9lB0DreNXgIzMUo2Rsc4s49o3KUqTP5RO/4puQzpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDtcOomN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F2606A324
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDtcOomN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537091F000C4;
	Thu, 19 Nov 2026 12:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795092190;
	bh=IFtqVH88O25FS/6K1rECxpH89bT6cbuyt35iwlIln6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDtcOomNd+8SLwi5yJ5McszFQleAv0hnGK69p4dUpkA0wdSDnq7sYOmpVoDGAOQN+
	 +rl891aNN2OYxLsvCI6yD/aeEZSfFRaEisXiltwDOZZfCdBXitzcwLnxNyBtHKYMCA
	 Rm6D8LKD189kEMnc1oOZFQhZU/YbBCGTtMm6Diyi3DNTA9v9hgWPXHZ7Qd1Zh9eex8
	 J+QgObHMmCnMws4/grunAJCdeWaNS3HJKYxll6EobnzUpulyqidq1O7qqyq9SbAU2U
	 M9GzWBrzUIpvJQccYPgQaB+DKD4A6g1N+x6CBUKCJDJv2Ci+J6obzZxoGBXgbKEXqI
	 ZJgvAdPigtU3g==
Message-ID: <sashiko-outbox-223107@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: Don't block bridge config access while waiting
 for the device lock
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SW9udXQgTmVjaGl0YSAoV2luZCBSaXZlcik=?= <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119123504.25906-2-ionut.nechita@windriver.com>
References: <20261119123504.25906-1-ionut.nechita@windriver.com>
 <20261119123504.25906-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:43:09 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> pci_reset_function() locks the upstream bridge with pci_dev_lock(),
> which takes the bridge's device lock and then blocks config access to
> the bridge, and only then takes the device lock of the function being
> reset. If another task holds that device lock, the reset sleeps with
> config access to the bridge blocked, and every user config read of the
> bridge sleeps in pci_wait_cfg() for as long.
>=20
> This happens with vfio-pci when a userspace driver keeps a VF open:
>=20
>   1. A driver unbind of the VF waits in vfio_unregister_group_dev()
>      for the user to release the device, holding the VF device lock.
>   2. Writing 0 to sriov_numvfs on the PF takes the PF device lock and
>      waits in sriov_disable() for the VF device lock.
> [ ... ]
> reads of unrelated callers stop being blocked.
>=20
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119123504.2590=
6-1-ionut.nechita@windriver.com?part=3D1

