Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3AA377EAC;
	Thu, 11 Jun 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166491; cv=none; b=mQuOFexKicykB/1qsVnRkzWObtLvTUM8PaxZpf8ss7arGSeRDHrT1GtElaxLFBvjXr7GB+LS0kzueF6tGJhihfsVmO9ibvGe3aGrE16iKOH5W04IJg94610DVuvNUJcHW2SHWXhX8daVMoadYOWrDiLwPYP9XFal06f9P5tv1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166491; c=relaxed/simple;
	bh=1MlTbb7U648HdL2SIhlJGd2z3l5bCc6QhpA+T9NpT1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePuOsIfCeTHsIYQYh4WZmEbbVBk469r9DM94kH+neXGTlo0V8MOvL1e7x5hkFV62SThj4MPjPyFQIhLo4RI2JHj4OM3Qg3kchzkH8wY4LxSMfYZ/LgtfZsVGbvNeDM72pfpV52wYTLSino0xh1dANnUowPmR04OhVK2CrMX6rVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKGsSb4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKGsSb4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666211F00898;
	Thu, 11 Jun 2026 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781166490;
	bh=AypkWdNIREEui+qRJtEN2M9ojjSr5SL8BFesFuDPnHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bKGsSb4h47erEIsheRgFGkilTaK0apzp+wkdUXoTU8YQSDhLP+RIAQN2YktipZNW3
	 p3IagRWrkCexamq9tDiYH0zIzNippY5SJ9Ng7E6FM4rea9MBd/mb3hakKMr/IjhMQ7
	 wlSLWTQtQbHuG6Qq6arIpxhkgqmTGmM/RrfxP7n1zB/nbz4rIeGXKTJOdt0+FzOd3V
	 UiKebxc4hgeMjddo2cBzKqtyzHQCVLfB5Ikv6ye45D0+RRdGLhgp6SnieKwibxapyu
	 o2PmS65Rm0D6/Geos7N8JmwJqngwePUsblgniYhL/+P0emONTulsS6/uZwC6eYqpv8
	 TUN1KQ0XdSjkw==
Date: Thu, 11 Jun 2026 10:28:07 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650
 compatible
Message-ID: <20260611-bulldog-of-inescapable-peace-e384a7@quoll>
References: <20260610-ipq9650_pcie_binding-v2-0-69e27a1fbf1c@oss.qualcomm.com>
 <20260610-ipq9650_pcie_binding-v2-1-69e27a1fbf1c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610-ipq9650_pcie_binding-v2-1-69e27a1fbf1c@oss.qualcomm.com>

On Wed, Jun 10, 2026 at 04:30:53PM +0530, Kathiravan Thirumoorthy wrote:
> Add the IPQ9650 PCIe compatible to the IPQ9574 binding, as the IPQ9650
> controller is compatible with IPQ9574 and uses it as the fallback.
> 
> While at it, make the global interrupt as required for IPQ9650.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

