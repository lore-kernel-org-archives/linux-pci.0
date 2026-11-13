Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568666;
	b=iz2nOSEdUvPf/MqvK7TkwMiozVcNSv+Uj+Z7oNmcEWVo3aswK52yQhfu8Jb2sdgp/TVw
	 6r9V/9OBMSOWuGEO4W9iA0vS1e6yEJupLXUKzy+QkaW5UufrOPT25n24ucLW/GkFtxltr
	 ia/6ma3xQs+4AGE9xf7iNkVk3P6E2i1GG0NZVtCNjxr351nFO0CWQUvJ3aq3dURhPEDh0
	 KGdmi1iXSn0i/SmoZUrqHryMmiTbNW1rB+eX9O/gP0lOP+KfaEhokfzOwdST0hcsJmoVY
	 wroW+U93cg+cas8XG0R4/QOJ5yt26xeEAc0gR8lv8WtcWMXg9lIAbz4sH7ez6Sf0k4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dJdlDBXRBX38JQA7UQ1FR2qIOh+COWSAFrnVXP7XUdg=;
	b=R7JkqXXwl+x9VRXaNYI8DVwphyYnHN8L2OaK00adhMecpKz43B4p4xu9ZfU1jqUiCIXS
	 H/OJUBpsbeXpA8lXavGE67iIKBywrW+f9A3ZW0wi6ba/5AmDFoSls4xgsUzL8aMP0FtrX
	 7iSR1SmrIcMD2JXb2tQLesertmYs+Q43FPbA5wdKrWsBicyC5IKHQ0Oi9LymQFVRTNfIC
	 TaR8TEr34fa+vBpKQa04QUTaFTRwC4/eSzbJbvVE1HkDg1oyxZj7vymUlGUBufi07aSNJ
	 cgXz48r3o3adZBs53qiqEUzr0HrKuIAtXE/4awToO11N6zekdcDBS2Pmc5fmmQPwpcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMBKQGi5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46636606A332
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMBKQGi5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A549C1F000C6;
	Fri, 13 Nov 2026 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568665;
	bh=dJdlDBXRBX38JQA7UQ1FR2qIOh+COWSAFrnVXP7XUdg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cMBKQGi5a1/xT2/r+rMY8gEcISnZApEOaKlSWttRac8JVS+UUPUyTK2vt8v2wAn8R
	 kMhq2k+L/3A/Iv+QMftyVP79oROHvSrA/AVRwOFemKem9f82LFC33hMLEOmps0ju6Q
	 4qaeAvNGlML0BrAuxCX7Rs6y7gIj8zD7Zf2930VbBIGH0GiWr0fOUwPGxox/1EAI9Z
	 uU7FBPknXkD0FAFUTwZPBRum49k7ViRTYJo0wQ51uwMi47ge1uF1ovZN55ifHZrdyI
	 gWVr7yP5UAI/N+P/5TJt/F3w9iYkMBAGijZh2BYXFexPsBFtl5NA5ZCveVIitReq6u
	 RcsR1D3OWWMpA==
Message-ID: <sashiko-outbox-212696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] ACPI: Drop unused .driver_data initializers in
 acpi_device_id arrays
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <b7c5533882b5a979a4ba19a87e9ba1b13a24023d.1794567577.git.ukleinek@kernel.org>
References: <cover.1794567577.git.ukleinek@kernel.org>
 <b7c5533882b5a979a4ba19a87e9ba1b13a24023d.1794567577.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:17:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Uwe Kleine-K=C3=B6nig (The Capable Hub) <ukleinek@kernel.org>
>=20
> Many drivers explicitly initialize the .driver_data member in their
> acpi_device_id arrays without actually using that value. Drop these
> assignments and while touching these lines use named initializers for
> .id and use consistent spacing.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794567577.gi=
t.ukleinek@kernel.org?part=3D2

