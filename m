Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4553DCD90;
	Sun, 16 Aug 2026 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786871733; cv=none; b=tKuSYTbUdJQFNleetuZyVheTqAM7MwpUKcG4HkvS46HGQfDRWjZOyCcSWgrziDgd0cx6vcjxfbgevPb7vs8nrygUoSEvivj0Y1xQqX6kkKML9fuk9CCIqfpX3zjna1g5g8dnFqkkAtaF4oVoTLeS+rZmM6npMNS4+oZngaF3FL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786871733; c=relaxed/simple;
	bh=2yQf1LDHX4qgpWCGQ4E8y6JxL5PiFR08RNCQx7brcQ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LMPnt9ZDh1fbFhQbd7UWMWx8uhVvxMSunFQzmroEg9QgSUh5Tw3Itgwu1/yT9N81Xhfg6qh4WLMSqCnZTU14dKre11EaylXt2d+bkcVIch27hmxTgFWM6QaszP12CSHB5ILSKIFMFC/xTBIRFq8FTNBL6OZ6veRcNOPthK4mDok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YE8E1H0r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YE8E1H0r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25321F000E9;
	Sun, 16 Aug 2026 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786871732;
	bh=XV2zA0tWxyYOlGyGOtRBqxqb5B18R0sX3jOtz5i2ht0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YE8E1H0rvSz/ajvih1eSLh2tFmHeJX8mujvLVEOWwmg/F9bf+u1e2GNuwezoUJ9z7
	 3tW6MIwTZRJGdsEu+X0ccQiEq6YevzM8Qrr9fUz3rhQxbKroO95HjbhB5JHTviReAl
	 gVEog60Bwr96ukW4PoFy3SqND85GRmwOf3QqciLmuujut6nGl0Sq/Fb6VQHN2epvGq
	 qOEkY18bLMCZ+TVMIPhA0knfNOdO2+EVoYWC56VhrTvnilnBsB33fl47wg7j6tbQWv
	 0WBQF4hSCfR5TjF1cKEef6qZiQu9KZy80QD/zXSuyvHZtCWmnZ9lR1w2NrUPANV6Lg
	 90lqgy1mIDwKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: Add MMIO Capabilities Register Block
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: peng.guo@montage-tech.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260816084957.3316727-2-peng.guo@montage-tech.com>
References: <20260816084957.3316727-1-peng.guo@montage-tech.com>
 <20260816084957.3316727-2-peng.guo@montage-tech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 09:15:31 +0000
Message-Id: <20260816091531.F25321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The PCI_MCAP_HDR_BASE(n) macro incorrectly calculates the capabi=
lity header base offset by omitting the 8-byte MCAP Array Header size.
--

--- Patch [1]: [PATCH 1/2] PCI: Add MMIO Capabilities Register Block defini=
tions ---
commit 20bc3890e7eab9f1dcc6c8e26abf81734aa23ac0
Author: pguo <peng.guo@montage-tech.com>

PCI: Add MMIO Capabilities Register Block definitions

This commit adds definitions for the PCIe Management Message Passthrough
via MMIO Mailbox ECN. It introduces the MMIO Capabilities Register Block
array and capability headers.

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
[ ... ]
> +/* MMIO Capabilities Register Block (MCAP) */
> +#define PCI_MCAP_ARRAY_1		0x00
> +#define  PCI_MCAP_ARRAY_ID		__GENMASK(15, 0)
> +#define  PCI_MCAP_ARRAY_VERSION		__GENMASK(23, 16)
> +#define  PCI_MCAP_ARRAY_TYPE		__GENMASK(27, 24)
> +#define  PCI_MCAP_ARRAY_TYPE_CLASS_CODE	0x0
> +#define PCI_MCAP_ARRAY_2		0x04
> +#define  PCI_MCAP_ARRAY_COUNT		__GENMASK(15, 0)
> +
> +#define PCI_MCAP_HDR_SIZEOF		0x10
> +#define PCI_MCAP_HDR_BASE(n)		((n) * PCI_MCAP_HDR_SIZEOF)

[Severity: Medium]
Does this macro calculation correctly account for the MCAP Array Header siz=
e?

Since PCI_MCAP_ARRAY_1 and PCI_MCAP_ARRAY_2 occupy the first 8 bytes of the
block, calculating PCI_MCAP_HDR_BASE(0) as 0x00 causes the capability
headers to directly overlap with the array header registers instead of
starting at the correct offset.

Should this macro include an 8-byte offset for the array header?

> +#define PCI_MCAP_HDR_REG_1		0x00
> +#define  PCI_MCAP_CAP_ID		__GENMASK(15, 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816084957.3316=
727-1-peng.guo@montage-tech.com?part=3D1
