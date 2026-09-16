Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943C53B616;
	Wed, 16 Sep 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575886; cv=none; b=M7aI9OMIh54olX5cLySNfBVoErBO3402G7zr0Uygr8XtFglHVQO4wNaF4dCsOIogSTYmutbe6J3G7258ev1DJ+UVo4jIoj4mDtAQC7G8XDbWgbeHDk/p5niVHeomxcvSqp8PBCp9QGBjKOrZlL0Lyg+6y3X5WPSmRkL5cPNHNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575886; c=relaxed/simple;
	bh=QZHNuqxIvhsUnyu9LbQYA0gPFKo1+OvrlGiLvaKpVMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oE2BLwbJfA7598IQlHe6YE1UrpGdQKH/Phet+E2nIfSLfBN1KPnnniIksqeZDphUMH1V4+PiebYFQXurGHnZgGFbwVOa2SfszKCSbGGR7FAstZt2k6jZkCeEPaIyGwmw3FjxJo4Z5MSmFCipgjF4EydZSWDT4WX0kRPK0eNqN7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8u+go8e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8u+go8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CE71F00893;
	Wed, 16 Sep 2026 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789575879;
	bh=4SqfaW2RsFhUF5ui6S2RqYVP16Ly/WudXK02+qJqhYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i8u+go8eWK0y7yEetWbu7j+4MgbynCDSOZf1O/SWb5i4KMa0jYZXLlXnZ7sUqSedl
	 VFMDioy0d1kE3lXQHqQPdVA4gb4OUP3JcDXfKsHUAnygltqFZN6YqKyi/G1YnWlkXb
	 E/w7icaJFOhJkmsQcqD7+K9D+/3ikWnOt/k//ASfOSGRNBLwh/fKqkdynJoLCP4WWy
	 S8Y/hhzJUknVpsuDemlSH7ftRUgOheITfsESYkFtBfQNz4AidqlUdggnf9ITaUCdm6
	 u73W9bIlfarrMtG9FmN9Xb+Np/I4APIuzhBJxkHOvx+FX2lMbcFLlfos8wcl3CHbik
	 ug2XWLfvMYdYA==
Date: Wed, 16 Sep 2026 18:24:34 +0200
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
Message-ID: <aqrCwl--CqjPANA2@ryzen>
References: <20260916-topic-pcie_portrec_enodev-v1-1-5dc7bde39552@oss.qualcomm.com>
 <aqq7j9L76coy65lC@ryzen>
 <a4436f33-db21-489b-80b2-bf4793925cb5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4436f33-db21-489b-80b2-bf4793925cb5@oss.qualcomm.com>

On Wed, Sep 16, 2026 at 06:13:29PM +0200, Konrad Dybcio wrote:
> On 9/16/26 5:53 PM, Niklas Cassel wrote:
> > Hello Konrad,
> > 
> > On Wed, Sep 16, 2026 at 02:37:49PM +0200, Konrad Dybcio wrote:
> >> Root Port recovery may race with a device hot-unplug. In that case,
> >> dw_pcie_wait_for_link() returns -ENODEV because no device is detected
> >> after the controller has been successfully reset.
> >>
> >> This is a valid outcome and should not cause Root Port recovery to
> >> fail. Ignore -ENODEV while continuing to propagate other link-training
> >> errors.
> >>
> >> Assisted-by: LLM
> >> Fixes: 4d88cb82a6d9 ("PCI: qcom: Implement .reset_root_port() and use for link down")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-qcom.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index ee63a6ec99de4d07c16b8d6cb68df0d92f822cd8..3d3be9bf798b7c247d69969d6570385b8648123f 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -1880,6 +1880,9 @@ static int qcom_pcie_reset_root_port(struct pci_host_bridge *bridge,
> >>  	qcom_pcie_start_link(pci);
> >>  
> >>  	ret = dw_pcie_wait_for_link(pci);
> >> +	/* This linkdown might have been a hot-unplug */
> >> +	if (ret == -ENODEV)
> >> +		ret = 0;
> >>  	if (ret)
> >>  		return ret;
> > 
> > 
> > I did not know that pcie-qcom supported hotplug.
> > 
> > Last when I was discussing this with Mani, I'm quite sure that he said that
> > it doesn't, see:
> > https://lore.kernel.org/all/20251222064207.3246632-8-cassel@kernel.org/
> 
> I don't know if native ports still don't, but the ones used for USB4
> tunneling certainly do
> 
> see e.g.:
> 65ccb2203ef8 ("PCI: qcom: Clear Attention Button Present in Slot Capabilities")

Ok, nice to see :)


Kind regards,
Niklas
