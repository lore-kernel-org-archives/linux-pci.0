Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E53CD8CF;
	Fri,  3 Apr 2026 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775235319; cv=none; b=lRft2HhNqqRiF9sLFwIeMisshZYUY51oZ51/x/CI91T7m99qPxEmuLwLaQY7GQa52cs/LrCzMFxTe6smzuYYf2Yera/Dxi5mtcI0zi9UOjjWaDFsazEd9eoLSUqAzjDxrxHgEbOvbfrZxrVQ5Y3qp769FAkcfVMjPpnkmGG9fLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775235319; c=relaxed/simple;
	bh=ouSDhq6tByAUyVdiNPcPvc2h/XPDdsjsL76Qcd0N1wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHZkbnDjz6XRqM6HIPa4ddcoREIgcpTvsAjNA4OVkMQ5x2RD/8U+ygjFOdba8zuEBGrsHm9WiRA0zecn0TgkQC27JoTiZ9AuXX9GjLaKh9Hyv9imKGgu7xfa8xOGXHX4bDRU6SdZpEhV38ShPTi7Nbpuwc0lTvSgS6UQzwh/P0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+9Q6uT9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+9Q6uT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF91BC4CEF7;
	Fri,  3 Apr 2026 16:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775235318;
	bh=ouSDhq6tByAUyVdiNPcPvc2h/XPDdsjsL76Qcd0N1wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+9Q6uT9TwGOsf0lDX6ULcQ8MnU11Ws+ToVg6TYclrPuFtXDoush3g6SOFxWPBjdk
	 ew6TT95U8qtyYFJCu7aEsLfO7zWPjnXVWWrvkaIu1rQNamykF+UUwajfWjw4NI7KJn
	 Kkate6CxC7py+5hx1ftuaoCRjgy4YWjJ7I/3DKVuH3maHUzdL6pbW7NrPK+by1Bibw
	 DDP4VxsGtNJ9O24k1YpO/V48kGyx5yFBUN9hYURqWp4WuPWH7zq7vnqeFsQRQOyShb
	 suUvo1PjPxhQWTsZpVsj7tJ+Si26SX3o3jtL8BFmzwR/mbStelwI+4sQiBo0d6TWoZ
	 UkiB6yDY+f9tw==
Date: Fri, 3 Apr 2026 22:25:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Koichiro Den <den@valinux.co.jp>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, Marco Crivellari <marco.crivellari@suse.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v12 1/7] PCI: endpoint: Add auxiliary resource query API
Message-ID: <vwhptrhnwiraim446o2asoz4orpbadmqwbjykz5yzq6ivuruvo@27nqiyszlb2h>
References: <20260327035422.4020455-1-den@valinux.co.jp>
 <20260327035422.4020455-2-den@valinux.co.jp>
 <acawzbj2s8P95YKi@lizhi-Precision-Tower-5810>
 <zzatuxxzrg6yuqprvhgntwspsrg3igk2wqqqamx7xh733ksgef@mvwzcseqvjrb>
 <acvVmM-nk73ntNj5@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acvVmM-nk73ntNj5@lizhi-Precision-Tower-5810>

On Tue, Mar 31, 2026 at 10:09:28AM -0400, Frank Li wrote:
> On Tue, Mar 31, 2026 at 10:56:34PM +0900, Koichiro Den wrote:
> > On Fri, Mar 27, 2026 at 12:31:09PM -0400, Frank Li wrote:
> > > On Fri, Mar 27, 2026 at 12:54:16PM +0900, Koichiro Den wrote:
> > > > Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> > > > engines) whose register windows and descriptor memories metadata need to
> > > > be exposed to a remote peer. Endpoint function drivers need a generic
> > > > way to discover such resources without hard-coding controller-specific
> > > > helpers.
> > > >
> > > > Add pci_epc_count_aux_resources() / pci_epc_get_aux_resources() and the
> > > > corresponding pci_epc_ops callbacks. The count helper returns the number
> > > > of available resources via an output parameter, while the get helper
> > > > fills a caller-provided array of resources described by type, physical
> > > > address and size, plus type-specific metadata.
> > > >
> > > > Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > > Changes in v12:
> > > >   - Add pci_epc_count_aux_resources() and pci_epc_ops.count_aux_resources
> > > >   - Use pci_epc_function_is_valid() instead of open-coding
> > > >
> > > >  drivers/pci/endpoint/pci-epc-core.c | 83 +++++++++++++++++++++++++++++
> > > >  include/linux/pci-epc.h             | 53 ++++++++++++++++++
> > > >  2 files changed, 136 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > > > index 6c3c58185fc5..fded71a19d71 100644
> > > > --- a/drivers/pci/endpoint/pci-epc-core.c
> > > > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > > > @@ -156,6 +156,89 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pci_epc_get_features);
> > > >
> > > > +/**
> > > > + * pci_epc_count_aux_resources() - count EPC-provided auxiliary resources
> > > > + * @epc: EPC device
> > > > + * @func_no: function number
> > > > + * @vfunc_no: virtual function number
> > > > + * @num_resources: returned number of auxiliary resources
> > > > + *
> > > > + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> > > > + * registers and/or descriptor memories can be exposed to the host by mapping
> > > > + * them into BAR space. This helper queries how many such resources the backend
> > > > + * provides.
> > > > + *
> > > > + * Return: 0 on success, -EOPNOTSUPP if the backend does not support auxiliary
> > > > + * resource queries, or another -errno on failure.
> > > > + */
> > > > +int pci_epc_count_aux_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > > > +				int *num_resources)
> > >
> > > Most like such kinds APIs return count directly,
> > >   < 0,  means error.
> > >  >= 0,  means how many resource.
> >
> > I chose to return 0 on success here based on Mani's earlier feedback on v11:
> > https://lore.kernel.org/linux-pci/lfbv6sjevz4xtjr6zt2hl3wap3bfwkvigqb6fdztqmutxgcvld@3t4x5gstr4nj/
> 
> I am okay for both, But may request Mani think 2nd. Most existing kernel
> API use return value for count of resource.
> 

Ok, fine with me.

@Koichiro Den: When you respin, could you please rename the API to
pci_epc_get_aux_resources_count()?

Reset LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
