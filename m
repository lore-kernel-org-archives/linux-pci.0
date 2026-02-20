Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D931A56C;
	Fri, 20 Feb 2026 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771583236; cv=none; b=VG0N2jwsT/h9f5Mu5Ffr7OCMWM9eYnHv2ec4Fj+YVCVB0LjlGRKQq6XApEKNZ9+hPWem8YxbSti30WCK25QqsjxGTOHZ8oLkN96nHwWokbqD9j5I1/cMWrCUo0vl1zf65nCltAB2WAbUabQTYYV3+V82D12k6i1vVW/5M+45plk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771583236; c=relaxed/simple;
	bh=cJ2IM3upnXR8IW4btue8CPFwbptHGKWmYdiEiAEhNsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+UF62OktlLj+24z+rkrDRotNT19VZ0L/yFIFq86tD7RcilPu+G0cAUmQ8DiwLb838VtCcwvw/Smfu9NsftN5kfmqEq/EXjNcY2p8q9y2fpIMEqBioMUNmFmEhWjtuVAVtDi40YZG+TUqfqA9XCVRFzs96g3NsxxizwTjkOWqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP6QwK+O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP6QwK+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF3C116C6;
	Fri, 20 Feb 2026 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771583236;
	bh=cJ2IM3upnXR8IW4btue8CPFwbptHGKWmYdiEiAEhNsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DP6QwK+OKhiQRxmij17aSnX+vifGjJ+99tBVhDdzmMH+teAJJMm+33ZagDRl2annp
	 KaPggN9DKm2jKpnZSZUppg60t0oZ/3UkSJUzwA6bg++jmtoSTg0qzAbs6wdthLoefV
	 jZl4ZumV/lNUcByDDmcD/sCo+UJrn+zIWOYtqbJdDbEh7HBOvXHLmR00+AQh/zJvB7
	 cP+vP4RrAK8yGvi2tnMJRPzUK0eX+M7YqVsj2usFuDsJ0xQeaXBcr8rvpcpFeUjW9D
	 aopTFTNc9wcNQiUjjqojrHq/E3sVvNrL1Awd8Aujy9c3xdR6kM7drd7HPOYnVFQb0g
	 6O3k0jT4799qg==
Date: Fri, 20 Feb 2026 11:27:05 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: ALOK TIWARI <alok.a.tiwari@oracle.com>, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Frank.Li@nxp.com, shinichiro.kawasaki@wdc.com,
	christian.bruel@foss.st.com, mmaddireddy@nvidia.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v9 5/7] PCI: endpoint: pci-epf-vntb: Reuse pre-exposed
 doorbells and IRQ flags
Message-ID: <aZg28ligp2ovwuiT@ryzen>
References: <20260219081318.4156901-1-den@valinux.co.jp>
 <20260219081318.4156901-6-den@valinux.co.jp>
 <9067af7b-9794-4313-aec2-98c2c5e018b2@oracle.com>
 <4hn7xbjltx6z37j5foj4mikuz5t5wntf4pr4hxiy577ebuw24w@efke5jakhhjh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4hn7xbjltx6z37j5foj4mikuz5t5wntf4pr4hxiy577ebuw24w@efke5jakhhjh>

On Fri, Feb 20, 2026 at 12:35:31PM +0900, Koichiro Den wrote:
> On Thu, Feb 19, 2026 at 10:00:19PM +0530, ALOK TIWARI wrote:
> > 
> > 
> > On 2/19/2026 1:43 PM, Koichiro Den wrote:
> > >   static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > >   					    struct pci_epf_bar *db_bar,
> > >   					    const struct pci_epc_features *epc_features,
> > 
> > The return value of pci_epc_get_features() seems to be used here
> > without checking for NULL.
> > 
> > Since this function can return NULL, and other EPF drivers
> > (pci-epf-test.c, pci-epf-ntb.c) handle that case,
> > is VNTB assuming that epc_features is always non-NULL,
> > or should a defensive NULL check be added for pci_epc_get_features()?
> 
> Thanks for the comment, good catch.
> 
> AFAICT, this is a pre-existing issue (at least since the initial vNTB merge,
> commit e35f56bb0330), and the same pattern can be found in a few other paths in
> epf-vntb, such as:
> 
>   - epf_ntb_config_spad_bar_alloc()
>   - epf_ntb_configure_interrupt()
>   - epf_ntb_db_bar_init() (the one you pointed out)
> 
> From the current mainline state, all in-tree pci_epc_ops implementations provide
> a .get_features callback and return a non-NULL pointer, and the same holds for
> the in-tree dw_pcie_ep_ops implementations. So in practice this does not appear
> to be triggering a NULL-dereference issue today.

We should really clean this up somehow.


The problems are:

1) A long time ago, not all EPC driver had a get_features callback.
   Now, EPC drivers do have such a callback.
   Ideally, we should probably add a check that an EPC driver implements
   epc->ops_get_features in __pci_epc_create(), and return failure if it
   doesn't.

This way we can remove the if (!epc->ops_get_features) check in e.g.
pci_epc_get_features().


2) DWC based glue drivers have their own get_features callback in
struct dw_pcie_ep
But here we should just have some check in dw_pcie_ep_init() that
returns failure if the glue driver has not implemented
(struct dw_pcie_ep *)->ops->get_features)

This way we can remove the
if (!ep->ops->get_features) checks in pcie-designware-ep.c.


3) Even if the get_features callback is implemented, EPF drivers call
   pci_epc_get_features(), which has this code:

        if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
                return NULL;

So, it will return NULL for invalid func_no / vfunc_no.

I think this currently makes it quite hard to remove the NULL checks on the
return value from a epc->ops_get_features() call in the EPF drivers.




How pci-epf-test has managed to "workaround" this the silliness of having

features = pci_epc_get_features(epc, func_no, vfunc_no);
if (!features)

checks everywhere (problem 3): It calls pci_epc_get_features() once in .bind()
and if it fails, it fails bind(), if it returns non-NULL, it caches the result:
https://github.com/torvalds/linux/blob/v6.19/drivers/pci/endpoint/functions/pci-epf-test.c#L1112-L1123

That way, all other places in pci-epf-test.c does not need to NULL check
pci_epc_get_features(). (Instead it uses the cached value in struct pci_epf_test *)

pci-epf-vntb.c should probably do something similar to avoid sprinkling
NULL checks all over pci-epf-vntb.c.


Kind regards,
Niklas
