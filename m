Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBA93D75CF;
	Fri, 29 May 2026 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780054472; cv=none; b=XCLCGdVwm9mg76oeoeAI720/ySO3cg98nYzEkeECYUjpX4FNuHKkMFI9JCey6kvKIKyDKlUXeCFbIDQBU5OKl1JQUX340ZoZzEgDl5UaIxu4q7Yaa9OveJFz0+AL9E6JW2hoFEn87N3SOgy/mH1d2bMJDB84VeJMKjQnvh88T10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780054472; c=relaxed/simple;
	bh=5Iab6X4RhrWitUCbun54a4+F35ok7WUHKaB69LikAFw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TWUZJT0XUm8bOgp+CIBS4CpOufwQIcuqOexMIsG12EotRxORwGO1gauI4h/Xlk24OtTgu6WR6Ngm9rWUljHIeym4XyrzhQ+Jh/Mcp5aJMgj8oTfmzew5ZtJn+Yj+RGYBu8jEV+4mS6qo8ADNIk/pcw/HgitM/DPxXzGmQYBoKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdQ7Ynky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdQ7Ynky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E977D1F00893;
	Fri, 29 May 2026 11:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780054471;
	bh=Rva11O7unq6kogxVmk2m9YYMSdahz4e/wFC22rOT/QI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FdQ7YnkyjWqYhwz1lydMlH76BArr9i5jmDwpHYDilathLSeNpC/YwPPW2uZUDN1jq
	 QjiSRHdx95157iGbVwP7e9vPN90130Bj8YI+q5dxr3uKvIz3PQCFDuH+6VnESecN6U
	 HnHQ2xO9SJSjX9nfm9pxwVrcHE0KjgdhDqEvkyD/PqfDXtcfY2gO4WtFHmBWvbvrTa
	 S/azUSJ39+QBVxFrCeroFqqOphi6GKEqneff82lElyrGdVJYZdgXlPgPexljJ5NyQb
	 yI3M6tjs9LgbDC4M+9XAQdavA7gBUPzgUADvTMpQhxUgIePcjgwS4By2ghV5s8278p
	 idWA+OVOHs92A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] hwmon: (k10temp) Add thermal support for AMD 1Ah
 Family Models 80h-8Fh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muralidhara M K" <muralidhara.mk@amd.com>
Cc: linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260529111242.2748206-1-muralidhara.mk@amd.com>
References: <20260529111242.2748206-1-muralidhara.mk@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 11:34:30 +0000
Message-Id: <20260529113430.E977D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding a driver-specific PCI Device ID to include/linux/pci_ids.h i=
nstead of defining it locally, and inserting it out of numerical order.
--

commit abc89cca4a911449422a5a960303c2439a718982
Author: Muralidhara M K <muralidhara.mk@amd.com>

hwmon: (k10temp) Add thermal support for AMD 1Ah Family Models 80h-8Fh

This commit adds the PCI Device ID for AMD 1Ah Family 80h-8Fh Models to
the k10temp PCI device table. This enables out-of-the-box thermal
monitoring for these processors.

[ ... ]

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f66e4b6..3301224c58454 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -585,6 +585,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>  #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
> +#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243

[Severity: Low]
This isn't a bug, but should this device ID be defined locally in the
driver instead of being added to include/linux/pci_ids.h?

Could this ID also be placed in numerical order? It looks like 0x1243 is
inserted after 0x12bb.

>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>  #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529111242.2748=
206-1-muralidhara.mk@amd.com?part=3D1
