Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAD1480DD8;
	Wed,  7 Oct 2026 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791382026; cv=none; b=ukxGpdrrAnrVDv/oj7mT2FvvV70qKtVH+LC3LaCQ4JtQevEngr72eGsxJc0AB2U07hrK7cEOtN4IRh4YHXbY9FBdLax8oAY+KlK4aCg1UBrh12IchxxaA+IWW8+W0fuGVmxD/fFBARef6ZjHCWUlL7JFJzFnIrCfx+IWn/S7Vv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791382026; c=relaxed/simple;
	bh=S7Y2PAq9IAn4nj0fPTP1QUMdSaSZSSeTldDAOYHPZL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPFml13iY9zIfi3B+VJhbdRpb+dooyAGbj7GbJDx89FRTYtkti2lPnNc6K/tPJUXokiBKY2q5dYJw7NmYPRRxK2Yp3IkuUWbame5PF8Wb54qVU82BA2IYKmyzf6dqrIBgprFOUNE0amdfSjXNMR3ryzbBVJOEaGZzUUGYMMXOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJ6QOUqU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJ6QOUqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F0E1F0089C;
	Wed,  7 Oct 2026 14:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791382014;
	bh=HfrGI8jbXGpVFXqniKyw95lNwNeVBlr5DYqdOuibDxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AJ6QOUqUmtGukhveI/7CsjnHSPjsK+MEQfJxYLt0j0XldjymCYxDDo2fKyavES0x8
	 ohxUp6DSaEz11DMr4uJEeCJCqeujx+dj+O2QguDFLNJirqEyiqIGTTmQBmPhUKe/Jn
	 0+JIx6XBqgV4y1UIKl7l3HhCCozfB0loCS1wYqcgXXVoczBzMxCk37DBjcQ+D2yD+o
	 CGcsCZ6q3bD6HvPp5Jj1ba4t5VQI1faZjSEcDGR4ySb3q/kUmEMspBpb2kbcosUX13
	 EO5zZqmBXP1OSbz2aSUDvM5JP3BuqQUCLKwCwqNe1Go2naiSdlk9Hn9cX+WpGF05wT
	 dXEJp0lz6cONA==
Date: Wed, 7 Oct 2026 15:06:47 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v11 01/16] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <asZR98gl3FTgnn9G@willie-the-truck>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-2-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929034510.2023173-2-praan@google.com>

On Tue, Sep 29, 2026 at 03:44:55AM +0000, Pranjal Shrivastava wrote:
> @@ -5594,7 +5631,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	arm_smmu_rmr_install_bypass_ste(smmu);
>  
>  	/* Reset the device */
> -	ret = arm_smmu_device_reset(smmu);
> +	ret = arm_smmu_device_reset(smmu, false);

It's a minor thing, but I have an irrational dislike of 'bool' paramaters
because they're so opaque at the callsite. One way to tidy if up would
be to rename arm_smmu_device_reset() to __arm_smmu_device_reset() and
then have wrapper functions around that (e.g.
arm_smmu_device_reset_resume()) but I actually wonder wheter you need
the bool at all. Why can't you figure out the resume state from the 'struct
device' instead?

Will
