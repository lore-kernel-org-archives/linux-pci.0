Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1823890E0;
	Thu, 17 Sep 2026 06:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626898; cv=none; b=Wus/hBP6dA/QV90EWzN7JW+jhgXP5DkSN4g3kR/D3zWosMvlZnj40lcSgKbpR7H/VSoxr/Z/UTafKA5GAiLEGbUhHPTfs5NwibvhcUyRQjTXhk3KXqe5JDueZXboIyonzbadP1yqCCYM8dX29jlJWQ07YfgnAgni8VQHd0Ch75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626898; c=relaxed/simple;
	bh=Pel8NccN5e6LgcDmBLjFjb1oYPKYLZap4kl1H554C8M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=atL7bYcFkbF63KWM0TYt3hjNsCPTYcWG6Ui+kNqmqNzalCH9YFSOvjE6yeO8fcs9C0RadjkbbeUjYs8hq0gJib3kRTYEiklGOE1rbsxhg5S+oVCDBsHIxyQlwCEjxi0ebukRa/ll1i0o0vy9Hv7DRzABmPv5HQ/ynhtgaEWCVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iu5JjWtK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iu5JjWtK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6AA1F000FF;
	Thu, 17 Sep 2026 06:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789626897;
	bh=Pel8NccN5e6LgcDmBLjFjb1oYPKYLZap4kl1H554C8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iu5JjWtK9417blIcOrgXFHVDv1k+Mef5SiOhjKP7qCO65KVQVQfB4YysmQm1ymbO6
	 Jun73aGV9g3uRJgI4rP2fw4xtexfVHo+OZf6dl9muYMtK6PjQtM4x1T2SrnLTPN+nZ
	 CBEnZrHzGflh/ifRcNvP0nJThCkEWzlFTLjLA38BD0pYsaspGeW1Jm3vjVxEsKlaDL
	 9yHp9UrGhGCM7+VZusq+L1nJ6KymffWMa2wYb2FMsho3AJ0dtAunR267GJ7Hpl2xO1
	 8n183iL5wDxqu15ooKndhdALpTMIF2+hCEeWORyRgaxs+A2MD/Sqn54tsib3mBwKMX
	 E4jdlz8bE22mQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260917063322.4102035-1-hongxing.zhu@oss.nxp.com>
References: <20260917063322.4102035-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 06:34:56 +0000
Message-Id: <20260917063457.0C6AA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Some platforms like i.MX power off their PCIe RC controllers during
> system suspend, requiring full re-initialization on resume. These
> platforms need to enter L2 state to properly notify endpoints before
> power loss.
>=20
> According to PCIe base spec r7.0, sec 5.2, the system software should
> transition the device into D3Hot before broadcasting the PME_Turn_Off
> message to initiate L2 entry. In practice, endpoint drivers properly
> put their devices into D3hot during the suspend flow. However, some
> wakeup-capable endpoint devices that don't support PME from D3cold
> fail the D3cold capability check in pci_host_common_d3cold_possible(),
> which currently prevents L2 entry even though the devices are already
> in the required D3hot state.
>=20
> For platforms where the RC loses power during suspend, L2 entry is
> essential regardless of D3cold support, as the link will be lost anyway
> when the RC powers off. Without L2 entry, endpoints are not properly
> notified before power loss, which can cause issues during resume and
> reinitialization.
>=20
> Add a suspend_poweroff flag to allow L2 entry for devices that are in
> D3hot but fail the D3cold capability check, and enable it for i.MX PCIe
> controllers that lose power during suspend.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917063322.4102=
035-1-hongxing.zhu@oss.nxp.com?part=3D1

