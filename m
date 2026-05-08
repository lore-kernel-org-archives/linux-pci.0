Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53618221DB3;
	Fri,  8 May 2026 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280014; cv=none; b=VBdJsDPRM3dYpZksRwQRMyPb2ehuPjz9Aer25g/XeTk0l4SZiJHkeVskfQT366ZVG1LV9xPEQKQzWv6YGqKdWd80sFMs2lDygqDYNgy8MY8A4z7WkUd9L1ZJZqF7+fZdpK7KPF7WtGexHu0zOh6aEYpea2ockLKW+L38JUZkDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280014; c=relaxed/simple;
	bh=3U/SufooL3Si7bLRcOBI7bsAVJzUk2gQOQr1d6uTwfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aybgsKnZwIvG1wbSR4dgL6BQHoK3OdV4vmijaohJlcfZ4cxVepfkoOLkIf6Lhe+8B2zWYNhR66UU+w955VVxMtZyPglu72vL+UzJymWgJhliOnDiF9p88wDalAk1+ykbN86CWw6jkxVXHupk8XVonShPG0Vrkp82B6rEodS0DVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Qm8ycKBe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lL6hewsN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Qm8ycKBe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lL6hewsN"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B60AF7A003D;
	Fri,  8 May 2026 18:40:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 08 May 2026 18:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778280009;
	 x=1778366409; bh=Wc3dTDrH7Vx3KTw/aznXnAyEe2c8FMx6eWi4Ve4R5S0=; b=
	Qm8ycKBeS1hGwW4e+I7uIEDcACwNCXjMVDUrfqyJJNCYwNCXNVsanULGcKUWUWbu
	aLqHiK5YvlbJizCgxig8xYSyMaR/cZDDQjz6x4d9ZtCOu9zONtVWgL6ITwoCk9p/
	R48xsEfaSzKi8DyOdn4IHlfQbaoQ6WVpez4WOIhOaIrpBlqcGQGJm+Y2BYue5j4n
	VWuLST1sOUqfB/RxQHKLv8e4T4D98sqiHcpvGYAzedddYNqzgs8yqHIoQJpgKJPe
	vkbLwvGnkIKYqSEJXkHoifywkIM4BiXxG1BTCyEz4fv47B53lhhICD3YeMFlY7p6
	VYxTNfKNb134qchlDU/Kdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778280009; x=
	1778366409; bh=Wc3dTDrH7Vx3KTw/aznXnAyEe2c8FMx6eWi4Ve4R5S0=; b=l
	L6hewsNFVW7fn722npCcf241T/bS42PLlQmu61d8YKU/gA2VR3jS09oQ6/ZH88qB
	+Hf6KJJ/IJTtDSYwfsyyVm0ofC/czvL+Mt0CQjuJC78Tdtjm3sWwiNHWFuSCytCr
	3Y4XUbcM48AWldIygn8RlkOiIDyqao1Y5Itie7YHGQLqMkU8q14a1UUj60w1zoFL
	CD3RW8K7/lVej1QaqxaHxaJz37FpX4XRh1ux9ByrN8Hlw9UvVaE0dFSZOMQCdqAu
	uUUXSEtFchMMS0RVQVg4eFIx0O81LAYVcwvXGeEtXIsCqlf1oaUEMxo3CG8taYeY
	726HIuxZXA4auP6NAVpnA==
X-ME-Sender: <xms:SGb-aXzHN17j16e--r4VWJWR_xjsOSC-MeCdtNQuST4hq6KVqZAJvA>
    <xme:SGb-adjdwQvIEyIwkvYBKy4NTuk9_3tbTKUMPO-tyS58e-8CytK0lEu-cazuFEBeO
    aAXkZxp2v2P6UcJpWgZ3GZ8t1yzsfX0Su7iYa0Hdosd-Megra0_gw>
X-ME-Received: <xmr:SGb-aarISflQoeHxJ1pxV2dkr9ky007b3YUW8sLNwj65rdecmjQ2KEfjaLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudduheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
    hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
    veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehfvghnghgthhgvnhhgfigvnheshhhurgifvghird
    gtohhmpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtohepfigrthhh
    shgrlhgrrdhvihhthhgrnhgrghgvsegrrhhmrdgtohhmpdhrtghpthhtohephhgvlhhgrg
    grsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfigvihdrhhhurghnghdvsegrmhgu
    rdgtohhmpdhrtghpthhtohepfigrnhhgiihhohhuudeshhhishhilhhitghonhdrtghomh
    dprhgtphhtthhopeifrghnghihuhhshhgrnhduvdeshhhurgifvghirdgtohhmpdhrtghp
    thhtoheplhhiuhihohhnghhlohhngheshhhurgifvghirdgtohhmpdhrtghpthhtohepkh
    hvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SGb-aUj_T85b8j6-xBHgvujER9Yo1AKuXmCkypS0G_pclvA1dH4lcw>
    <xmx:SGb-acN8lU1XnZT-js6l8fUDfL_cZryIHvqEZI3aQczsU58bf4y3Ag>
    <xmx:SGb-aey7sjHdEUUHBNtqWaa0o8zowEqF_2ovQd86pOLdIyH6hnpmTA>
    <xmx:SGb-aepE0WuI6fB9XlmSptcHVvDw8dHApQfILDWxNDWLBvwVlf4_bA>
    <xmx:SWb-aVc8ucTlsOHHo2qPkpaqN9he8egKKP6kJaoaV-ZdLFgq8Z8OCQKD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 18:40:06 -0400 (EDT)
Date: Fri, 8 May 2026 16:40:03 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
 <wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
 <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v8 4/7] vfio/pci: Add PCIe TPH interface with capability
 query
Message-ID: <20260508164003.70918c0c@shazbot.org>
In-Reply-To: <20260508064053.37529-5-fengchengwen@huawei.com>
References: <20260508064053.37529-1-fengchengwen@huawei.com>
	<20260508064053.37529-5-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 May 2026 14:40:50 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add VFIO_DEVICE_PCI_TPH IOCTL to allow userspace to query device TPH
> capabilities, supported modes, and steering tag table information.
> 
> Add module parameter 'enable_unsafe_tph_ds_mode' to restrict unsafe
> device-specific TPH mode to trusted userspace only.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  drivers/vfio/pci/vfio_pci.c      |  13 ++-
>  drivers/vfio/pci/vfio_pci_core.c |  56 ++++++++++++-
>  include/linux/vfio_pci_core.h    |   3 +-
>  include/uapi/linux/vfio.h        | 133 +++++++++++++++++++++++++++++++
>  4 files changed, 202 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 0c771064c0b8..40bf5aa9fd0b 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -60,6 +60,12 @@ static bool disable_denylist;
>  module_param(disable_denylist, bool, 0444);
>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>  
> +#ifdef CONFIG_PCIE_TPH
> +static bool enable_unsafe_tph_ds_mode;
> +module_param(enable_unsafe_tph_ds_mode, bool, 0444);
> +MODULE_PARM_DESC(enable_unsafe_tph_ds_mode, "Enable UNSAFE TPH device-specific (DS) mode. This mode provides weak isolation, cannot be safely used for virtual machines. If you do not know what this is for, step away. (default: false)");
> +#endif
> +

Why is the "unsafe" aspect of this keyed on mode rather than storage
location?

Currently the user cannot enable TPH, the capability is read-only, but
the user does have direct access to the MSI-X table.  We rely on an
agreement that the user needs to use SET_IRQS to allocate host vectors
and we use interrupt remapping as protection against abuse, but there's
no mediation of STs written directly to the MSI-X table.  If the device
supports IV mode with ST in the MSI-X table, nothing prevents the user
from writing those ST entries directly to the MSI-X table.  Therefore
doesn't it have the same security concern as DS mode?

Further, config space lives in the device and various devices are known
to have alternate means for accessing their config space.
Virtualization of config space is more to present the device in the VM
address space and bridge features between guest and host.  It's not
great as a security barrier.

Maybe it's really neither the mode nor storage location, and we need to
decide if TPH as a whole introduces any new security considerations.
It seems arguable whether we can actually prevent a device from
including arbitrary STs on TLPs in any case and maybe we're really only
exposing a curated programming interface.

...
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..81da2bd0c21b 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1321,6 +1321,139 @@ struct vfio_precopy_info {
>  
>  #define VFIO_MIG_GET_PRECOPY_INFO _IO(VFIO_TYPE, VFIO_BASE + 21)
>  
> +/**
> + * struct vfio_pci_tph_cap - PCIe TPH capability information
> + * @supported_modes: Supported TPH operating modes
> + * @st_table_sz: Number of entries in ST table; 0 means no ST table
> + * @reserved: Must be zero
> + *
> + * Used with VFIO_PCI_TPH_GET_CAP operation to return device
> + * TLP Processing Hints (TPH) capabilities to userspace.
> + */
> +struct vfio_pci_tph_cap {
> +	__u8  supported_modes;
> +#define VFIO_PCI_TPH_MODE_IV	(1u << 0) /* Interrupt vector */
> +#define VFIO_PCI_TPH_MODE_DS	(1u << 1) /* Device specific */
> +	__u8  reserved0;
> +	__u16 st_table_sz;
> +	__u32 reserved;
> +};
> +
> +/**
> + * struct vfio_pci_tph_ctrl - TPH enable control structure
> + * @mode: Selected TPH operating mode (VFIO_PCI_TPH_MODE_*)
> + * @reserved: Must be zero
> + *
> + * Used with VFIO_PCI_TPH_ENABLE operation to specify the
> + * operating mode when enabling TPH on the device.
> + */
> +struct vfio_pci_tph_ctrl {
> +	__u8 mode;
> +	__u8 reserved[7];
> +};
> +
> +/**
> + * struct vfio_pci_tph_entry - Single TPH steering tag entry
> + * @cpu: CPU identifier for steering tag calculation
> + * @mem_type: Memory type (VFIO_PCI_TPH_MEM_TYPE_*)
> + * @reserved0: Must be zero
> + * @index: ST table index for programming
> + * @st: Unused for SET_ST
> + * @reserved1: Must be zero
> + *
> + * For VFIO_PCI_TPH_GET_ST:
> + *   Userspace sets @cpu and @mem_type; kernel returns @st.
> + *
> + * For VFIO_PCI_TPH_SET_ST:
> + *   Userspace sets @index, @cpu, and @mem_type.
> + *   Kernel internally computes the steering tag and programs
> + *   it into the specified @index.
> + *
> + *   If @cpu == U32_MAX, kernel clears the steering tag at
> + *   the specified @index.
> + */
> +struct vfio_pci_tph_entry {
> +	__u32 cpu;
> +	__u8  mem_type;
> +#define VFIO_PCI_TPH_MEM_TYPE_VM	0
> +#define VFIO_PCI_TPH_MEM_TYPE_PM	1
> +	__u8  reserved0;
> +	__u16 index;
> +	__u16 st;
> +	__u16 reserved1;
> +};
> +
> +/**
> + * struct vfio_pci_tph_st - Batch steering tag request
> + * @count: Number of entries in the array
> + * @reserved: Must be zero
> + * @ents: Flexible array of steering tag entries
> + *
> + * Container structure for batch get/set operations.
> + * Used with both VFIO_PCI_TPH_GET_ST and VFIO_PCI_TPH_SET_ST.
> + */
> +struct vfio_pci_tph_st {
> +	__u32 count;
> +	__u32 reserved;
> +	struct vfio_pci_tph_entry ents[];
> +#define VFIO_PCI_TPH_MAX_ENTRIES    2048
> +};
> +
> +/**
> + * struct vfio_device_pci_tph_op - Argument for VFIO_DEVICE_PCI_TPH
> + * @argsz: User allocated size of this structure
> + * @op: TPH operation (VFIO_PCI_TPH_*)
> + * @cap: Capability data for GET_CAP
> + * @ctrl: Control data for ENABLE
> + * @st: Batch entry data for GET_ST/SET_ST
> + *
> + * @argsz must be set by the user to the size of the structure
> + * being executed. Kernel validates input and returns data
> + * only within the specified size.
> + *
> + * Operations:
> + * - VFIO_PCI_TPH_GET_CAP: Query device TPH capabilities.
> + * - VFIO_PCI_TPH_ENABLE:  Enable TPH using mode from &ctrl.
> + * - VFIO_PCI_TPH_DISABLE: Disable TPH on the device.
> + * - VFIO_PCI_TPH_GET_ST:  Retrieve CPU steering tags for Device-Specific (DS)
> + *                         mode. Used when device requires SW to obtain ST
> + *                         values for programming.
> + * - VFIO_PCI_TPH_SET_ST:  Program steering tag entries into device ST table.
> + *                         Valid when ST table resides in TPH Requester
> + *                         Capability or MSI-X Table.
> + *                         If any entry fails, all programmed entries are rolled
> + *                         back to 0 before returning error.
> + */
> +struct vfio_device_pci_tph_op {
> +	__u32 argsz;
> +	__u32 op;
> +#define VFIO_PCI_TPH_GET_CAP	0
> +#define VFIO_PCI_TPH_ENABLE	1
> +#define VFIO_PCI_TPH_DISABLE	2
> +#define VFIO_PCI_TPH_GET_ST	3
> +#define VFIO_PCI_TPH_SET_ST	4
> +	union {
> +		struct vfio_pci_tph_cap cap;
> +		struct vfio_pci_tph_ctrl ctrl;
> +		struct vfio_pci_tph_st st;
> +	};
> +};
> +
> +/**
> + * VFIO_DEVICE_PCI_TPH - _IO(VFIO_TYPE, VFIO_BASE + 22)
> + *
> + * IOCTL for managing PCIe TLP Processing Hints (TPH) on
> + * a VFIO-assigned PCI device. Provides operations to query
> + * device capabilities, enable/disable TPH, retrieve CPU's
> + * steering tags, and program steering tag tables.
> + *
> + * Return: 0 on success, negative errno on failure.
> + *         -EOPNOTSUPP: Operation not supported
> + *         -ENODEV: Device or required functionality not present
> + *         -EINVAL: Invalid argument or TPH not supported
> + */
> +#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +

This seems like the wrong shape to me and introduces yet another ioctl
multiplexer.  We already have that via the device feature interface.
I'd propose this only needs one new DEVICE_FEATURE ioctl, TPH_ST.  The
uAPI would look like:

struct vfio_device_feature_tph_st {
	__u32 flags;
#define VFIO_TPH_ST_MEM_TYPE_PM	(1 << 0)
	__u16 index;
	__u16 count;
	__u32 data[]; /* host CPU# on SET, ST value on GET */
}

The user can SET multiple STs at once that have the same mem_type
(assuming that's a reasonable limitation).  On SET, each {cpu#,
mem_type} is translated to a host value and stored internally.  A GET
returns that translated ST value for DS use cases.

The user can use PROBE to determine if this feature is available.

We already provide the TPH capability read-only in config space, we can
use that rather than an explicit INFO/GET_CAP interface.

When the feature is available, the TPH control register is virtualized.
On enabling TPH via config space, vfio will store the translated ST
values to the appropriate location, or none, and enable TPH.  On SET
while already enabled, vfio will update both the internal table and the
device location (or none).  Thanks,

Alex
