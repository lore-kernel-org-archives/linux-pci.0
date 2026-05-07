Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD230F535;
	Thu,  7 May 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154957; cv=none; b=PvImNycthW1KNYsBucryU3uJiSg1q6foUi8WlxPbi8RjcsPdkZoa4mcOvpvv2qhOI5ZSRzi1w0uUVNdtyofUNHVM+VolfippAHJYkJRO4f0b0NcRVrTN0+MyOp0BOPSpZ1Q0QxxdXYT4D9wOTQJ2KSNJZaL/o3e/QhLKICy6T50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154957; c=relaxed/simple;
	bh=YDXczwc/IWPhalqlWlFpa2CJ/z0NSpD0assHYzKCyWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU1a93UWuxgqkWvs1j8j+uy8fxODYLTVmPhynVUJj3uSVRDRJjFzGCKNv2Kjrxq7GN6pLuax1iy7Zox3JonQFLzCO7H/QNHzoX6NbxPlvyomPRvCl7q01UYhM5TMk/poZzz5npusdxPIjUifsBBFhBX9RbazA/BN19GspS9RRAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbWLF5YR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbWLF5YR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA99C2BCB8;
	Thu,  7 May 2026 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778154957;
	bh=YDXczwc/IWPhalqlWlFpa2CJ/z0NSpD0assHYzKCyWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbWLF5YR1dqs5ZCyWfRaA26iiUEiANJ8QdYaY9R/RFS5fSg8HgxxFA76o88d5MgCn
	 QUVsqwwjxeojpmMH/g7xO6YOXzLLtKKWnl8QVaPXIFv6X7oPQghNuoXgbEjmpGH8QO
	 zBnuuWQ1gjSPjf4aRsbbV1FcGHWI46BJfIDFhwbuFH6gO0cR7NMFw2yR7K2UMREant
	 Fb0vTnzqTI+Ijz+O66M99I262BHAmzpSy/EGXgAg628s7nCEzj0vScLjraRnydaWH3
	 Gk2qGSqcyqCcHdxZ+nYsxuNuNK6oLVsZPIkcAhwzDJgQwLEuAu4ESxaJRt2BvZ/gvF
	 0NSVGP7KBOYMA==
Date: Thu, 7 May 2026 17:25:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Wei Deng <wei.deng@oss.qualcomm.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Shuai Zhang <quic_shuaz@quicinc.com>
Subject: Re: [PATCH 01/12] power: sequencing: Introduce an API to check
 whether the pwrseq is fixed or controllable
Message-ID: <77mdzohpwzvzivuipzt34hjetnuuxznqsyomncipdwo3ne374f@msayj6kdqwru>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
 <CAMRc=MfCprFY4QCwEJzbBnROGJzrRE-sRAD89xDxsUsJVfqOiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfCprFY4QCwEJzbBnROGJzrRE-sRAD89xDxsUsJVfqOiQ@mail.gmail.com>

On Thu, Apr 23, 2026 at 12:24:02PM -0400, Bartosz Golaszewski wrote:
> On Wed, 22 Apr 2026 13:24:42 +0200, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> >
> > Introduce an API pwrseq_is_fixed() so that the consumers can check whether
> > the given power sequencer is fixed or controllable. This will come handy
> > in situations where the consumers need to know whether the specific power
> > sequencer like 'Bluetooth' can be controllable using properties like BT_EN.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >
> 
> I have several concerns about this new function: its name is very vague and
> doesn't really indicate its function (how is it "fixed" if you still control
> it?), it can be used to expose all kinds of things because of this lack of
> precision. I feel like it goes against the goal of pwrseq which is to abstract
> these things away from consumers.
> 
> The problem we have here is for now a HW quirk affecting a single driver. I'm
> thinking that we can live with this driver just checking the relevant property
> of the provider device.
> 
> Many subsystems provide functions that allow accessing the struct device
> associated with the provider. Could we introduce something like:
> 
> struct device *pwrseq_to_device(struct pwrseq_desc);
> 
> that would return the address of struct device associated with the provider of
> the descriptor? It wouldn't even have to return a new reference as holding a
> descriptor already implies also holding a reference to the pwrseq device
> backing it.
> 
> Then in the bluetooth driver you could do:
> 
> 	struct pwrseq_desc *pwrseq = pwrseq_get(dev, "bluetooth");
> 	struct device *dev = pwrseq_to_device(pwrseq);
> 
> 	// Big fat comment stating why you do this
> 	if (!device_property_present(dev, "enable-gpios")) {
> 		// do whatever quirk is required
> 	}
> 
> Would that make sense?
> 

Yeah, sounds good to me. I'll incorporate this in v2, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
