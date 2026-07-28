Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DD73BB670
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277152; cv=none; b=upAFYzEBfxqU3eXHOBZOfURN5gL+k99xERu2KwDEiTYBkhSAh+7r2sOserkO/He7rLkjrxls0KKeZtYKsafqqsrzh52U46683WPMNBFE07hsdqDolOtWfiWw9d6e//dsJee7tDr8ZHt0xZ2TKGLbUrZNdXB+4kM/Zzu+keMeIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277152; c=relaxed/simple;
	bh=G54YkUuhfwzu0d6OzWsFmkySq626wgRZnhtg4yP18j8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fgno/1AcBW4uScOxw5cHA00xgCgcXEXsct5OHa3hA1ovPVqHzC0HqZWcpPNVkzNYM602MY1/sIQhagBNr8CFFe+7GnrdhK29SJsP/3lMwX7jygNXDja5YxDXwU8IlGWLGajcfvlHFCIGCwHjBjCFAcq07rAbQZHTR90kj2bxIug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbTfbrcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbTfbrcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D9261F000E9;
	Tue, 28 Jul 2026 22:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277150;
	bh=G54YkUuhfwzu0d6OzWsFmkySq626wgRZnhtg4yP18j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbTfbrclLZ3bbPUoaaUjulhbbKZ7UcG5hstHt0kwU9ol/JW6pnLeOHDYl3rdfxCNc
	 2097mYGeNndZIU/wLgXNj9Ij4PcwvAv4KUwOautYDJ4msb9w/0UjBXfMmZCCfLU6xi
	 S7d5NrNhKJjjNYoLmTBWU+oVgAPxKt396aYs1PJFS2A7bTT2YlaJE6bv42iVNhRZYd
	 OByySzzmTyIQnBvV53iHzBWtl/kcnoF1mWbQOsrPIVRjSehwD1KJq6h98voCUd94+s
	 rdotKvaO6uTDTibKy1k5+VaHW9PTGKZG5dPiq6NPFlRUzf2iN3LgcHKedkXY7c6w2A
	 zSCCsi4y+7TZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728221007.2098560-3-dmatlack@google.com>
References: <20260728221007.2098560-1-dmatlack@google.com>
 <20260728221007.2098560-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:19:10 +0000
Message-Id: <20260728221910.6D9261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
>=20
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
>=20
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so the list of
> preserved devices can be handed off to the next kernel.
>=20
> For now, the API only supports preserving non-VF devices on a root bus
> (not behind an PCI-to-PCI bridges).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728221007.2098=
560-1-dmatlack@google.com?part=3D2

