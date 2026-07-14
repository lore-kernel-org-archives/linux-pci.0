Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7B47A0D8;
	Tue, 14 Jul 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037322; cv=none; b=rDfBdnjSbl/4SLTH6GNNQP3Dn7nv/jHEm9mo5hQ+ihZ6eG0FcC+eTUs4avXHXpp+yytTv9BlVGpj7ubm1xxLuT5XjTzN4oejHj/8ccZ+LLc9RmOd3IYRLIS8HdETHNnLwRY5AgK8apw+SNS4gPXDJ2bp/Bqc98x/fz7CxbJgyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037322; c=relaxed/simple;
	bh=cmc/aIuMjg9PV2KGS2UBuRJTHpKXuzpAISPFbH/wEv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5IqMnQBCmGUa4wCaJXV+CqSG3Y4KPrqXvRxZbgu+4pR4uZarr6MJKl1gDywGohvXPajZSknPqYLlxZ6X38IB5KLia9BTgA6aqPyySgDxRWtnpKWjZtnd5/tDsx377CUE13zsfX/nrtZkzPwzRi71mRyF5uFG7GrrkNM/4KkH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkJkt2q7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkJkt2q7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35641F000E9;
	Tue, 14 Jul 2026 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037320;
	bh=K8IJldkTRt1FtCS6EIP1M86hblVqMCHFadZ/rYcCp+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BkJkt2q7S0wulWdSwiZKqTT5wLEy0JHO+mWFnc/rzCLfIuOpN1DOWYExJAaq8IfNV
	 Hnujq+T+5gSr3znYik66PQ6m/Jbm+jfcNj4sSlx38/WCOs2KQpgB/6rbKdg9gqtND7
	 GqdrvZ75bwi0TLKal/mHomTLtoV4dT+thdPIF4MIgiUj2I4x8VxLyABjTbh6glQKQe
	 E1uIaPEme1bVCkuteu/0P2RbQ+kciK+xDKx44K6SmlUaKYZyEdsYcKPZ4b1b2o7My6
	 qmN/H1CvsTRam9d+HYR1hv6bWJU1YkbFtkVqeqt2FuWg0oPNJb5knvrmyJE18zFwG2
	 guL5jmwAuIcWg==
Date: Tue, 14 Jul 2026 15:55:12 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/3] power: sequencing: pcie-m2: Match WCN6855 and
 WCN7851 UART BT variants by subdevice ID
Message-ID: <tctgytskrycxiybavlq4gb2gt2xe7hqegsu6g4pms3vl5k4g6z@bl5us2yyk7iz>
References: <20260709-fix-hamoa-m2-w-disable2-v1-0-5e725091266a@oss.qualcomm.com>
 <20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709-fix-hamoa-m2-w-disable2-v1-2-5e725091266a@oss.qualcomm.com>

On Thu, Jul 09, 2026 at 12:59:41PM +0530, Wei Deng wrote:
> The WCN6855 and WCN7851 combo chips are available in M.2 card variants
> that differ by their BT interface: some expose BT over UART while others
> expose BT over USB. Both variants use the same PCIe device ID for the
> WiFi interface, distinguished only by their sub-system device ID.
> 
> The bare PCI_DEVICE() entries match all sub-system IDs, so both UART and
> USB variants hit the same table entry and trigger UART serdev creation.
> For USB variants this is wrong — there is no UART BT interface on such
> a card, and the serdev probe will fail.
> 
> Narrow the matches to UART variants only by using PCI_DEVICE_SUB with
> their respective sub-system IDs. USB variants no longer match the table
> and will be handled separately to deassert W_DISABLE2# for USB BT
> enumeration.
> 
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
> index 83fe6a1396bc..cf51122d54fd 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -191,9 +191,11 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>  	  .driver_data = (kernel_ulong_t)"nxp,88w8987-bt" },
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x0108),
>  	  .driver_data = (kernel_ulong_t)"qcom,qca2066-bt" },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_FOXCONN, 0xe105),
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1103, PCI_VENDOR_ID_QCOM, 0x337e),
> +	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x1107, PCI_VENDOR_ID_QCOM, 0x337c),
>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
>  	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
