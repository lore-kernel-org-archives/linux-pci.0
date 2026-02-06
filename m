Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA41827703A;
	Fri,  6 Feb 2026 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390308; cv=none; b=Mu5v+rDJAwWiLWO7Q0niFYed9Xbs2xZqF5fZ2dF8xq14Np6bqL+jepZz2B9OjuW2qIhBXCJy874nuinfE6cmQYt5koTZZ96YKU90EaFrZ0bsCYZFjwyrdbC6UsFuBYj8V0nA6GryhmGm4Z1nxim27Apz6Hg5ASS9ICbkVJHjx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390308; c=relaxed/simple;
	bh=e1ladWSCG2stqWaVrRloIwPzTmKKTrPRCepH4VzfAcM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XUWy2VHWIcridwcGasQeSyoAZXK9A2B36mAwDP26/dnk50vQotEIcBypUQSG1Uy+6QISO716As8i9Tgk5SrxCLq923cMWD5aJQEXKJ0z50t47SB7xbs6R4wdaUfvC/G+e6BVOPXJUz1cwKbWPlpvYNPrrA/Brw1HaDGdBEBx1Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXO9QuMj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXO9QuMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B988C19422;
	Fri,  6 Feb 2026 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770390307;
	bh=e1ladWSCG2stqWaVrRloIwPzTmKKTrPRCepH4VzfAcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LXO9QuMjfmukmbPbXxrRy0hWZPgqnuSZgbQFNmKJCMAlxYO9hicMvhHhh85ndHSS2
	 2yaYiHyUdQMySHMIGSt/LjgWwQOhX55CCTsFOba3j2WxjzbShhYYfut4Zp8krets5V
	 m4PNCPAZMvC840Xatturgoi95z9qAQlYdeAyVLMfYNjfXvc8FUUlnhPv+WeRPcYeVe
	 q8jjV6BOd5N9IDRu9zarzf6eyDtec/nRAwUEvRIfSqspegA8c4kPlAsLTFKm4+iScO
	 fwbNlJ5IhVH/f69cCP5AAKaIMZt6lMl1wYBxl2xJB8p8yVrFL0wyQmSORFALF68xCt
	 JjOk2JtvxuoVQ==
Date: Fri, 6 Feb 2026 09:05:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3 3/4] PCI: Disable ACS SV capability for the broken IDT
 switches
Message-ID: <20260206150505.GA58808@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206145254.GK943673@ziepe.ca>

On Fri, Feb 06, 2026 at 10:52:54AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 06, 2026 at 08:46:51AM -0600, Bjorn Helgaas wrote:
> 
> > IIUC the current situation is that for these IDT switches, ACS SV is
> > enabled when downstream devices are passed through to guests, but
> > after these patches, it will no longer be enabled.
> 
> ACS SV is enabled at boot time if an IOMMU driver is present
> regardless if guests or virtualization is in use.
> 
> Linux doesn't change ACS flags dynamically.

Right, it's just that this series effectively un-advertises ACS SV for
the IDE switches so it will never be enabled for them, whereas today,
I think we *do* enable ACS SV for them (but temporarily disable it
during enumeration).

> > So my question is whether users are giving up some isolation.  If so,
> > should we even allow devices to be passed through to guests?  If we do
> > allow that, do users have any indication that they're not getting what
> > they expect?
> 
> iommu_groups will correctly describe the system limitations with the
> ACS quirk path and so all of the above concerns are taken care
> of. Robin is saying the Juno SMMU forces a large iommu_group covering
> the switch anyhow today, so at least that platform is not affected.

I guess REQ_ACS_FLAGS is what iommu_groups looks for?  I looked for
such a thing earlier but must have missed it.  Thanks!
