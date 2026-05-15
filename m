Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED1438FEE;
	Fri, 15 May 2026 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842545; cv=none; b=RVbCc8SbLeQ52VVY1CdDFpxSl9jtScG0/94hf/dh4d5Luo5K9X8kD7zUK3SfoZp9cByoreqXM81495a+qn3mxMa6Nqhw1OsL5NScbM2OgWaIsSyhMQSvsNrU2e9dseULEwUH+4LPD6YE31k4SHWFqs2U7S9ImUCu0KxMnK8mS80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842545; c=relaxed/simple;
	bh=29IGxQZNBUzGuWA8s7r27B+7Ef244Dgf6KcW2r1Qnmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDQ8GBh1hZ35VMWWpHblNqzUY7N8pBGY3//1yW2rmujjBdFp0u7xsohWlV06E7VPUJ072fuiUWdiv2vAzYYfQ0C9FY+Esv911r/O0SDPILdWXpWPlIlSK/AhrklKpU5J5lzvKmSG+WJ1E9AgNlWRzeqMxt4KiavuorGj8ztx8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5vWSaL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5vWSaL+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3E8C2BCB0;
	Fri, 15 May 2026 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778842545;
	bh=29IGxQZNBUzGuWA8s7r27B+7Ef244Dgf6KcW2r1Qnmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5vWSaL+ONv7rEoZVuEX+tVp9m63nHDX8b+hhhtY8DVg4KBlO6XO3YdNHlBml7Vl0
	 ZoUwhUYykTs1yOlVLQaUYOXTs+Wi7hHCtYdAgszObSJIuoffVlmVqnoUa3JafS4ul3
	 AfA4GwqH149hSlfPCHGZcNCjSpYlbEa/10UWv8/Ow/67koxml5lzVnqazCzgmxU5rk
	 D4l/JIeo8sMsMU7SlbZicwmIZX7Yc3n9koxkVY0CcMKHqu3qsI33VGfSEiwe4Ql5rG
	 tAHlu2ubVHKrEcsuosZk6yQ4Qpf1ge2S+V+Np/oTpzPUGu04uI/YIYkPOJZ2NlFMn5
	 JfaHsI40c5Ctg==
Date: Fri, 15 May 2026 12:55:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom,pcie-ipq9574: Document the
 ipq5210 pcie controller
Message-ID: <20260515-amiable-incredible-starfish-e9041e@quoll>
References: <20260514-pci-ipq5210-v1-0-a09436200b35@oss.qualcomm.com>
 <20260514-pci-ipq5210-v1-1-a09436200b35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260514-pci-ipq5210-v1-1-a09436200b35@oss.qualcomm.com>

On Thu, May 14, 2026 at 09:43:01AM +0530, Varadarajan Narayanan wrote:
> Document the ipq5210 PCIe controller using ipq9574 as fallback compatible.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 1 +
>  1 file changed, 1 insertion(+)

Please have your patches reviewed internally, including quite useful
tools.

Best regards,
Krzysztof

