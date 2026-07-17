Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48B246BD5;
	Fri, 17 Jul 2026 22:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784328245; cv=none; b=TS7pHPaQlSA94jrLWTfbsettzhk1KQFMzfiu2sjT9F+6kiu57UDr64XOWMxDGx/uf0zn7TQCFWZzz+oiOJxN8hXaV/lZEEtlj05q4+73gZf+716RiRc9biH+/S1PCceg5OLYanDGu77FQbtkk5fl1vYZcRfLwaJDobrt422SHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784328245; c=relaxed/simple;
	bh=JILEP//ib3tmnIje7mmsBEMOtn0UP8BpsEzRBT+H/k8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PAlFumVw8faLt7UncblSw0Q0LF2pzZ67Fj2NIkzcXCxAJXdzrWK8by1u+ZUgU3Wx+zKMY3MwsLziSTQ8BQk9Nln+wN4S1LvQk0Vis1R/V7e5iANExSRzmeA1Gp7MmLhs68hiKPceQRzy6BGSwaobAwrFXhpR4D1i2lH6KB2s9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVtUgrt9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVtUgrt9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7191F000E9;
	Fri, 17 Jul 2026 22:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784328244;
	bh=JILEP//ib3tmnIje7mmsBEMOtn0UP8BpsEzRBT+H/k8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gVtUgrt9QG5RwMbOOZ3W4mbP7Su80td6cl2Jmn0jYETlCPMY6QJNmivwHpdCWMjKz
	 Td8dDot1ZnSnJ8PBA2zfVpCprs/8vis+LJhgwMO6AFr4GuD6VtiKqEeKupPetXcO+J
	 w1WzCdzixj2zxIB6RYbEp2h1OEHI9+OBdozNlswqdE7eHIF1a3Nttsw0F6F5uq1QW4
	 /dKjY7k34dPX8XlG3T5C3m3m7x/Tl84CKNJCMUR2BWaPB7OG6eyWM30FCqVeZBtjvZ
	 r3K4oGC6k8A64LgiEOvBps37onBOdMYkRmILtt1iclYsWmquHG52WaS9TadNUQNy5M
	 0vBds+iU7h6Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 11/13] PCI: Cache PCI DSN into pci_dev->dsn during
 probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260717222706.3540281-12-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-12-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 22:44:03 +0000
Message-Id: <20260717224403.EB7191F000E9@smtp.kernel.org>
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
> pci_get_dsn() is not modified because it remains a pure config-space read
> with no side effects on pci_dev. The cache is written exclusively by
> pci_dsn_init() at probe time.
>=20
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717222706.3540=
281-1-terry.bowman@amd.com?part=3D11

