Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C63750D7
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753681; cv=none; b=Z8QD5MX68h5FsfgIckbsCREX80oAXGf1m/DZ+xW5Ulc13hw+RvrKR3MCAmkchhB9PPkeyxWTu1pVPpaiLZp50VIVOD6gfvSxdK59Uj58k/yNXpAlqgaRkNP7eJYyuD92/TGvTPW8mWGwucUtj3Pc8gOMnhZxLeuAk8W24uIRHTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753681; c=relaxed/simple;
	bh=HtrSg4YH+swBEiyRb9nUJe5ls2ysSweyJ8gSDTz4o4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c5D/uXL+yrPoQyvxINhOXtOrTV9C51Xy8GwpTNXBhKwH8l7afw/h/wSbg0etZ4n1x00UEKh5Q3Ux+UC6S2RyOFe39ulBpTsunctoFdzprbIemq9ww7i+2lgj6Xa4AWzcHuOHBhXiv0TcAukkCldYlvufip9MHkHzNYyvHXAfXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+BW9m/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+BW9m/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16461F000E9;
	Mon,  3 Aug 2026 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785753680;
	bh=HtrSg4YH+swBEiyRb9nUJe5ls2ysSweyJ8gSDTz4o4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+BW9m/98VusGJ04O26BECNETZgPUyvElJXmuB2/w4lE+AwlHKQDPjkT8hAN0RCbU
	 HO3Hnh9081VEKo9tu82xkU8PGcJ1q2vV7gQ+zLYmn6wXcrcFWQww8GOtTASjRhimK8
	 S5D30Z0KQOT+C4vKkWFW/QyRALt38VPjAVjngPUMKzBgekVDV54pUisJnSN5v9RGPQ
	 3zAMFSaM0i1zhlFqIszcFHwVxrpcRdYK7PMIZ9GojJLW7lTAjOQEgHOtUb1Wn/Se79
	 KFnU49esca4JuwiNyiJRF+UcZA+Y38fxJ86gwgngEVxPvUhwmsen4Xd0j/fr3nYl8t
	 y+jE85/qkp1pw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI/IOV: Restore initial VF ReBAR sizes on PF
 driver remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marcin Bernatowicz" <marcin.bernatowicz@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260803103007.209625-4-marcin.bernatowicz@linux.intel.com>
References: <20260505170010.3414074-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-1-marcin.bernatowicz@linux.intel.com>
 <20260803103007.209625-4-marcin.bernatowicz@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:41:19 +0000
Message-Id: <20260803104119.F16461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> sriov_disable() and sriov_enable() error paths restore the per-VF BAR
> sizes saved at probe time. They do not cover the case where the PF
> driver is detached while VF BARs were resized but SR-IOV was never
> enabled (or was already disabled).
>=20
> Restore the initial sizes from pci_iov_remove() as well. That hook runs
> on driver detach while the device is still live, unlike sriov_release()
> which runs later from the pci_dev release path.
>=20
> Skip the restore when the PF driver leaves SR-IOV enabled; in that case
> VF memory decoding is still active and pci_iov_vf_bar_set_size() cannot
> safely change the VF BAR size.
>=20
> Signed-off-by: Marcin Bernatowicz <marcin.bernatowicz@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803103007.2096=
25-1-marcin.bernatowicz@linux.intel.com?part=3D3

