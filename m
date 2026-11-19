Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116416;
	b=FWuYwWDM7JncukBzPikicKeSIaF+KDnTVsuDMweRHIFyeMHI2rCQbgBurhdAyjADe/2O
	 /AqZCOAFLmqPBgHzvMBiRwhHRAkdK6/ai5ipOnjyZnzDZ9CUob86dV0zcdJCNRz9Zi6vv
	 OLUWQL8MT2SeELzK9vwW5DleEfc8IaNZ8fCLXHSq4grsseV9tQert52sjpPDZnvaRBUn0
	 NC7Lt+bVFWTUlZx6RUGdOCRV36yTF+GamNKK3Eha3JJO7SjgerZTFE4MiF+bXXHvYB2J4
	 AgyApz+JaPLeN18mhjNR5doq4JVJoSoRkQeaDiIre1zYuiqPl1KsmIdL9QHBdzH1U2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116416;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LdkBBP3VfHIzppvuE1udIFF4slj7SbhNVhVBEnpdAaA=;
	b=WiIImBXHPZbKiaoImZzjQ/+yDAXofeJ3s/muEgO5N5EDBC7piqRFlOMLpAfZ+r3OcyII
	 n5vEtaFKQOON5OAmJZBburnKtd+72UjziPio+Ek6meYHEns61OdDLD9vP4FQrCWvJ7nQS
	 ES/9/eqGyM7FpdtK04TX2RlrPVlJPOHVyS5GZg9Ie04bR9h44YAwUhsEmba9RU6jPTNeZ
	 fvC3yxA3XK09Ns+TA752+vXETMl81bv45fl640+s/rdBlfVQQ0r4ZJI1oh98FHHHEiFEA
	 Oz/gTmeLmg3zReSv9gCHVyyggkR1w3ErGbKwRf2N445M1aNz5fr3zBl3ELYF2ULcZSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVmqIu+D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685AE606A325
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVmqIu+D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F6D1F000C7;
	Thu, 19 Nov 2026 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116416;
	bh=LdkBBP3VfHIzppvuE1udIFF4slj7SbhNVhVBEnpdAaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVmqIu+DqSAk4NknrTyoDC2wfPY5TDTuQ53nqRBDU7HMUkW/RHdee9/ZzQNpUKQ3/
	 dbEOfhPOgGEkidOnXxjYJUtMfmftB1A2nCThNCfuS9SsSGzhlrASJIdVnKRh8ixZ4d
	 NXYXMx3NsnNJNDdop6sNgnhqttSDfZDUsvtVWzhkV5PQbPnZ7ITiWgP4Tz6ur51F4+
	 kAnq1zFLn4QaxEZvD9+C0+GmaTk6O73ElTGoYomVN5NlgG9JhDL2xV8pRBhJdFYAJH
	 QAhueszfOWJ8o/EYdvwl/yAuTVZY65dI+q0nsfW2JNpE6Vfc4xyl6DPsVJUi1Km+Nn
	 eUisLd+SvTRHg==
Message-ID: <sashiko-outbox-223881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] PCI: Cache bridge firmware secondary bus number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
 <20261119-vfct-regression-v8-v8-1-12463194e457@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:26:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Drivers such as amdgpu and radeon need the bus number firmware assigned
> to a device to match it against firmware tables like VFCT. The PCI core
> may renumber buses (e.g. with pci=3Drealloc), after which the runtime
> number no longer reflects what firmware programmed.
>=20
> Record the bridge's secondary bus number in its struct pci_dev when
> pci_read_bridge_windows() reads the bus number register. This happens
> once, when the bridge is first enumerated and before any renumbering,
> so the value is what firmware left at FW/OS handoff. Devices behind the
> bridge can then retrieve their firmware bus number via their upstream
> bridge.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-vfct-regre=
ssion-v8-v8-0-12463194e457@amd.com?part=3D1

