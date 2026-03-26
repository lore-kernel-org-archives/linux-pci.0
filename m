Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A427FD75;
	Thu, 26 Mar 2026 17:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774544892; cv=none; b=j49ImiBRqgFlSf+vDcZCKzDz6/bZJ4Axt/GA7GAkGqIn40bbaX1+8V+COy+1d6BjxM3uVRknq5LNZ+Ukf0GIILDGb7s1DyTWwEqkxN1derXOiYC5q6Qi7S7MSZo+DT8XmaZhiQCGbPszrGDAj579xCMhYfvRbuyjx4ZjhKSl88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774544892; c=relaxed/simple;
	bh=0Xr0+mOJzJL2nLBTrc8KDIz4NYNlLkpmEaGhoG6OaiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUK7R0iPHEoU+qf/eeEK6TUS1y82f/0wUIuukZY9gmzsTJIrdHIb4Mo11NrpJ+gewt2Owtr0BfI+GKpy42XTQzinQWAyzRmMj2LZw2ypxD5qSKPeFVWiVg8+P3Z1tj90a6GhlvBYVldZjrUcYCLRUa1l3vxcb/8sHl3Oqj4fH3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdgO4c8D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdgO4c8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F1EC19423;
	Thu, 26 Mar 2026 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774544892;
	bh=0Xr0+mOJzJL2nLBTrc8KDIz4NYNlLkpmEaGhoG6OaiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tdgO4c8DqIk8+nt3tP1dl3PxaR4Ck8cTMOZ48IZP/QXr+I9IVH3wALaKQ0GpErU2r
	 PeCIQaHsr54/n6dfOStNpgmSBKYJY7fck7uH/Cs6p5mp3EaP9SIAZGuzaMr6Z6rIHj
	 Yial/QoShCMv7URSyEnsr7jxzl1yZalLS52EFhQeJBEd/5RAliyms9/UcqfTmn0m0T
	 Z4CjcO70kLbJbQP1XgkNaOhM8+atnvov4uTjHOX7QEUZI4rXFQE8Zm8gaZZJUEub+S
	 05lJ/rd9K0bpQkk1+oMWM+lIdgomiM+peQoCB1Usthv6r8n4x8GToD6dU8zOO707FC
	 KqY7+I2d3igZQ==
Date: Thu, 26 Mar 2026 22:38:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: endpoint: Improve error messages
Message-ID: <jx65wotmbm2gcv56wpawdaxul3dhsifvyxdhgxpeq2lzv7wap4@prgjks6yq36m>
References: <20260305071236.23792-1-mani@kernel.org>
 <20260305071236.23792-2-mani@kernel.org>
 <11354ba8-b7f1-4d84-8326-046c89d25a5b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11354ba8-b7f1-4d84-8326-046c89d25a5b@oracle.com>

On Fri, Mar 06, 2026 at 05:25:49PM +0530, ALOK TIWARI wrote:
> 
> 
> On 3/5/2026 12:42 PM, Manivannan Sadhasivam wrote:
> > From: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Include errno in the error prints and also use dev_err() where applicable.
> > 
> > Signed-off-by: Manivannan Sadhasivam<manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >   drivers/pci/endpoint/pci-ep-cfs.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> > index a19db22b7991..2d2efd444b02 100644
> > --- a/drivers/pci/endpoint/pci-ep-cfs.c
> > +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> > @@ -565,7 +565,8 @@ static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
> >   	if (IS_ERR(group)) {
> >   		dev_err(&epf_group->epf->dev,
> > -			"failed to create epf type specific attributes\n");
> > +			"failed to create epf type specific attributes: %d\n",
> > +			(int)PTR_ERR(group));
> >   		return;
> >   	}
> > @@ -578,13 +579,17 @@ static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
> >   	group = pci_ep_cfs_add_primary_group(epf_group);
> >   	if (IS_ERR(group)) {
> > -		pr_err("failed to create 'primary' EPC interface\n");
> > +		dev_err(&epf_group->epf->dev,
> > +			"failed to create 'primary' EPC interface: %d\n",
> > +			(int)PTR_ERR(group));
> 
> using (int) not wrong but it is a bit unusual, in this case can we use "%pe"
> instead ?
> "failed to create 'primary' EPC interface: %pe\n", group)
> 

Agree. Amended this change while applying, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
