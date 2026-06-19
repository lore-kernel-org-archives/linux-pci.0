Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BF3321F5F
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859705; cv=none; b=gEQ3tg7Tf2y7lfWucs/ICO56g7vvFMosbRBWh+yaSWAxmEkoRDFRfVT+jCfee2QEmK9JHAoKZi4iQTJnsSRE6S3c90hAxcyNjxdaYSxR5Z/qS5bgavEj4p+AcWH3zjS1ClMVzCyvzdDJuViT+ysE5yHtn/fsk3dZFmYGu/FSxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859705; c=relaxed/simple;
	bh=Flt3qCxiVHfwdAZ7BibfqJUQzptIM1mEXICwGU2w6qA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=egri/qLq+8vmshx4uQIgLt+L6Luek2IWnuPdbJ7AaPYJhX3c1su9izlO5VjFvRmZEbjmRDwOCF45kDCkrSya9FNSnyyAeMMUrKVPnkRDLTqMNPT6aInWQikAbM2738XSG7d/qv/uXUahpaIC8UmFSHYkSzCwB9wtvwwXOfAG064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cp4CYMZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cp4CYMZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155191F000E9;
	Fri, 19 Jun 2026 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859704;
	bh=XzFxt1l/BR4mVzwclcCr+dvgtFOXTTdnPbB6XFqU29c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cp4CYMZB4UxljJA91sDSWo5qz5hvxiDFSEpCpKL4TaV3BMxnjhQ9dHC+FJZvwitpr
	 /gzrLJWdOM170rAwPODwom7n3waS3OnI+Fh6uZE4leDb0ic/RVAjn4ljhzzzUbUAeq
	 tEHweIE/2Q/H5+V/JlVQRVeKWhDluEGEyjTsCPnV4E8WDMKHDp5NWk3aeJOQDMiJlM
	 h+SLlIrwWknA5odRha4ZP0mChWZ5gqiJQRKtE06KjuUnhitcf4PbPx72D2QxTtPPTj
	 jdM1h3hIaH0FErnCCvoOLnMZpENwiBFrYyIFGfHkr7aC0O0vjjrhH9KmOr+EXgk6jO
	 ulHnl/L8o0ekA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/25] PCI/sysfs: Add CAP_SYS_ADMIN check to
 __resource_resize_store()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-6-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-6-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:01:43 +0000
Message-Id: <20260619090144.155191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, the __resource_resize_store() allows writing to the
> resourceN_resize sysfs attribute to change a BAR's size without
> checking for capabilities, currently relying only on the file
> access check.
>=20
> Resizing a BAR modifies PCI device configuration and can disrupt
> active drivers.  After the upcoming conversion to static attributes,
> it will also trigger resource file updates via sysfs_update_groups().
>=20
> Thus, add a CAP_SYS_ADMIN check to prevent unprivileged users from
> performing BAR resize operations.
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D5

