Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346382;
	b=xs939tCheiyIvitgzpUSO7ZWTbrHyt0uo5kSxvke8hDiNnR2ZdlwzHeL36JWJERw6RlO
	 RxMiz1Tu3KI0qkhb+7jEw8psoqXuZ+Qywbw/vX9W+4dYuOkwgxs2Km5QwExwz6k33FfXH
	 sZNhiige4BctnvDYzKmguIfOCKWo3ZUKrtKAaDuieBovMcw/S4x/boRK7VWnUXap2IhJj
	 NhsQEZKzn+4bSW4FRuMNPC4wMjLlGUiQZS+usHgwDRJE8zkAaMb1XXD+M4rYKwIihm+b2
	 CRp410BPmdDyF55XBLjgLXTXAfqQueA9BYEtZ+Y2SxH2Vg1b7evFpZymaAcBCOa5PNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346382;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nWGDoIpeR7JV3zctK2LkyVldby4FTDkgu+WwCEhQEkQ=;
	b=Bruk3A35FPjOGcEMMFglNZ1sBI5qZky0CLfql6tXpv8PjJiFUkXCZ7/FKF6nH4C1PrkI
	 eCwNKAFRqLFtfVnIcA75l2+dvvPq+OfJHad8gdubyDQh+DXoXzhQcU5Xprlqle8L06jdS
	 vQT1nlmfbY1ILRMFW5GUVRMuS84LyKx6uzdUwcf4WB9L/uPFqKUeHI6NIEMKRAq8If0p2
	 5S85vG1Qj6fg6UERo4s/lsltKsBHMNMSSEhtvkGdmqRb8DQPER7rrMfpeBPyrmhIOQWO3
	 8NE+D2EhLQ3QIuBMvkNcjF/4cSDG0PvVnE9J6b3TOxG7omNahtsUlPl1HbfGC6sbBbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MWWy/3c3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C03606A320
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWWy/3c3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFFE1F0089F;
	Tue, 10 Nov 2026 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346381;
	bh=nWGDoIpeR7JV3zctK2LkyVldby4FTDkgu+WwCEhQEkQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWWy/3c3kyC41QuwZad4ET1KDiBGt03ggfXgRWLgHdIpp8I9yzV2G0PyWKp8J5ZsI
	 IoDeW8pdxoKfbvbPLYvCk5Lfda4Th+ET2rFX8YweSoNHA8i+k98MImVnMppYt1mUCp
	 68QpdsMN9mn07I9DSojvPDV4QgwURl2SA+WjjNZG71tgZ5TGXOnpjakQsDkR75/CzD
	 as0T0NE99A66oLMcPSe57EelvMiu42Xc6DCUJQx19+iKIaQqBnDYB7/ccvNLqjOi3Q
	 5oJIby7XNG8U8ma0C6mzAgubyKXn1GM9Q3KV7qeCtRDOCcet87bJg+ZeDrzWaZP7XH
	 +HaV60iFlIcaA==
Message-ID: <sashiko-outbox-207770@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] pci: Add broken-GPE quirk for some Lenovo Legions
 with Nvidia GPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
References: <20261110-broken-gpe-legion-v4-1-c672bb1c4d91@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 21:33:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lyude Paul <lyude@redhat.com>
>=20
> On certain Lenovo Legion devices (including the 16APH8, 16AHP9, and
> 15AHP9), the firmware appears to enjoy firing a GPE on the parent PCIe
> port of the nvidia GPU very shortly after the GPU enters D3Cold. This mea=
ns
> that every time the GPU is runtime suspended, ACPI firmware immediately
> wakes up its parent PCIe port, which then wakes up the GPU. Once it falls
> asleep again, the cycle repeats.
>=20
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>=20
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>=20
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Link: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
> Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-broken-gpe=
-legion-v4-1-c672bb1c4d91@gmail.com?part=3D1

