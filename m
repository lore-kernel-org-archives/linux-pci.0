Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B4569F14;
	Wed,  9 Sep 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970193; cv=none; b=nXgVhnFpXP2GKwl6isXD+9iMeWQ7XNURVqZdZORjnJHkktoy2Pp8qg1i+8e1iWMDgrRV+M2UpveOEmWt/IzmN0JtGYr1xdkb1ehUGkWtAD+5ZgAlymHq130JaQATZTVypWHn0q7vec6snKilsyhytlEidv8/Ml3ARlXcgnSwxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970193; c=relaxed/simple;
	bh=DuSqGtr4ac4x/SYdfjrPWImbLKom++9KwKXchZw9Jyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JEhysQ2pw+6jHJVH3taTkk7qf9R0Pa+0DrrJd2KdP6Amwnf8SPJXwIy5AEUE8am539pZZhftfToJB8jfQ6JW6kKFxXBLMLuNS/cx0HcDX3jSqWOhOPFmN+smAsycpBOgIU09InTUQ/+BFOvIL3r6Iqi+/mofY0z0rwaom6i6ySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwbQO67O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwbQO67O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CAE1F00A3D;
	Wed,  9 Sep 2026 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970191;
	bh=k7U7NlQUuGTnB1mNS12xNiflYBCMFQmx5qYIiQYXvfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FwbQO67O9tonJyOuoS+/VXiNUY8LxWCyXIQEKXWncjnoCvuaqWprI3yUqpiThorVC
	 4XIdQY2LfJKE/I0k10SX4U3rNGWsofvjTypV9LdPpEv4t61dbxcwdodg40xITNxuX9
	 ENKWwffvvKFFyoMb5qmX+qP4LP1M2Bpu6muFs3viqMzIE+SJEinhgoc9vnEbXqYGjq
	 QVRtnznTbM20wJdOD9hOG8ckbvGjgknMHF3XsS/ZImNr7OpaR08DxBw6WNH+4MC8Y9
	 T5g733+Do2gugpBDIhSY3B9AvkGiFmctb3WVw1nGhNWlK/AjOm/lYDsRnZFM/Y6DeL
	 CFclf3+5u7WOA==
Date: Wed, 9 Sep 2026 11:09:49 -0500
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
Message-ID: <20260909160949.GA216221@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rmso2szdpfjy4qoqalhhpf3zxzn2te25m573qmwmpmoilk5jz2@arvvr4hdzbbj>

On Wed, Sep 09, 2026 at 01:53:53PM +0900, Koichiro Den wrote:
> On Tue, Sep 08, 2026 at 09:23:11PM -0500, Bjorn Helgaas wrote:
> > On Wed, Sep 09, 2026 at 11:01:48AM +0900, Koichiro Den wrote:
> > > On Tue, Sep 08, 2026 at 11:53:15AM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Jul 29, 2026 at 02:23:04AM +0900, Koichiro Den wrote:
> > > > > vntb_epf_mw_set_trans() programs the memory-window BAR through
> > > > > pci_epc_set_bar() with hardcoded function numbers (0, 0), so the BAR
> > > > > lands on the wrong function whenever the vNTB EPF is bound to anything
> > > > > but PF0. The other BAR programming sites in the vNTB driver already pass
> > > > > the EPF's own numbers.
> > > > > 
> > > > > Pass the EPF's own func_no/vfunc_no here as well.
> > > > 
> > > > We're referring to these as "PF" and "VF" in the subject and "physical
> > > > endpoint function" and "virtual endpoint function" in the
> > > > pci_epc_set_bar() kernel-doc, but I don't think these have anything to
> > > > do with the SR-IOV PF and VF concepts, do they?
> > > 
> > > Not in the specific case that motivated this series. But AFAICT, the EPC API
> > > uses the same (func_no, vfunc_no) pair to cover both ordinary functions and
> > > SR-IOV PFs/VFs scenarios. With vfunc_no == 0, func_no can identify either an
> > > ordinary function or an SR-IOV PF. A non-zero vfunc_no identifies a VF
> > > associated with the PF selected by func_no.
> > 
> > Now I'm even more confused :)
> > 
> > Are you saying that a non-zero vfunc_no always identifies an SR-IOV
> > VF?  And there's some dependency on that?  I don't any mention of
> > "iov" in drivers/pci/endpoint/.
> 
> Yes, that is my understanding of the current in-tree implementation. You're
> right that drivers/pci/endpoint/ itself contains no explicit reference to
> SR-IOV. E.g. pci_epf_add_vepf() just calls it a "virtual EP function".
> So my saying was kind of assumptive, but I still think the same because:
> 
> - The support was introduced for SR-IOV:
>   https://lore.kernel.org/r/20210819123343.1951-1-kishon@ti.com/
> 
> - The core rejects a non-zero vfunc_no unless the EPC provides max_vfs, and
>   Cadence is the only in-tree EPC driver I found that does so. For example,
>   cdns_pcie_ep_set_bar() calls cdns_pcie_get_fn_from_vfn(), which uses the
>   SR-IOV First VF Offset and VF Stride for a non-zero vfn.

Thanks, that's helpful.  I still have to work hard to change my point
of view from host-side drivers to endpoint drivers operating on the
other end of the link.  The fact that there are several interfaces
that need (func_no, vfunc_no) suggests that callers really do need to
understand what's going on, and maybe we should try to connect the
kernel-doc and abbreviations more closely with PCIe spec terms.

E.g., if "physical EP function" and "virtual EP function" refer to
SR-IOV PF and VF, maybe we should word them as "endpoint PF" or
"endpoint VF" (or "EP PF", "EP VF" for short).  If
"pci_epf_add_vepf()" adds an SR-IOV VF, maybe "pci_epf_add_vf()" would
be descriptive enough.  We already know we're on the endpoint because
of "epf", so we probably don't need another hint in "vepf", which
includes a "pf" that doesn't mean SR-IOV PF.

> > > > I don't have a better naming suggestion, but this is slightly
> > > > confusing.
> > > 
> > > Perhaps a better subject might be:
> > > 
> > >   PCI: endpoint: pci-epf-vntb: Pass (func_no, vfunc_no) when programming BARs
> > > 
> > > Best regards,
> > > Koichiro
> > > 
> > > > 
> > > > > Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > index c3caec927d74..fba65abfb6b2 100644
> > > > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > > > @@ -1427,7 +1427,8 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> > > > >  	epf_bar->barno = barno;
> > > > >  	epf_bar->size = size;
> > > > >  
> > > > > -	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
> > > > > +	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> > > > > +			      ntb->epf->vfunc_no, epf_bar);
> > > > >  	if (ret) {
> > > > >  		dev_err(dev, "failure set mw trans\n");
> > > > >  		return ret;
> > > > > -- 
> > > > > 2.51.0
> > > > > 
