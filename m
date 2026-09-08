Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D554568550;
	Tue,  8 Sep 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882356; cv=none; b=Wm84GHDiExOqNvOt1TRYk7WEUDBq6hjrzOZiZ8KHH6jq8i1pA1b86cKX9k8N2tOE8z1fHqHJobhZkUu/idGplhayj2Acjej1CF6iUdBSGpj8v4jRtmGY5WJSa9ZfL5tlnsYH7pwGnqAxqHfix3TUgqPSME9ZJpbh28EFAJQl1ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882356; c=relaxed/simple;
	bh=O/fF5sj/Ds4z6fXwqych4pUTtgaDwjbqMHosMm5R21o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N/gtpNY1yNEYVXRBBbq45luD4yNygNspl7QJ1ePWDPHKdp1IFeqhZ/3N7eX7YkSboHZ8n1UEfPBfZ2Dj6ZW4GtHT1Ic+j+1nJwohgG+4Cj8S6YhEOOfhD4k2mZua9WXTJLviEmgND4napAxRsAfRmq67Nf4+iPts2DM8BwQ3pC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WelHplo8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WelHplo8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD311F00A3D;
	Tue,  8 Sep 2026 15:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788882355;
	bh=O/fF5sj/Ds4z6fXwqych4pUTtgaDwjbqMHosMm5R21o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WelHplo8osKHlCoqql1EpU0QU75iVC1fsbEQkN1xLHhVEFlwBToA52vG0bdBeAOhl
	 VIEJSXshuhJJtWvCrf5PAFALZU9k0lF6zrhjV8du5A1iW+QQslXKc5m51mUyIOLOrI
	 7+S+6HzParyFM8fzzeukaZq97LmFKoRfjAdMPoxw+aHVaogfibL5vCyzigXQzpAJnh
	 rTB4P0OCORaqMmPs1wMqSM8LjSQYdzpi4E+IlrZJqbz6OoHaKed7jl6si34NPt5hDl
	 AVc7hEasvu99nPMliEo6b5WJe6EoreIjjMLf3VeOQmDR2hqEZ0J4HVfcdCG/cC6L5N
	 cYHV6TMZeD/YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] PCI/pwrctrl: tc9563: Switch per-port reset to
 GPIO descriptor API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260908-pci-tc9563-aux-v4-4-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
 <20260908-pci-tc9563-aux-v4-4-c7fc7778292b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:45:54 +0000
Message-Id: <20260908154555.0FD311F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Remove the local TC9563_GPIO_MASK and TC9563_GPIO_DEASSERT_BITS
> definitions, which are no longer used after switching to the GPIO
> descriptor API. Move TC9563_GPIO_CONFIG and TC9563_RESET_GPIO
> definitions in tc9563.h header file.
>=20
> Replace the direct regmap-based per-port reset logic in
> assert_deassert_reset() with gpiod_direction_output() calls, falling
> back to the legacy regmap approach only when no reset-gpios DT
> property is present for a given port.
>=20
> Add the reset GPIO pointer to struct tc9563_pwrctrl_cfg and introduce
> tc9563_pwrctrl_parse_reset_line() to look up reset-gpios from each
> PCI downstream port child node. The lookup is done lazily at the
> beginning of power_on(), returning -EPROBE_DEFER until the GPIO chip
> is registered.
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-pci-tc9563=
-aux-v4-0-c7fc7778292b@oss.qualcomm.com?part=3D4

