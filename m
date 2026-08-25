Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399F52F7F0A;
	Tue, 25 Aug 2026 02:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626743; cv=none; b=uwLgwg1jQ1p0zqOG/QtnjU6UrA0TVZMTPgWaCRMvwzX4DwYNP45B+PAhv3H6KswKp3Eeb+d87dj2dj0vQt4usw1GLYnHWoTicWtgmVx2T7eAyfbRdUdbgPqyeEF8Fak/I24IOdRuZG51JUPG5bZbpWnXJnUKfLo4I2JmYsf8c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626743; c=relaxed/simple;
	bh=KeVWRFdJyoAW/TD2WZA46QRaM7M8KCArLaUKSBP8atY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgOjBtMjmRQlKwYlvikYObu6OUF5g+3bJ08neOamWXQnfmY5GumrKqZTeqra/VRYXn7C9ah1MOhdt7sppE+5j3807DgUzTNhs/CsS9ojdiqxgvpDgmiRhjv9X3ZV3FqAwVzWGLFxDhasmamaeu/OgPUoBD5yXhlqda63/CWJNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+vBuozc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+vBuozc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93F11F000E9;
	Tue, 25 Aug 2026 02:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787626741;
	bh=DdCSIO2895WEDUIt9ovDiCnlP80XCh4X7ua6U5AMtcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+vBuozcPPjI5ypTICnCnqqjf93hmdMMAE1nqmhcJrwcBWw6/wUhmtCHq8qTSVSCw
	 eIYgt7FMdK6p5pd11TOBFUBhQL5fcmBVYlRRNC7u+pgy1r793/FPRMiQbz5lAVHDOS
	 tckLz8gfFA39qad3mNsfnB+ROHTxqYm3ffa/WQiQRzwxtupZOLMgxqQO2qGzHfqOVW
	 lSrXBYeE6gBIiHI5tIHtpOt5kRKd/yOEe7JcFQvqhyc6cd8XX8XJeyKwM1t9EbEBMR
	 ytFK2/3FfhSTJr5I59MbHugb1Jmlw96krd1W5twwY/gYM1reszDML/TH+oYovQj9rH
	 G7TIBqQFAB0pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] PCI/CXL: Refuse an SBR of a CXL DPort unless
 authorized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260825022628.3651434-14-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-14-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:59:01 +0000
Message-Id: <20260825025901.A93F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl_sbr_unbind_regions() and cxl_sbr_enable_regions() ignore the r=
eturn value of cxl_sbr_collect_regions().
--

--- Patch [13]: [PATCH v2 13/13] PCI/CXL: Refuse an SBR of a CXL DPort unle=
ss authorized ---
commit 8a167a59c2870bad236e079ff1641933532c8a30
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

PCI/CXL: Refuse an SBR of a CXL DPort unless authorized

This commit prevents the Secondary Bus Reset (SBR) bit from being
silently unmasked if it is left at the firmware default. It adds
cxl_sbr_allowed() to verify whether a CXL Downstream Port has its
Unmask SBR bit set, requiring explicit authorization otherwise.

> diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
> new file mode 100644
> index 0000000000000..823b63012f45b
> --- /dev/null
> +++ b/drivers/cxl/core/dport_sbr.c

[ ... ]

> +static void cxl_sbr_unbind_regions(struct pci_dev *dport_pci)
> +{
> +	struct cxl_region *cxlr;
> +	struct xarray regions;
> +	unsigned long index;
> +
> +	if (cxl_sbr_save_hdm_state(dport_pci))
> +		pci_warn(dport_pci, "HDM state not saved, decode will not be restored\=
n");
> +
> +	xa_init(&regions);
> +
> +	cxl_sbr_collect_regions(dport_pci, &regions);

[Severity: High]
Does this code silently ignore memory allocation failures during region
collection?

If xa_insert() in cxl_sbr_collect_regions() returns -ENOMEM under memory
pressure, the error appears to be ignored, resulting in a partial unbind
before a bus reset.

Could this leave uncollected regions bound while the link is reset, leading
to Machine Check Exceptions if the memory is accessed while still online?

> +
> +	xa_for_each(&regions, index, cxlr)
> +		cxl_region_unbind(cxlr);
> +
> +	cxl_sbr_put_regions(&regions);
> +}

[ ... ]

> +static void cxl_sbr_enable_regions(struct pci_dev *dport_pci)
> +{
> +	struct xarray *hdm_state;
> +	struct cxl_region *cxlr;
> +	struct xarray regions;
> +	unsigned long index;
> +
> +	xa_init(&regions);
> +
> +	cxl_sbr_collect_regions(dport_pci, &regions);

[Severity: High]
Is the return value of cxl_sbr_collect_regions() intentionally ignored here
as well?

If region collection fails, it seems the uncollected regions would skip the
enable step and permanently leak their disabled state.

> +
> +	hdm_state =3D xa_load(&cxl_sbr_hdm_state, (unsigned long)dport_pci);
> +	if (hdm_state)
> +		cxl_sbr_recommit_decoders(dport_pci, hdm_state);
> +	else
> +		pci_warn(dport_pci, "no saved HDM state, decode not restored\n");
> +
> +	xa_for_each(&regions, index, cxlr)
> +		cxl_region_enable(cxlr);
> +
> +	cxl_sbr_put_regions(&regions);
> +	cxl_sbr_drop_hdm_state(dport_pci);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D13
