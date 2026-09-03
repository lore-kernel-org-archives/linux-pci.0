Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF44485CCA;
	Thu,  3 Sep 2026 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438480; cv=none; b=kg3itz8RI1gMz440vKbzneSBn343BglzTD/FEDDWTlYPcSTblSfZD3H1IsZnXrbWNdxsDV4q4V5XK/qIoo8MHJF/iF+pfL0XS0EJoekOyJw2icWnI8xFntpcAw9PCiRS0Cn/05IimhrXqp+YjjvqZyB6nBBuaJuGEgVXFVKSwPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438480; c=relaxed/simple;
	bh=tPgQPqeQ8tivFoOi8T92/LAwDafbjGB3DMZys3D1d8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0ZDxHSP8T8QhpDGbO5RVyX4j54Yc8DUjvKaBVpqqvrulx0lgh9PpNraE4Thd4JPPlFfROHXcpfu542Nn3VRTc3rAbXoajOFj2Xo6FTVTn7rSB9JXkc5Fv5obDYMJl3nUqrNJlPMUJiWPxe4UIMsxdzsrHN90UTWRc21MZkjBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ewng8sCF; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ewng8sCF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788438470; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iSSfdL1I/sWuhejsZXnDXVfRiUf2pDJbtuLEZmLDvb8=;
	b=ewng8sCFzw4k/iSZrIWhvFJJeaOlW/jA0VOnK5InyKGKdLoPHOX2+s6MFh0kOm+v9/InuIs64r7/+JAsKaFhgUsUmOY5V01k986TGBiXZ/lm81CYqcYzwTwQ5OUIJbjIesewXaYdilDLYWOU6ZRVydVxsOrkdqhfLzBhqeeJ2QU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0XAFvA3u_1788438466;
Received: from 30.246.160.252(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAFvA3u_1788438466 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 20:27:48 +0800
Message-ID: <3dc96249-5103-4b00-8981-5d309ad9e941@linux.alibaba.com>
Date: Thu, 3 Sep 2026 20:27:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/27] vfio/cxl: Virtualize the CXL DVSEC
To: mhonap@nvidia.com, alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com,
 jic23@kernel.org, dave.jiang@intel.com, alejandro.lucero-palau@amd.com,
 smadhavan@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org,
 dave@stgolabs.net, alison.schofield@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, bhelgaas@google.com,
 dmatlack@google.com, kees@kernel.org, gustavoars@kernel.org
Cc: cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, zhiw@nvidia.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260813093631.2288172-1-mhonap@nvidia.com>
 <20260813093631.2288172-18-mhonap@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260813093631.2288172-18-mhonap@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/13/26 5:36 PM, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> Serve reads of the CXL DVSEC body from the per-open shadow and keep guest
> writes in the shadow rather than letting them reach the hardware, so a
> guest cannot reprogram the device through the DVSEC. Accesses outside the
> CXL DVSEC return -ENODEV and take the default DVSEC handling, so a device
> that also exposes a vendor DVSEC is unaffected.
> 
> Route each shadow write through the CXL r4.0 field class rather than
> storing it verbatim: Control stays programmable, Status is
> write-1-to-clear, and Capability, Lock and the Range registers keep their
> firmware snapshot. The guest can no longer set Config Lock or scribble the
> capability and range fields.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>   drivers/vfio/pci/cxl/vfio_cxl_core.c | 88 ++++++++++++++++++++++++++++
>   drivers/vfio/pci/vfio_pci_config.c   | 36 +++++++++++-
>   include/linux/vfio_pci_core.h        |  5 ++
>   include/uapi/linux/pci_regs.h        |  1 +
>   4 files changed, 129 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 2e516a0929c6..9fed909cb9d3 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -148,11 +148,99 @@ static void vfio_cxl_close_device(struct vfio_pci_core_device *vdev)
>   	cxl->dvsec_shadow = NULL;
>   }
>   
> +/* Read a 16-bit DVSEC field from the shadow; @off is DVSEC-relative. */
> +static u16 vfio_cxl_dvsec16(struct vfio_cxl_state *cxl, u32 off)
> +{
> +	u32 dw = cxl->dvsec_shadow[off / sizeof(u32)];
> +
> +	return (dw >> (8 * (off % sizeof(u32)))) & 0xffff;
> +}
> +
> +/*
> + * Apply the CXL r4.0 8.1.3 write class for the 16-bit DVSEC register at @off.
> + * Control is programmable, Status is write-1-to-clear, and Capability, Lock and
> + * the Range registers stay fixed at their firmware snapshot.
> + */
> +static u16 vfio_cxl_dvsec_field(u32 off, u16 old, u16 wval, u16 wmask)
> +{
> +	switch (off) {
> +	case PCI_DVSEC_CXL_CTRL:
> +		/*
> +		 * CXL.mem stays enabled for as long as the guest owns the device.
> +		 * The HDM decoder maps the guest window to device memory, so a
> +		 * store to it while CXL.mem is disabled completes on the device as
> +		 * an error that the host fabric reports as an SError, which is
> +		 * fatal. The spec does not pin down accesses to a decoder whose
> +		 * CXL.mem is off and many hosts SError, so ignore a guest request
> +		 * to clear the enable and keep the bit set.
> +		 */
> +		return ((old & ~wmask) | (wval & wmask)) | PCI_DVSEC_CXL_MEM_ENABLE;
> +	case PCI_DVSEC_CXL_CTRL2:
> +		return (old & ~wmask) | (wval & wmask);


Control2 is routed through the r4.0 write class as plain RW,
but both INITIATE bits are self-clearing doorbells per spec: the guest
sets the bit, the device performs the operation and clears it, and
completion is observed in STATUS2 (Cache_Invalid for the WBI). With the
plain-RW class the shadow latches the bit at 1 forever, and because
reads are served from the open-time snapshot, Cache_Invalid
(CXL_DVSEC_STATUS2_CACHE_INVALID) never changes either.
Both polling paths are dead ends.

The interesting part is that the series already models this correctly
for the sibling command bit -- the vfio_cxl_reset() epilogue does:

	/*
	 * The guest-facing DVSEC bookkeeping only applies while the device
	 * is open. Initiate_CXL_Reset self-clears in hardware; mirror that
	 * and stamp the outcome onto a fresh hardware STATUS2 read for the
	 * polling guest.
	 */

INIT_CXL_RST is self-cleared in the shadow and the outcome is
stamped into STATUS2 for the polling guest. Initiate_Cache_WBI just
never gets the same treatment.

The polling contract is one this series itself implements on the host
side: cxl_reset_wait_cache_wbi() sets WBI, then polls STATUS2
Cache_Invalid with a 100ms budget. A guest kernel running the same
sequence would set WBI, poll the frozen snapshot, and time out before
ever reaching INIT_CXL_RST, so whether a guest-initiated CXL reset
succeeds depends on the open-time STATUS2 value rather than on device
state. The stuck command bit is also directly visible to any guest
reading CTRL2 back.

Would the minimal fix be to mirror the epilogue's INIT_CXL_RST handling
for WBI: self-clear the bit on the 0->1 write and set Cache_Invalid in
the shadow (the host already runs the real WBI at VM power on/off via
cxl_reset_dvsec_sequence(), and the existing W1C class on STATUS2 lets
the guest clear Cache_Invalid before the next round)? Or is forwarding
the WBI to hardware and keeping Cache_Invalid live the intended
long-term model?

Thanks.
Shuai
