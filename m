Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB5F346FA0;
	Wed, 21 Jan 2026 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986797; cv=none; b=BF8vqXVfSkp0GOJejOorlo+nU7eZq5pBb9SNcfowoqzvkNwuP2juuZIlcgi6SeQpDVVIHiD/fA+/q0KuEsnSy0p9QE0dfzF+Hs3oVSM0KD64kBbh+sD6DyzpyogoUVHrgSVkuPL6Tax6Zr3Ov5gMaKqAlTq2EYNeFSs8PNF7jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986797; c=relaxed/simple;
	bh=V7hAMM+aRiYM4Md6WRZjQ7ajcU5VIwA5crlDJxNSaH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLP0wyD/L10/RTpk0joffW/DPvlVTQwVu90snKvzadM3sACb7FuBtT4P3BOBbG+Y9TeVo7+r5k8WDNiyNSu8nP11IIojpVERnnq7OAq9/CMpbBR3sCg1+Tprk6qYiLOI+ah7TrzcTQe37L9AW6PJWPISB9NgdNB5fgP5t8qIjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD61C116D0;
	Wed, 21 Jan 2026 09:13:07 +0000 (UTC)
Date: Wed, 21 Jan 2026 14:43:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com, 
	Shawn Lin <shawn.lin@rock-chips.com>, Richard Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v4 2/5] PCI: dwc: Return -EIO from
 dw_pcie_wait_for_link() if device is not active
Message-ID: <wswb6we7iyp3co5u7wcntqogtqmqitbmty5ihqnweno7efdpoh@gekgtcp262zw>
References: <20260120-pci-dwc-suspend-rework-v4-0-2f32d5082549@oss.qualcomm.com>
 <20260120-pci-dwc-suspend-rework-v4-2-2f32d5082549@oss.qualcomm.com>
 <aXCM-ky9PFTKZTcZ@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXCM-ky9PFTKZTcZ@ryzen>

On Wed, Jan 21, 2026 at 09:23:22AM +0100, Niklas Cassel wrote:
> On Tue, Jan 20, 2026 at 11:17:41PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > There are cases where the PCIe device would be physically connected to the
> > bus, but the device firmware might not be active. So the LTSSM will
> > get stuck in POLL.{Active/Compliance} states.
> > 
> > This behavior is common with endpoint devices controlled by the PCI
> > Endpoint framework, where the device will wait for the user to start its
> > operation through configfs.
> > 
> > For those cases, print the relevant log and return -EIO to indicate that
> > the device is present, but not active. This will allow the callers to skip
> > the failure as the device might become active in the future.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 55c1c60f7f8f..aca5bbeade03 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -696,8 +696,9 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
> >   * dw_pcie_wait_for_link - Wait for the PCIe link to be up
> >   * @pci: DWC instance
> >   *
> > - * Returns: 0 if link is up, -ENODEV if device is not found, -ETIMEDOUT if the
> > - * link fails to come up for other reasons.
> > + * Returns: 0 if link is up, -ENODEV if device is not found, -EIO if the device
> > + * is found but not active and -ETIMEDOUT if the link fails to come up for other
> > + * reasons.
> >   */
> >  int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  {
> > @@ -722,6 +723,16 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
> >  		    ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
> >  			dev_info(pci->dev, "Device not found\n");
> >  			return -ENODEV;
> > +
> > +		/*
> > +		 * If the link is in POLL.{Active/Compliance} state, then the
> > +		 * device is found to be connected to the bus, but it is not
> > +		 * active i.e., the device firmware might not yet initialized.
> > +		 */
> > +		} else if (ltssm == DW_PCIE_LTSSM_POLL_ACTIVE ||
> > +			   ltssm == DW_PCIE_LTSSM_POLL_COMPLIANCE) {
> > +			dev_info(pci->dev, "Device found, but not active\n");
> > +			return -EIO;
> >  		}
> >  
> >  		dev_info(pci->dev, "Phy link never came up\n");
> 
> This should probably be squashed with the previous patch.
> 

No. I'd like to keep it as a separate patch because I think this deserves its
own justification.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
