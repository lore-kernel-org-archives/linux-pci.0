Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206D40B107
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255809; cv=none; b=P5fD0iZMVQHy0X4FLBRbDzB52BYwyKiBsbiil1wU9SblCBb41Aq14woeJrFn6hFcV6Rn9VfVZ3swp5dceHEp42Zx6BnI6ic3WVLCP1o1o46qhgch3RUj0Un1G6Eg5h/YW99rasGO7CrAc7C5SfXNC6mKmh08qW3EAKhVpk/hclY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255809; c=relaxed/simple;
	bh=RmBGPPmnHZB7sWOryRhUyWXwDesZ2C671GMYTmf7+wE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQO4H2i3XmwNXR1bStpHhPaH1xYjNRpnCglvUNZPptBVV/JBg+StoyCLLLPdJnnFfZK/9Z/AtarvDzRwRVifBw6b1FmYj5itzvmXe9+dQtNV5Sesu/fiSvf4hyM4aFjSnkz72tvWU2IlotKVtrofOMJK18ulrmFlPW+Get9h34Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1YuBaRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1YuBaRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDC71F00A3A;
	Thu, 20 Aug 2026 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255808;
	bh=RmBGPPmnHZB7sWOryRhUyWXwDesZ2C671GMYTmf7+wE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o1YuBaRDVWZeY84KMiDmiPzm5KnoHfURg7E5uRv2vIDKWk3/BM/u8v6jKfbG446TP
	 IX7mFDZbY+dBYX4d/LafLk2oxK7M3/kqQW9tQ3AZH7wpvq3pG1QCCB+8dqiu95j9vd
	 0SpUUEIilWG7maQOc2MRUxt2k6Bmliym32UIWLod1H9Utloc6ZoImmpDW9U5khIggG
	 A2Pvvo4hD+5sv6xyd7Y8p8AHKAUWh+tQjqx2DATMqtmEsPp4/q16Insx+1G96kou2d
	 AZ+QwQJ1YTfgL3vwrX4TtPdjcanXiw1uOUcbOsVf4icCLalwYGL45CSALbO2FEBOH6
	 xPz1+hmUyFkVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/sysfs: document the link speed and width
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ferran Duarri" <ferran.duarri@me.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260820195334.275375-1-ferran.duarri@me.com>
References: <20260820184228.166566-1-ferran.duarri@me.com>
 <20260820195334.275375-1-ferran.duarri@me.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 19:56:47 +0000
Message-Id: <20260820195648.0BDC71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> max_link_speed, max_link_width, current_link_speed and current_link_width
> have been exported under /sys/bus/pci/devices/.../ since 2018, by
> commit 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_s=
peed/width, etc"),
> and none of the four appear anywhere in Documentation/ABI.
>=20
> The gap matters most for current_link_speed. current_link_speed_show()
> performs a fresh PCI_EXP_LNKSTA read on every open, so the value reflects
> the link state at that instant. Modern GPUs retrain their link continuous=
ly
> as part of idle power management, which means a single read can legitimat=
ely
> return any speed the link supports, not the speed the link will use under
> load.
>=20
> Observed on an RTX 5070 in a PCIe 4.0 x16 slot, same boot, no configurati=
on
> change between the two reads: 5.0 GT/s while idle, 16.0 GT/s under load.
> Comparing current_link_speed against max_link_speed at idle is therefore =
not
> [ ... ]
> end's capability rather than the link's.
>=20
> No functional change.
>=20
> Signed-off-by: Ferran Duarri <ferran.duarri@me.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820195334.2753=
75-1-ferran.duarri@me.com?part=3D1

