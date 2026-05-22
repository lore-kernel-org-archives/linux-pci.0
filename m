Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE75364038;
	Fri, 22 May 2026 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432690; cv=none; b=op919tzsVeo3pyTNbK4fDnjr1M55JdTjxSsI8ZdX5AJuvdv0LLKsTwxT7p5fd1Nl43HwG+sDhS6rpXLDMJEXDiPBjVLuTdHR0zn387ax2lmZdYaK0ywN3wfhBw7uF3vndoBL5J253koFvfoCRcAnM6vfhxCN/Ohry5kQCOBA0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432690; c=relaxed/simple;
	bh=d/6kU4cCye21BHO0fVfm7KWA3Mu9e6uONDevlMz1yvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDOd2t/p7xQf/pby++eH1867orTeifZLJM0bwa5uzS2OyqkAaQe/QRDKHmXIfz14lZjoysnB3t4Z1JVx2qNym4W0rutVl9+M6DAbqmWvTCHzd9VKeGh7CnNKhOsU7iRcVJ7kKu47wThNxos/S+FRnq7Do079JAfDUYWOibCbx+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxQ2QX2Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxQ2QX2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE581F000E9;
	Fri, 22 May 2026 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779432688;
	bh=dDjkxf6l3El40X8q8ClVjELJbsKgRC498N66LV+lbJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QxQ2QX2Q0X0pAAIoiFAOyWMK6qki2CPLyeap76YO5/Iz4RHlv8XCNcaBQPB5SDhVQ
	 x3oxPU6lsTiCOo09JKUbYXXV5jhvEn41AWV18L/tqvHY3a2t34OrWgYsP4wUpF27G+
	 eJBgfytqOcnbhuOg5eyNOmUF/nYJaJe7KztZE2Y0jKCgDb/nXuYjJyQDx6mfE4MWcS
	 yP/gRLqwM3R2ptrFn2yVg/m+eXGPyrlKXPr/DhTJySC6BTZQvy8ORdKRZ5kzzCDAe2
	 5HoD0Zt6ONQJYhJs5vxOsl9gxhd6pdUdO3+INnzU63H07Rho1ogb+i51zpHYI29d2x
	 /fTeP2gLhR+RA==
Date: Fri, 22 May 2026 08:51:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: qcom: Add Support for Eliza
Message-ID: <20260522-discerning-sympathetic-moth-daa9e7@quoll>
References: <20260521-eliza-v1-0-97cdbe88389d@oss.qualcomm.com>
 <20260521-eliza-v1-3-97cdbe88389d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521-eliza-v1-3-97cdbe88389d@oss.qualcomm.com>

On Thu, May 21, 2026 at 07:35:31PM +0530, Krishna Chaitanya Chundru wrote:
> Add support for Eliza soc, which has two PCIe controllers capable
> of 8GT/s X1 and 8GT/s X2, using the cfg_1_9_0 configuration.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index af6bf5cce65b..40f0a5f247eb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2123,6 +2123,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
> +	{ .compatible = "qcom,pcie-eliza", .data = &cfg_1_9_0 },

So compatible with sm8550. Why isn't this explained in commit msg of
the binding?

Anyway, drop the change, pointless. Look how other devices handle this -
do you see kaanapali here? No.

Best regards,
Krzysztof

