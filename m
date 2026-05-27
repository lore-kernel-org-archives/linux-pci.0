Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC06C30AD15
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903037; cv=none; b=RHOlLKWgztAQ1OxPVkR/9cHQi1DDAZwftoWqQqO1tB6BeL9J7EVZ9kdtdKBUpw3meGqrxCbwMJxDwPmC8jnp+91wwzbNfsXCLLUBVr//fiDkBdFJASazRY+5fFyr1Yaj+PefZeKDjsqMARjVHAk3JcdVxUsOhKM/tJZNyo66lUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903037; c=relaxed/simple;
	bh=Zlo8MU5MUH6M//JgnGKPMmb9vCR7NwjHtQlwpB5XVvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ahw1SfMVU+z4jUxCMGzCfCDHAMpgRJAYywuDOkrQE80o7yfmbn7WDGRhZeg7/OVDGZuMsVUAtjAoiY0JWrjG0KXrtM0aIxYrHSmnhPa5LI1RqdfjzEG/tw0EVGD6xV0C7y3daLgnUJKdjr2Fhizcjcxpeea95OEfjHViuURQPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNOm/+xY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNOm/+xY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453A01F000E9;
	Wed, 27 May 2026 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779903036;
	bh=fuea7FT7HTreB/IIuRln/W0lYEIc81/WCGz00TeKS2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNOm/+xYf8fMStDiLQxj1WEu2UwaeYSL+ORcrU0QJ4oN738DTzLJx0wI03yqUqHOp
	 GVkSOc2fMyBQoLNRSRDM7B+CzGGiW/VIGcO63PAPtGWUSrbN8JJHAlnDflz3WSvFQS
	 sN5P2QywTjbCq4PDm5nkVM3w1eRktac0FP+18IbAAyf58GYT/sDu10FC3WinaVJzeD
	 C11bVjGZbvapUp/sBCHTfzdfAg1JQODK9nVjYnAmqX+SA+3DgjzWd0e9+ZGdAsPEWL
	 8o/Z+YtEA1z0sqzuvGivav3y2vCLOJuROIveH+OEPA5Ph7mGKKe37XRiiO/pzalKuF
	 6xFIZiDXnkjig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/amd_node: Add PCI Device ID for AMD 1Ah Family
 Models 80h-8Fh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muralidhara M K" <muralidhara.mk@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260527171731.2370179-1-muralidhara.mk@amd.com>
References: <20260527171731.2370179-1-muralidhara.mk@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 17:30:35 +0000
Message-Id: <20260527173036.453A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit defines a new PCI Device ID macro but fails to add it=
 to any driver's device table, rendering it unused and incomplete.
--

commit b8176196e7cd4eadef9e2045b12170c737ec764f
Author: Muralidhara M K <muralidhara.mk@amd.com>

x86/amd_node: Add PCI Device ID for AMD 1Ah Family Models 80h-8Fh

This commit adds a new PCI Device ID to the MISC IDs list. It intends to
support the new generation of AMD 1Ah family 80h-8Fh Models of processors.

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 24cb42f66e4b6..3301224c58454 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -585,6 +585,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>  #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
> +#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243

[Severity: Medium]
Should this new ID be added to a driver's device match table, such as
k10temp_id_table in drivers/hwmon/k10temp.c?

The commit message states the intent is to support the new generation of AMD
1Ah family processors. However, the patch only defines the macro here in
pci_ids.h.

Since the macro is not added to any driver device matching table, will the
kernel actually recognize or support the new processor models as intended, =
or
is this ID effectively unused code at this point?

>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>  #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527171731.2370=
179-1-muralidhara.mk@amd.com?part=3D1
