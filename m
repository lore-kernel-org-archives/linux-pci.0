Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688149A3D8;
	Mon, 12 Oct 2026 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818996; cv=none; b=MH1bE15POLsC8xKm53A28Nqcyhj2PoBJAwMB6hr63gHSZ9YT2JnNUb0O3Q6yQw/0bUiabAjo8FwxnPoXeH571PkCRFwqJmxMFt25hixGcEBm0YBEB/wON6ugt+hMYN0AfCJAU1sHCOmEo/PhxWNSadTEzwxUaOqmctdcK5CIGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818996; c=relaxed/simple;
	bh=0l2CDdgfCczICn074vu7xLpOmJtO/6AWxdrFKmbQs1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKuJ2Z3BRZ3dbHJGBszrDWLZ+1kEqKwbHGPL67xffdwA9ePgODw8ixBnMxsxmyj//YxkCRUXJfQaaWH5iPrM8cRdqk47IrOFyYnYzn8+K+WWu2QN6WiWimvo107K3HTrTPZEdO2xrRgwV/iaM9yifCWA2zHlXHXqOY71T5dNYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0HbSVms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0HbSVms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC781F0089C;
	Mon, 12 Oct 2026 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818995;
	bh=QGxvx/QLjnMgsM111662/b6rObFKZJ15uWxYClEgMlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A0HbSVmsS8vh1ArDa0XSbplLZ3Ud2mOasHZSp4FvYB8guvesdMTxXJ3G+VTQ4CRmn
	 csQDD2a+LcLiYC8xLdYgiQKQIiDVEJIAnlTF3ZoVlhzEJ0ygoTXW0y0GEwF3+QUYF5
	 +LodW0DR834sLv56x6LHoyGvkONDrbHLHvAkI/NEexGVjdELaE12xsYqixROTwPswV
	 bDHUAXZKMzQeQsjjsvBmifcLGZ7y2CyX4qoPd2dTp57IrtPAimPNaYOypf70xdPr2i
	 /bgGSMrKn46Nmt5y6t+Xaq94HHDqHez82u94z/5o1jDhubMI0K+CgBX3aNIjUMo4oa
	 gckCrWkKwLxPQ==
Date: Mon, 12 Oct 2026 20:59:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/4] PCI: qcom-ep: Move PHY init and drive PHY reset to
 align with HPG
Message-ID: <asz8xQuxSiIgFCm1@debian>
References: <20260915-align_pcie_init_sequence_0916-v1-0-0b2195836f30@oss.qualcomm.com>
 <20260915-align_pcie_init_sequence_0916-v1-2-0b2195836f30@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915-align_pcie_init_sequence_0916-v1-2-0b2195836f30@oss.qualcomm.com>

On Tue, Sep 15, 2026 at 11:04:22PM -0700, Qiang Yu wrote:
> HPG requires the GDSC to be powered up and all PHY/controller clocks
> enabled before the controller's core reset and the PHY's reset are toggled
> together as one atomic group, with PARF_DEVICE_TYPE set right after that
> reset group, same as the RC-mode change.
> 
> Move phy_init() ahead of the controller's own clock enable, and fold
> phy_reset() into the core reset assert/deassert. phy_power_on() keeps
> running afterwards. Also move the PARF_DEVICE_TYPE write out of
> qcom_pcie_perst_deassert() to right after the reset group, in
> qcom_pcie_enable_resources().
> 

Sashiko pointed out that PARF_DEVICE_TYPE change is not present in this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
