Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9303AEF4F;
	Tue, 12 May 2026 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564096; cv=none; b=iutYeGbZy41DVOOO5UcxTxu1pB0dc4W0uVBGrjP5GPbr2pFMqyO24K+pPTdR/JR56MiPawNS4zjiFkHB78RpXgJC09qXm7K3Z+zUAJc9Vop3vKm11rssDTAOQ4a2xKc026P2p1+vpf5c6xhzJ3Q/R8RGKUIq5p+i/or8XfZojSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564096; c=relaxed/simple;
	bh=3iE2BfbzaFzEzzKJoeI0oo1+L4Oj9l1rNn6U0KRAZV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6wP7EYyTq3WHkJg8x9VbPupv5KTzGxhoGGjE8H3mWF7GCcv5Q1SgSo6GdKSw0/Pn33hT196+Z1+oDxAQ44EYAEPSNpb1nOXlm8dn0/f1FVHElCzRdMG4p/l5Rzdq5WEWAwRSOcOtK8N4pXpkgF1BvadAJgRXHpUPmlLwLt2Fqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDyIqv/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDyIqv/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B01BC2BCB0;
	Tue, 12 May 2026 05:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778564095;
	bh=3iE2BfbzaFzEzzKJoeI0oo1+L4Oj9l1rNn6U0KRAZV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDyIqv/JBk+DWUXsO2+Z0774CsNPvCdvK1ZmljHpFd/C/4sW9uKrNbQFNitFX0oqT
	 WJ1nUxKp1McIubKZCXINR3bzhwXsH+CQmRPH6ogQUoEo4qHPTD+XF192WKUE1uJBL1
	 8wDM6Hz5y+DGB2q7KAaem5s2pjtvyjb0fEGupZBleCnUPGknM7d93GYp+2aCXXLjQy
	 vvAd9EH80+u5e9acv6MKT+9iYL8jtdUnUYA60qtQ83z00nD7Bp0v3eJgceiHiXbq30
	 Us5GhLEw73X9Zyu9Mv89HQdlSJhAOTCRDIP3c3X4ryKoNLxuPZf9M7SvUnqGCd2ki6
	 D7GNF6mTqTVkA==
Date: Tue, 12 May 2026 14:34:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, den@valinux.co.jp, 
	Frank.li@nxp.com
Subject: Re: [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
Message-ID: <20260512052928.GB1687877@rocinante>
References: <20260407124421.282766-1-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407124421.282766-1-mani@kernel.org>

Hello,

> These two fixes are flagged by Sashiko during the review of doorbell series:
> https://sashiko.dev/#/patchset/20260406155717.880246-1-den%40valinux.co.jp
> 
> Manivannan Sadhasivam (2):
>   PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
>   PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 15 +++++++++------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  9 +++------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Might be out of scope, but since we removed one redundant "db_count"
variable already, perhaps we could also drop this one, too.  Just to add
a small clean-up since we are touching this code already...  Thoughts?

Looking at epf_ntb_db_mw_bar_init():

  (...)

  db_count = ntb->db_count;

  for (bar = BAR_DB_MW1, i = 0; i < num_mws; bar++, i++) {
        if (bar == BAR_DB_MW1) {
                align = align ? align : 4;
                size = db_count * align;
                size = ALIGN(size, ntb->mws_size[i]);
                ctrl = ntb_epc->reg;
                ctrl->mw1_offset = size;
                size += ntb->mws_size[i];
        } else {
                size = ntb->mws_size[i];
        }

        (...)
  }

Thank you!

	Krzysztof
