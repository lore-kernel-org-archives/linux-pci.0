Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141781B4257;
	Tue, 17 Mar 2026 04:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773723403; cv=pass; b=GOETZRWQCV8685R/KfLwj9qUDdHB+SEZ++OonqSP0khh+CqJ8BnevkeT6V4+LbqD5THogjWCqalvvI8YKbRw4Ev+4qrZfgB3yJJVkNfnDbet59Lm8s+fiwO3fMCvHCR35o+t1eC2g7Jyj46n7o/xtvbtB6URRPqE2MNQmzl3eHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773723403; c=relaxed/simple;
	bh=76xcV6JFbO7j2t608/cM7lRLXMaX/zP9dgE7PR1Y9fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2B62fMoeuCGEehzURBDZiBrg6Z/UQ8dbw988zgEw9UQe7kTsAgsgxsqmWSbQfV/c7Cv+H8XglMOHJ+ygvGKvN+JWZDLiovNx/jMTShb6s6QCpr/bg6Bg+5xHHRtBoPC6eHOnu0k5vaBSxp3hfgCq321pZBwuZqmY4e+nC1ZRjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=WPCqwGLg; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="WPCqwGLg"
ARC-Seal: i=1; a=rsa-sha256; t=1773723375; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jv4W65Eez2XeH9G5ErU/Y8ESdtUVdFcY98YBU6VYVL32MAvWA/3o27T85GNglxfY2zG41dX/1h1hNF5YTjeGZ48TSDBQfbccolxYkJAAYFoT34Ex0ruvdCTbhoA52dl1xM+qj7xaeJ6Ni7I6ygbEzbFDtY+WPg3uZPvV5IddfB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773723375; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/T2hb2zDBTYyx2qNSAdWht261iTUJecScL8CnM2TGvc=; 
	b=A7hfPYMKt3xQ9cT30L5UCrgV51YbBzJ65/x1qGwdJKViu9iGhnyRCLOKyvaS2w+skFbalcWM4FVCcr5FF8lJ/uYt4K6HJH0xyeV+eInKQ5fI0MGPFPiYhbh/0zIde7YtlY8BULUGRE1iesyDRkQ3YvWGg6GhZAxTtSaUU86JAHw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773723375;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=/T2hb2zDBTYyx2qNSAdWht261iTUJecScL8CnM2TGvc=;
	b=WPCqwGLghg4ELnTN0tR7SEMkq0yPRX/HCjbLCRFxu+Qmz19wmBt0P3riww0KuAZt
	4V8bMeGnXDyQ/GORqiRq5XpdtTklmon8PRTyzj+3OwG4bY0/BcQ1VozmHv5sZbg4lph
	feeQ9VTh3/e1bb9HtSRuCMlB5WMO0iyMmccY1Vi0=
Received: by mx.zohomail.com with SMTPS id 1773723374200302.13921499108164;
	Mon, 16 Mar 2026 21:56:14 -0700 (PDT)
Date: Tue, 17 Mar 2026 04:56:07 +0000
From: Yao Zi <me@ziyao.cc>
To: wangjia@ultrarisc.com, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller
Message-ID: <abje5wWCljOBhgHU@pie>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com>
X-ZohoMailClient: External

On Mon, Mar 16, 2026 at 03:06:59PM +0800, Jia Wang via B4 Relay wrote:
> From: Jia Wang <wangjia@ultrarisc.com>
> 
> Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.
> 
> Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> ---
>  .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 108 +++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> new file mode 100644
> index 000000000000..b50ff98dd878
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/ultrarisc,dp1000-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: UltraRISC DP1000 PCIe Host Controller
> +
> +description: |
> +  UltraRISC DP1000 SoC PCIe host controller is based on the DesignWare PCIe IP.

If so, you should probably refer snps,dw-pcie.yaml to avoid
some duplication.

Regards,
Yao Zi
