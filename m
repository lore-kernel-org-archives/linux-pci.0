Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5437F00A;
	Fri, 17 Jul 2026 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291373; cv=none; b=XlbN1mjB+geOzVU9f9YDF8UDEDEXwVbd0SFiSG78e0k4od1hwmNVleE6PfX4PLj0Ne2pKffm7URX+ZJHGsC2BDDde/qaht2D/y5F9sKPW5/aVgamWwtVyl7hEury1jCE0+fv3/mzUgaSOxNRCMFbGMcJcgSCsZqbQ/+2g+ny9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291373; c=relaxed/simple;
	bh=6CpbO9cDC7fPF/jU1lNa979CN+dldEcbEhbOG+ifaIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiNlJqVc1RgjDidE/Esz7we6GeQOPXwTVh/nzer7wIFgWu7AFWazdhT5fs1FlAqdfb3nZyFVLqJFeOzSMzh8WaiWiHeZFf7GvmK7ia8YWQbPMk4JDW+bO9LboWXIvVqCQExM7H+e5imDJYdw2Dmlr/mpb9orVMIkDOp+rL6nqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIzWYoRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIzWYoRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561BC1F00A3A;
	Fri, 17 Jul 2026 12:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784291372;
	bh=bPkB9sL6mY6O9RFZh/Qv5uF/ZSrP+dcSmej20sG/t50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIzWYoRH6tNeUtKYWn/pEc+Q9HgK99tm0B9SBxf6j5qKPennJDwoXDaKEwrHK8fSk
	 HtWVlEqL3LnK30IBxB9KAei5YxSyqjOoQrKnNb5TaRHC88/coywdGibuaEhzH9SFp0
	 LCQjNvp5IzOtgeENpapX0uv1qlBUye7ckMEuswoBH75d1TjHCMbCcaHSLHJIEXve7a
	 UIblFq0A6MoHrZtL7KIP8pXJIKyvf+9vltbSPpM0Yt0tK9hV+IJm4YTXja29OaLGi6
	 Rb8hWnLHFDwoDvVGpqd3Cn4bQaeXkXFm4RwvVM2v1qljTgwfy9S3gyun5SWobcEgF1
	 M9DUe9x/C34fA==
Date: Fri, 17 Jul 2026 17:59:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.li@nxp.com>, Kelvin Cao <kelvin.cao@microchip.com>
Subject: Re: [PATCH v1 1/3] dmaengine: switchtec-dma: Add PCI1008 device ID
Message-ID: <alogKEzstqyO6Eh8@vaman>
References: <20260714212010.230606-1-logang@deltatee.com>
 <20260714212010.230606-2-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714212010.230606-2-logang@deltatee.com>

On 14-07-26, 15:20, Logan Gunthorpe wrote:
> Add the PCI1008 device ID for switchtec-dma.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
