Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B91F942
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 03:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297026; cv=none; b=rx/MvsMxKCgxz2LbvFLcr+bGxBUK3shVlcOhVFVw3pMUnlCjWnaogScPLkt0Sy+9BF9QhoQPFDfUetQAdNenosf97F/LaUPtv8Ui5pHedRzLRc7xckiM9g82GHAeHQRZk0gr0pB3nR6AJrXmIRhw+HqFwqxiXjxHqzeqt0ntqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297026; c=relaxed/simple;
	bh=LZVq2XrMqc2FEXXaKlOF1yaoddq1AaseNZz4UHGGJ0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KHpOb9ZtYh/V6B+XFoePNLQzxPpplvkR902P480lgeCBg+zYziq3daLTc2MDLZQtSo/Vht+4aB0+521nakzT09aaWzLHZiv3rDOAPbRn81GD5OItTvKjobyACpRyU7P+4xpkOZl2DMqthajO9jh39Jxj4+EunGoVcqf5oDKEcPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdTE9St5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdTE9St5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BF21F000E9;
	Wed, 29 Jul 2026 03:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785297025;
	bh=u0ToZMcd96M5kObVvmKvDft3AWpj/xy1PW9atrZdrrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HdTE9St5SNMSLe0WRc1/Gk7c9u4RjMVbcePnQKlhdd7XbLBJ1MAkudPRg6rlnD4d+
	 isWXcpvXiq6I5Wi8dpsbplwHylEnmCmKYSuMsU9ScGun54JVp0qDOCOENJCY8ywwLQ
	 CGpcOZM1Q6RCsgt18aAdMk0M6YAUE6kXE0zj3la5+kc0hE+ojGjNkfgxBlFoE6Y4tz
	 px3aV78XDTmDmSyI16pP7IBhvZ5XqYEnj1/kiE/0n7AOSoBjc9n88Ei8RquA6NGaNa
	 vCLSRgyCH3JGtd5W1AF+L7HTCjJjhOQ+JTjqiVA5Tyy5HMG8Ww0hBWUlDaI13RFcXt
	 6kjW21DCuZhqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] PCI: Add pci=nobwctrl parameter to disable the
 PCIe bandwidth controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729034505.469107-3-kanie@linux.alibaba.com>
References: <20260729034505.469107-1-kanie@linux.alibaba.com>
 <20260729034505.469107-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:50:24 +0000
Message-Id: <20260729035025.52BF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe bandwidth controller enables the Link Bandwidth Management
> Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
> (LABIE) bits.  On some (typically old) platforms this has been observed to
> cause boot hangs; commit 46a9f70e93ef ("PCI/bwctrl: Disable BW controller
> on Intel P45 using a quirk") addresses one such platform with a per-device
> quirk.
>=20
> Per-device quirks only help once the offending device has been identified
> and a quirk has shipped, which is awkward for a boot hang since the machi=
ne
> cannot be booted to report it.  The only existing escape hatch,
> pcie_ports=3Dcompat, is a blunt instrument that also disables AER, PME,
> hotplug and DPC.
>=20
> Add a pci=3Dnobwctrl boot option to disable just the bandwidth controller
> system-wide, giving users an immediate, rebuild-free workaround while a
> targeted quirk is worked out.
>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729034505.4691=
07-1-kanie@linux.alibaba.com?part=3D2

