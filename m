Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5AF32B10F;
	Wed, 16 Sep 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574039; cv=none; b=Gh9+MYw6F+MuKLI+DaDIQifrw+2FWP34FarqIi9u76EQUQh3D76p40GAFCVx5mR8Px7HvK3G+pe+XwiNGxaMNT2B+bUWBYRLd/p917DS4YS0XkaYvUQkciOKatN7zTQV5lusrbExZU28urwwiM22e0gZQ/jvWqNYbDJBHh0Pbt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574039; c=relaxed/simple;
	bh=ySNaz9gh7Q9NYnmV8fABEysOR62aEPArmwyigKylXT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ck7cz3debmVlUiu9WM+22GOkgFOKT+K69fEiBl8E+mYEZnLIwMECgWpcAqCiK1+uo0DtUUoAcX1RVZqD4r99yKiRj2zbf98Blrn+VvxFKN7p8pyE0K3OBGShmRRAazq7DeEq2e3olJB+SD48BwPqUgKsgRKfCSsFlHvuAz8tkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2O+ZQiW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2O+ZQiW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A599E1F000FF;
	Wed, 16 Sep 2026 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574037;
	bh=6g+y/UxB51shVOcnfNGGmr1NgvU/7y9bCDtFQQo+4WY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2O+ZQiW388XM1QgvY04nKm2vtobEexRcW+mpq7+gZELM+b0oAy34S6y8ieWzWUR9
	 1bpocdlKYoS6yl3nQ/JDQP0XGDLmEXbl+yqAmbQKgXCYt+iBvPyWxf3H3rqOUKgAYH
	 Ej+TC+c00K41zzjDcFbYKKz+einl/ePHRXRiTg8hyxtwZ0uC7Bl1yod1aGd9L2g66m
	 YCGc940Xrcnu33IK/t3BiMinnZparrt4+5HxyeiajXSbxFASSe6N/S9qym78ZlDDHP
	 /dM9K4xt6yPxUzj23dWm1x1cNnxYc6BSNz94ChCesT6+V0cGYxCK1oHbRWWIb2WVwF
	 /GtuKT2BPR20w==
Date: Wed, 16 Sep 2026 17:53:51 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Ignore -ENODEV after Root Port reset
Message-ID: <aqq7j9L76coy65lC@ryzen>
References: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>

Hello Konrad,

On Wed, Sep 16, 2026 at 02:37:49PM +0200, Konrad Dybcio wrote:
> Root Port recovery may race with a device hot-unplug. In that case,
> dw_pcie_wait_for_link() returns -ENODEV because no device is detected
> after the controller has been successfully reset.
> 
> This is a valid outcome and should not cause Root Port recovery to
> fail. Ignore -ENODEV while continuing to propagate other link-training
> errors.
> 
> Assisted-by: LLM
> Fixes: 4d88cb82a6d9 ("PCI: qcom: Implement .reset_root_port() and use for link down")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ee63a6ec99de4d07c16b8d6cb68df0d92f822cd8..3d3be9bf798b7c247d69969d6570385b8648123f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1880,6 +1880,9 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
>  	qcom_pcie_start_link(pci);
>  
>  	ret = dw_pcie_wait_for_link(pci);
> +	/* This linkdown might have been a hot-unplug */
> +	if (ret == -ENODEV)
> +		ret = 0;
>  	if (ret)
>  		return ret;


I did not know that pcie-qcom supported hotplug.

Last when I was discussing this with Mani, I'm quite sure that he said that
it doesn't, see:
https://lore.kernel.org/all/20251222064207.3246632-8-cassel@kernel.org/

If that is the case, perhaps the commit message and code comment should be
clarified, so it is more clear what it actually means.


Kind regards,
Niklas
