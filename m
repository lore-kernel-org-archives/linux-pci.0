Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E35E3CAE8F;
	Fri,  2 Oct 2026 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982210; cv=none; b=Zfkk9CfBKmwLNkjc0wfDYDLwfdIXA15dQWRFnfBwtYMTV8uRWHZa2VA5nHcbKJbCe8BHXZUJga3Hy0K2Hclh/9PyZq94pyECuGBWgMrwJ2upuZ9Z8rTWSTuFgGxsNjkGLfzK5PdEJpN0b7HEqkCvhJ4h3AapE3k0emy4caGL5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982210; c=relaxed/simple;
	bh=tkWvSOfumEV/X5/gizi21lDoOGcOq5p0tOMkQFiL9aM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ImfkTXe3pldxGAz9brLWRSJPu/B0POmuwYCFYpGYEgFCMR6+fMttAn+4OWtv9jEgeLJCNJlF/0oWpnRBcRPTULGnq3LqSRIUInNHojjMRntsnirk/QCjxklY1khyHd6clkR6U/SXIAFZooKRVV/+enUBEY9a9lR5VPloAuWkdrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8L6jpPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8L6jpPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39F81F000FF;
	Fri,  2 Oct 2026 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790982209;
	bh=GlKl0n4h+SRDG0bZhe9Pdd1zeVrtxnOk7XdqNbUxb6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Q8L6jpPQtXLZ8K5NCaIVrl3IqINLwbM2biCNWgxQC1oKxpsIkYe/8+ljxDi4v3B8H
	 2Nxy6Ykb0VT/Qw1rhBm40hckJVPuYTmuUpA4N2o7jry+AQuT9Cb37PoGu923Es7Rz5
	 2KC9HeSTx1kxqJPb16RSJ+X6gH2EKTAwfMwQDo3JMRO/tWoeD9U1K+v8rOQSH4eaOs
	 jhdQ5SgrtVAkBVVqgCvBUHm4qzL5IK5iZaOOaIou0ajV7tYig1U7RpP3lSFIT2eyoz
	 4PeFBUEaRG3ufaOmNXysCViOy87h+8KScfVQE7Kppjeg9qzH94sGNurkA8Q8cWXSVL
	 W8KjOPGPfjEDQ==
Date: Fri, 2 Oct 2026 18:03:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Disable ASPM L0s for SA8775P
Message-ID: <20261002230327.GA381812@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419093934.1223027-1-shengchao.guo@oss.qualcomm.com>

On Sun, Apr 19, 2026 at 05:39:34PM +0800, Shawn Guo wrote:
> Commit f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port
> if iMSI-RX is used as MSI controller") removed MSI/MSI-X capabilities
> from the Root Port on platforms using iMSI-RX (including SA8775P, which
> has no msi-parent/msi-map in DT).  This causes PME and AER service
> drivers to fall back from MSI to INTx.
> 
> With INTx-based PME active, the QCN9100 modem endpoint sends PME messages
> during D-state transitions early in boot.  The level-triggered INTx
> assertion coincides with ASPM L0s exit sequencing on SA8775P hardware,
> causing Data Link Layer Replay Timer Timeout errors on both sides of the
> link.
> 
> [   13.069528] pcieport 0000:00:00.0: PME: Signaling with IRQ 332
> [   13.082436] pcieport 0000:00:00.0: AER: enabled with IRQ 332
> [   13.082447] pcieport 0000:00:00.0: AER: Correctable error message received from 0000:01:00.0
> [   13.101347] pci 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
> [   13.111281] pci 0000:01:00.0:   device [17cb:1103] error status/mask=00001000/0000e000
> [   13.111284] pci 0000:01:00.0:    [12] Timeout
> [   13.111313] pcieport 0000:00:00.0: AER: Multiple Correctable error message received from 0000:01:00.0
> [   13.130512] pcieport 0000:00:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Transmitter ID)
> [   13.130514] pcieport 0000:00:00.0:   device [17cb:0115] error status/mask=00001000/0000e000
> [   13.130516] pcieport 0000:00:00.0:    [12] Timeout
> 
> Fix the PCIe regression on SA8775P/Lemans platform by adding no_l0s = true
> to cfg_1_34_0 for SA8775P, so that PCI_EXP_LNKCAP_ASPM_L0S is cleared from
> the Root Port and ASPM L0s is prevented from being negotiated.
> 
> Fixes: f5cd8a929c82 ("PCI: dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI controller")
> Assisted-by: Claude:claude-4-6-sonnet
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index af6bf5cce65b..6a14b5091338 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1473,6 +1473,7 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
>  static const struct qcom_pcie_cfg cfg_1_34_0 = {
>  	.ops = &ops_1_9_0,
>  	.override_no_snoop = true,
> +	.no_l0s = true,

Internal sashiko review suggests that possibly a similar fix should be
applied to pcie-qcom-ep, since this chip can also be operated in
endpoint mode.

Just a heads-up; you can evaluate and decide.

>  };
>  
>  static const struct qcom_pcie_cfg cfg_2_1_0 = {
> -- 
> 2.43.0
> 
