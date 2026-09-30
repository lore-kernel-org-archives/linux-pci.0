Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067344E780D
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778407; cv=none; b=jN5vlslR5OvDw0N8eE5r5EBEtPW+sYdEd9Wkn8VFJl3w3ywtzsHvYTDz489vwLjiPQrbdfkovASgWy4orpDA3xmqWM5ZkSZFUZvLjqMttdnVOhqFvU8nIaDqOdObGAzjGnELn9pryjTFRi6maR5YasPpJhrDU1p1qkmEQpZ0+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778407; c=relaxed/simple;
	bh=s26huTZBBrF2bln+7OTj8WFntX45UxvSCChJZqd88Vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aT5Mcx/X6r44+/WiO2hFzTCRYeJxsVik9s6delmBaQ2XJjbeA1uORF1QWCxsB/bvUCrZmRjOWiTuI/bsptWng6tGBjtYnlcVL2yQ3gmGnNJH5mMektHByRYqHu1c480RyJZvY9Jj0a+8kx8fRAPUqNGK2L6QBnw1pYOtcKJCPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEbiedRv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEbiedRv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62A51F00893;
	Wed, 30 Sep 2026 14:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778396;
	bh=gc7LcRd42BHMZz9E/67qWS9URcitopAA1+dehm0Gi1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VEbiedRvc+BKpYS8A0Cy2TsdVCUmlXXd6DV3oP4c624FKu1bLXq1hSIqHp1GU48Ol
	 Ip8l2bEMkTFrFtpGl2Pnq0tIHDjWO8lQWxUfbvk58AnaA2hIg7JWsTjoGfMDuUUDZF
	 ogFzIya4k4Wyq6jhuy1414rGAnuL4RwJpNYqL8mSGse5stufl21c0pLeiKU/f2jZgE
	 njtZVzre9drm2ZjYTb/VFPvcxmFRjihlLnN/A9b0CLPU6+Z3YGLaafhia3NFt9V9Iz
	 bo7MBS6jfwOqLNkkTnCu9H8Ag3ocBGtMUOZQHfx8HISrFcevWwfCvXV/sD33a1Bpxu
	 EGAQagLRiVtnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] usb: hcd-pci: Honour pci_save_state() failure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930141914.6678-2-fbeltranmillalen@gmail.com>
References: <20260930141914.6678-1-fbeltranmillalen@gmail.com>
 <20260930141914.6678-2-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:26:36 +0000
Message-Id: <20260930142636.A62A51F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> hcd_pci_suspend_noirq() ignores the return value of pci_save_state() and
> goes on to pci_prepare_to_sleep().
>=20
> The next patch makes pci_save_state() fail, without marking the state as
> saved, when the config space of the device is not accessible.  For such
> a controller pci_prepare_to_sleep() does not work either:
> pci_set_low_power_state() reads the PM control register as all ones and
> marks the device D3cold.  pci_pm_suspend_noirq() then finds a device
> whose power state changed without its state being saved, and warns.
> With an earlier version of the next patch on a MacBookPro14,3, whose
> Thunderbolt xHCI controllers can be inaccessible at this point:
>=20
>   xhci_hcd 0000:7d:00.0: PCI PM: State of device not saved by hcd_pci_sus=
pend_noirq+0x0/0x180
>   WARNING: CPU: 7 PID: 96793 at drivers/pci/pci-driver.c:888 pci_pm_suspe=
nd_noirq+0x2f4/0x300
>=20
> [ ... ]
> in D0 instead of being put into a low-power state with an incomplete
> saved state.
>=20
> Assisted-by: LLM
> Signed-off-by: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gma=
il.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141914.6678=
-1-fbeltranmillalen@gmail.com?part=3D1

