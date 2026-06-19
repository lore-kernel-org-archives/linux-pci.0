Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB7364927
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860608; cv=none; b=by3l9PklHra3aMDTm1Cs/CaFQbaWl71GvdfAX64173ZXdDuiVjmwq5GuPA5X+cIsAv0eAF2pg4bxDqb2ntF0NwxKRiKbRTRixpMdPptgb6jbCgqI6Kf7N5uGLi+w3LfO3b7B7jPU19co7jEY5UtVAht+gEZYoyQkVlZKJeNm5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860608; c=relaxed/simple;
	bh=ZjBC9ik95R+SOh7VZ2p8xnI10SIyX24KG2VOSfeCaOc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WJ05NEuYcco5VMENSQB6Y3pRgg0u72WFa8c3aoxZmukJN7HZdejZ00eeD3KDUFyIILI9FRThxCZUXJOFqP/oHyWGmhr1DCUDabhdKjdEDQxVD3PoxGgUSBDvBsu3c5STNifrb3I/okacuSWm6OevyQzq3kmbsTqq7P66+VXLkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etKNtIJe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etKNtIJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819C41F000E9;
	Fri, 19 Jun 2026 09:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781860606;
	bh=nzRGgjmPEwA+AIjWeHSqJ5ceWu2YGERTRMqIM9EJZMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=etKNtIJewqFpGu/0RyHvRrQ271tQqjmoTGeaoVWAEjZRbDqWw6zG6ou9kflmFVEZY
	 AECxCRcWd2eoW8NqzJ4clcgaj87RS5WVSPCQoR7L76L1JygmTr49bOCbfo8nWZY+pP
	 J4b4qu1AqHJmElTdDwbr8/v8NZA9NEbkWAR1shs18+MLfjWkaGBVd2udadq0TvZ5OU
	 ioloj4+zXK8K4B2qmzF4Ivfknd2pGOREVB+D1TkpHmoDmP5D1VAMJga7Cpu8cY3fU5
	 64dsvvOycjiihvLkEm5yLLp1UDJ47kmDUrXexoQmwdWm/CrcA4U3r1Cw4axcscij3M
	 LTIkkX5Ce/zRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 23/25] PCI/sysfs: Convert legacy I/O and memory
 attributes to static definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-24-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-24-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:16:46 +0000
Message-Id: <20260619091646.819C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused fields `legacy_io` and `legacy_mem` in `struct pci_bus`.
--

commit 7da0447cc07dd2c8c43599562ff0122344fb1754
Author: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

PCI/sysfs: Convert legacy I/O and memory attributes to static definitions

This commit converts legacy_io and legacy_mem sysfs attributes from dynamic
allocation to static definitions. It leverages static attribute groups and
is_bin_visible() callbacks to handle sysfs creation and removal automatical=
ly.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 7f1d8e07924f5..dfb4e06677fce 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
[ ... ]
> -void pci_create_legacy_files(struct pci_bus *b)
> -{
> -	int error;
> -
> -	if (!sysfs_initialized)
> -		return;
> -
> -	b->legacy_io =3D kzalloc_objs(struct bin_attribute, 2, GFP_ATOMIC);

[Severity: Low]
Since this patch removes the dynamic allocation and assignments to
b->legacy_io and b->legacy_mem, are these fields in struct pci_bus
(defined in include/linux/pci.h) now completely unused?

If they are dead code, should they also be removed from struct pci_bus
to reduce the size of the structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D23
