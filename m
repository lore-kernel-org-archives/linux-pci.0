Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF73641C30A;
	Wed, 13 May 2026 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676760; cv=none; b=Z+gFlerOl8T4c7IxnK6d+h6A9M4e0GFlfECD+S3W7tSZmog/GWIF3Mu5em5BW6ep1l4SBg7VSlj73yEIEo3mCg6jHKJiGJhcd3SBV0uldr/+lbrK7p+keTnoRoc5LQUiHDikz+mgrcr3QD0XEbDJn+EMtF8S7tj/jcQaQ0fzP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676760; c=relaxed/simple;
	bh=kLTK/bjgxEcA7FIN/QpTOpfPGhPJk2zZod3r8xLxVps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD08vFRHSO51hpYB2OjiyZHI8RhuNSzKnfoM6X8s2DqUaFNhbmj8NiFhYxvG4Bib4UZkWDzF3YLsWd5PjKY+Y7X5WaOxWmRMZ9eymjhl/7dxDShqy+/zrhSAsu2Mfh7pSGnIPFHlFyul8jKac2n/TEugl2peqNk9Gp/8aan4Vc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg5GAfJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg5GAfJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C1BC2BCB7;
	Wed, 13 May 2026 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778676759;
	bh=kLTK/bjgxEcA7FIN/QpTOpfPGhPJk2zZod3r8xLxVps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cg5GAfJh490o7/brWMxykaQ4QK8UP3NqybpVGK2l/AF1VRKYcSqjZW6RsBkqRK9mo
	 0sBcUrEiijyM/vKj7Aer/iPy6TbYBXzufkE41xqLlxXFGNJQEHV6vuSPSuxhA4FOpt
	 TuR38Kn2rmvG2HiL/w+yzEy654DFxyP73xba2m+syBvjiwUAqFxhtBDdvDrRHj6Kkx
	 wMXh4UXTqrZGoUcZCga91hueS2QXKq0QQEgkOgITsN2B9WguufzBBxtFccl2OAy5FS
	 8vI7F33N6m7b5V93SZmO/rikUmN5HWpp72N6RnjehYAW+32zVlMXhs6g22cFKnIi5v
	 S582DQTqffMPA==
Date: Wed, 13 May 2026 18:22:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mayank.rana@oss.qualcomm.com, quic_vbadigan@quicinc.com, Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 0/3] PCI: qcom: Program T_POWER_ON value for L1.2 exit
 timing
Message-ID: <sf23jm4by4uvqu7vrzc6gwnh2e7hhhdk5rthjsj6s2onm3cnyf@clb6k72o6g2k>
References: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428-t_power_on_fux-v5-0-f1ef926a91ff@oss.qualcomm.com>

On Tue, Apr 28, 2026 at 02:07:14PM +0530, Krishna Chaitanya Chundru wrote:
> The T_POWER_ON indicates the time (in μs) that a Port requires the port
> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
> asserted before actively driving the interface. This value is used by
> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
> 
> Currently, qcom root port exposes T_POWER_ON value of zero in the L1SS
> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations,
> which can result in improper L1.2 exit behavior and can trigger AER's.
> 
> In this series, qcom controller drivers read the devicetree property
> "t-power-on" which got merged recently[1], and use that value to over
> write default/wrong value.
> 
> To convert T_POWER_ON in to T_POWER_ON_SCALE & T_POWER_ON_VALUE created
> a pcie_encode_t_power_on() helper in aspm.c and also created
> dw_pcie_program_t_power_on() helper for other drivers to use these
> helpers.
> 
> Link [1]: https://lore.kernel.org/all/20260205093346.667898-1-krishna.chundru@oss.qualcomm.com/
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Series LGTM!

@Bjorn: Could you please ack patch 1 if you are OK with it?

- Mani

> ---
> Changes in v5:
> - Initialize *scale & *value to zero incase of ASPM is disabled pointed
>   by sashiko.
> - Use dwc readl & writel API's instead of direct readl & writel pointed
>   by sashiko
> - couple of nits (Mani).
> - Link to v4: https://lore.kernel.org/r/20260404-t_power_on_fux-v4-0-2891391177f4@oss.qualcomm.com
> 
> Changes in v4:
> - calculate maxv from PCI_L1SS_CTL2_T_PWR_ON_VALUE to PCI_L1SS_CAP_P_PWR_ON_VALUE (Mani).
> - added a todo to move the reading the devicetree from qcom driver to
>   dwc once multi root port parsing support is added (Mani).
> - Link to v3: https://lore.kernel.org/r/20260311-t_power_on_fux-v3-0-9b1f1d09c6f3@oss.qualcomm.com
> 
> Changes in v3:
> - move pcie_encode_t_power_on() include/linux/pci.h to
>   drivers/pci/pci.h (Bjorn).
> - couple of changes in commit text and variable name like t_power_on (Bjorn).
> - remove return 0 from qcom_pcie_configure_ports (Bjorn).
> - used FIELD_MODIFY instead of FIELD_PREP (Bjorn).
> - Link to v2: https://lore.kernel.org/r/20260223-t_power_on_fux-v2-0-20c921262709@oss.qualcomm.com
> 
> Changes in v2:
> - Instead of hard coding the values in the driver, created a devicetree
>   property "t-power-on" to program it (Bjorn & Mani).
> - Link to v1: https://lore.kernel.org/r/20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Jingoo Han <jingoohan1@gmail.com>
> To: Manivannan Sadhasivam <mani@kernel.org>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kwilczynski@kernel.org>
> To: Rob Herring <robh@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org
> 
> ---
> Krishna Chaitanya Chundru (3):
>       PCI/ASPM: Add helper to encode L1SS T_POWER_ON fields
>       PCI: dwc: Add helper to Program T_POWER_ON
>       PCI: qcom: Program T_POWER_ON
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |  1 +
>  drivers/pci/controller/dwc/pcie-qcom.c       | 14 ++++++++++
>  drivers/pci/pci.h                            |  6 +++++
>  drivers/pci/pcie/aspm.c                      | 40 ++++++++++++++++++++++++++++
>  5 files changed, 89 insertions(+)
> ---
> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
> change-id: 20251104-t_power_on_fux-70dc68377941
> 
> Best regards,
> --  
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 

-- 
மணிவண்ணன் சதாசிவம்
