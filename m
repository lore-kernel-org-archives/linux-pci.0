Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FDA4192E5;
	Thu, 11 Jun 2026 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194628; cv=none; b=FT/htAQn8Al13RlcN+SLvZlvRI3Baojiyl9wK/1CS9sM7O49rSgKVwzNOrfbvrdXXj7+pbiS567LVkCkAggvHSHRafo8MUsof40X4RjnhrsSwiV9ageFt+avP+yxA65LFIsoCkxgmp/pXoolrivSPUoKA4JdFKTDt3obd2mDzj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194628; c=relaxed/simple;
	bh=89AyRdbchef7sjB/Yb5mFTiSDbyA+DCW4vDRX6so6wk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qwCOpPINrZzo2UIYGfHtedXRHlpbQhdNIno3y4sP3QM1xpVmHF6+KCLCQ9bwKxPjUENP2Ra0jcl0oB/lUoDnLn+sV5AEkSUjxLMCOynX30qk1oUQ+MFB6xGhrlgF5M0qDmAcDvNUsdKT+e7g/QwJItS3bY/2Xy4wtMW4AugYa2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVWTFu/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVWTFu/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BCE1F00893;
	Thu, 11 Jun 2026 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194627;
	bh=vzZhenHbPwepLaH1jkQZbPxGq+tZ5ZGXbuy3+e6Nifc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=OVWTFu/TSFSg3ELJDdAbFWDbM3Hi3TSeZBAet0Vz8UDsfS2ektb+YAEPPbmblPwgl
	 DaP6LK0Jv5gePb7DFx5uE/iMovoFan/dVPOtRNqvPnWnb4hckPobwj3ThuIBecXtYx
	 bNnuTlAH4OOh9zIN6Ialc5WjVVg7BJL0Jn8lSGXGEHXpP1OERyuyzKIgr7iC390ULw
	 WRe1d5T+9TM0no5xmVJ6ZUr1Ca7M9yIrZJYdK3i9oz31MF3AHvm9rPEZ0XEfDMR6Rr
	 E+0SA/LOnuK7tXPVC7zNwXlNElGaWfL6wuK84JCGkOO3Iko/rt05q8ToLPQMx0vO4g
	 f/f1k/l3o+f6g==
Date: Thu, 11 Jun 2026 11:17:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linusw@kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"moderated list:PCI DRIVER FOR MVEBU (Marvell Armada 370 and Ar...),linusw@kernel.org" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] PCI: mvebu: Use fixed-width interrupt masks
Message-ID: <20260611161705.GA486072@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526044016.1025613-1-rosenp@gmail.com>

On Mon, May 25, 2026 at 09:40:16PM -0700, Rosen Penev wrote:
> Use u32-typed BIT and GENMASK helpers for PCIe interrupt register
> masks.  This keeps inverted masks in the same width as the registers
> and avoids truncation warnings on 64-bit compile-test builds.
> 
> Fixes this and similar warnings:
> 
> drivers/pci/controller/pci-mvebu.c:316:21: error: implicit conversion from
> 'unsigned long' to 'u32' (aka 'unsigned int') changes value from
> 18446744069414584320 to 0 [-Werror,-Wconstant-conversion]
>   316 |         mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> 
> Assisted-by: Codex:GPT-5.5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: remove sys_to_pcie change
>  drivers/pci/controller/pci-mvebu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index e568528bad85..f5a3f7370552 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -57,9 +57,9 @@
>  #define PCIE_CONF_DATA_OFF	0x18fc
>  #define PCIE_INT_CAUSE_OFF	0x1900
>  #define PCIE_INT_UNMASK_OFF	0x1910
> -#define  PCIE_INT_INTX(i)		BIT(24+i)
> -#define  PCIE_INT_PM_PME		BIT(28)
> -#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
> +#define  PCIE_INT_INTX(i)		BIT_U32(24 + (i))
> +#define  PCIE_INT_PM_PME		BIT_U32(28)
> +#define  PCIE_INT_ALL_MASK		GENMASK_U32(31, 0)

This looks like something that could be an issue in dozens of drivers.
Is it?  If so, I'd prefer to fix them all at once in a single patch
instead of a slow trickle.
