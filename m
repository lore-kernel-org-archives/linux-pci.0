Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01314352000;
	Mon,  3 Aug 2026 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796436; cv=none; b=G7TPlblM9pKNBWiLBf+QT0S9jhGkRHPVgbRZHKtSKxvl8K+D/obgGGMEmaIfl1f++3Yt7E5yEauXM7gIsXGiD40UQ+E7gumrFNR3+vouAMn8vjnx3Dh7tKzB3EgJV4zS4lo4rWqwH/K9Y6vl7q3GNMlo7ahrSf5sOT7lDzw003E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796436; c=relaxed/simple;
	bh=V25yhg35FFAlE1a05zV6ETzWDWkv/Oe31YQpN2UPlcM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MDMWF+273VxhODbvPgeQwYyY0Rx4EyjUTBvT75hPs5vU5Lxh6TmEcrxzbeEHbzWVlfPcTuLUsRsYBgRmjJUNHKR1NRjsG6U0u+GAhyXFgdAv2LCl8KGeMgL4h9gFMl8QN81Csg1hqZ7/aAWi4vwZxd75/LxpM0RA1NBH9RlTnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQlZq/pC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQlZq/pC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC561F00A3A;
	Mon,  3 Aug 2026 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796433;
	bh=V25yhg35FFAlE1a05zV6ETzWDWkv/Oe31YQpN2UPlcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQlZq/pCZTZ1Z/J8Zo57SLP6H5b/vcI0bR477yNGPkFiPinximMDOyXubdXjLdIBr
	 vTaxVSnKSss6n1S+GTl+XsRDuqfKXd7rpppyspIT659r141akhbTFCTI4TX/MiO8nD
	 LF7j7p49LnM7sTJJUR4+0r2gzy3WBD3UF3ZuHjkdpLf2dh6+di6w9o86Z/F1f7LRa9
	 q07bPBCaaONCIEXyn4zwpDiBwTM/93lybGynQLOhammI9XzhGzj4/NArBVuevIiscm
	 MMWExl3AkBPRps/AxAV7c/lMu1zGnGYl3dd9tLpNYEpI30n/pNwyfwFXFhRuqtXEmT
	 Dca8Lly1qE2OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 09/14] cxl/pci: Thread port and dport through RAS
 handling helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-10-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:33:52 +0000
Message-Id: <20260803223353.4BC561F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dan Williams <djbw@kernel.org>
>=20
> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
> a struct cxl_port * and optionally a struct cxl_dport * for the device
> being handled. Passing a generic struct device * requires is_cxl_memdev()
> to distinguish Endpoints from Ports at trace emission time. Threading
> Port and Downstream Port directly enables is_cxl_endpoint() and explicit
> dport/port branching for cleaner trace dispatch.
>=20
> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
> emission logic is split into three branches: Endpoint events are
> identified via is_cxl_endpoint() and emit with the memdev, dport events
> emit with dport->dport_dev, and Upstream Port events fall back to
> port->uport_dev. This branching is transitional: the follow-on patch
> [ ... ]
> device types.
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D9

