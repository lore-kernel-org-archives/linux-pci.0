Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20933A717;
	Wed, 12 Aug 2026 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565228; cv=none; b=tPTrsO0mCtcUjhzQSUDzMxdpSr8VJ+De+O7khzBX9fdvAeFBrSAuKcZvQIXyDHZwg3dKfdkgZHtEdYruMXX0BE8uO+3NqEDxXKIof8j7KzHf3rPvHRx1WhtMtKcG9/gzez5y++mkdA/Bwb0BzSj38VfAb10HnupWq7QRoI+Kqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565228; c=relaxed/simple;
	bh=H13ur29CDd66EDmCZ6WZhT1RgY2n3OpWrbka52hy3nk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEHZFAzPN1Yqgp6FpCIytbiL9XeVkoYOfpkSO7Rt+LZPzMIr12qUHY1iRqSglnFpfcmH3WfwokpS7atKh6fXMHEBVXpmrFvOhNJ9WpvW7zJ1H6RZUMopW6aPr2oaNAp9nMtF5L9M7D6InwtF9GImvcveUTSHw8s1yrkUB4xISts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=goLQDROv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+HMnnyB; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="goLQDROv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+HMnnyB"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62A7C14000E2;
	Wed, 12 Aug 2026 16:07:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Aug 2026 16:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786565221;
	 x=1786651621; bh=q6vLuK4NOs9J00j+cLp1FMNvI5c69+T/NFPNSqeXvzI=; b=
	goLQDROv8rmxUSUNimpLI8gF0O4ZaMrxP7GiOR/NyCGqukozDBkQGJnGwpXeLT+v
	ZfWHAXLzzwpG2A6NtNgBqZajq+qs1GMg3Mf9aTj0A6ByU5RKBY4tbF1gLlYwtOWD
	vKuKaeXfacbplGb2uWoSn0yuX6LqvVNjyUaKB5lNf/6f/9hjM4jKJjXpM1Iy10DM
	T8mxQPeLEdPUve/cGcB/GaIcDpnqqIPPfJN7SNg+8B3P3zWROLw31xfk1bANFRDO
	+VzA1S4edsqT0tqBs2+zDCNxTZah6QihkEOgOQe0n40x5LKQa/AJXxx+U3NWM/MH
	2pRrC55C+fdOYelAot7w5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786565221; x=
	1786651621; bh=q6vLuK4NOs9J00j+cLp1FMNvI5c69+T/NFPNSqeXvzI=; b=P
	+HMnnyBrEKPlp4k17H+M0UJJFiZ7YPjPWJyQqIX+7Gfix+P8fOdFXnKGfshEnm9a
	NJLvpsTKFu714oHza/ctoEYjrfKmZ97xMHyauLj9A/p07NqPKAtG2xJz1O+O9zqy
	5a3h8xsgUCgXjmGPW+SVnfjg9ZT3cXHi1taalD8o9N9ne/GIone3UgNHY0pHQ3YF
	jxAybnkL+UnG11HypsiP2zdM5DSnU18tyiXKCuDw0BfZNRs1aWnOBoyCiv7trZX3
	GuUBYbfptyhZNmhqWMp3Wb2MHe6jSl3Jx6WoD8ES6X2fMPMMe9HtPTo1X/SdIrXi
	67MuQmhN+XhkqeDyLWSAw==
X-ME-Sender: <xms:ZNJ8antfIxAtov5MMh2VUu-xJL7dgXVY_vmpMJ-zBM8_ioAfwq8FzA>
    <xme:ZNJ8aj47hVXCXQhV8EpXZqVJHWFi2rXvzq5OGrEN75bGfVXYLOsW42vHkPQETR9I-
    EaE89wBjAzqdLmmj7AmDYV2ukUB-dupXMMkJKuVhVC8g7MjsT3v>
X-ME-Received: <xmr:ZNJ8apcTDc5IC2zkByKPl85EI2DOLStlIEy3nFf2y41TXuS4OtYfzFYdUkfF9Q>
X-ME-Proxy-Cause: dmFkZTE7YD1dYnn0YDep05yqqF1gLDcK+bObP31dZ9RE+zhxSsc4fnHrLBDmN/QqUrRomF
    jOH9mOxzon6Y+WPZy9cI3Rv/STnC+rLyT2/VGFz5btSb/yEd7HT6ljArSwSugWzYkf1C6E
    tdAvF7j3OTOdW+Mf5RGPgoJo8DGZjGwCDNwcmdyEY6TTdbRaXrriYYkFfFtnqCoynmskIF
    F4l3LCD1G799Gbrc+7wr3w3M9H+PuaAlzD5g6fUYW6HnZRKkrWXHc5qxg70inh+Lcfp6Mt
    rFw3FvxzjRcON2xizEJ4UK+ozOuB/N/NuPgnJIofsJRQ4xmz+A8zesXeFs/BPKZOwyTJfo
    WvlqNMFTS+CybWhksDx7ae0/vq4Gb/Iz0GW/Sf39s2Kf0syscftv28VMjaCiadkbkHaYGO
    2qjinsFvhHMfg+XPgnp6qKdzy2Jy6a6wO0eylvjXx6TJ8yCQZRZ/vByC05NApJx/nzf+Ox
    oaodjBsp6/qbr3G3Ozq2jHbYua8FtlZYdfMuyVGnV2EsVMJwkZ4SKxI+bhjdgyiivlq5BA
    ax6bUDCB3Smc5fQq6+R0pMG878F1lsBDM6TIS+y/Dx2wUvJ/XTRsqt97NWk3b9C2xZyTmD
    1ZArnQZujL4dm/PyuTUKkZFicUYD7AcADdCjlXDnatThCqf0SsJFv1g5JQLw
X-ME-Proxy: <xmx:ZNJ8ajUwAdVoMTBRbYYDYhTeC8s1aEgwd8s94cAluIdlYOX9UO5UKw>
    <xmx:ZNJ8auVw91HYFs0_ru65Sgen4GrRs1-Tab8lbjidEgZd7vr9krI4sg>
    <xmx:ZNJ8asRqQXKG_ALzsZB2YVzHbEMylNZ77vuhBt84akB76Ir-rFywxw>
    <xmx:ZNJ8al0-dc3ctr2Ii-PEp6vGdRET8cPBk2xQ0oondLjcMGCokyGd4Q>
    <xmx:ZdJ8ar2fvMHkaGKNMXJiUPrF7L7t0Qzug66QwIobzqvQe6MpiPNjhf6Y>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 16:06:58 -0400 (EDT)
Date: Wed, 12 Aug 2026 14:06:57 -0600
From: Alex Williamson <alex@shazbot.org>
To: Matt Evans <matt@ozlabs.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Logan
 Gunthorpe <logang@deltatee.com>, Kevin Tian <kevin.tian@intel.com>, Pranjal
 Shrivastava <praan@google.com>, Longfang Liu <liulongfang@huawei.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Ankit Agrawal <ankita@nvidia.com>, Alistair
 Popple <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, alex@shazbot.org
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Message-ID: <20260812140657.247b9fa3@shazbot.org>
In-Reply-To: <291625a2-f281-4c05-b51f-553018a34b08@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
	<20260715174737.15287-8-matt@ozlabs.org>
	<20260729115204.2a9a50b2@shazbot.org>
	<6a964960-722c-44b5-837d-9d582aeb0a3c@ozlabs.org>
	<20260804141022.71b6429d@shazbot.org>
	<291625a2-f281-4c05-b51f-553018a34b08@ozlabs.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 16:58:43 +0100
Matt Evans <matt@ozlabs.org> wrote:

> Hi Alex,
> 
> On 04/08/2026 21:10, Alex Williamson wrote:
> > On Thu, 30 Jul 2026 15:47:13 +0100
> > Matt Evans <matt@ozlabs.org> wrote:
> >   
> >> Hi Alex,
> >>
> >> On 29/07/2026 18:52, Alex Williamson wrote:  
> >>> On Wed, 15 Jul 2026 18:47:30 +0100
> >>> Matt Evans <matt@ozlabs.org> wrote:    
> >>>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> >>>> index 9a1674c152aa..e2b4252e7c3f 100644
> >>>> --- a/include/linux/vfio_pci_core.h
> >>>> +++ b/include/linux/vfio_pci_core.h
> >>>> @@ -134,6 +134,7 @@ struct vfio_pci_core_device {
> >>>>  	bool			pm_intx_masked;
> >>>>  	bool			pm_runtime_engaged;
> >>>>  	bool			sriov_active;
> >>>> +	bool			zap_bars_on_revoke;
> >>>>  	struct pci_saved_state	*pci_saved_state;
> >>>>  	struct pci_saved_state	*pm_save;
> >>>>  	int			ioeventfds_nr;    
> >>>
> >>> This should be in the bitfield usage group since it's only modified at
> >>> init time.    
> >>
> >> This was intentional, but happy to change it if you're certain ofc.  Is
> >> it inconceivable that a sub-driver could set it after init?  I'd say
> >> they _shouldn't_, but only review will stop them and this placement
> >> intended to be cautious.  It seemed a low cost way to avoid issues
> >> around synchronisation on the bitfield.  
> > 
> > I'd agree with the statement that they shouldn't, it would be difficult
> > to synchronize setting the flag once there are any active mappings of
> > the BARs.  Also, if we put it in the bitfield category under the
> > comment that the value is only modified at setup/release, it documents
> > the intentions, hopefully to the extent the author or reviewers notice.
> > An argument can always be made to change it if there's a worthwhile use
> > case.  Thanks,  
> 
> (Having noticed in moving this to the bitfield; my previous reply didn't
> supply the real reason it wasn't in the bitfield.)
> 
> Isn't the init-time 'event horizon' for writing the bitfield the
> vfio_register_group_dev() in vfio_pci_core_register_device(), after
> which synchronisation is needed?
> 
> The hisi_acc_vfio_pci driver's .probe calls
> vfio_pci_core_register_device() and _after that_ sets
> zap_bars_on_revoke, and that's now in the "needs synchronisation to
> write the bitfield" phase.
> 
> (Re-reading my comment in vfio_pci_core_register_device() I'd noted
> this, "Drivers can opt out after registration".  Has to be done after by
> definition as the default's set in vfio_pci_core_register_device().)
> 
> The concern is just blatting neighbours in the bitfield, not the window
> of time before the flag's set.  The flag's an opt-out of a safe but (for
> this driver) unnecessary zap, so having it unset for a short time is OK.
> 
> I still think this really should be a standalone bool, not a bit in the
> bitfield.  It has to be set after registration and having to take a lock
> to do that has downsides.

You're right on the ordering, the device is live after
vfio_pci_core_register_device().  However, I think that's evidence that
vfio-pci-core is setting the default polarity, inferred from the mmap
op, in the wrong place.  It should happen in init, not register_device.

The same mmap op pointer is available in vfio_pci_core_init_dev(), which
is used by all vfio-pci variant drivers in their init callback.  The
proposed vfio_pci_core_register_device() change just needs to be lifted
into vfio_pci_core_init_dev().  hisi_acc is then modified to fix the
flag after vfio_pci_core_init_dev(), something like below.

I think that's better than anticipating it being dynamic when we don't
have a use case that requires it.  Thanks,

Alex

--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1564,6 +1564,7 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
        struct hisi_acc_vf_core_device *hisi_acc_vdev = hisi_acc_get_vf_dev(core_vdev);
        struct pci_dev *pdev = to_pci_dev(core_vdev->dev);
        struct hisi_qm *pf_qm = hisi_acc_get_pf_qm(pdev);
+       int ret;
 
        hisi_acc_vdev->vf_id = pci_iov_vf_id(pdev) + 1;
        hisi_acc_vdev->pf_qm = pf_qm;
@@ -1575,7 +1576,9 @@ static int hisi_acc_vfio_pci_migrn_init_dev(struct vfio_device *core_vdev)
        core_vdev->migration_flags = VFIO_MIGRATION_STOP_COPY | VFIO_MIGRATION_PRE_COPY;
        core_vdev->mig_ops = &hisi_acc_vfio_pci_migrn_state_ops;
 
-       return vfio_pci_core_init_dev(core_vdev);
+       ret = vfio_pci_core_init_dev(core_vdev);
+       hisi_acc_vdev->core_device.zap_bars_on_revoke = false;
+       return ret;
 }
 
 static const struct vfio_device_ops hisi_acc_vfio_pci_migrn_ops = {
