Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9217A3BE156
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 20:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110567; cv=none; b=MHNQJAZuq6Kj49VPFGWIYL000TLabAe8wNmWjLeIQ+zDgU9DoOQiCDC1KTrobp4SCLdcDVOBgH76JK26hVgld8zqSb2oyZbyxuJMlWwWMBepePItSwft5W0PlzSYWD0NtUsSiop/0NtpYJmpHzA4A83ZR+6G12LydF5kPHzZW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110567; c=relaxed/simple;
	bh=p/Isjg5F5M6EEoSIl+c2D8ts5og9N5G6WSIueq/oNiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z9Hjo5urLgPdvBtYx9V9nt7HgiQfIN6+iZW4o4tnbdsxhzzyQULCQc4X7/dEa6rroiyRFwyRwlUGAyIJxiXre9mtzxynHQnpmCzwmfxhpD5skncyvlLVmfgQBmO8cpwobad4yCtUVuPKxaz/TI7pHCnmT9r7kYSJ/QkXAOeWwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjDMyR61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjDMyR61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC72F1F000FF;
	Tue, 22 Sep 2026 20:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790110562;
	bh=p/Isjg5F5M6EEoSIl+c2D8ts5og9N5G6WSIueq/oNiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjDMyR61bMOZkeliFRpo5Ks8QkeImuh9HRQ757V+p9njprCHiAbykG/kk7oyHwSjv
	 9/7MTlS3zzor1iPhmsrkCKsQtlhrKxH7ipFOzoB6XZH8n+1nsf0facPLNw76GfzItS
	 8T18c12dbGCmQ8KaLxXgUB3WRxPyVmNoFsbaV4DHaBI+cvruFYW/XOk4piwKnTtoA/
	 U4vs9nsSNFvtO7oVzx3i6Tf/+n2OFDgUx1TAbVzQXWMzEKC7RMKgS922xZzPl9bxlt
	 pFPeN3dBdQ4oKwu7s3QYWNB2x+5aqfiiL03jvqGhqOZ/S88Fh8Hvy9cninaCeRIzFl
	 e7VKsBV094fFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 3/4] PCI/ACPI: Centralize pcie_ports_native checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260922204548.3884906-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260922204548.3884906-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:56:01 +0000
Message-Id: <20260922205601.EC72F1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204548.3884=
906-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D3

