Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523F331202;
	Wed,  9 Sep 2026 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788920594; cv=none; b=i0yOACwQRjjA7aQY+aXhmM9eT87XI+GTQfZ0yLVGyJI9n7fjf89xvjOYKFvUmWTmgteCRsLLtCU0yS+aSVRwhixhmAetKVpA8mDFCRMhzXyC4yVKpmH9aqxAgcbNvwBGmafo1Tm/+cp58eBxVgMOJUSpUQDXc0qFAmDMKD1lBlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788920594; c=relaxed/simple;
	bh=cws26sbARMhJgmblLInMjF34nTkIpLglXDY6tRhC92w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LldWpURvI9c8H0uaQQxDsqeqGuOrmV0Nq8v8UrEIqnvgQA6wtETe16UFGlYvO17VmV8DVn1eWqv6pAooqtqoBie3JgOHli3hWRhM7NNKhI2Ogcwt1yiOEouwvvpQafABfewpwfDPGlLMy7aV0RZYMC1kaCH5/KQwrGl1EtP18E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJUiLnFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJUiLnFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51D21F00A3A;
	Wed,  9 Sep 2026 02:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788920592;
	bh=kTOy4guCZfY/UU41sDeK16kY5lIEY9TokhP/ojm3MvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=UJUiLnFWfExoYmlvfnOCRiZ0kYqdAk3cibffwl46resBBNbfVD+OJs3yowCsfCesV
	 +3QWNH6GZK8PWNnekCefmwvaUsouRtj0S03c8T0xQ3GT6x2ZrPfG4I8rFo9e0feUX4
	 3guz//lcMnVDCwrZKkYkglIVjAL/yNGR7IcHzz8sLKzWV7wBeszhrHHGceWrByVD+S
	 hrSnWJcubU0SqXdfJKgEn6pVpknsHzkiSw2m+HWu0FislR4mvurgtcpXRopAos2i7+
	 nFwVHRnbCz2Q6x2ikC1v6bUsacdOWbkdCGOnl5FuZAhSb++D8eqOqUW8e7rw7aw116
	 /Pe98fYPALz/g==
Date: Tue, 8 Sep 2026 21:23:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: pci-epf-vntb: Pass PF/VF number when
 BAR programming
Message-ID: <20260909022311.GA166287@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3nerafdorapt7erqpkqvsamuzy2ms7w23g3vrs5bildgxu7e3k@ml2udfhaqodd>

On Wed, Sep 09, 2026 at 11:01:48AM +0900, Koichiro Den wrote:
> On Tue, Sep 08, 2026 at 11:53:15AM -0500, Bjorn Helgaas wrote:
> > On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> > > vntb_epf_mw_set_trans() programs the memory-window BAR through
> > > pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> > > lands on the wrong function whenever the vNTB EPF is bound to anything
> > > but PF0. The other BAR programming sites in the vNTB driver already pass
> > > the EPF's own numbers.
> > > 
> > > Pass the EPF's own func_no/vfunc_no here as well.
> > 
> > We're referring to these as "PF" and "VF" in the subject and "physical
> > endpoint function" and "virtual endpoint function" in the
> > pci_epc_set_bar() kernel-doc, but I don't think these have anything to
> > do with the SR-IOV PF and VF concepts, do they?
> 
> Not in the specific case that motivated this series. But AFAICT, the EPC API
> uses the same (func_no, vfunc_no) pair to cover both ordinary functions and
> SR-IOV PFs/VFs scenarios. With vfunc_no == 0, func_no can identify either an
> ordinary function or an SR-IOV PF. A non-zero vfunc_no identifies a VF
> associated with the PF selected by func_no.

Now I'm even more confused :)

Are you saying that a non-zero vfunc_no always identifies an SR-IOV
VF?  And there's some dependency on that?  I don't any mention of
"iov" in drivers/pci/endpoint/.

> > I don't have a better naming suggestion, but this is slightly
> > confusing.
> 
> Perhaps a better subject might be:
> 
>   PCI: endpoint: pci-epf-vntb: Pass (func_no, vfunc_no) when programming BARs
> 
> Best regards,
> Koichiro
> 
> > 
> > > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index c3caec927d74..fba65abfb6b2 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > >  	epf_bar->barno = barno;
> > >  	epf_bar->size = size;
> > >  
> > > -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > > +			      ntb->epf->vfunc_no, epf_bar);
> > >  	if (ret) {
> > >  		dev_err(dev, "failure set mw trans\n");
> > >  		return ret;
> > > -- 
> > > 2.51.0
> > > 
