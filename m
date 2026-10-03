Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE5E37FF56
	for <linux-pci@vger.kernel.org>; Sat,  3 Oct 2026 01:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991240; cv=none; b=aqb2dS+0xPr+omS2pTY08XNj0KefQeasuii+c6UAf2CQRwT2ZYIRg+MeneNu+aoRZdkHTCUYSUxTS93842UB2rZHeW18wdw7NUH12X9o6ab0u2Eeet2nM2ou66E7Db+WB+1EnrAa2EsGrAZoj6c4+hPxIo7E4i1Dy686LLWF+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991240; c=relaxed/simple;
	bh=4yDRvrc/8oR35cl/HxDAnoaA3ahPr2yoi4L9Np7NPoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AiL/r0y6jqX3Waj2qfUCL5cQ0CxmAr/gALYzOJV3JEB+lU/Lb1A3wIgSoAKZE82nQkeeASO2DSQBEuwzz09nYxjGAuhGoeOBKfLEL8WkXxYVRQPkfc3w+c4CO60OgPPFh2p3orDP0YSHU4HIj9G6NldpagF2nGY9iT9VJLvePBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTCfzvuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTCfzvuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FA91F00899;
	Sat,  3 Oct 2026 01:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991239;
	bh=4yDRvrc/8oR35cl/HxDAnoaA3ahPr2yoi4L9Np7NPoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTCfzvuWNwIU/lDAIavhKReGsT7uMs5Lz9r5+IK+UKlhcRdQTawDH0CrzdXVXZgug
	 CuOZiySbxIVR4K5n2cYPC6Y0RjTa8zjsdE+ydv+hbAJgrFzdWnNoIC02WDb3rPKM1k
	 Q9JjUYrOhSMQe9O0xv80CH1huPDCj00j9xcSHFQ8v1aRcRHS0VOTajpJGisBYJxDFA
	 79z/JW2O9mMFDloHbvE/0+dlYGdOymsCO7ukESw/CGOyBTVvyokAt2AjyXw6vs1NtN
	 edv2az1HRZefyNtWJFg7enpd+GtgfczSqUQmAeB9/gUvMsmmr5V+menaezbiiBnKSn
	 Gp0iUmoCGgkCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 3/4] PCI/ACPI: Centralize pcie_ports_native checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261002211828.1293177-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261002211828.1293177-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261002211828.1293177-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:58 +0000
Message-Id: <20261003013359.04FA91F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> If the user booted with "pcie_ports=3Dnative", we take control of the PCIe
> port services unconditionally, regardless of what _OSC says.
>=20
> Centralize the testing of pcie_ports_native in acpi_pci_root_create(),
> where we interpret the _OSC results, so other places only have to check
> host_bridge->native_X and we don't have to sprinkle tests of
> pcie_ports_native everywhere.
>=20
> Rather than overriding the host_bridge->native_X flags after the fact,
> fold "pcie_ports=3Dnative" into the _OSC control mask we evaluate, i.e.,
> proceed as though the platform had granted control of the port services.
> That way there is a single mechanism deciding each native_X flag, and we
> can report exactly which features we are overriding _OSC for instead of
> just noting that we are overriding something:
>=20
> [ ... ]
> Closes: https://lore.kernel.org/linux-pci/20260901064554.2178688-1-kanie@=
linux.alibaba.com/
> [bhelgaas: commit log, rework OSC_PCIE_PORT_SERVICE_CONTROLS, logging]
> Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.=
1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002211828.1293=
177-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D3

