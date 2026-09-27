Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449F41DEDA
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533607; cv=none; b=lrFl9dJxYSORKYxtbNzSfsOMsUQ7PcP6s7lyJ0+jhsBhBtub/j6k2uWu3mZVCeMZoP9aD6i7RKbOG7x6+QaByn7hgUJDla4Op79YK474cTyJUFDjf8yVoKrpk+EnelHbG3HH/YBUXPqKDu+RXALdG1+gAtMvJErkhjpSoK3YR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533607; c=relaxed/simple;
	bh=lS/1EgGTchM/SfYiOu4T44KtegCcU6blWuCzLdbGfUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W3uwDSfdQAgtdsD3Rtc1ruuOn5UQlu5HQGoZV6FqmcdqSEoTplvPSmymWSleochumYK+fab6cxQkIt2bKmuFTo8Z3gt+G5eTQ/sgT6dxg3CNFUlKP0IRuizCIpNJG3taO+jj2SjPHxa4sCpNJU7v9wXeEJCANeCRtnSia2mRHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In3G12PV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In3G12PV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE091F000FF;
	Sun, 27 Sep 2026 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533602;
	bh=rDo5vATu7iddxIJuNDoFet2aEBWNe9BC+LpVUtGJCw4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=In3G12PVwOStS341Lni6yRm35xzmKfUgtJymx3DJ0xYtCNmgB8YMk1Gsz8+0W9E0I
	 kQ4ifT1d3rG0m4ZH4rRR79sEyse4xtZvuygDd7HCH5762NSoz2p9hsrZdvWPldit6r
	 p/OpEh/Glw39Yz4l3J02B0k4kl/dOKmhxheqgODyYTSUcGXzcz16viTW46wIvsqiex
	 Q9/8XFfgFd4Wv0UqEx6Dra4Umc09T1anoNrIp9evYFtaaN7S6sny4OmsKGuP2JPRgu
	 XchD8gftctbf0HavmIxaH6ncsc1E3dhKMvzzlBjDeifDJRqB3ZVxuPvnc1L8XB9t2r
	 g6B8uQ+YY62OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] PCI/DPC: Reinstate support for AER-incapable ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:26:42 +0000
Message-Id: <20260927182642.7AE091F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
>=20
> Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> ownership") seemingly inadvertently constrained DPC to AER-supporting
> Downstream Ports by inserting a call to pcie_aer_is_native() in
> dpc_probe(), which implicitly checks for presence of an AER capability.
>=20
> Drop the call.  It is superfluous because it duplicates the conditions
> applied by the PCIe port service driver when it decides whether to
> instantiate a DPC port service (see get_port_device_capability()).
> If the conditions are not met, no port service is instantiated and
> dpc_probe() isn't executed.
>=20
> The only difference between the conditions in dpc_probe() and the ones in
> get_port_device_capability() is the check for the AER capability, so by
> removing the checks from dpc_probe(), DPC is supported on AER-incapable
> Downstream Ports again.
>=20
> Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER=
 ownership")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790531238.gi=
t.lukas@wunner.de?part=3D2

