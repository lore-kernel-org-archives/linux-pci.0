Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412C37DAD0
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499911; cv=none; b=dKPFdq7bzqm+y+HNLCRpqFzK8fpO2cXlS2wIcSs+KjUlC9y57Dz0c06bqp+QBXvv2EKfq9feLqGQMlXFMwjtJiiYA/s2fHFvQgXQZNVeTekqc0HGl+bVS1JPomtahbChUsMQ4yaWMQdODIOVMIlc6dFJMj0qdfHPxJkcwUy9KhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499911; c=relaxed/simple;
	bh=lgoMuQzBRXeW4jZ8eTE+UmxZo/Xc2D4pWVHzSH0Vq8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k9iuYjGzpphhebLVWqBtgoV000IULdTrxqfmJQQitpoc/YERRy09b9odE2E+PiFu4q2RbN174mRB8N6HqM51uOIqTl9QNiSF8dCgX5ZgyndKI0dtPy8LqdjJ7EC/+uzkECal5ijbdKgpgWHoSK1ZGMRDYB0mv+YnXOC6Cb6nj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9sRRj16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9sRRj16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3041F00A3E;
	Fri,  4 Sep 2026 05:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788499910;
	bh=AgN6ReUG6BA5hqWM7TBf8m08vbrhrfvQc1BwfQr5h3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9sRRj16J09147SJWPvXcsIB236PAgM6Q72HKUAHUbdt2Y+XHzULy5Y6Yvf0oS05n
	 lnNfGn4AX8Co2cCbfUvIkWuCjU9HcPAv6+O8ckFFaqmWas0VyGKkDhs3HOPPhN0BrP
	 d+k98GxaxeHfwOIfPg2vzmzEWEDe+XYKISFYb1NEV/ch6KTLZfxwqazJuPQZXVcOE1
	 OvE2TKncE+WFrYecFVrarYO/ynEvWBAP+FurzvTvPfZDDdJeotNOk0DbxGfwka1gUd
	 PYxKad4TVmyo169KljXS/39zhsEAefW90CGMGc+/eXjMx5VnsE98yMlkGbu/KuxrVq
	 itPJPgLB9WQKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] PCI/pcie: Add PCIe Lane Margining at Receiver
 (LMR) support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904-pcie-link-endpoints-v3-3-4b9a91bd4b35@google.com>
References: <20260904-pcie-link-endpoints-v3-0-4b9a91bd4b35@google.com>
 <20260904-pcie-link-endpoints-v3-3-4b9a91bd4b35@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 05:31:49 +0000
Message-Id: <20260904053150.6F3041F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Per PCIe Base Specification r6.0, sec 8.4.4 ("Lane Margining at
> Receiver"), PCIe devices operating at 16.0 GT/s (Gen 4) or higher data
> rates support the Lane Margining at Receiver Extended Capability
> (ID 0x27), and it is mandatory for receivers operating at 64.0 GT/s
> (Gen 6) or higher data rates. Lane Margining allows software to
> evaluate high-speed link margins by measuring timing and voltage steps
> for each individual physical lane and receiver.
>=20
> Add driver and debugfs support for PCIe Lane Margining at Receiver:
>=20
>   - Add Lane Margining at Receiver Extended Capability register
>     definitions (PCI_EXT_CAP_ID_LMR, PCI_LMR_PORT_CAP, PCI_LMR_PORT_STS,
>     PCI_LMR_LANE_CTRL, PCI_LMR_LANE_STS) to <uapi/linux/pci_regs.h>.
>   - Add Kconfig option CONFIG_PCIE_LMR (under drivers/pci/pcie/Kconfig)
>     dependent on DEBUG_FS.
>   - Implement drivers/pci/pcie/margin.c to probe the capability on Gen4+
>     links and expose per-device debugfs entries under:
>       /sys/kernel/debug/pci/pcie_lmr_<pci_dev_name>/
>     providing control over margining enablement, receiver selection, and
>     execution of timing/voltage margin step commands. Distinguish
>     between missing mandatory LMR capability on Gen6+ vs optional on
>     Gen4/Gen5.
>   - Hook pci_lmr_init() into pci_init_capabilities() during device probe
>     in drivers/pci/probe.c and pci_lmr_exit() into drivers/pci/remove.c.
>   - Add kselftest script under tools/testing/selftests/pcie_lmt/pcie_lmt.=
sh
>     to test debugfs capability reads, enablement, and stepping.
>   - Add MAINTAINERS entry for PCIe Lane Margining at Receiver (LMR).
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pcie-link-=
endpoints-v3-0-4b9a91bd4b35@google.com?part=3D3

