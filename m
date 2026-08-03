Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276EF34D3B0;
	Mon,  3 Aug 2026 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796203; cv=none; b=dWq0ZtBPN+jKzRMJCNFyMFjE4A/X48LKUGXH9K1fXBfhXGc6ByR+1J99MKRRoCZDJF0Od64dvH36wtc0mcx8iLLPk+J91tRJWzdOBou2BsRP8/og5TYSWkQowfJ3zuu0vGMmtp9MIsmWwcexTAMOWGO4TSrCw8fTuFmE+1fkAPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796203; c=relaxed/simple;
	bh=NQC99CnxR6zvrJlZT4wYBX9OaYv8VcKfUM61Yn5l2NY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iMd/7C27/0R7Z/4VvMo/zGkSDdu6LC2yBUQIQjEnL/9QC5LRUovU6vR0NIU95I362fMrFEgEVReULYp6PdJ/O3jR7hwriqA4H03c9NzhSsoZ7X5aJgVc6H6ur5D6bBc/t2z9eA20deUWTsf+QfdHEjWay5Y1iXll4V9cwm0UtYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbgnGP4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbgnGP4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644DD1F00A3A;
	Mon,  3 Aug 2026 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796201;
	bh=NQC99CnxR6zvrJlZT4wYBX9OaYv8VcKfUM61Yn5l2NY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IbgnGP4edUCeVBMGaNZP/OlxaGJku4jeqVwzVtyMWoMhuwiBY+g2o5tiERbtjc2h0
	 1j/7W6OJ/MQs+QbDoiYSLano/iIYh40uR+dHIyULpAvUTwhwYvFoUCD8g/Exmglhdn
	 8agEAr2A+bAUKQ5pAyio88QvZy0UQc4FabggbswT8xpR/fcK2sYGcklm2qXlgj9XV2
	 hzRH0SDNMXdpFuyvdelArl9nd/GLyDwbM9OFRA4M0ysAOuU1vowuGCfoyb5G0r7X1i
	 ImG+HWm9OeaIdLecLDbBVXpYevN8kpUaagHBUBhi4KMhYXZTj6GCp9QCEDxbaYhEo4
	 Qq65oSpZ7FDiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/14] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-12-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-12-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:29:59 +0000
Message-Id: <20260803223001.644DD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Subsequent CXL error-reporting code paths need to log the PCI Device
> Serial Number (DSN) as part of trace events emitted from interrupt or
> panic context. Computing the DSN there via pci_get_dsn() requires PCI
> configuration space reads, which are slow, can fail when the link is
> down or frozen, and may not be safe in some contexts.
>=20
> Add a u64 dsn field to struct pci_dev and populate it from pci_get_dsn()
> during pci_init_capabilities() at probe time via pci_dsn_init(). Only
> write dev->dsn when the read succeeds. The zero initial value from
> pci_dev allocation already represents 'no DSN available.'
>=20
> Remove the now-redundant dsn member from the pciehp struct controller
> along with its kernel-doc. Drop the pci_get_slot()/pci_dev_put() pairs
> in pciehp_configure_device() and pcie_init() that existed solely to
> read the DSN into ctrl->dsn. Use pdev->dsn in pciehp_device_replaced()
> for the device-replacement comparison.
>=20
> pci_get_dsn() is not modified because it remains a pure config-space read
> with no side effects on pci_dev. The cache is written exclusively by
> pci_dsn_init() at probe time.
>=20
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D11

