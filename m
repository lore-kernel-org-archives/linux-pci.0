Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15C4466B65;
	Wed,  6 May 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778083590; cv=none; b=RTtTMvq03H/rq8iFc27sxkgiSrOkHN/6Nse/XjuTdopKFG/YoRxhfHfi9CnYz0mmeSQhauYNrcWnkZVBa3U/Ol4g2LYPHqrVhwWj79SuL4qSaRG+3XLgFhfSL5h0W9wYWb7eQG+q6Xrz7iduBk2AzAn7dno6RXhrnKcjnuc7/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778083590; c=relaxed/simple;
	bh=dw1RBaTtWl+xJ4dT/a4uc4TtjIaLLW1DXmDYHjx9dVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwMdWZ5nLfizrXLIYTf7Sc5KogqfCxiKn9F36fVUgTZIiPI1BenanGFReAjrH6dRRM8jBvKq0JpaYOkZFjJ41P7zITE88oD/YGLGcYe8iRbQFi3Zlq6L0h4R0iZKP3sFjMeMZ9a/iW9qgwtEO+uhr4SYxTSLpOkpeFZSPUvM2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9qQFqc3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9qQFqc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F16C2BCB0;
	Wed,  6 May 2026 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778083589;
	bh=dw1RBaTtWl+xJ4dT/a4uc4TtjIaLLW1DXmDYHjx9dVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y9qQFqc3y1BQi8VHDtLk6wwOnx85IW/MOetmM11iTWA3d+9OF3Wk8WMkpTxup2iCB
	 O5eBwYeGIRxGXfztja9lU64J/HM2tHEgrfqPJ0JWPDbC1X5evOpA8xwGUaBKRiWVjL
	 u13izj1CULgBvNkKFozW+jQgnUoywGhahbcrM77mWL5a8JrkVv94kGe52Wx0PO2X5n
	 OPCl3VrEqgP9nTN2ZTdZPNU13QQ5F2KznHg89OXMJ67ny/g3/GmZmY6FR2oKZFiVBn
	 fe5838AVU701hj9+NGP0oTV0TS1Ub83wAIwctrFTsb4Bwb+hWPX4MK6U9CRd4FhPx4
	 25hCMk1jxgdzg==
Date: Wed, 6 May 2026 21:36:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	hans.zhang@cixtech.com, robh@kernel.org, mpillai@cadence.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Message-ID: <twryupjevgplfyfcjip323jcy2gjdnbigvvdpytcodisq76lfs@p7fvtw2ev6lr>
References: <20260406103237.1203127-1-18255117159@163.com>
 <20260406103237.1203127-3-18255117159@163.com>
 <7g32xmc5juraumjexmjmptrwvpsbni43csjw727zzkdetforzs@y5xumpko2lf2>
 <3fd86269-e25e-4bd7-9b2d-6b8afb514be4@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fd86269-e25e-4bd7-9b2d-6b8afb514be4@163.com>

On Wed, May 06, 2026 at 11:52:06PM +0800, Hans Zhang wrote:

[...]

> > > +static int ltssm_status_open(struct inode *inode, struct file *file)
> > > +{
> > > +	return single_open(file, ltssm_status_show, inode->i_private);
> > > +}
> > > +
> > > +static const struct file_operations cdns_pcie_ltssm_status_ops = {
> > > +	.open = ltssm_status_open,
> > > +	.read = seq_read,
> > > +};
> > 
> > Sashiko pointed out that you could use DEFINE_SHOW_ATTRIBUTE() to simplify the
> > code here.
> 
> I haven't received any notification from Sashiko. Next time, I'll go
> directly to the website to check the relevant information. It seems that
> Sashiko only sent out an email recently; I didn't receive any emails from
> her before.
> 

Yes, that's the recent behavior. Thanks to kwilczynski ;) You should get
notification for next iteration.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
