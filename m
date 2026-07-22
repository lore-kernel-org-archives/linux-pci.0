Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7608F148850
	for <linux-pci@vger.kernel.org>; Wed, 22 Jul 2026 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784700710; cv=none; b=PcM8X2FsYU57u833DL/3w7bM2RiZCkFXYWbC6/z8edQsFLD+t1G5VWlOSFKo91RqiLqTZnHEMYdtZtA+bv34Y3w/X3CGh9OgkvUtxDYLRGq3+Z9JAyqQ/EdmuPBF6uJzhRZcv5kZecayOxXvPM+j4GtNV/ptLG0/FYqE6v8IIXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784700710; c=relaxed/simple;
	bh=3GjirWQH1jEA4Y+bLg5SROyec/EZ99aUQ4TK86xyr1g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VKRoA1QE5c3Yh1esEcZdoLEbPSdqEjcbVhwulj+9e/8BmvjRekKILLtabsE5TRyhlTPZthezlZdVHgQyOZgBL1640hUHIRrYH/z/i2YqJZ+m2Z7GKBSVBpuZYx16drBNFuvDCKGgdohR5n6/wg9gxNpm0yq9WbqZPI7OZs21z9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFUx/RIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFUx/RIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7D61F000E9;
	Wed, 22 Jul 2026 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784700709;
	bh=eIO15XX8CLs9EzsaWXoqsu75r+BA4zMdxeV77CJJnjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IFUx/RIYmhSZPxqIRXl1EMcf7dHIAsNFScC+DyhP5FFd3gNHYwjZVO1iwSoWD7I9a
	 pWfeMdmap6DR4aV5J2ea40fac7klDLeK9cM1BZvLGb4lH2oaoSnOR3ywCw6zkqt9lu
	 BBmG3kN/8KcD8cLAvqwdNeKVmyA5opuU6okV19AXSikO4WHpzyBSX/rDj+HbKhnn35
	 hF0gLL+ADI9JVrDjYF2Za09HPWMmKHTdsQVCWHTNWcAJq1db/XhFvNPwL5IOnCEAIC
	 ToV2Mh452q40JwFjzlqXbFJlkLeGzMwBv8H+yFHtwEazCfDfs4jxGIjToh0A0EmUpB
	 j2SEhADLcQi2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_async()
 to flush DMA read/write
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260722-mhi-ep-flush-v3-3-d855e715264e@oss.qualcomm.com>
References: <20260722-mhi-ep-flush-v3-0-d855e715264e@oss.qualcomm.com>
 <20260722-mhi-ep-flush-v3-3-d855e715264e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:11:48 +0000
Message-Id: <20260722061148.EC7D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The newly introduced `pci_epf_mhi_edma_flush_async` callback uncon=
ditionally accesses `dma_chan_rx` and `dma_chan_tx` without verification, l=
eading to fatal crashes if DMA initialization fails or the PCIe link toggle=
s.
- [High] `pci_epf_mhi_edma_flush_async()` misuses `dmaengine_synchronize()`=
 by not terminating in-flight transfers, invoking undefined behavior and le=
ading to Use-After-Free when hardware completes transfers after teardown.

Pre-existing issues:
- [High] Teardown paths in `pci_epf_mhi_unbind()`, `pci_epf_mhi_epc_deinit(=
)`, and `pci_epf_mhi_link_down()` are vulnerable to a severe Use-After-Free=
 (UAF) and Double-Free due to dangling pointers.
--

--- Patch [3]: [PATCH v3 3/3] PCI: epf-mhi: Implement mhi_cntrl->flush_asyn=
c() to flush DMA read/write ---
commit e8cb88746eba8db4d5212c60aa7ddf4b58afafd5
Author: Manivannan Sadhasivam <mani@kernel.org>

PCI: epf-mhi: Implement mhi_cntrl->flush_async() to flush DMA read/write

The MHI core needs to make sure that all the current DMA transactions are
completed before removing the channels. So implement the
mhi_cntrl->flush_async() callback by first making sure all the in-flight
DMA operations are completed and then flushing the DMA workqueue.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/e=
ndpoint/functions/pci-epf-mhi.c
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -644,6 +644,15 @@ static int pci_epf_mhi_edma_write_async(struct mhi_e=
p_cntrl *mhi_cntrl,
>  	return ret;
>  }
> =20
> +static void pci_epf_mhi_edma_flush_async(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	struct pci_epf_mhi *epf_mhi =3D to_epf_mhi(mhi_cntrl);
> +
> +	dmaengine_synchronize(epf_mhi->dma_chan_rx);
> +	dmaengine_synchronize(epf_mhi->dma_chan_tx);

[Severity: High]
If pci_epf_mhi_dma_init() fails during epc_init(), the DMA channels are not
initialized, but the flush_async callback is still registered later in
pci_epf_mhi_link_up().  Will this unconditionally dereference dma_chan_rx
and dma_chan_tx and cause a crash if the link goes down?

Additionally, if the host toggles the PCIe link down then up,
pci_epf_mhi_link_down() destroys the channels and sets them to NULL, but the
subsequent link_up does not reinitialize them.  Does this also lead to a
NULL pointer dereference here?

[Severity: High]
Does dmaengine_synchronize() safely stop the hardware or wait for pending
descriptors to execute?

The DMA Engine API states that dmaengine_synchronize() synchronizes only the
termination of a channel and does not stop the hardware.

If dmaengine_terminate_async() is never called, will this return while
hardware DMA is still processing in the background?  When the active DMA
transactions eventually finish, the hardware might write to unmapped or fre=
ed
memory, potentially causing memory corruption and enqueuing a freed transfer
context to the dma_wq.

> +	flush_workqueue(epf_mhi->dma_wq);
> +}
> +
[ ... ]
> @@ -812,6 +821,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
>  		mhi_cntrl->write_sync =3D pci_epf_mhi_edma_write;
>  		mhi_cntrl->read_async =3D pci_epf_mhi_edma_read_async;
>  		mhi_cntrl->write_async =3D pci_epf_mhi_edma_write_async;
> +		mhi_cntrl->flush_async =3D pci_epf_mhi_edma_flush_async;
>  	}
> =20
>  	/* Register the MHI EP controller */

[Severity: High]
This is a pre-existing issue, but teardown paths appear vulnerable to a
double-free or use-after-free.

If the endpoint is unbound via pci_epf_mhi_unbind() after a link down event,
the teardown logic executes again:

pci_epf_mhi_unbind() {
    ...
    if (mhi_cntrl->mhi_dev) {
        mhi_ep_power_down(mhi_cntrl);
        if (info->flags & MHI_EPF_USE_DMA)
            pci_epf_mhi_dma_deinit(epf_mhi);
        mhi_ep_unregister_controller(mhi_cntrl);
    }
    ...
}

Since mhi_ep_unregister_controller() and pci_epf_mhi_dma_deinit() do not set
mhi_cntrl->mhi_dev to NULL or clear out the destroyed workqueues, will this
conditional evaluate to true on a dangling pointer and run the teardown
logic a second time, resulting in a double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-mhi-ep-flu=
sh-v3-0-d855e715264e@oss.qualcomm.com?part=3D3
