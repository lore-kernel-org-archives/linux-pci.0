Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E83D45D5
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795702; cv=none; b=ESdYQe2vA+fCeLGo+v8zPW/UumVuWuLap9N7kBA90Phnoyk68zoZv2nHzKshOJhSaDDEfHjvwwkRg07xtK9o8D6gfVzb8pxlUL752oXdaWHRwxUv/f9vzV74RdSO2ytrrlVZ1XNaeqxQh97qhdmU+wctkwErHm7SX/G0Ike9d/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795702; c=relaxed/simple;
	bh=CcJ5EQbXB1vvO2LrNlN7X57vmweWnPcCL7MC9IvYNRI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gz/yziXXEx42MYAmpCZiDGGIVH9XN0OwelwNqq3fqBBJV2YuMDu8UuFqndOEXOA46HG9jP4a4HPD6D+Qfn05oino1+OCXmDSSiSw2yLUGz77nNeRSTzNI117XyDxYgBWWJVPkt7aK6T3vsx8aBAZH3WFmZ89Kw+chKmYKQ5EjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdoE3Svn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdoE3Svn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972161F00898;
	Wed, 30 Sep 2026 19:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790795700;
	bh=CcJ5EQbXB1vvO2LrNlN7X57vmweWnPcCL7MC9IvYNRI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZdoE3Svnwp+Ai1HNqPzHaNkZ9yRLPLjcrqVE+8EbywQmxdJsTTpCGCVyKFse44b9q
	 U9KFr97CtnV64eaZBCOtqrWCAQHZEQKe3iEX7DVpSY9NHDhmRLbAo3+0NtksfY1T/h
	 xUSPiZNXrOxGROvx88hMTEKleEJl51Xm0V8IUYDAuk/GCjwB4hVFqbG4ePOSAqTOly
	 8xbSTWutwapwc+4UPVdxIel8P1jdqmj03RM989gK0l9goaQEoRAQ2kBj38sstAYpHd
	 ld3WAtaMNnPpUhvHgFIuF0UM5UsVsv0l2lE2fOQxM/bt0xJaqo2SVORyUd9pHDYjk1
	 oSmOMpeeQxIrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Disable MSI for ULi M1575 EHCI controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Imre Kaloz" <kaloz@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930191100.6127-1-kaloz@kernel.org>
References: <20260930191100.6127-1-kaloz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 19:15:00 +0000
Message-Id: <20260930191500.972161F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> With MSI, the ULi M1575 EHCI controller (10b9:5239) intermittently stops
> executing its asynchronous schedule. Control transfers time out ("device
> not accepting address", "device descriptor read/64"), the port is handed
> to the companion OHCI controller and the device ends up at full speed. On
> a configured hub the stall shows up as hub descriptor and status read
> failures. Only re-initializing the controller recovers it.
>=20
> On a Sun Ultra 45, 65 of 800 controller initializations stalled with MSI
> and none of 200 with INTx. Each initialization is an unbind and bind of
> ehci-pci on the EHCI function, with MSI or INTx selected through its
> msi_bus attribute; with this quirk, 0 of 100 cycles of the same loop
> stalled. The stall reproduces on a kernel that already contains
> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
> edge-triggered MSI").
>=20
> The OHCI functions (10b9:5237) keep MSI. They showed no stall, and the
> hub enumerated through them on MSI during the EHCI failures, so only the
> EHCI function is quirked.
>=20
> The illumos EHCI driver also disables MSI on this chip, in
> ehci_register_intrs_and_init_mutex() in
> usr/src/uts/common/io/usb/hcd/ehci/ehci_util.c.
>=20
> Until USB HCDs started trying MSI first in v5.9, the controller always
> used INTx. Disable MSI so it uses INTx again on this chipset.
>=20
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930191100.6127=
-1-kaloz@kernel.org?part=3D1

