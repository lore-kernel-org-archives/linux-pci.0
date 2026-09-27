Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC8E3E40F0
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790533640; cv=none; b=m9k9H2Lef44hMg6/E4XKszT6UqwadBzUQZwFaEb/TM51FTIdBMshbjY1L+mMmd9p0zfgrbIdVw1jQWLlYmJg9CJ0X8Q8t1Z+yDYqAfmSfrvkYsw4XEXvr+iEIgwFYcIHA3jHw/QFKPZOi3yczUhIh96zSsu1f08nrWLEzQqTtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790533640; c=relaxed/simple;
	bh=D+cm3yZWfjJLjTpa7xNse7hMFD+75+xehDr836iteMA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BZo2PHJoGEuJRojDIuhxZIYdO5irDiVL0Z1EfvtQg+ma790gCUKpd2UFhFOvkD1/Eyhoc/T+JZDFGW0D+5HjmlsEZVKvzJgh54B1aB3RiX2Bma9gYaS+0GoVOv1kgfkPu/B5o/24IMqKzCu5CeK58c4IkGkcaQZZnOePtvpQM48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uog2QaOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uog2QaOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8811F000FF;
	Sun, 27 Sep 2026 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790533639;
	bh=ldjyjKkLBHkz70QJnNOVi4hfan1re6hrbzgs8tyXF/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uog2QaOoR+o1yi5qol8Kb7reg9FHe3vuHiNITbv6tBoyTZ5CZ0ofPhIgMLH8dzZ0x
	 zHnka6AFq9fR6EDoD9r2Aiu2fnbJtA9DaN9yU0F5qW9mSIkPyCKi2wKtrhXEsOxUmn
	 j5r1JmX4DVWxsSuDzn3/KNN493a9ndMcCCUmVtW1WMhiOROzIDnLWx6+5BXPl/bFTJ
	 LT6ZRG0lmBbmPYd/Rvt/q0Adq+WgDDsB/jVsv4xPxz7CsIxLsXtCLwMMROvTWhtfHv
	 15/4KzJ2xYAZVaqAiyi5W4hN9L451HW3hu29aRbAKsmXq2mKfdf1svB3//Czw04GE0
	 5UmEYPQlJp8Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] PCI/DPC: Avoid access to non-existent AER
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
 <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 18:27:18 +0000
Message-Id: <20260927182718.DF8811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
>=20
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
>=20
> In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
> parsing for AER ownership") fixed it by inserting a call to
> pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
> of an AER capability.
>=20
> However already in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
> "pcie_ports=3Ddpc-native" to allow DPC without AER control") made it
> [ ... ]
> for AER-unsupporting devices.  The check will become obsolete and will be
> removed with the imminent baseline capability error reporting.
>=20
> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=3Ddpc-native" to allow DPC=
 without AER control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790531238.gi=
t.lukas@wunner.de?part=3D1

