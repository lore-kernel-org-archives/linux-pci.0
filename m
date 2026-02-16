Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF3315D5C;
	Mon, 16 Feb 2026 15:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254936; cv=none; b=FfNyamfxW2qgMmsczRl1n1r22N3ykuq7J9tdavC5Dg50fw2GQw8kYmTILG5neLcDES4JCmuxqNWMjbLjGg9lJcR00UCGT/6DQk8S9BIWxrpN22aYm6H5XLQJFL++5a5cXxXQ2M4PHSQEmMf8+hPgtVGQShYQFfL57ZqFA5rpeQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254936; c=relaxed/simple;
	bh=T0/dBAH4A6VtIhLGFbkca4e08w1S8Y6tr6iOo5y+MLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U58McqBixtDb7EgTt+g2UCx7XFRINhBKwnLsb8EKMjdj1uRaKSlxeCj4Wf6AvJsgWhcBuFwdDAhEf/qsGXq5RspkA2s+9Vg0fG8+DeP/Z7qWmJ+WLbMB5sKzJrYZAL59YSlkAVJXnj/VadP/+ZKAjFFJn+TocE9IsMihRR9LcBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVAmm0hV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVAmm0hV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CDFC19423;
	Mon, 16 Feb 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771254936;
	bh=T0/dBAH4A6VtIhLGFbkca4e08w1S8Y6tr6iOo5y+MLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVAmm0hV5VPgoD8Na1fqz30ujWFYw2iZR7Xeepn3HwBgpweurYwSUjOsEhwJJqY0i
	 RC4PisqqVINr9iOO2DQ5iymWQQa7ztNq/7ftY6gOf5E6SPGI5bN5dx5Kpm80NsXXqr
	 L2Vy2EQnhW4+sq70Wo9fSTkxNMU0Kh1uoS8ae8mUOhPFp4LKlMtwotnJ7JEU8Hkn3d
	 80XYwVPsogpL4Z96+zTD94LTqQbkd9BngC8QA2yyHpAdVob+s0D4URZYhvECQudqrW
	 4e7IZdvnK4e9HNDeATC+z4rRzlghwzR3e5ABG4SmldLqggK0V73aBqV8Wy1GLUoqV2
	 oSdjNt8fSlpNg==
Date: Mon, 16 Feb 2026 20:45:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] PCI: mvebu: Simplify with scoped for each OF child
 loop
Message-ID: <2w3cvp43y5fxjveifmagikxhlbrotuztjufa2eoaxesi2fzz2f@6fkyex46nucd>
References: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20260105103502.00002efe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260105103502.00002efe@huawei.com>

On Mon, Jan 05, 2026 at 10:35:02AM +0000, Jonathan Cameron wrote:
> On Fri,  2 Jan 2026 13:49:01 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:
> 
> > Use scoped for-each loop when iterating over device nodes to make code a
> > bit simpler.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Hi Krzysztof,
> 
> Drive by review.  Your changes are functionally equivalent and lgtm.
> However, I am curious at whether the lack of reference count for child
> when stashed in port->dn (and then used in the for loop) is a potential
> issue.
> 

Looks like it. But the current code doesn't drop the reference either :/

- Mani

> Jonathan
> 
> > ---
> >  drivers/pci/controller/pci-mvebu.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > index a72aa57591c0..4d3c97b62fe0 100644
> > --- a/drivers/pci/controller/pci-mvebu.c
> > +++ b/drivers/pci/controller/pci-mvebu.c
> > @@ -1452,7 +1452,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  	struct mvebu_pcie *pcie;
> >  	struct pci_host_bridge *bridge;
> >  	struct device_node *np = dev->of_node;
> > -	struct device_node *child;
> >  	int num, i, ret;
> >  
> >  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
> > @@ -1474,16 +1473,14 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  
> >  	i = 0;
> > -	for_each_available_child_of_node(np, child) {
> > +	for_each_available_child_of_node_scoped(np, child) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> >  
> >  		ret = mvebu_pcie_parse_port(pcie, port, child);
> > -		if (ret < 0) {
> > -			of_node_put(child);
> > +		if (ret < 0)
> >  			return ret;
> > -		} else if (ret == 0) {
> > +		else if (ret == 0)
> >  			continue;
> > -		}
> >  
> >  		port->dn = child;
> >  		i++;
> > @@ -1493,6 +1490,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> >  	for (i = 0; i < pcie->nports; i++) {
> >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> >  		int irq = port->intx_irq;
> > +		struct device_node *child;
> >  
> >  		child = port->dn;
> >  		if (!child)
> 

-- 
மணிவண்ணன் சதாசிவம்
