Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC339AD49;
	Wed,  8 Jul 2026 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783553644; cv=none; b=bLkETOXhlfp0lOjODtr5s39QmC5lobvSfi44znzGuehZ2hCXP4+mWueAQXhv/FpWuc/G1pjvs7Ajwcfb55bFFm+hXy/vfYLwmSTsY58khVKBdHPCdMtU0M2W3hAa1gbatYd50Fk9bd+QwwiC5z+XQZd4dtDxo3LN74WEqO1FyUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783553644; c=relaxed/simple;
	bh=4BnxtS/s0vu0hkfK7XuVCAMACH6g5Jb10F+BmScwM0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxebBPPkr1PwPhjIsOOiuBTlAjMWV+tiOCYxIpiNMMltP0DMaFN35Z42gyyvszofnnItnw0Ir5Kn1n2FnsT7izD3NY2BVxc2t/1CM/6NQRqUXUO/c5s92sO44KrcDdfVFml4LT6pyzvLoVfXhqotzgiJJbrf6abZmz8AaDCRHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=WIejyE14; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQs0xJi5; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="WIejyE14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQs0xJi5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30F50140010D;
	Wed,  8 Jul 2026 19:34:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 19:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783553640;
	 x=1783640040; bh=6kGzCsZxmYHQ+5BEnu7jmb5HSSQ1wTYaH1GyVeV24YE=; b=
	WIejyE14NF2isUwerWaNFK0BtVpSr4l6nXFEHMEGLd5KKGv5/3+WHCqIORTJmSxp
	vMCUfOJLikxvmar32WBglE9IaGcZIT72hgLEia8rAi2rAjFkYKMKL4iKhShL4ItU
	tDP0GNEDaaV+FpfHlaxlAVn4aN32Nt43KpzvxeBHX+npJIZvCivLZayi74isEqD+
	lWovw5oYoTl2V++/PbJUaVvVpukEglbvLg0hDkuOR4fSvDbLwbIMKZasgScsBtF0
	TCjXQro02qsCVzDKiupfcathrVDuqsZVuhcRcSuU8afGz9JuaVgFY6KzHmG5008J
	IE4okva6ewte3cxFeZNpCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783553640; x=
	1783640040; bh=6kGzCsZxmYHQ+5BEnu7jmb5HSSQ1wTYaH1GyVeV24YE=; b=A
	Qs0xJi5ciw0jhfLKSStAQ8Rj5z414U9TY8dZOPehVUUNiI3EV4/ZSAKzgjib9fXd
	mVJdkeikCP8yfxeQJTraHeuaW1b5zgBEvc6QPpMrjguHSKf0ZniaGfJP7jNl14fh
	Il9zKu3VF16HmeaU/YvV9oOWSDwljH+TTuUIUrTSH36fVjN2tmHPuV9G4FlGL10A
	kabVF1VqENIAEcSiyG5OOj6K+y8vey1GpTjqS2DgCC91nmOEZTzxm36TMyN0CimY
	W/N6V3jDIAuTR6CgcE4mt2zJTRPMnRqUbSoMYvMYsbI2ltjoF2s/B+Ghie3SiiDz
	UP5J5Ny4q7hFgOsStUb6A==
X-ME-Sender: <xms:Z95Oap5l7iAmmlJv4TIxypgBC8OWdRK6QyQQwoO0VmqZOe3F5i4d9g>
    <xme:Z95Oaod1IxlbUM2nJdW8ij2MF1rjCyZTUNjDN-x5AN8JfPKoAVcyk4abIf5B7xwTm
    _ShPE0pB-MqTkErYIwwNZ5l4G0CzCSM7Vyv2MtyhHS_jsTMMXzdMQ>
X-ME-Received: <xmr:Z95OavvqrkA5Ipfk4g3f7L_UqDoNmA44gYGNtFKSVAfxdrxNynxgl_kcc8E>
X-ME-Proxy-Cause: dmFkZTFk66Tr4PZ1RpoJ2yXE2BF2dN68DoODhH+NgpAxw/zva66bqnWHxfSCYuZR+JyEHm
    flF4GbtFnt8bLxJgMnCN6nvmLvaELOEEjMTryq/TRPaGVQdVxjfdjdFdCfsRXGWtaOQPLj
    vzEmEj9I22CJ/UbhUOEd0yW0tDBXwpjK6Sjvuhsts1Pkn254JZLVYCPz1f8XdQrd79LQIU
    jMi262mhG4so7FIUMKsu10QFKFjSCejJBkuIBhOwSViFF1N3o2bNmiSB1Bnpugtb4NhQFP
    ywoiS6dLdLko78Xju90QoFu5L4u4/khGmtDl8gm0o7afMlgiE6wqGIDcb9T/cN8hCOZMJF
    gQWVj24MpYLqdFpGFM364jIsUBRtJ5kM9IYRkN3WFe7BiQWqibE9wT9cW95mgLFh6sY5B+
    hmpqUuxD0c/j6AryoaITrZaizEaWO2qZMUd5e8rcs76w4lDqOPFg9bKAhTf2mKv8iQcwUG
    M/0Lnrf8WCmr/Jb05T5YPEzFMsy4SsmhV1ogPPzmDjD9uHi+9LVW6bRde+Qhldm3fu7KGo
    MjwDek9bJkz8c4Fp1fbPx7LGjykO32a8EZS/AaHU+TqBlw0+OVRoLTUqy/qU0NI1nuBc19
    /rdxoSQUx5AekqTeSYfh0CvmLC9Gc7u1X8/qOH19aFgEXucqNiZfJqgmY/ZA
X-ME-Proxy: <xmx:Z95Oaolg-iWf2eUiHpghZIEXL7nUqMuBLCzPdcz9ScpfDFLFo80f3A>
    <xmx:Z95OaiQ-O7QUsClhF2vQusTr92zXA0P5JeKZ8V81RWutH9fipq0ZQw>
    <xmx:Z95OauJLqMrkF_sH7B-xvifU3HyzUNdoo8D5GaN7mG-S1iRIMrsZpw>
    <xmx:Z95OasF8HeuqKY4LOF5MnZL7zX2OS1atScfJrtQJicsMl-3_rus7WQ>
    <xmx:aN5OasPa9Tsm2RxgID7uy6HPouK2j2NO7uLg6NCctqMqtqBYc9hBWndn>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 19:33:58 -0400 (EDT)
Date: Wed, 8 Jul 2026 17:31:01 -0600
From: Alex Williamson <alex@shazbot.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, alex@shazbot.org
Subject: Re: [PATCH v19 13/18] vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH
 family uapi for PCI TPH control
Message-ID: <20260708173101.236cd0b9@shazbot.org>
In-Reply-To: <20260702124224.57168-14-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
	<20260702124224.57168-14-fengchengwen@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jul 2026 20:42:19 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> Add user API definitions for PCI TPH device feature set, including three
> feature IDs:
> - VFIO_DEVICE_FEATURE_TPH: Global TPH enable and capability query
> - VFIO_DEVICE_FEATURE_TPH_RESOLVE: Resolve PH/ST from specified source
>   (GET only)
> - VFIO_DEVICE_FEATURE_TPH_ST: Batch program ST table entries (SET only)
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  include/uapi/linux/vfio.h | 62 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5ee..ed04b6280cd6 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1534,6 +1534,68 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
>  
> +/* PCIe TPH device feature definitions for VFIO_DEVICE_FEATURE ioctl */
> +#define VFIO_DEVICE_FEATURE_TPH		13
> +#define VFIO_DEVICE_FEATURE_TPH_RESOLVE	14
> +#define VFIO_DEVICE_FEATURE_TPH_ST	15
> +
> +/*
> + * VFIO_DEVICE_FEATURE_TPH - Control and query PCI TPH capabilities
> + *
> + * SET: Opt-in to TPH feature; flags must be zero.

We clearly need to define what it actually means to opt-in, as this
series is not implementing it as it should be defined.  The user needs
to opt-in via this feature before we modify the device ABI in any way.
The extent to which the user may enable TPH features is bound both by
the device capabilities and the module parameters set by the system
admin.

> + * GET: Return supported TPH capability bits in flags.
> + */
> +struct vfio_device_feature_tph {
> +	__u32 flags;
> +};
> +
> +/* Capability bits returned by GET on VFIO_DEVICE_FEATURE_TPH */
> +#define VFIO_DEVICE_TPH_CAP_DMABUF	(1u << 0) /* DMABUF sources resolvable */
> +#define VFIO_DEVICE_TPH_CAP_CPU		(1u << 1) /* CPU sources resolvable via _DSM */
> +#define VFIO_DEVICE_TPH_CAP_LITERAL	(1u << 2) /* LITERAL ST source supported */
> +
> +/*
> + * VFIO_DEVICE_FEATURE_TPH_RESOLVE - Resolve PH/ST tag value from source
> + * Note: GET only
> + */
> +struct vfio_device_feature_tph_resolve {
> +	__u32 flags;	/* IN: source type + namespace modifiers */
> +	__u32 src;	/* IN: dma-buf fd or CPU ID based on flags */
> +	__u8 valid;	/* OUT: bitmap indicating valid output fields */
> +#define VFIO_DEVICE_TPH_VALID_PH (1u << 0) /* ph holds valid processing hint */
> +#define VFIO_DEVICE_TPH_VALID_ST (1u << 1) /* st holds valid steering tag */
> +	__u8 ph;	/* OUT: TPH processing hint */
> +	__u16 st;	/* OUT: raw steering tag value */
> +};
> +
> +/*
> + * VFIO_DEVICE_FEATURE_TPH_ST - Batch program architected ST table entries
> + * Return value: number of successfully written entries
> + * Note: SET only
> + */
> +struct vfio_device_feature_tph_st {
> +	__u32 flags;		/* IN: source type + namespace modifiers */
> +	__u16 start;		/* IN: first ST table index / MSI-X vector */
> +	__u16 count;		/* IN: number of contiguous entries to program */
> +	__aligned_u64 dests;	/* IN: user pointer to array of source u32 values */
> +};
> +
> +/* Common flags shared by TPH_RESOLVE and TPH_ST features */
> +#define VFIO_DEVICE_TPH_SRC_NONE           (1u << 0) /* TPH_ST only: set ST=0 */
> +#define VFIO_DEVICE_TPH_SRC_DMABUF	   (1u << 1) /* src = dma-buf fd */
> +#define VFIO_DEVICE_TPH_SRC_CPU_VOLATILE   (1u << 2) /* src = volatile memory CPU ID */
> +#define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT (1u << 3) /* src = persistent memory CPU ID */
> +#define VFIO_DEVICE_TPH_SRC_LITERAL        (1u << 4) /* TPH_ST only: src = raw literal ST */
> +#define VFIO_DEVICE_TPH_EXTENDED           (1u << 30) /* Use extended 16-bit ST namespace */
> +#define VFIO_DEVICE_TPH_REQUIRE_ST         (1u << 31) /* TPH_ST only: fail if resolved ST=0 */

I don't see the value in jumping to the end of the flags field for
these last two.  Adding DMABUF is a good change from the proposal, but
I wouldn't go out of our way to try to preserve some grouping of source
flags from modifiers.

We also seem to have avoided any statement or decision to what extent
our uAPI is defined by the current implementation.  Particularly the
ordering of TPH_ST versus manipulating the control bits in config space
are entirely undefined here.

We're also not addressing that the TPH_ST policy counters the overall
feature policy to return 0/-errno and not updating the documentation to
bring that to the forefront.  Thanks,

Alex

> +
> +/* Mask for mutually exclusive source type bits, only one may be set */
> +#define VFIO_DEVICE_TPH_SRC_MASK	(VFIO_DEVICE_TPH_SRC_NONE | \
> +					 VFIO_DEVICE_TPH_SRC_DMABUF | \
> +					 VFIO_DEVICE_TPH_SRC_CPU_VOLATILE | \
> +					 VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT | \
> +					 VFIO_DEVICE_TPH_SRC_LITERAL)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

