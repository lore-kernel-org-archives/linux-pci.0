Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1CE36AB77;
	Fri, 22 May 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779460058; cv=none; b=MWq42k9IUR14MDsCzv1BRBsE14//6XGXCe0AOhqKEQ5x8xelUsLZ8w7qAPVnamDgBd5XuZnNiPTnX6jKTHZUZQ9MoLQ/IkmCed8/AdnGg8pnyHuoasZja3j4Wq6yk34cSYcYh1mWHi8b/mN8eTQJU1wZKX3rMQQdEoMwCl4+Lgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779460058; c=relaxed/simple;
	bh=plxPpLMP6WEHRwBxbMEElRJxgmc2K9gbji6TFwFsVVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3ujqDZHn1B9FbFooYqETOXwlzTAm1QTNCVBzMOwmTVRxch43WklCPifq41HmMYwlxKpwprWZSF5+c9nLDnODgy0bf/p+4dkANnA/gtXgoNgMQ+Cy3mXCzphafZDE4zRX+BpjSTUshQyscsa4isxDRryRBf1K2/dtPOUsFpEMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=HqUoE5vL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GUD6zca8; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="HqUoE5vL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GUD6zca8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 74E5714000F5;
	Fri, 22 May 2026 10:27:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 22 May 2026 10:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779460055;
	 x=1779546455; bh=sBTGTRf71E2MpJmi83lGE/zP6dtUsvkn63wA+R8D/PM=; b=
	HqUoE5vLzkhGwxki2xb4ey7u0Sq+PD0YJcF2Ec+FYA28RSgyiHUF9fyaDGE8ibfs
	eoLgZ/Sk7KWnQZCrI83Zx6pjMnrzrqip1zM5dR/B4lGu2vAjLvzhLZf+VNL/iPOm
	Vr1AleuSZ2PiKVPRxTbFVDDP14Kukp7LqV6LbvRXNt8G3BZOoQkgnrdInFbCn+xe
	H7gwc4ojoJ6Z8r3oj/HOJbKNtzXqejIsgfynCFTMQwDdZ38X1vXkdMzdduKhpdVI
	J3J5cXU8JO4qaneYVQ0/hkPtCpoWsREy+i550w4auLVAG51SUAvNQ8zzHcXNGKut
	6Poq+HwrdXlrUqEwRB3pgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779460055; x=
	1779546455; bh=sBTGTRf71E2MpJmi83lGE/zP6dtUsvkn63wA+R8D/PM=; b=G
	UD6zca8iTrICctOD0/AF+pVf+rMuC393/kbfJQM05QvIt5WrDKm7XLd7Uw3w3LPy
	xE0wGwHacW4IR+32gWadVTtfsJNeqURxaphxvT/NjIKp0P8hW0m9wpZDLYoUsr28
	XuScUlqxRTDK6ts13RAUTPuNXmYGnEunSighqaxlYdyzyRFBMtZZOsRSZWtl+Cac
	A7HeO+WmQ1apqvZyn39Nl1bwemaDETUGd2ifGJj+2hcvWTum0LjcxaXAEsmXVd7Z
	BxJP4jTM6esZSICog4F3knWJ76KlIKfrt96+3Ir3LlHOsi9U3THN4V4tD14/Kr89
	TqG7HBqdPaw+KhGGwFDhw==
X-ME-Sender: <xms:1mcQavR81An6Uo3LF6Ecf6cU7ZFVK1IOaf1SS7GS_ZksikygY1XKuQ>
    <xme:1mcQavDxJEORNIc66eHumh0fgOQwSiJeJv6uMz2mhzPJ8S_w7Ait7JTd7JkCF_U3Z
    xGoE1NR7780A-jU-ov_y9O1T6KfYUcOdYPNweYsHJ4Emq7dYOHL>
X-ME-Received: <xmr:1mcQauLmpuisbCfSDVmuqrjeP5UMamTSvsRiMDtgPJ2puEal6WA7oJNV-3U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduhedtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhgvnhhg
    tghhvghnghifvghnsehhuhgrfigvihdrtghomhdprhgtphhtthhopehjghhgseiiihgvph
    gvrdgtrgdprhgtphhtthhopeifrghthhhsrghlrgdrvhhithhhrghnrghgvgesrghrmhdr
    tghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeifvghirdhhuhgrnhhgvdesrghmugdrtghomhdprhgtphhtthhopeifrghnghiihhho
    uhdusehhihhsihhlihgtohhnrdgtohhmpdhrtghpthhtohepfigrnhhghihushhhrghnud
    dvsehhuhgrfigvihdrtghomhdprhgtphhtthhopehlihhuhihonhhglhhonhhgsehhuhgr
    figvihdrtghomhdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1mcQaiAtvM2_sK57nwC0BHqlaRxHJt1jG4gQTvwYWM2hEjKBO78xxg>
    <xmx:1mcQarsR9dLQ7EM7CHguDYp07UB75_pV1CR16PB3hK8tMQqkGIyQmg>
    <xmx:1mcQaoT52z8z5kW99EiZbTj4vFPGYoIRfuWQcwT8YT10sgoH7UVbqw>
    <xmx:1mcQaqIO1xgnVjSYUPdsaRCZHl8nHoYODPU0Jujbob9CxI_TXBS1KA>
    <xmx:12cQak9LvKo2Gj-gT5kLMEOjmpNfS8SsyDlNKo9NwB3YgFlKvlCC2DyZ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 10:27:33 -0400 (EDT)
Date: Fri, 22 May 2026 08:27:30 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v11 5/5] vfio/pci: Add VFIO_DEVICE_FEATURE_TPH_ST for
 TPH ST entry management
Message-ID: <20260522082730.3d843a7f@shazbot.org>
In-Reply-To: <512bce27-13a2-44a1-aa5b-b5ea77c174ba@huawei.com>
References: <20260518071701.25177-1-fengchengwen@huawei.com>
	<20260518071701.25177-6-fengchengwen@huawei.com>
	<20260521221008.59ddf977@shazbot.org>
	<512bce27-13a2-44a1-aa5b-b5ea77c174ba@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 18:04:13 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> On 5/22/2026 12:10 PM, Alex Williamson wrote:
> > On Mon, 18 May 2026 15:17:01 +0800
> > Chengwen Feng <fengchengwen@huawei.com> wrote:
> >   
> >> Add VFIO_DEVICE_FEATURE_TPH_ST to allow userspace to manage PCIe TPH
> >> Steering Tag entries.
> >>
> >> SET: Program contiguous ST entries when ST table resides in TPH Capability
> >>      or MSI-X table. U32_MAX CPU ID clears the corresponding ST entry.
> >> GET: Retrieve ST values per CPU ID, only available in DS mode.
> >>
> >> Both operations are only valid when TPH is enabled on the device.  
> > 
> > What?  That doesn't align with the hardware programming model.  The
> > specification even suggests that the device should be quiesced or TPH
> > disabled during programming of the steering tags for deterministic
> > behavior.  
> 
> As mentioned in the 4/5 commit, obtaining ST must first enable TPH.
> Of course, I think it might be necessary to calculate pdev->tph_req_type
> during the capability detection phase, so that we can modify ST before
> enabling TPH. Do you think such a modification is needed?

I think a uAPI that doesn't align with the recommended programming
order of the specification, potentially resulting in non-deterministic
behavior is bogus.

> >> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> >> ---
> >>  drivers/vfio/pci/vfio_pci_core.c | 91 ++++++++++++++++++++++++++++++++
> >>  include/uapi/linux/vfio.h        | 41 ++++++++++++++
> >>  2 files changed, 132 insertions(+)
> >>
> >> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> >> index 0d0140202280..13a22c1d6ea6 100644
> >> --- a/drivers/vfio/pci/vfio_pci_core.c
> >> +++ b/drivers/vfio/pci/vfio_pci_core.c
> >> @@ -1558,6 +1558,95 @@ static int vfio_pci_core_feature_token(struct vfio_pci_core_device *vdev,
> >>  	return 0;
> >>  }
> >>  
> >> +static int vfio_pci_core_feature_tph_st(struct vfio_pci_core_device *vdev,
> >> +					u32 flags,
> >> +					struct vfio_device_feature_tph_st __user *arg,
> >> +					size_t argsz)
> >> +{
> >> +	bool is_set = !!(flags & VFIO_DEVICE_FEATURE_SET);
> >> +	struct vfio_device_feature_tph_st tph_st;
> >> +	struct pci_dev *pdev = vdev->pdev;
> >> +	enum tph_mem_type mtype;
> >> +	int i, j, ret;
> >> +	u32 *cpus;
> >> +	u16 st;
> >> +
> >> +	guard(mutex)(&vdev->tph_lock);  
> > 
> > Wrong place for this lock.  Why do we even need it?  If a user races
> > SET/GET with enable/disable, that's their problem.  
> 
> OK, will fix in next version
> 
> >   
> >> +
> >> +	ret = vfio_check_feature(flags, argsz,
> >> +				 VFIO_DEVICE_FEATURE_GET |
> >> +				 VFIO_DEVICE_FEATURE_SET,
> >> +				 sizeof(tph_st));
> >> +	if (ret <= 0)
> >> +		return ret;
> >> +
> >> +	if (!enable_unsafe_tph ||  
> > 
> > Why did we allow the feature to be probe if it can't be used?  
> 
> OK, will fix in next version
> 
> >   
> >> +		pcie_tph_enabled_mode(pdev) == PCI_TPH_ST_NS_MODE)  
> > 
> > Here's that ambiguity of reporting NS_MODE for disabled, but as above
> > it's a bogus requirement.  
> 
> OK, will fix in next version
> 
> >   
> >> +		return -EOPNOTSUPP;
> >> +	if (!is_set && pcie_tph_enabled_mode(pdev) != PCI_TPH_ST_DS_MODE)  
> > 
> > Why?  Let the interface be symmetric that GET works regardless of mode.  
> 
> OK, will remove the restrict
> 
> >   
> >> +		return -EOPNOTSUPP;
> >> +	if (is_set && pcie_tph_get_st_table_loc(pdev) == PCI_TPH_LOC_NONE)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	if (copy_from_user(&tph_st, arg, sizeof(tph_st)))
> >> +		return -EFAULT;
> >> +
> >> +	if (tph_st.count == 0 || tph_st.count > VFIO_TPH_ST_MAX_COUNT ||
> >> +		tph_st.flags > VFIO_TPH_ST_MEM_TYPE_PM)  
> > 
> > Wrong operation for a flags field.  
> 
> Because currently flags only use bit0 (0-VM, 1-PM), this judge make sure
> it will return error if userspace passing non-zero in remain bits.

This should be a mask to test undefined bits are not set, not a value
comparison.

> >> +		return -EINVAL;
> >> +	if (!is_set && tph_st.index != 0)  
> > 
> > We can only GET index 0?  Why?  
> 
> Because GET operation don't need index, this judgment make sure
> it will return error if userspace passing non-zero index.

The interface is not symmetric.
 
> >> +		return -EINVAL;
> >> +	if (is_set && (tph_st.index >= VFIO_TPH_ST_MAX_COUNT ||
> >> +		       tph_st.index + tph_st.count > VFIO_TPH_ST_MAX_COUNT))  
> > 
> > DS can have more that 2048 steering tags.  
> 
> I check the PCIE protocol, DS mode with ST in pcie-config or msi-x must not
> hold > 2048 steering tags.

The MSI-X storage location is limited to 2048, but DS mode doesn't
necessarily use either of these storage locations.

> >> +		return -EINVAL;
> >> +
> >> +	cpus = memdup_array_user(&arg->data, tph_st.count, sizeof(*cpus));  
> > 
> > Use an __aligned_u64 data_uptr like iommufd does and avoid copying this
> > into the kernel.  Isn't this steering tags, why's it named cpus?  
> 
> we reuse the field which according your previous suggestion:
> in GET, user pass in cpus, and vfio will feedback steering tags in cpus.

Perhaps this was over stated, but aligning to the generic uAPI name
since it's dual-purpose would seem to make sense.
 
> >> +	if (IS_ERR(cpus))
> >> +		return PTR_ERR(cpus);
> >> +
> >> +	mtype = tph_st.flags & VFIO_TPH_ST_MEM_TYPE_PM ? TPH_MEM_TYPE_PM :
> >> +							 TPH_MEM_TYPE_VM;  
> > 
> > Then why did we use two flag bits for this?  
> 
> VFIO_TPH_ST_MEM_TYPE_PM is just one bit, could you explain the two flag bits?

My bad, I overlooked that they're both shifted by 0.  Typically we
wouldn't define both the 0 and 1 value, only the latter.
 
> >> +	if (!is_set) {
> >> +		for (i = 0; i < tph_st.count; i++) {
> >> +			ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);  
> > 
> > My understanding was that GET would return the translated values from a
> > previous SET, not translate on the fly.  I think in order to support
> > writing STs before enabling TPH, we're going to need to store them
> > somewhere anyway so that we can push them to the correct location when
> > TPH is enabled.  That means there a buffer for SET/GET regardless of
> > the mode that's enabled.  
> 
> OK, will try to fix
> 
> >   
> >> +			if (ret)
> >> +				goto out;
> >> +			cpus[i] = st;
> >> +		}
> >> +		goto out;
> >> +	}
> >> +
> >> +	for (i = 0; i < tph_st.count; i++) {
> >> +		if (cpus[i] == U32_MAX) {
> >> +			ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, 0);  
> > 
> > Why do we need a magic value to set it to zero?  Hardware doesn't have
> > a "clear ST register value".  
> 
> So you mean for SET, usespace direct passing steering-tag not cpus in this patch?

How does this work with Zhiping's series where there might be TPH values
exposed through the dma-buf to support p2p DMA?  Where would that level
of TPH programming occur?
 
> >> +			if (ret)
> >> +				goto out;
> >> +			continue;
> >> +		}
> >> +
> >> +		ret = pcie_tph_get_cpu_st(pdev, mtype, cpus[i], &st);
> >> +		if (ret)
> >> +			goto out;
> >> +		ret = pcie_tph_set_st_entry(pdev, tph_st.index + i, st);
> >> +		if (ret)
> >> +			goto out;  
> > 
> > Clearly broken for DS mode.  
> 
> For DS mode:
> 1\ if ST table in CONFIG or MSI-X, then it could done by this way
> 2\ if ST table not in CONFIG or MSI-X, then it only need invoke GET, and set by device-specific way.

The SET only after enable model is broken, DS mode needs to support
SET, where GET returns the host translations.  Thanks,

Alex
