Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118087;
	b=j8LGxnQjQ39ZBOq2UTwrphK4K3tha2mGho5Lek6RE5xZF5nCnstbM6tKQAZg0vTXXNOP
	 QzOYiWWZAptj1udBjGcXPsJirHR8+3doLSCmpuFlEQHUwUJQsTz+KX5ZuJBW3tzOFDDDg
	 j+K6HUG17kE7Jc75EkDAPCBkvrCqThOaKSqIqWM2CyGibyxm/XSCy5lgrHDP9xt5/eh3n
	 3sYojhyEQIZ/LC2088YjnW2mHqDUifMf2UfSpURUvBjX1SGO1v2xqEjCBoQ7cmTi5ZENh
	 Gl0MMM4CMtzvbHheCEwiYeHoTcu+praOJS/BkID3gM0DupCk+1L6hgr3wKCst4am0OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118087;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2p14zzEGnI0bMDaGqPvYHpV3lc7xj5lB6i22zU9RbuA=;
	b=0LAXRuast93hfno4wy769CCfnubK3TCXQi7PaTdVod2g3gspusWq9xrAJtRCZPjSMOA4
	 9npdfb2zpMgMIO/m6An+7XlJjXP/9j+xiZTtoKauaYSdaJJVxXTjPsTgyy+W4HyqQN7rF
	 qZ5Q6dtG2L5zocqUPxMPTI3m7ZTt9Z8enZ8camaZgm1OFkMX02qcfVB9/7lMcHY58vzJW
	 imT+3/BzI1GfrYo2jWWcc9Ukm9jhN5U+Y+V62WsyOZg+eKm7psqYsBrqh2ocoODm6Eti3
	 zivdwF5HpuGdaelw+qVRJLT3BmZsc+yrTzEZDXivq0OGj8hyBxCaxKbCcWNdpZQKRNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEAXJwCv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4F5606A322
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cEAXJwCv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89AD91F01825;
	Tue, 27 Oct 2026 16:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118086;
	bh=2p14zzEGnI0bMDaGqPvYHpV3lc7xj5lB6i22zU9RbuA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=cEAXJwCv17+gApZOb4bLbV0ttBMmtMvVnxu8/tGklLONSUCRbo0ZRFjrnMI+jKrhG
	 PNxYP+9AmWZoBXp+9kFcOh//2Ezb2ds3Tgs0Gx3SDY5GSCzmCaogua5XalfAkfhXhT
	 hoWOyKxExxxsNCKRA/qSJfR1TJISW+z/kzQsAiNCOcdXyxVZl66+3OMovoKGDJnc6y
	 uiYpgCzcsEjCTprE0WQFWyX17MwCDb58W5dVkAWgo4RnshTdJrBKKQs+vwj6Y3Zle1
	 BngF8eQgT+sQt4+wjDXLt9E2PQFgPd0mFCpf9CavcE9YLKbhJDI3OlAZEZd9aijRMM
	 TNz+fFFcDZgWg==
Message-ID: <sashiko-outbox-186902@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] drm/xe/pf: Use pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-14-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-14-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:21:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> xe_pci_sriov_get_vf_pdev() implements its own VF lookup. Replace it with
> pci_iov_get_virtfn(), which also takes the VF's bus number into account.
> Previously, the VF was assumed to be on the PF's bus, which is not always
> true.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D13

