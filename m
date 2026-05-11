Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCE1CD2C;
	Mon, 11 May 2026 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473544; cv=none; b=U03va5z+V+6ASpFMoWEL4Q5+I71QBEWxEG9fZ3IptcUpYobe7VcKFeBvvauVv8q1FxRkIg19vUJ4Eb1HutQ/zqmNVTIpW/gheU0HF/G7YQxQMRYDgM1OHtGvFoBqAFuh3x4ZUbEeqajYyvTNk5DOzc7mlN/gyOMKu/0CA8U8C9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473544; c=relaxed/simple;
	bh=rz5cDY4MNkFKlVez6VsZbm5d6GeZBlK0kvkHFRVzggk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVYEKYhCzvq7UFOMyrFNojQGfWjHWkZYoNEqDoKpIUV5mVBW0w3e8WaRXozOuUnCt4R6PEsBYeY23fvK+sSOjYkkj4I8fL7rReJ//dI3soq57H+xpyTQbQhQg+6KoBKFuFM0xgcV6thQ36X/z8FA42GdjgqjKkfIWWoJTW/RCJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTfwa1FG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTfwa1FG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E292C2BCB0;
	Mon, 11 May 2026 04:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778473543;
	bh=rz5cDY4MNkFKlVez6VsZbm5d6GeZBlK0kvkHFRVzggk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTfwa1FG+lMVBtjALeSfFUUec7s92aV0w2VM4s6kQ7e0FvpNf0AOHqyJUtm813hJ2
	 WX5Cfsx77bQegIVFY76d3BuV1G0n6Cm4VZt4XQwUMPG0PAzLKsU6Mvu2Fmjo5b9Bbp
	 LQrqzHhAvv4LpXR0wD0gs1+usHC1WVY0tAOl9qE68ixf9LNnEuvyCvuCV27DAhn1Ad
	 c4MEcvLEkaHiCxTWQqhAkvTD8ckNZin8Gg8cixba5rAwE3+0erNfm/zy5V5gW1h0mo
	 7dBtrU0Oji54s7R2Igxr7xDO+8OUaFLOsPq5BdthIuovnHhrn+VYStamB2fVRkTwqv
	 nqrsLD7ljGgUw==
Date: Mon, 11 May 2026 09:55:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, 
	helgaas@kernel.org, linux-kernel@vger.kernel.org, s-vadapalli@ti.com, 
	hans.zhang@cixtech.com, vigneshr@ti.com, danishanwar@ti.com
Subject: Re: [PATCH] MAINTAINERS: Add Aksh Garg as PCI CADENCE reviewer
Message-ID: <gizjfxvrl27kz5qb34mrnrlqzroemki5ifjpxztxlz64chsfie@ylfz5u6mvfbd>
References: <20260508060951.840233-1-a-garg7@ti.com>
 <12c2c868-a734-49f9-9938-77319b35da3d@163.com>
 <d0fb1c9b-4331-4f28-a95e-0962a2c9dd77@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0fb1c9b-4331-4f28-a95e-0962a2c9dd77@163.com>

On Fri, May 08, 2026 at 07:34:01PM +0800, Hans Zhang wrote:
> 
> 
> On 5/8/26 15:08, Hans Zhang wrote:
> > Hi Aksh,
> > 
> > Let's wait for one day, or two days, to see if Vignesh is willing to do it.
> > 
> > For drivers/pci/controller/cadence, currently Aksh and Siddharth hope to
> > become Reviewers. Manikandan believes that he can become a Maintainer. I
> > myself also hope to apply for the role of maintainer. Then let's review
> > the common driver related to Cadence PCIe IP, as well as the driver of
> > the product.
> > 
> > Siddharth:
> > Depending on the frequency with which we are able to Review patches
> > consistently, we could eventually take up the role of being a Maintainer
> > as well.
> > 
> 
> 
> Hi Aksh,
> 
> Privately, Vignesh has replied as follows:
> 
> Vignesh:
> Agreed, I would prefer if Manikandan can own the driver as he would have
> better visibility wrt IP documentations as part of Cadence.
> 
> Sorry, I don't have the bandwidth to own the driver. Siddharth and Aksh
> can help review and test on all TI platforms with Cadence PCIe IP.
> 
> 
> 
> 
> Could you please add Siddharth as a Reviewer? I and Manikandan are the
> maintainers. Of course, we need to see if Bjorn and Mani agree. Then, send
> this patch in the next version.
> 

$ git log --oneline --author=Manikandan drivers/pci/|wc -l
4

I wouldn't vote a developer who has committed 4 patches for a driver to become
a maintainer. But considering the fact that the driver is currently in 'Orphan'
state, and the developer works for the company that owns the IP, I'm OK with it.

But atleast that patch has to come from him, stating that he wishes to maintain
the driver. He can add reviewers in the same patch though.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
