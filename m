Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7934EF0F;
	Mon, 22 Jun 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143434; cv=none; b=ixOvwi6Yo9wQvWQFb5JwccnnkHkZseEfdYAZy0YmcUGnXYVVUrFQvPlNvvxMVjFsdyJLl0NHYalcvYZFrFxR1XO9SBbhVwOEHoRuNXKdCgYH2m43qM1CqEmcyluWvNYDcNTreIkZ56k5lsXJcy/DYHxMayTG1xC0Yz0F/jfaS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143434; c=relaxed/simple;
	bh=QATy3wWZAgeQlkKPoBXy/75b57BmhnwccBCP5LZxeyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQVvg+0HGvQY8hVvENHQwSCpuUdmNO3xNfJBSGPOq1tXZv0Pjh6oVLkW4JCnombVfS68ctPASLOUAizO72nDX94F2QOIb7pa0EumLmdemPGIdjwyezQm8zhryXSFEnEs8xkIwNha5ZnfYra+S6+VZ7ZE90wGtyIZ5i6x4iXVksM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuvARrXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuvARrXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A82F1F000E9;
	Mon, 22 Jun 2026 15:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782143433;
	bh=HKMXIB/q1rC45uurP0dyb6nvOhoZiIepNCfGubawWOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EuvARrXTy1veUwn8k5vNeuaCwvEZygZhUvDa6udCl9fT9gUBnfrhoW5e27cQjq+ZC
	 ZhcYyw5of7yNyXkWhmq3Clcl3+H7bU/fvzCR2HUx5ZePFokayKokPJyPvhlw5mQzUk
	 v8ndoGcdKf51wNNQZ9Krfs+rShBU3u47NuJCvSxeAmGG+vOc6G1vJOcd5aVX4ylMM2
	 5cGAJ2x7hkcucv5x+ISOZv2G9b0e3f6OugNcIGbDlhj5eiGD+/4CBoMSjrRrvep7L/
	 +kuDXS5liUqRKfkCldVA9WoZDsJXE/gJCOwwYO/ikVXuUNgCiOO2c479stu6Yd/81k
	 EcBBdVl5xVzSw==
Date: Mon, 22 Jun 2026 17:50:27 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Wentao Liang <vulab@iscas.ac.cn>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: fix refcount leak in qcom_pcie_ep_probe()
Message-ID: <beejsw4p3wkf3zvarqxnaknzoyreddhcp7sgt32pb23xlhhvtg@2dghsaqvitqa>
References: <20260609100747.230521-1-vulab@iscas.ac.cn>
 <20260609101554.36D4B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260609101554.36D4B1F00893@smtp.kernel.org>

On Tue, Jun 09, 2026 at 10:15:53AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Calling `pm_runtime_disable()` manually in the error path after using `devm_pm_runtime_enable()` causes a double-disable, permanently breaking runtime PM.
> - [High] The error path for a failed `pm_runtime_put_sync()` falls through to `err_rpm_put`, leading to a double decrement of the runtime PM usage_count.
> 
> Pre-existing issues:
> - [High] Failing the entire probe function if `pm_runtime_put_sync()` returns an error is incorrect and brittle.
> --
> 
> commit 2adeb10c2dada5b5e65aed93fd2d269f6cd5a790
> Author: Wentao Liang <vulab@iscas.ac.cn>
> 
> PCI: qcom-ep: fix refcount leak in qcom_pcie_ep_probe()
> 
> This commit attempts to fix a runtime PM reference leak in the error paths
> of qcom_pcie_ep_probe() by introducing a new error label. The new label
> calls pm_runtime_put_noidle() and pm_runtime_disable() to properly release
> the reference before returning the error.
> 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 257c2bcb5f76f..c01d4d3b49520 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> [ ... ]
> > @@ -932,6 +932,10 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
> >  err_ep_deinit:
> >  	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
> >  
> > +err_rpm_put:
> > +	pm_runtime_put_noidle(dev);
> > +	pm_runtime_disable(dev);
> 
> [Severity: High]
> Does calling pm_runtime_disable() here in qcom_pcie_ep_probe() cause a
> double-disable of runtime PM?
> 
> Earlier in the probe function, the code uses devm_pm_runtime_enable(dev).
> This registers a devres cleanup action that will automatically call
> pm_runtime_disable() upon probe failure or device removal.
> 
> If we explicitly call pm_runtime_disable() here in the error path, it
> appears it will be executed twice (once explicitly, and once via the devres
> unwind). Because __pm_runtime_disable() unconditionally increments the
> device's disable_depth counter, could this leave the counter permanently
> elevated to 2 and break runtime PM for any subsequent probe attempts?
> 
> [Severity: High]
> Will this new error label result in a double decrement of the usage_count
> if the probe fails during pm_runtime_put_sync()?
> 
> Later in qcom_pcie_ep_probe(), if pm_runtime_put_sync() fails, the
> function jumps to err_disable_irqs:
> 
>     ret = pm_runtime_put_sync(dev);
>     if (ret < 0) {
>         dev_err(dev, "Failed to suspend device: %d\n", ret);
>         goto err_disable_irqs;
>     }
> 
> The err_disable_irqs path then falls through to this new err_rpm_put label.
> Because pm_runtime_put_sync() maps to __pm_runtime_idle() with the
> RPM_GET_PUT flag, the usage_count is decremented first before the idle
> check even begins.
> 

Both of these issues are perfectly valid and is an indicator that the error path
change proposed by this patch is not correct.

- Mani

> If it returns an error like -EAGAIN, the usage_count has already been
> successfully dropped. Falling through to call pm_runtime_put_noidle()
> again will attempt to drop the usage_count a second time. Could this
> wrongfully steal a concurrent thread's reference and lead to an eventual
> counter underflow?
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it correct to treat a
> negative return from pm_runtime_put_sync() as a fatal probe failure?
> 
> Looking at the same code block referenced above in qcom_pcie_ep_probe(),
> a return value like -EAGAIN simply means the device cannot be synchronously
> suspended at this exact moment (for example, if another thread concurrently
> incremented the usage counter).
> 
> Since this is a valid runtime PM state and not a hardware or initialization
> failure, does tearing down the fully working device and failing the probe
> cause spurious device initialization failures?
> 
> > +
> >  	return ret;
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260609100747.230521-1-vulab@iscas.ac.cn?part=1
> 

-- 
மணிவண்ணன் சதாசிவம்
