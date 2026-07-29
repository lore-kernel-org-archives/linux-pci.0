Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A1D43E070
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312307; cv=none; b=fsNLIb/St/CTvx+8cwjZH6BzAjOFET5eOA6U+uWcDw8McA3j0uH9BZ0cUC1LH7yykoCNSu0vfgDD6Rs6CTgKioOEnkCTGgVwdqdnIVK60L70fGIrqniAH08bdSYZ/ot/P5Ej+Rp85syTo9d0aERXE78LqjBfSw2xFUAsoVmOWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312307; c=relaxed/simple;
	bh=Pek5VBPTQILB2ah35maZGgkIpHd4UBl5Yyag9Gsbvtw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S1uFtYiL3RXZPfQzmav3wuJ+Lg+/jKvcqLcCCqfgi9UhNs9eGN9/P9SjMU+wiLc1LwSfa4gqSCEB7C65bSSgTrX8ozSd0ktDSrLMBXXfk9aREMXfUZp5lm7GNKThy6mV+x28jf5BKhJ6WF1z83v/0U+FP8uQuCHXyA/c2tsV5vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyNz/92L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyNz/92L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBB71F000E9;
	Wed, 29 Jul 2026 08:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785312304;
	bh=GBXylTSLKPLa57AY25ObbEq0kbG52Q/y4eOtsRBe/hc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KyNz/92L3En3rmM5XYAYXkpKVSG/qZzqwbGXDrsRIJWqZXX1uhrsGtdWAT3EtnCOb
	 uGYeWY+NKOrJk5vrtKLQeDr4VmaNg3G5GsY9KHH0fOr/iR12tMCKRqpqQoz3yyPwa0
	 2OGj1yNW4A8gzH1pNIofylgyKwpCYpcq3plW79Gfb4JFS1oAzZOVtgyC0cgkE5WR8c
	 M4BybFoiq8ztwuSxF+jmguaQzaccUwupsROVqJxkUYDgc2SVd6OKDsv3Y7tTOdLyAh
	 NYkvcvDYiCzkvbszqyg5ZBkV5BtHuSvUSXj6zU/VnKMZL8zPLcCDdFwuMGf0SVxTGx
	 ABTkeqeD5EMaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/proc: Avoid spurious runtime PM wakeup on config
 space accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729075909.1219906-1-kwilczynski@kernel.org>
References: <20260729075909.1219906-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:05:03 +0000
Message-Id: <20260729080504.1EBB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, proc_bus_pci_read() and proc_bus_pci_write() do not return
> early for zero-length configuration space accesses at valid offsets.
>=20
> Thus, such an access invokes pci_config_pm_runtime_get() and
> pci_config_pm_runtime_put() around transfer blocks that do nothing.
>=20
> This is a problem because pci_config_pm_runtime_get() synchronously
> resumes the upstream bridge through pm_runtime_get_sync(), and resumes
> the device itself through pm_runtime_resume() when it is in D3cold,
> only for the handler to return zero immediately afterwards.  Such a
> spurious wakeup wastes power and adds needless resume latency.
>=20
> The sysfs core already returns early for in-range zero-length binary
> attribute accesses before pci_read_config() or pci_write_config() is
> invoked.  In contrast, the VFS forwards zero-length requests to the
> procfs callbacks, where they continue into runtime PM handling.
>=20
> Therefore, return early from proc_bus_pci_read() and proc_bus_pci_write()
> when nbytes is zero, before any runtime PM involvement.
>=20
> The value returned to userspace at these offsets remains zero,
> so the change is not visible to userspace.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729075909.1219=
906-1-kwilczynski@kernel.org?part=3D1

