Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2A3BE644;
	Mon,  8 Jun 2026 10:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913894; cv=none; b=R58rsCpx55Hm/o/LoK0i1MsVBHjLJ2wBzEn4iDYQmOiJ9PeiCYGrE3IpU02ZsN2Sls1JpvD6c/b1274RlO4E2BmPXkL4pkQADRIoryfZCnS0MhJvMxqUONjR/eUoHZRw8n+S1hg3T45ftIayrg+wVgXF7LIMR32sc1/hzBf/9Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913894; c=relaxed/simple;
	bh=iPtL72hWbPnlcbHvYuTD5CE11dgBfuIg4+EE/trSF+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZS7e9WUAn/mHOnhDcF73wm/TrVhvsLGh4bv4hlknCeD0/ktnFMDpivT/adJPOWjK85CVv+4a1kupM+GnyYETKzdR5/B/LUm9WQZVEEp2ofyF+FmhEcumoe+y0S3QZtEnSYa81BX4X5ZdOMUmi1xGZzVC7Sgn7MhNm/FTpNT8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdM4slwJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdM4slwJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9A81F00899;
	Mon,  8 Jun 2026 10:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780913893;
	bh=aHS6jaQw/yvoxfE3p+vq1/TWxSezMC70ir4mnCrJGDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jdM4slwJbdAnOhLUY9FcRrmPxdrDXTndIFpYeSfS4NYV0QXS3nDyAE9zhb1OIsDW3
	 xR5u2tDfa8f9rUSNkaMp0Oloapm4Jl/vwGuSzugsqzrDJEt4++yLe2Qvgr/eGwYYYm
	 V1a47eVw/s+Mw8dBhdN+vStaIH1ZkjQaNP+OZ2KfhzkUdZ9HgF5ijkRxgqJ/PxUsE4
	 9m92aUUiOipSBAqfPmoPBnDlzoC5P59sc6/E4YBXx3x9j/bieAiu9LHx90V8S8AVNw
	 9haq4/TO5ZIIYErxCM6rkPA8jdWengqQQOhEWvZe4oVFDCfiVdT8nvij6SvKb7Gu7R
	 Dn+x24BV+d8tw==
Date: Mon, 8 Jun 2026 12:18:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-ipq9574: Add IPQ9650
 compatible
Message-ID: <20260608-wonderful-controversial-toucan-daab4f@quoll>
References: <20260602-ipq9650_pcie_binding-v1-1-486a535da8c5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260602-ipq9650_pcie_binding-v1-1-486a535da8c5@oss.qualcomm.com>

On Tue, Jun 02, 2026 at 03:06:18PM +0530, Kathiravan Thirumoorthy wrote:
> Add the IPQ9650 PCIe compatible to the IPQ9574 binding, as the IPQ9650
> controller is compatible with IPQ9574 and uses it as the fallback.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 1 +
>  1 file changed, 1 insertion(+)

Any reason why global interrupt is optional? Older devices were
incomplete, but new ones should come fully described.

Best regards,
Krzysztof

