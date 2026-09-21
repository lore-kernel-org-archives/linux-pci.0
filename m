Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543A194C96;
	Mon, 21 Sep 2026 05:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969567; cv=none; b=HtPVhWNFWKwiY4yR6E8927WJ+9G63UvYCE78jATbzSaoh4yeREIHYxZ5DKhRRSzTHi/Dr1gZd/RdQNY97EqNcSF16iwZKKpUmY8TUZfUu4Svb8zjJUj08YuiZe/VCSdyX3xMKAzc+aKW8k8lIl71fkghWLmxiCwaPz/iztVZm9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969567; c=relaxed/simple;
	bh=2mG18cplaotkY7xbXvkCMZUcoWprG1aWL0oChCiuX/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PIXRnDzOBDbs9ltap6Ye6Ew3HaVgahbxCWapZxGtr6r8IO7K5J5KrNtV8Y8+Ve6P4AFAYOsHrsbn9BX7kodKE78G7H8JPp7VR9lx9gjKpVmgOY20U/flA/FD70hbyD8lkpiY/dMe2VZtrxa/RfgYRIVXKHJMNfq4MSGNu84VduU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ64kA1V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ64kA1V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8631F000FF;
	Mon, 21 Sep 2026 05:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969566;
	bh=J/kAvxPdVNaVb0n5O8bYcuDBkBCgxS17oz1Lu6OLAEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GJ64kA1V6mB9zRFZwMiRFlsViVb9s8YKzl45xRGB3PPQTGh1zahcizBoM9aFjhqPn
	 d+yEniEYGH42gLXKPqXjKYYB7iLO2/VAzv5FVUHhjXlwHE8ymC+jPifS01Zjr6oaqe
	 K/KGPj9qqYKy7ePYtcV4OU3Sg5jgkaHYyzgCZEIwygDjJ090sqb+Iwx+z4LimqG+qT
	 aGqaPAXTjD+8aZ0A6tDA/bs2e1dPo+MIEc9NA3zHs/CKQBbDkrdV8q+HQ9KjVRHl/7
	 snpqbMoXyG9Xec3JfBJt7F5WYfJDz+qX3meU5mGfMNWoR2c8dld9Tizr06D9+3UYCd
	 un5RVJSyXBq1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/6] PCI: qcom: Add Nord PCIe controller support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: vkoul@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, olteanv@gmail.com, conor+dt@kernel.org, linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260921-nord-v4-3-ed05c6e09240@oss.qualcomm.com>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-3-ed05c6e09240@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:46:05 +0000
Message-Id: <20260921054605.7A8631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci: qcom: missing kernel-doc for disable_cgc in struct qcom_pcie_c=
fg
--

commit e586f6bf039bd0cdbc21480739c4165ddb038509
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI: qcom: Add Nord PCIe controller support

Add the Nord PCIe controller configuration and the platform-specific settin=
gs
required for correct operation. Includes a clock-gating workaround and disa=
bles
L0s, as documented in a private erratum.

> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/control=
ler/dwc/pcie-qcom.c
> index b58a607b713f5..304628b57f33b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -281,6 +281,7 @@ struct qcom_pcie_cfg {
>  	bool override_no_snoop;
>  	bool firmware_managed;
>  	bool no_l0s;
> +	bool disable_cgc;
>  };

[Severity: Low]
Should this new field be documented in the accompanying kernel-doc block?

The struct qcom_pcie_cfg has a kernel-doc comment block that explicitly
documents its members. The new disable_cgc field was not added to the
kernel-doc block, which leaves the struct documentation incomplete and will
trigger kernel-doc script warnings.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-nord-v4-0-=
ed05c6e09240@oss.qualcomm.com?part=3D3
