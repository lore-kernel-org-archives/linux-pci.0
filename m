Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65532E733;
	Fri, 30 Jan 2026 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769766823; cv=none; b=DxNybDGfOdopCju74VoEe61RcqSa6lqrqfT0dDBgR4s31fGxje8o45Qe7Q23czWzOGIC4KMt/TROdsNXZN3+b/fLAimBhjaqMRJiRGjwKvECYUaO/b/EDb8AIglvjyMvUrT82UkEW+bIX9/DKpGRRdm9pUfdDSBGYOWN//Mrb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769766823; c=relaxed/simple;
	bh=wPVjTXRGT85vRLu049PHiNNkwVAbd/ZvJO65bc22IDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttGap2458HY/CXvWduG/pCJyeuVum7Lt4DxrbON1TucvuJHmTfhiCPZyFB4wBdWoGXgXYKC/BaQMRK23ZRMcN82fx+P55tVAXpLsRI+8CKSMeJkI3Tmb0oUhqCEqAkUoHcyZ45T1c9Qnyv3ydGCS+g4bKMEG4GkbFWrpSG3oyg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdVId5Bv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdVId5Bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DABC4CEF7;
	Fri, 30 Jan 2026 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769766822;
	bh=wPVjTXRGT85vRLu049PHiNNkwVAbd/ZvJO65bc22IDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdVId5BvKdkvSPge+laz+c5afTAj+A8aFG2JfHuMEyN/elnywR2piTsQiPYBMer6x
	 KJTfHf0slyVZmUTaWu6oisPkUNHBA9IvFWUdO1cito2Asr44xjxzQPhU6cMuEY5Bfp
	 +FBrYrW7bWxrV+sj/Tha7VqHNXVYVBpk6/+630VyITqNOCrgErDv5H7GPfzetWIc3o
	 dqrj77IGZKqXYBQFRD9J+e4wFP78kszhu3iATXHob/6Ha/OLEdMbnTNzwIYpPUdYnd
	 juJGNvgEpUQJtnVWY9pBueMW245K79mTzrXzPh/DeT5put4i172bjiD6LEx8O2XNCV
	 dLhBX2VIz+CcA==
Date: Fri, 30 Jan 2026 10:53:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Aksh Garg <a-garg7@ti.com>
Cc: Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	Zhiqiang.Hou@nxp.com, gustavo.pimentel@synopsys.com,
	linux-kernel@vger.kernel.org, s-vadapalli@ti.com,
	danishanwar@ti.com
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
Message-ID: <aXx_oaBxCmAXAZQt@ryzen>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com>
 <aXtrW7viGZfMNZur@ryzen>
 <4c71700d-e4a5-496b-825e-01f346f73949@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c71700d-e4a5-496b-825e-01f346f73949@ti.com>

On Fri, Jan 30, 2026 at 09:42:43AM +0530, Aksh Garg wrote:
> On 29/01/26 19:44, Niklas Cassel wrote:
> > On Thu, Jan 29, 2026 at 02:47:52PM +0530, Aksh Garg wrote:
> > > -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> > > +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
> > >  {
> > > +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > >  	struct device *dev = pci->dev;
> > >  	unsigned int i, num;
> > > @@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
> > >  	u32 *indexes;
> > 
> > Hello Aksh,
> > 
> > Considering that all other functions that you have modified, you have added a:
> > 
> > if (!ep_func)
> > 	return;
> > 
> > 
> > I think you should do the same to this function.
> > 
> 
> I omitted this NULL check here because all the current call sites of
> dw_pcie_ep_clear_ib_maps() already perform this validation. I felt
> adding it here would add redundancy in the code.

Ok, but with that logic, shouldn't we also remove the NULL checks from
dw_pcie_ep_ib_atu_bar() and dw_pcie_ep_ib_atu_addr(), because they are
only called from dw_pcie_ep_set_bar(), which already has the ep_func
NULL check?


Kind regards,
Niklas
