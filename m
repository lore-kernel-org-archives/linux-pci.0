Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA19110F1
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599651; cv=none; b=mtxxJzs3UHvlIpZJmd88woDJgtsGtFfMmsxDojUQNeSPJoLONN0OJMBbCqEe5E3Pn3b6GaM4EJWaRiH9VcM2hA6CG66zq0UoZsJLUZ55dJkM1duM7MylJSbn4gDeeRZ9jFnrwUtypyhiHhmcda5zUpN/L7afhpXtCfv8nCP/GO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599651; c=relaxed/simple;
	bh=u68pIyV1j4E6lzSGaJT+XQ5G81sn0jabqYbPNjNiOp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W5DaNYdIoE43z3C3padU5FlC8Qi1/oNbmtaMz5kVhpLFyi+lK2iuTupCpnzroALcBzWbr89uBSZp/N6kywinUj8gfZvnv5QeY7nKNLSitmP0ecEmGPBDF18i0yL31MpOG0mHHieJ+AHzKjtg4vG82K3G9frnqAoPfOmaunk2htA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kecmldCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kecmldCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE1A1F000E9;
	Tue, 21 Jul 2026 02:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784599650;
	bh=2gTaKRROUm//0IhEvjyjk+1EILoeE9cy9eULEVzufb4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kecmldCu6I6Af6Ewe2EVqYBpRA7Fc9NL+p1BDEDaTKq0fD4bb1h9b7GoM1GjBTnYE
	 wjMgY7OpNe6LpOq82onsGUk962JarBkDCVpKa0P5TIgUmP3cezu18t105ALnStzbAq
	 pc7UolTq1VYLMRa2yzcSGu1G2G+STpT35zV9IClD4GBfNstwjaRf/8K46/ZXjeaVeu
	 7N/EWoNERCxysF4kxifkKTGSYx/6lX+O7ncElptdnSOXwN+4sIUqofEf6Ru+pLt1D5
	 b9MbKOQcYcM8/ADRq45TlnabzsHJvqshtExpdpODZEs4C9chapRj3zF/jy40p/GwpI
	 q8d37fp0+DSwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI/sysfs: Add pci_ prefix to static PCI resource
 attribute names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721020427.1541197-2-kwilczynski@kernel.org>
References: <20260721020427.1541197-1-kwilczynski@kernel.org>
 <20260721020427.1541197-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 02:07:29 +0000
Message-Id: <20260721020730.5EE1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, the static binary attributes for the PCI resource files are
> generated with the names dev_resource<N>_io_attr, dev_resource<N>_uc_attr
> and dev_resource<N>_wc_attr.
>=20
> The macros that generate these attributes and the arrays that collect
> them already carry the pci_ prefix, as do the sibling legacy I/O and
> memory attributes, such as pci_legacy_io_attr.  Only the generated
> variable names lack it.
>=20
> Thus, rename the generated variables to pci_dev_resource<N>_io_attr,
> pci_dev_resource<N>_uc_attr and pci_dev_resource<N>_wc_attr, and update
> the attribute pointer arrays to match.
>=20
> While at it, re-align the continuation backslashes in the resource
> attribute macros to match.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721020427.1541=
197-1-kwilczynski@kernel.org?part=3D1

