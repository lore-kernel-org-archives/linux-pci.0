Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6C474255;
	Fri, 11 Sep 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134690; cv=none; b=DWWeFuPyBKvIBjGpH4Nte9aaE+cIcbPON4d3zcLlKO7mPEZI0TaD3u6XyNmiSOhRcmQYqsrKbSYrjHk4Y99tSq/KWXRdcet9gTzG3lYkdeA+zSPb+wVWX/BSQL5jtJ1O1JNc9CdAUWeIRqE3FII1vFbuHjjjNr71aZzPO3bLp/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134690; c=relaxed/simple;
	bh=pBimXvr3yyEZJ5pChbAx7Sy/8b0/dsfkSuSzhoaYyTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pqzJZNGBYgYlAM1S6H7DvdvLms7gT5nI+/L/ZnInLYysqcODB/lRzOUwdPSVD+K+/Hbeh+qD/o1pS+8AdYbvkPzB8XTTTmdmgAs9P+RfEqG9NeH7dBjh2J+xS8G1WYuk6pzONMCXXe8i1zzNdgBev6vpp9ubkfYAGwx7SvFXd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATTUGsA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATTUGsA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CECE1F00893;
	Fri, 11 Sep 2026 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134685;
	bh=sAp9ihGLbimDOgUjVgqQytFLhrvgvJc5zuJgMKu2xqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ATTUGsA4NInrUzdc/II+bCsTYou8HeqWh0GPhXZaSG/U9juIXeZYs/NCHuy/6HpCH
	 VLtkNSJA3Cq2/ClXKcOgyGJ+LWjxRIwlnfkQmkyE8T58srFjx7DEWy/AlV+eA2e8aS
	 nS20KWKiKfwvN/c6CeKDWBux1TpeWIDcztzE9cKKya3lnbuNBWVC2J2EIzLGjuMO7C
	 TcWJFFaIT9UIHfQIs8nwJ5Go3oaCp00XkCjYadXY9W+LHJqr+HLHWbmm8AXgNugclR
	 1qMxtU9RXs22P5B5QyXQQ+KfP7HHX58qprSSVqAfGP6+B21twvnLooHf/Xlmn5O1PK
	 6yFFzj1PO+Tww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] hwmon: (k10temp): Add PCI IDs for 1ah/80h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org
In-Reply-To: <20260911134304.226286-1-mario.limonciello@amd.com>
References: <20260911134304.226286-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 13:51:25 +0000
Message-Id: <20260911135125.8CECE1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The new PCI device ID `PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3` is inappro=
priately added to the global `include/linux/pci_ids.h` instead of being def=
ined locally in the driver.
--

commit 7a5a1abca982d7be5902a75b129f16bd3cb32d69
Author: Mario Limonciello <mario.limonciello@amd.com>

hwmon: (k10temp): Add PCI IDs for 1ah/80h

This commit adds a new PCI ID to support AMD Family 1Ah model 80h processors
in the k10temp hardware monitoring driver.

[ ... ]

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 63774ae2bf71d..57a4ad9984798 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -585,6 +585,7 @@
>  #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
>  #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F3 0x124b
>  #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
> +#define PCI_DEVICE_ID_AMD_1AH_M80H_DF_F3 0x1243

[Severity: Low]
Should this new device ID be defined locally in drivers/hwmon/k10temp.c
instead of the global include/linux/pci_ids.h header?

There is an existing comment in drivers/hwmon/k10temp.c that establishes
the practice for these specific devices:

/*
 * PCI Device IDs for AMD's Family 1Ah-based SOCs.
 * Defining locally as IDs are not shared.
 */

Since this ID does not appear to be shared with other drivers, would it
be more appropriate to define it directly in the k10temp driver to avoid
cluttering the global PCI IDs header?

>  #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
>  #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
>  #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911134304.2262=
86-1-mario.limonciello@amd.com?part=3D1
