Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6D211A14
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860648; cv=none; b=ovsZUAylL0Q6190tUqe5lWtQliYU0cf38ZG9JDn+EgqFLvORDRF+04LN4n/QQ3aCLiGDdXYpsmvcjCpfW8reqfcR18wdcJc8LxTuZ7DgcER+zqOr9r7lLURmxfGjI3o9du40zorEGuPHmgojxUO0KK2IHWvktG/wupNsIJMW7X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860648; c=relaxed/simple;
	bh=vo+EJ2ZSWjXQzEnvFVkPhL30WN9CDKWU4+9GZK7eGzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RPa38lg6Xn+XJZShIz5dwiIixpkW4gwzMgwSncdweuit9FZo20srUxKvZYT3I4ym750NfY8bbHpxppL9+OoapZ6+qMsCJvlCLhxEg6u9Mr3DbnNfeLK4m5tiQjTyVf7HkKArC4r9SUBP7CY3puWffdZsYMs3ZQ754FI9H40odV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RETDyPwP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RETDyPwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63133C2BCB0;
	Fri, 15 May 2026 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778860648;
	bh=vo+EJ2ZSWjXQzEnvFVkPhL30WN9CDKWU4+9GZK7eGzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RETDyPwP09Hk5g3dWVtxOo1qXZLmmkZco33UjgcsxAvWdFcG5uJZjHVxxQO6evilC
	 c/mSi2Cr+0QfBlAHVUZ/1Lw6y+9ZJwaurC3lPADkzFoea0kwxAZn2KArz/g36dGk9N
	 tDnhDSt3hNxByUD+2lvHwxyZ1o5/FxxwuRSaWYQBBoYukyp5yiKkrVS1yHpcLr27v4
	 Fw/eTTD01FciUQxZucXIc70xNWaPAVn3bVL/eXqZG8M90+H3WlfOTkvD8aQM9+rbXh
	 QLUkiZBU8n7V+FbMa/pOSvZDU1pxNZbnPb1ievr+XxLEply4NsUk7dq79ZaEs2FLVS
	 K2zf5g3gpIpmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] PCI: cadence: Add LGA IP debugfs for LTSSM
 status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515145747.129635-4-18255117159@163.com>
References: <20260515145747.129635-4-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 15:57:27 +0000
Message-Id: <20260515155728.63133C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Out-of-bounds memory read in cdns_pcie_lga_ltssm_status_string due=
 to incorrect prefix length subtraction.
--

commit f6b71b7c026fc3d8d383a59dcd6b10992b1a66e1
Author: Hans Zhang <18255117159@163.com>

PCI: cadence: Add LGA IP debugfs for LTSSM status

Extend debugfs support to LGA-based Cadence PCIe controllers. The
'ltssm_status' file now works for both HPA and LGA IP by selecting the
appropriate register access based on the 'is_hpa' flag.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/driv=
ers/pci/controller/cadence/pcie-cadence-debugfs.c
> --- a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> @@ -13,6 +13,58 @@
> =20
>  #define CDNS_DEBUGFS_BUF_MAX		128
> =20
> +static const char *cdns_pcie_lga_ltssm_status_string(enum cdns_pcie_lga_=
ltssm ltssm)
> +{
> +	const char *str;
> +
> +	switch (ltssm) {
> +#define CDNS_PCIE_LGA_LTSSM_NAME(n) case n: str =3D #n; break
[ ... ]
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_RECOVERY_IDLE);
> +	CDNS_PCIE_LGA_LTSSM_NAME(CDNS_PCIE_LGA_L0);
[ ... ]
> +	default:
> +		str =3D "CDNS_PCIE_LGA_LTSSM_UNKNOWN";
> +		break;
> +	}
> +
> +	return str + strlen("CDNS_PCIE_LGA_LTSSM_");

Can this cause an out-of-bounds memory read?

The stringified enum values, such as "CDNS_PCIE_LGA_L0", do not contain the
"LTSSM_" portion in their names. For example, "CDNS_PCIE_LGA_L0" is 16
characters long.

However, the return statement advances the string pointer by
strlen("CDNS_PCIE_LGA_LTSSM_"), which is 20 bytes.

Since L0 is the normal operational state of the PCIe link, could reading the
debugfs file while in this state advance the pointer past the null
terminator and leak adjacent memory into the output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515145747.1296=
35-1-18255117159@163.com?part=3D3
