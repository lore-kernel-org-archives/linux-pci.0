Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2593F86E2
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 09:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677070; cv=none; b=WOBPukB/0SR0/iO31AtxvEipwiVPvE0KYH/f0jUo4SuN2NIvOAPauvhEoeti4XVNRNs+g3kPrrVyac4Js3gNLDBApv7XcXK5zeW0Ed+g8vS8CJP46BYM85KCM0hX5sLtaunEQTHRioUfSIUgu0sv3hpEuGCXcjGYiPiv3ZyXVKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677070; c=relaxed/simple;
	bh=ORdpHIhEjKns2gXH48nm4FDyUgjTzmF8EfQrU2vZXxg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MuRVNEbXwx6CWjOiiWxqrvibuUnkZUq/eQVrQxWM5x/fmxl+5t2qLnL2xfSrD3fRUBsnw+lm6vT1zP3t9utFaBKc4SNN12YCWZzJn4SWDr7H/vC+slvRXRGCCJyvXBlgMMt5etPQ3Ey5xaQ6lf6Da602q3fP99T38HlKPYTuRkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVG3E8mM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVG3E8mM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1185F1F000E9;
	Fri, 10 Jul 2026 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677069;
	bh=s7CEhW7qoM63jTDw4ZDIUa2tOnDBv8EuxCy3FNS95Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVG3E8mMfM3rN3Mpt8CLKGf3YT37wKXanujhSh1paqio6D5wTmZlMcdQO4IwqqGEb
	 wZIH0tPQctlel5mEfrkKE38LNSqWf5y1x4oAamLVmr12SDcigs0NBipy5gbCydGhkR
	 YmAQ5kAddkxEk2ET+aQqGAWW6M5Rp1lDB6GPxtTUwwkr1stO9ZEke/WE6iBhF8AjOM
	 b4tijezintsX99ufs0XD/oMDDoATWLO17c9WtkQuZs/hJnGQgLTvy70Lwi7BOy6xpK
	 AVt4m30iF6bbClY7JozcKiRWQOuaIhbetv3h7tRu1Mhh48zPsw5oFZLyvqzhRUJzKC
	 Hvml4+/dre2Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] arm64/pcie/pmu: Add pci id for LECARC pcie pmu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Braden Zhang" <braden_zhang@lecomputing.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710-pcie-pmu-v1-1-1519e580313f@lecomputing.com>
References: <20260710-pcie-pmu-v1-1-1519e580313f@lecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:51:08 +0000
Message-Id: <20260710095109.1185F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Inconsistent whitespace formatting in include/linux/pci_ids.h.
- [Low] The commit message is incomplete and contains typos that obscure it=
s meaning.
--

--- Patch [1]: [PATCH] arm64/pcie/pmu: Add pci id for LECARC pcie pmu ---
commit c0d34696455e22a889eb602a30aeaa12283c0cfb
Author: Brett Zhou <brett_zhou@lecomputing.com>

arm64/pcie/pmu: Add pci id for LECARC pcie pmu

This commit adds a new PCI vendor ID for LECARC and registers it in the
DWC PCIe VSEC IDs table to support the LECARC PCIe Performance Monitoring
Unit.

> This patch adds  for LECARC SoCs that pcie Controller
> IP PCI Express DM Controller pum function

[Severity: Low]
This isn't a bug, but there appear to be a few typos and missing words in
the commit message. The phrase "adds  for" seems to be missing a word like
"support", and "pum" is likely a typo for "pmu". Could the message be
updated for clarity?

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 1c9d40e09107d..1c4fd16315054 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -173,6 +173,7 @@
>  #define PCI_VENDOR_ID_DYNALINK		0x0675
>  #define PCI_DEVICE_ID_DYNALINK_IS64PH	0x1702
> =20
> +#define PCI_VENDOR_ID_LECARC            0x0720

[Severity: Low]
This isn't a bug, but does this newly added macro use spaces instead of tabs
for alignment? The rest of include/linux/pci_ids.h appears to consistently
use tabs to separate the macro name and the value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-pcie-pmu-v=
1-1-1519e580313f@lecomputing.com?part=3D1
