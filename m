Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAE47F76B
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204603; cv=none; b=VxwHfXBhp8EC168g+LG/Mbjc/jGDZhJ5rCzztOgH/q1mwFEafFA3IcMaPSIXjgbiyms7kmSbdhZNmZB70MgKwtFekBY4o/fCs5uClRXAjbkB4HBEeUlPhY793eJ7cdToug4rKITpPCfdGFMw2XXeHqVSsWPceZHtGtVTwWq+ZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204603; c=relaxed/simple;
	bh=gzHm0oaEimBfnPu/DLAnRQEHECqJuw/G5EwMNCg94Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kg6MuqVy7nYo9XtNU52foLokKXY+Iudp4hPdtXhh/EozUAdK+fXsg/cO5z5XzPDHftoheNv1NuWOZYe7alYX9mUgyqiwTLtonrPihkod4i64+L+Tl4BiucpWgiq1yo46UhvEQhlxq3M6Fj1oWbJx6Ex5e3Qxkvr1vPj5LniKbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6psw/26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6psw/26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9D31F000FF;
	Mon,  5 Oct 2026 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791204602;
	bh=C/y6bsyYbKLbIS6Hh/IRMKpZV+RYQ25v240l12zSl90=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U6psw/26Df/WG8WXPWxlloTNALKOuyF46P8TWW2RYsCOSYgTzXiwp0cW7VgqEftm6
	 sgLYyMPRCF7c8acR+zOCALg2qoVR8yLy1iBnp9OOaasCiOLe7omC0HzjCOTrbmUEsF
	 3utbLbnMnyklHVXFH7mKPNovyb3m1CSpWQ72WAoVMRVL2zvgm3FAdULgWNkI3M5sdL
	 P/cBcOTpYbtoH69y/bMUQbMZv2xhBo+JprCbCaDt//7AcHfNv9WGVXA+LkE2Tooi7v
	 54KggepfMXibtLJmTY6GlADfQeOtvT4VmFsb9git/6Vq80n3Btr8t5XXQYSlf39VPQ
	 T6MmVbIMV6SkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Update saved Max Payload Size in pcie_set_mps()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261005124154.2190628-2-cassel@kernel.org>
References: <20261005124154.2190628-2-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:50:02 +0000
Message-Id: <20261005125002.8D9D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pcie_set_mps() changes the Max Payload Size (MPS) in the Device Control
> register but leaves the copy saved by pci_save_state() alone, so the next
> pci_restore_state() puts back the old value.
>=20
> The PCI core does change the MPS of devices whose state has already been
> saved: pci_configure_mps() reduces a Root Port's MPS when a device with a
> smaller MPS Supported is hot-added directly below it (commit 9f0e89359775
> ("PCI: Match Root Port's MPS to endpoint's MPSS as necessary")), and with
> "pci=3Dpcie_bus_safe", pcie_bus_configure_settings() can do the same when
> pciehp calls it after a hot-add.  The Root Port's state was saved when it
> was added and again when portdrv probed it.
>=20
> Since commit 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root
> Ports in a platform-specific way"), pcibios_reset_secondary_bus() restores
> that saved state, without saving it first, after host->reset_root_port()
> has reset the Root Port, e.g. during AER recovery or on Link Down with the
> qcom and Rockchip DWC drivers.  The Root Port then goes back to the old,
> larger MPS while the device below it is restored to the smaller one, so
> the Root Port may send TLPs that the device treats as Malformed.
>=20
> Update the saved copy of Device Control when pcie_set_mps() changes the
> MPS, like commit 909f7bf9b080 ("PCI: Update saved_config_space upon
> resource assignment") does for BARs.
>=20
> Fixes: 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root Ports i=
n a platform-specific way")
> Assisted-by: LLM
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005124154.2190=
628-2-cassel@kernel.org?part=3D1

