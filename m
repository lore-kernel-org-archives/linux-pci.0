Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CD19067C;
	Mon, 11 May 2026 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778474194; cv=none; b=arUuAVVXdGiNvDMYFVji8wVaf3y27ZbY1Uc2DWSGX5GToeun2jFfOAFbVlcq1FSIokUjKX88LpBlnKRQU30oAe6VN2bmTBQsiP4pG4OIoXC9cpUoEdn9g7+1HIsPXZKWWyK8dklBlJYCmBSN0qSAsukUzgWzKAHQraJBbF782ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778474194; c=relaxed/simple;
	bh=TyzsigNPCkp3QLTPhvuM3vIwRzgIr6nm/JhARS3wwBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDimGG1HhcX8BNVGHQD2EtzOMimvf9YHoWy1CkBsaYd0a4YhOVLDOtDX20a74zRJ0oIGOznmD0ylrDjZssXyFJ4GoKFJBSfDwm3bArY5KuSyR3feHYBCM45lXknzJ/GU7O4pq6+mjrlkBiqZJdGiHEFOgGpmEKYsGsFRT46ZQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=JwivJHl4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fKl4yaV1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="JwivJHl4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fKl4yaV1"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AABBEC00A5;
	Mon, 11 May 2026 00:36:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 11 May 2026 00:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778474190;
	 x=1778560590; bh=vOSeOEo8R8er+06oeYobh51ZXZvoEwG8WPvF6EieTrs=; b=
	JwivJHl4TnzbopRA0hUIYhRKHaU615vFjkIPVvLkiOTYU6hibpSZTQTW2FN/bxsQ
	+RwcldEqbWRoDYUkYrD43K5GQe+eFIxbHx+thIvfjGDRQv5DHFOfaHwU/kKxru8h
	4jjibG6XDVtvUtWn7gU4y1xY21Zei+W6egscWfU7DNyvZz85UjJLAThfKNfijBu3
	d32lsl5faCjHBDy0ihk7yG2Vi9RScJdfCX+8MriyA0d9SjQxXqm7oSUryemw+wkT
	g3JjElu3w51JUTfLG98BEy2kNLFbDK9NJ8A6ojBkY0jyhpPiGjFpvbMebhLecVJW
	0MgqOAfCRcpZkltIonGM1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778474190; x=
	1778560590; bh=vOSeOEo8R8er+06oeYobh51ZXZvoEwG8WPvF6EieTrs=; b=f
	Kl4yaV1hNUbxk+iBS3uTPPvqqcAPa7p9aLmFdlXAHyZzCd85vrtmwSL8xbyuooPh
	BUScbEDz4i4MYXlKzsRhC3yfoS8tkpjTtQax8vFjUFYQut/tMlhop9d30eGEJD9t
	qIOFEJBygy6365kFKs0hEJDEF3kjSP+08Nl1R+t0pmM+OlqW87r0Tyl4AYzhgELr
	ersRtl7vgy4TXT/oUR0nXikvDr7NDeYDzml+XumBidEy6BrnlvywunR0/PZ0Z6f5
	JxojjDMTxzSmp/k02huDc/1kvtl1mV2iTcp3ceP1+XLmHPIL6mTUjRJKdy1+vddX
	9F26delnrQZ+1QQz1W8Zw==
X-ME-Sender: <xms:zVwBanb-NHiluI-mIYXT3I0Ekv75YUIMIhDKMdoSbSj7-iJ8sH2tsw>
    <xme:zVwBakribhZdiAN09vosR5d3TW9GR_pg3c_wlJkKm-cPUJMEU2lC-fyp25T-V0xRq
    5-Gftd9xC4TCXL1ss2eXbASMfBTtoua4m15P1MMyLcJrOzCuKyoswk>
X-ME-Received: <xmr:zVwBajQZC-yv25ItqYID1dKZmYu4MS4TydL0FtX3Dfwyq6RDx4m5rMNTE_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudektdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:zVwBagpGM8SxEtsg_afTuzt3pY2GSKWhB3blOu68Vtapiomdyhjg_A>
    <xmx:zVwBal3pxKfVxdFwYxBkllefX0jiZS6sbRl8kJAaU0uRhU6BXTfqSA>
    <xmx:zVwBan5Vbt0phrwGQ1AukqkrcokHR_-dV6dOAR9inh0453FAjz18rg>
    <xmx:zVwBahTUQkUyyAr5oCvr7Xsz8XgzYpFGoDTNzIqg3l4m5hSpsY8TnA>
    <xmx:zlwBanHsx17zNSzUGNqOveovxYLoRcm8zN61G-XDWkk4qNCbV6PtmASf>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 00:36:28 -0400 (EDT)
Date: Sun, 10 May 2026 22:36:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v8 4/7] vfio/pci: Add PCIe TPH interface with capability
 query
Message-ID: <20260510223626.0ba9dc0b@shazbot.org>
In-Reply-To: <f1f11651-c86d-47a9-974c-da0b3d423657@huawei.com>
References: <20260508064053.37529-1-fengchengwen@huawei.com>
	<20260508064053.37529-5-fengchengwen@huawei.com>
	<20260508164003.70918c0c@shazbot.org>
	<f1f11651-c86d-47a9-974c-da0b3d423657@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 May 2026 11:28:03 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
> On 5/9/2026 6:40 AM, Alex Williamson wrote:
> > On Fri, 8 May 2026 14:40:50 +0800
> > Chengwen Feng <fengchengwen@huawei.com> wrote:
> >> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> >> index 0c771064c0b8..40bf5aa9fd0b 100644
> >> --- a/drivers/vfio/pci/vfio_pci.c
> >> +++ b/drivers/vfio/pci/vfio_pci.c
> >> @@ -60,6 +60,12 @@ static bool disable_denylist;
> >>  module_param(disable_denylist, bool, 0444);
> >>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
> >>  
> >> +#ifdef CONFIG_PCIE_TPH
> >> +static bool enable_unsafe_tph_ds_mode;
> >> +module_param(enable_unsafe_tph_ds_mode, bool, 0444);
> >> +MODULE_PARM_DESC(enable_unsafe_tph_ds_mode, "Enable UNSAFE TPH device-specific (DS) mode. This mode provides weak isolation, cannot be safely used for virtual machines. If you do not know what this is for, step away. (default: false)");
> >> +#endif
> >> +  
> > 
> > Why is the "unsafe" aspect of this keyed on mode rather than storage
> > location?
> > 
> > Currently the user cannot enable TPH, the capability is read-only, but
> > the user does have direct access to the MSI-X table.  We rely on an
> > agreement that the user needs to use SET_IRQS to allocate host vectors
> > and we use interrupt remapping as protection against abuse, but there's
> > no mediation of STs written directly to the MSI-X table.  If the device
> > supports IV mode with ST in the MSI-X table, nothing prevents the user
> > from writing those ST entries directly to the MSI-X table.  Therefore
> > doesn't it have the same security concern as DS mode?  
> 
> 
> Agree, from this perspective, even if it is in MSI-X table, it is still unsafe.
> So TPH is unsafe as a whole, not just DS mode.
> 
> > 
> > Further, config space lives in the device and various devices are known
> > to have alternate means for accessing their config space.
> > Virtualization of config space is more to present the device in the VM
> > address space and bridge features between guest and host.  It's not
> > great as a security barrier.
> > 
> > Maybe it's really neither the mode nor storage location, and we need to
> > decide if TPH as a whole introduces any new security considerations.  
> 
> I will adjust the module parameter to control TPH globally instead of
> only DS mode.

I'm not convinced that's the right solution either.  It's a usage
barrier if the TPH capability isn't exposed R/W, but does it guarantee
the device won't make use of such TLPs anyway?  If the device has
config space backdoors or can otherwise be manipulated to send these
hints, a vfio-pci module option is just security theater.  It's also a
burden for users and for each variant driver for devices supporting TPH.

We do however need to consider how changing the behavior of the
capability affects existing users, like QEMU.  We may need to consider
two device features, one that only supports SET with no payload to
enable virtualized access to the TPH capability and another that
provides the ST handling interface.

> > It seems arguable whether we can actually prevent a device from
> > including arbitrary STs on TLPs in any case and maybe we're really
> > only exposing a curated programming interface.
> > 
> > ...  
> >> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> >> index 5de618a3a5ee..81da2bd0c21b 100644
> >> --- a/include/uapi/linux/vfio.h
> >> +++ b/include/uapi/linux/vfio.h  
> 
> ...
> 
> >> +#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
> >> +  
> > 
> > This seems like the wrong shape to me and introduces yet another
> > ioctl multiplexer.  We already have that via the device feature
> > interface. I'd propose this only needs one new DEVICE_FEATURE
> > ioctl, TPH_ST.  The uAPI would look like:
> > 
> > struct vfio_device_feature_tph_st {
> > 	__u32 flags;
> > #define VFIO_TPH_ST_MEM_TYPE_PM	(1 << 0)
> > 	__u16 index;
> > 	__u16 count;
> > 	__u32 data[]; /* host CPU# on SET, ST value on GET */
> > }
> > 
> > The user can SET multiple STs at once that have the same mem_type
> > (assuming that's a reasonable limitation).  On SET, each {cpu#,  
> 
> Agree, using the same mem_type for a batch is a good idea.
> 
> Because it could set multiple index, so how about:
> 
> struct vfio_pci_tph_entry {
> 	__u32 cpu;
> 	__u16 val;	/* ST index on SET, ST value on GET */
> 	__u16 reserved;
> }

In the structure I proposed the user can set/get contiguous index
ranges according to index and count, where the data field can then just
be a u32 array.  Why does the user need to be able to set/get
arbitrary, non-contiguous indexes?

In a VM use case we'd likely be trapping individual writes, therefore
we'd be intercepting one index at a time.
 
> struct vfio_device_feature_tph_st {
> 	__u32 op;
> #define VFIO_TPH_OP_GET_ST	0
> #define VFIO_TPH_OP_SET_ST	1

The vfio device feature interface already handles set/get, we don't
need this.

> 	__u32 flags;
> #define VFIO_TPH_ST_MEM_TYPE_PM	(1 << 0)
> 	__u16 count;
> 	__u16 reserved1;
> 	struct vfio_pci_tph_entry ents[];
> }
> 
> > mem_type} is translated to a host value and stored internally.  A
> > GET  
> 
> Should we store internally? How about writing directly to the device?

Perhaps we should, but I think we need a flag to indicate whether we're
virtualizing a write to hardware (capability or MSI-X table) or SET'ing
an index that userspace will later retrieve for DS mode via GET.
Otherwise we don't know until the mode bits are written which location,
if any, the capability is actually using.  For example the device can
support either MSI-X or capability locations, but enable DS mode.  For
consistency though, it might make sense to write to an internal table
regardless.  Thanks,

Alex
