Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267636;
	b=lbIR4i++8FU7TAzuXmciVGZD346TQGsIQL+CYiowU5CZuDXuqw9W3JOi6SmLkqD4mcLM
	 lqS3wAVM+U472IMXppD6K7ZWB0RPWVx4Lr6ymyF8jC/UTv87nPyKWMWOebS9DSRu7HtZj
	 pcPX2T47D+fLpK1GEdxbNB1UHplgMoCWn0J1hPTrqXryT5QYi+WLBgXudimUes1GW2mqS
	 wh5LFDmbltdTiOiRZ/gtOFQhjpvkYXLABMt7pL74MGoRK/sndlxiP2CALzlZe8ctH//v6
	 HrkZS7HpLdqLdkS9zS0lO+bIXptuyBw6mu0TrigPcezxdpmS/QLcIyfGQPpU//076cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267636;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OSbV1CGm3k+Zkuz4WRaiYfJ1ghuByuay4xdIaxXqNHI=;
	b=heN2mSTBGqK7nMpGvRJfuDGao4fdhdcIGO30etGNfgE2dMkx0VyebN4n+3Thea/Xd35+
	 IxP66uR3YNGkjN23iXQcgjZ64y6d6BBHBcEYw9fF7JLFu/6srQlKbVARYx5OFANcBeJSb
	 MFCkOiZStu3D4ZL7oWWAVH5EkATHSOo2NoVfQGrUy7xPcKESuqKr6D05snNafkvL11bWi
	 xwzsXNKis6S+1ASUUGunwdtf6zIqxMBxzGtWy+ldmHoJoj31ossVwKW5tGAT2mGJUw/U2
	 i3O9GKmzxMag69BwpUIc3gvdI70lRBbLGuc+AdSnvCKOglo0Ibjbxt4cvX4fQTzGwaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuSOEXYe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC25606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZuSOEXYe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243EA1F01825;
	Thu, 29 Oct 2026 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793267635;
	bh=OSbV1CGm3k+Zkuz4WRaiYfJ1ghuByuay4xdIaxXqNHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZuSOEXYev0JUM4vU2pwT2UBMnpO5lV5zyCbJW9txEx3MoCKR5c3pvFabj1ZKSSJw1
	 1Vyn9p4DicjtGCWns5n7U+MLbTrH1rWsMqZA3Cqnair7sMC1qmoaRIAWJ7JkGD6ry8
	 VTB5Rjbwo0xTP7FNJAsU1FfotVUUEfBt2HvRhAGiu+z/yKjRAuuv9Rdx8cVREwi6k7
	 TGDIHo7a/8RpQRTU/fldiQEL5PNcqki1Kzx31lpEVE6ut1QLx8dqeIrSM1wbwa7ezg
	 Fy5OHjwOCMv8thdWqqvhFZS4/zPF/IG82qA9Q5ZhlPixvK3qXooMFWDjk0XIJGT0Mj
	 sVGqjgGmVmcwQ==
Message-ID: <sashiko-outbox-189071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] firmware: qcom: scm: Allow QSEECOM for Radxa
 Dragon Q8B
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xilin Wu" <sophon@radxa.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-q8b-dts-v3-4-655696dfec45@radxa.com>
References: <20261029-q8b-dts-v3-0-655696dfec45@radxa.com>
 <20261029-q8b-dts-v3-4-655696dfec45@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 09:53:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add Radxa Dragon Q8B to the QSEECOM allowlist for enabling access to
> efivars and uefi bootloader.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-q8b-dts-v3=
-0-655696dfec45@radxa.com?part=3D4

