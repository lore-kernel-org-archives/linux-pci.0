Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956252D8378
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859590; cv=none; b=ZntZFEouBBZx4RBwNI2OeFxwBVSsSPEKd/BwraASW4yYUv2SEDoa/Owm+W5eRh0PrZBVS8+OqvohJv+z4w1idtqqCore1/dA+6ken3hRagDdJH09jArSa+CTxggJYrAyB4k3PVGuBs9B/l+BmT6FgkWFRf2xU0rfyWaYiZefRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859590; c=relaxed/simple;
	bh=DidqvvGgu2LRIHiLH4Fz9PPZ0A51l7WNhGn4/JQPgXI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GsCP27tgGqqVImBApBDPV0WFBLtMa1tD+d/V375O9ugw5so8qGaAjCIyHFXvH4cxp9XWmKmk8EWow3YR/skmpqyFcleuMVfkFNCERPQHJUBM+9KC+asrvMFFD+/E9p1ZisI0a694DhRBsP+7ISVSZCf+WTF9VodzmvY72vrzsmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0qpzuZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0qpzuZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1171F000E9;
	Fri, 19 Jun 2026 08:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859589;
	bh=RJuvj5iSMTdTygHi0QqUWzwXDDJWQH6fevAqN9x77+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F0qpzuZU7s3Gz3zTEJqnuRpaI23agPvMjbNKNIIpqGzHzonu404j1eCRe/G81Ba7Q
	 JL1gnkBbhlwW88TBNAsDqI0EjA3ibY7b63LkvWG72lj7b1OTFqq5xWfqlZX7Io2N8D
	 BxdyfrtPsKG1gzDBWzRhsJT8BUvVOUT3M+6gHfeAihDFElNsdHK5UH9xsa46VKZF16
	 2NqNUWLTObQy2j7jnqfSuHyqR78NnPO5GszPGwp6x2OwAWmOMd/Wl6vuiKUY0MuiAx
	 WxssF+CGXLBMisRYiyq1uXs2u1O4bBb3tpv7vmFM3MHtw96IlzbXi0DTJFPTuumARm
	 bn40n10pymXBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/25] PCI: Add pci_resource_is_io() and
 pci_resource_is_mem() helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-3-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-3-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 08:59:48 +0000
Message-Id: <20260619085949.4E1171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add helpers to check whether a PCI resource is of I/O port or
> memory type.  These replace the open-coded pci_resource_flags()
> with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
> tree.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D2

