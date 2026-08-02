Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D017B20A5C4;
	Sun,  2 Aug 2026 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785643073; cv=none; b=ITWLVAlQhPja9FNp/hpka5jinIof3emJN8HXo8kiZOVLsZq0fZUnViFaoB4Zj3RaU9QTMHXKv5TFoNblzfD4+OaYqkN8NqRE3kYcnXjiFj97SN8yy7gljT55Rd+F3+u7I0cw5zd87Pp+9y1ksBkjz2vqELak8aqjuMlZfagMK+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785643073; c=relaxed/simple;
	bh=q1pARS5jbKSDrkB9t9HhaunyyBy2cboPHge2yfedUCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IU7WUvcwlEa0ZrkXpX9R+asfAo+SIEXu+m9CIPEAb6PHu5EbWjgfaGeEicNsP2cGHZUmHsAxRvS+3Stpmf4vlTIsP8gdBMZmZGyagMw3nc11pkYuPMh17JYfa+/C9HXxy5d3eJCKQHLYru2lhg+pWxspw7FRrr9dZGf5qoyb9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8Ejf1aw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8Ejf1aw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F8B1F00AC4;
	Sun,  2 Aug 2026 03:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785643070;
	bh=Z6jKwCBwUouAbos6vdXsbSCPkFo09fH0Ecr1wnrqOmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l8Ejf1awpBz1WS/OwPhGlOaBtCDS4hVpNvzM122iNNItoDE7jO1iW3zQ+GwBrB7zV
	 SO6vrglalI0lTZeDoj9aqsHaVSKxrpzFUvQ/UxL1OSUbsyDenF8IoQCPpnMY8GiYw8
	 JMj2INBsLjjxuNurkdkje9fvCgsV2FgU3qu9UmqgW7DLCByJ9Dzg4DyACw/YzdC/a9
	 o/AuvT+WMQgEPj6ozmgTNkqsWih60atiVvgB7GuuS2/EvAMODbPFmguzLOwghrTYrR
	 x/sVY4NxZ06uSPLhspdSPrjUrGD7ne23kVGi0Tw2LtoGI0aXkC+p4cvMcPtoPvwe0s
	 Lx+vQTNDy0i9w==
Date: Sat, 1 Aug 2026 22:57:47 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: Re: [PATCH v7 0/3] arm64: dts: qcom: eliza-evk: Enable PCIe0 and
 PCIe1 with M.2 and TC9563 switch
Message-ID: <am6_-E6qSKY1C1dN@baldur>
References: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730-eliza_evk-v7-0-7ac7b66a3e6d@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 05:30:15PM +0530, Krishna Chaitanya Chundru wrote:
> This series enables PCIe for the Eliza EVK board (CQS SoM on EVK carrier).
> 
> The Eliza EVK exposes two PCIe ports:
> 
> - PCIe0 drives an M.2 E key connector. The 3.3V supply is GPIO-controlled
>   via a TCA9538 I/O expander on I2C4. The slot hosts a WLAN module
>   (connected over PCIe) and a Bluetooth device (connected over UART5),
>   modelled with the pcie-m2-e-connector binding.
> 
> - PCIe1 (8GT/s x2) connects to a Toshiba TC9563 PCIe switch, whose
>   management interface sits on I2C4 (address 0x77). The TC9563 RESX# and
>   PERST# lines are OR-ed internally; reset is driven via a TLMM GPIO on
>   the RESX# pin. The iommu-map covers all downstream switch ports
>   (SID range 0x1400-0x1408).
> 
> The M.2 WLAN module carries a Qualcomm QCC2072 Bluetooth chip. A device-ID
> entry is added to the M.2 power sequencer so the serdev node for the BT
> UART interface is created on PCI enumeration.
> 
> This seris Depends-on:
>   https://lore.kernel.org/all/20260630-eliza-dts-qcs-evk-v4-3-18cbbdba6e7e@oss.qualcomm.com/
>   https://lore.kernel.org/all/20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com/

As far as I can tell these where merged 3 weeks ago, please help me
understand what dependencies we're missing.

Regards,
Bjorn

> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v7:
> - Change the pcie sub nodes under dsp3 from pci to ethernet (Sashiko).
> - Update the iommu-map to 2 cells from 1 cell (Mani).
> - Link to v6: https://patch.msgid.link/20260730-eliza_evk-v6-0-40ece2d33114@oss.qualcomm.com
> 
> Changes in v6:
> - change 0 to 0x0 & remove num-lanes property (Mani)
> - Link to v5: https://patch.msgid.link/20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com
> 
> Changes in v5:
> - change from pci to pcie for subnode names (konrad)
> - Link to v4: https://patch.msgid.link/20260728-eliza_evk-v4-0-decc7fe5246e@oss.qualcomm.com
> 
> Changes in v4:
> - Added new line and used pcie port names as pcieN_portM (Konrad).
> - Link to v3: https://patch.msgid.link/20260721-eliza_evk-v3-0-92b10038f13d@oss.qualcomm.com
> 
> Changes in v3:
> - Clubbed pcie nodes to this series (Bjorn A)
>   (https://lore.kernel.org/all/20260708-eliza_dt-v2-1-e6281da26408@oss.qualcomm.com/)
> - Added comment for PERST (Mani).
> - Extended ranges property for pcie1 (Konrad).
> - Link to v2: https://patch.msgid.link/20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com
> 
> Changes in v2:
> - Drop patch 3, as this is already applied
> - Rebase on top of https://lore.kernel.org/all/20260708055017.A90C91F000E9@smtp.kernel.org/
>   and remove pincntrl as pincntrl is added in the eliza.dtsi patch and also remove
>   pinctrl for resx as this is covered in pcie1_default_state as perst gpio.
> - Link to v1: https://patch.msgid.link/20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (3):
>       arm64: dts: qcom: eliza: Add PCIe PHY and controller nodes
>       arm64: dts: qcom: eliza-evk: Add PCIe0 with M.2 E key connector
>       arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563 PCIe switch
> 
>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 221 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/eliza.dtsi     | 413 +++++++++++++++++++++++++++++++-
>  2 files changed, 632 insertions(+), 2 deletions(-)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260629-eliza_evk-6f30686b161f
> prerequisite-patch-id: 9e10dfbe360941cdac0300aaf163149755952f9f
> prerequisite-patch-id: fecce0170351baf00cbe8f6b302d1def4d99bbfc
> prerequisite-patch-id: 97cd6cb495fdd198f6de7fbe45ef32e4a638ec9c
> prerequisite-message-id: <20260630-dts-qcom-eliza-mtp-evk-add-pmics-v1-1-f4f320f7c88b@oss.qualcomm.com>
> prerequisite-patch-id: f3615b5c1e2222a2491f862a7fba3994058ecc53
> 
> Best regards,
> --  
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
