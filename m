Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC01F1534;
	Fri, 11 Sep 2026 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789106425; cv=none; b=LlPYxlaG/fr7tzTsJ8z+z8pp7SBS065HaRJIsxNbAExTpINjDI8kxtyQW/WN/AGEHoNH+fEuECxsWfCI0yCZSmQrcFqtFTS7Oq1ype09pBV7BNZOpdrvpVVPEJI1yLVAJX91nIgBbiOGPdQ1/qsuj81kUic63ll8jS6QKxE55RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789106425; c=relaxed/simple;
	bh=7bFF2tHiAeMNPHKVwAStjSnkWUszOlX5Ivpemv+2XZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbj2CLbQ9qBrXT97ZWztDEc5JIfjEJDRKNcj9SW+kA7tTlMg9l6DmRtmjjM5uoQueYU0nFGJjXG8B1IaNopYhXDBuOAQ7fLqylT8AiONc1aVwfUIYNAPAV/LuHwpTgw1oBGj1u7gXy5bQcRII48T2neJ/yWOPQCenDPEPSVj/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yzi0Uml1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yzi0Uml1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B271F00893;
	Fri, 11 Sep 2026 06:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789106424;
	bh=FNCveqZIi0FMQ2QV3D/aKhv09wwaP7IlMp+gG2SrKdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yzi0Uml1oKkL4iVMXPl+FPTm64v3S6V5cNhnHqutNYdEex/oJwkYQxKAOwP4TbQmz
	 pBv5Bi0oJLBnypsYS2oCn3rBbUqOe//sW7kCFv1NqwumJiNmUbmCYihUnev/ukYZHD
	 WLSAfnHI1YHKJRhqism2hkBPJBJE+cIcKtGRAs+lvamECyF7I+F8KNLVbFtPJrSwzh
	 9/j53i5YEtY4C9SXSMUq27AMhsq0FHSH138JdLNGhOcfJpkS03NQ7nY5VMoLFaIPb4
	 hh9S3LvN0XbJBV42C+eRyR7dVEg0863VA19frbNeT4FU7XtkE/uu7H7ptia4F1uRA/
	 x2aDEWEbrgNUQ==
Date: Fri, 11 Sep 2026 08:00:16 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 3/3] PCI: qcom: Implement shutdown() callback
Message-ID: <tvtjjnysk6cluqrwoseyssjpp6fla3qjvkndxbsw3wqqed6e34@74tuwpzgss7j>
References: <20260909-shutdown-v6-0-62b7bd123236@oss.qualcomm.com>
 <20260909-shutdown-v6-3-62b7bd123236@oss.qualcomm.com>
 <562fd574-a798-4b57-98fd-dc8e7c09f7f0@oss.qualcomm.com>
 <468f4ca4-e52e-48b3-bd60-20cadf7f311e@oss.qualcomm.com>
 <80f626f9-8a0d-49cb-a592-14195900e997@oss.qualcomm.com>
 <8293c4b5-948c-4859-b63e-835ec35ea90d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8293c4b5-948c-4859-b63e-835ec35ea90d@oss.qualcomm.com>

On Thu, Sep 10, 2026 at 08:56:38AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 9/9/2026 6:48 PM, Konrad Dybcio wrote:
> > On 9/9/26 2:40 PM, Krishna Chaitanya Chundru wrote:
> >>
> >> On 9/9/2026 6:06 PM, Konrad Dybcio wrote:
> >>> On 9/9/26 2:24 PM, Krishna Chaitanya Chundru wrote:
> >>>> From: Manivannan Sadhasivam <mani@kernel.org>
> >>>>
> >>>> PCIe host controllers should bring the link down cleanly before system
> >>>> shutdown/reboot proceeds to remove power/clocks from the controller.
> >>>> Without this, the link may still be up and endpoints still have
> >>>> transactions in flight when power/clocks are cut, which can trip SMMU
> >>>> translation faults or NoC protocol errors.
> >>>>
> >>>> Reuse dw_pcie_suspend_noirq() in the shutdown path to force the link
> >>>> into L2, putting it into D3cold.
> >>>>
> >>>> device_shutdown() runs with interrupts enabled, unlike suspend_noirq().
> >>>> Mask the chained MSI IRQ(s) and the Global IRQ before tearing down the
> >>>> link and clocks/PHY, since a late/spurious interrupt could otherwise
> >>>> reach a handler that touches now-unclocked PARF/DBI registers.
> >>>>
> >>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> >>>> ---
> >>> [...]
> >>>
> >>>> +static void qcom_pcie_shutdown(struct platform_device *pdev)
> >>>> +{
> >>>> +	const struct qcom_pcie_cfg *pcie_cfg = of_device_get_match_data(&pdev->dev);
> >>>> +	struct qcom_pcie *pcie;
> >>>> +	struct dw_pcie *pci;
> >>>> +
> >>>> +	if (pcie_cfg && pcie_cfg->firmware_managed) {
> >>>> +		/*
> >>>> +		 * Firmware owns the link teardown and clock/PHY shutdown in
> >>>> +		 * this mode; Linux only owns the chained MSI IRQ(s), which
> >>>> +		 * still need to be masked off before shutdown proceeds.
> >>>> +		 */
> >>>> +		pci = platform_get_drvdata(pdev);
> >>>> +	} else {
> >>>> +		pcie = platform_get_drvdata(pdev);
> >>> This is no less than an intriguing choice.. please store the same
> >>> element in both cases so we don't have to do this
> >> for firmware_managed solutions struct qcom_pcie *pcie is not being
> >> used/allocated at all. it will waste of memory if we allocate memory for just
> >> this use case. - Krishna Chaitanya.
> > Should we move it to a separate file/driver then, perhaps?
> > We could share the ECAM ops in e.g. pcie-qcom-common.c
> I will let Mani to comment on this.
> 

pcie-qcom-common.c is only for sharing common code between RC and EP controller
drivers. So it doesn't make sense to move ECAM ops which is just RC specific to
the common driver.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
