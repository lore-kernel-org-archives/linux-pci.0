Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B221EA65;
	Sun, 28 Jun 2026 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647902; cv=none; b=XbL4GD84L+l/UKA81uOiZWF7lT386fkMxG5zOVOk0Hgxh1RERWPYRx60BYVCSirem0ytmFBfFwTIHHOLi0cIcas2zzn1zgg7jclCODM6Blew/iGDtHLjbC1wxN0PMlPjaVA4fpx66ARrvJINU1LALSJ7qkl30J8Z4tOMY+YVAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647902; c=relaxed/simple;
	bh=mCuUksd4krRLJv8hSRCFO8C4oTlfGgSI+nPKhAFLZr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O5cubUVhDasfeGmwWzxteo8tvUlof6KkzFrBhPjqlvH8Uf+Am3MWspLGX+cFC7Iqj1sd1jxvD1F5I5eytG6fe3bn4rZhC9XJegz0H+DySRBcR173PO/rXPrhhcGmgm3XhHRaCPju9bG+gDUV/QJROG/Q+Ym6z8NzwmxKxCR8UFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XypkPo4x; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XypkPo4x"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=UTrcb7gWUL2BONX+Sc/VnUzGtIv4UFb8gxbuKfMiW2c=;
	b=XypkPo4xc9MYVO0vfsYSPbSohPmB+Ax4dY/KC8UaFcWIyd23lKqSLwxx3ja8XVYJnq1FNcxeM
	GXyQNFTXxnPKJhfqGMvJC2c3bVbeXV4gMt0IqznwoCcKDQrKGdRJh7MwWarOe8odnE8SjO3/2qg
	tT/rw3ajbKc0/Pu09E4CaTs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gp7435rN0z1T4GK;
	Sun, 28 Jun 2026 19:49:23 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7263D4058F;
	Sun, 28 Jun 2026 19:58:10 +0800 (CST)
Received: from [10.82.70.241] (10.82.70.241) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sun, 28 Jun
 2026 19:58:09 +0800
Message-ID: <5b389fb6-7d0e-8fea-1fd9-b873efc028c3@huawei.com>
Date: Sun, 28 Jun 2026 19:58:09 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to
 steering-tag mapping
Content-Language: en-US
To: Alex Williamson <alex@shazbot.org>
CC: <helgaas@kernel.org>, <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca> <20260616105754.784be22d@shazbot.org>
 <9105ceef-5e27-4e3c-8903-d46aef52a2bd@huawei.com>
 <20260626092232.53ed3a7c@shazbot.org>
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260626092232.53ed3a7c@shazbot.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

Resending this message because the previous version was sent in HTML format.

On 2026/6/26 23:22, Alex Williamson wrote:
> On Tue, 23 Jun 2026 17:56:51 +0800
> fengchengwen <fengchengwen@huawei.com> wrote:
>> I’ve sent v18-resend of the PCI TPH sysfs patchset with all prior review
>> comments fully addressed.
>>
>> I remain open to both discussed implementation options. This v18-resend
>> implements the sysfs binary blob approach on Root Ports as you previously
>> suggested.
> There's a problem with the pci-sysfs binary attribute beyond whether
> it's acceptable from a sysfs perspective: it only solves the CPU-ID to
> ST lookup.  We already know that this interface should support dma-buf
> provided TPH ST and PH values from Zhiping's series.  If we take the
> pci-sysfs route for CPU-ID, no subsystem exposes the value embedded
> into the dma-buf.  Another solution is required.  Repeat for each
> possible ST/PH source we might see in the future.
>
> Therefore, I'm coming around to the idea that vfio-pci provides this
> interface, but we need to do so in a way that it's not a wart on the
> side of the interface.  I think we can do this based on an incremental
> progression of features and support, where the ST can be provided
> through an extensible set of objects, CPU ID, dma-buf, no-preference
> (zero), and literal user-provided ST values.
>
> The key components of the uAPI are similar to ones you've proposed:
>
>   - An opt-in/feature flags (SET/GET): VFIO_DEVICE_FEATURE_TPH
>
>     The TPH uAPI necessarily changes the ABI of the vfio-pci device;
>     capabilities and control are virtualized.  An empty SET is the
>     opt-in to the ABI change.  There are also feature flags necessary
>     for uAPI surfaces not discovered through the PCI TPH capability, GET
>     on this feature returns a flags field indicating supported features.
>     (SET actually takes a zeroed flags field for symmetry in the vfio
>     device feature API).
>
>   - A mechanism to program indexes in architected ST locations (SET):
>     VFIO_DEVICE_FEATURE_TPH_ST
>
>     This includes flags to define the type of source provided, such as:
>
>      - VFIO_DEVICE_TPH_SRC_DMABUF
>      - VFIO_DEVICE_TPH_SRC_NONE
>      - VFIO_DEVICE_TPH_SRC_CPU_VOLATILE
>      - VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT
>      - VFIO_DEVICE_TPH_SRC_LITERAL
>
>     The requested namespace for the tag:
>
>      - VFIO_DEVICE_TPH_EXTENDED
>
>     And a failure policy, ex. if a translation results in zero, no-pref:
>
>      - VFIO_DEVICE_TPH_REQUIRE_ST
>
>     This would also include a start/count and pointer to user buffer to
>     allow batch settings, if the TPH subsystem can be extended to
>     support these, otherwise a single u32 holds all the decodable
>     sources.
>
>   - A mechanism to decode a source (GET): VFIO_DEVICE_FEATURE_TPH_RESOLVE
>
>     This is necessary for DS mode, where the driver may store STs in
>     device specific locations, but also for dma-buf sources even in IV
>     mode, where the PH needs to be decoded for the driver's use.  This
>     proposal also extends the API, through progressive opt-ins, to
>     support virtualization, where a VMM may (in specific scenarios)
>     implement a _DSM returning host values, and write through literal ST
>     values from this source, or from a guest-based userspace driver for
>     a completer, where the guest kernel can source a valid ST.
>
>     In order to prevent this from becoming the side-car/wart, returning
>     ST values is limited to configurations where the resulting ST may
>     actually be used within the interface.  For example, No-ST and IV
>     mode would operate only with DMABUF, NONE, and CPU_* sources, the
>     literal ST need not be exposed to userspace.  The RESOLVE feature
>     would be limited to returning the PH value for a DMABUF source.
>
>     The structure includes input fields of u32 flags and source, output
>     fields of u8 valid (bits declaring each of the next fields
>     validity), u8 ph, u16 st.  Flag bits are defined the same as for
>     TPH_ST, modulo NONE, LITERAL, REQUIRE_ST are not applicable and
>     reserved.
>
> With that rough uAPI, we can step through an incremental support path.
>
>   1. The most basic level of support, and default sans module options,
>      is No-ST mode.  After opt-in, the TPH capability is virtualized to
>      report only No-ST mode supported, the remainder of the register
>      zero.  Writes to ST Mode allow only 000b.  Writes to Requester
>      Enable allow only valid, non-zero values.  In combination, this
>      enables the device to operate only in No-ST mode.  The TPH_ST
>      interface is inoperative in this mode.  The RESOLVE interface only
>      accepts DMABUF sources and only provides the PH as valid.  This
>      allows only the PH aspect of TPH to be used and does not risk any
>      exposure or malicious use of ST values.
>
>      NB. All modes, including this one, must also validate support for
>      all reachable features through to the root port, ie. TPH Completer.
>
>   2. Via a module option (proposed below), IV mode can be enabled where
>      supported by the device.  This allows the unvirtualized interrupt
>      vector mode supported bit, ST table location, and ST table size
>      fields to be exposed in the capability register, and allows 001b to
>      be written in the mode select control register.  Additionally, this
>      brings onboard the TPH_ST feature, supporting a selection of
>      source flags.  NONE and DMABUF can be assumed, based on sequencing
>      of the dma-buf based TPH completer support series.  CPU sources
>      rely on root port _DSM support.  GET on the noted feature flags
>      above can indicate this support.  LITERAL is not enabled at this
>      point, this mode only supports ST programming via objects and
>      instance numbers.  RESOLVE support is identical to step 1.
>
>      Via SET of TPH_ST, sources are decoded and ST values are written
>      directly to the ST storage location.  The REQUIRE_ST flag indicates
>      whether the user accepts a translation resulting in zero (no-pref)
>      or if the API is to generate an error on this result.
>
>      Support for translating CPU_* sources relies on platform support
>      for _DSM, while other sources like DMABUF have no such requirement.
>      Therefore, for this and following steps, the returned flags on
>      FEATURE_TPH GET will include a bit indicating whether CPU_* sources
>      are supported.
>
>      There are some important considerations to resolve/document here
>      between the TPH specification and Linux implementation, such as
>      requiring TPH is enabled (and for MSI-X vector location, the
>      programmed vector is enabled), before the TPH_ST.  We need to be
>      particularly careful of a uAPI that relies on mutable
>      implementation.
>
>   3. Again, via a module option, DS mode can be enabled where supported
>      by the device.  On such a supported device (and only on such a
>      supported device), the device specific mode supported flag is now
>      reported unvirtualized in the capability register and the control
>      register supports writes of 010b to the mode field.  The RESOLVE
>      interface now supports CPU_* as a source.  RESOLVE will now return
>      both the PH and ST for a DMABUF, indicated through both valid bits
>      set, and the ST for a CPU ID, only the ST valid bit set.  The
>      TPH_ST interface still accepts only DMABUF, CPUID, and NONE for
>      configuring architected ST storage locations.
>
>   4. Finally, literal mode can be enabled via another progression of the
>      module option.  Literal mode allows the TPH_ST feature to accept an
>      actual, raw, ie. literal, ST value and also allows RESOLVE to
>      return a valid ST even for devices only supporting IV mode.  This
>      is intended to support VM use cases, such as a VMM configured with
>      1:1 vCPU:pCPU mappings that exposes a _DSM to the guest with host
>      CPU ST values, or if a completer exists in the guest that provides
>      ST values through a dmabuf.  This is the only mode that allows
>      writing unchecked ST values to architected ST storage locations.
>      The user discovers support for this mode via a LITERAL flag
>      returned from GET on the TPH feature.
>
> The proposed module option is therefore a progression where the user is
> granted increasing privilege to make use of STs:
>
> vfio_pci_core.tph=:
> 	0: No-ST Mode (default)
> 	1: + IV Mode
> 	2: + DS Mode
> 	3: + LITERAL
>
> It should be noted that even in IV mode, the user can R/W the ST value
> via mmap covering the MSI-X vector table and could read the value in
> the capability storage location unless we explicitly prevent it.
> Removing the latter is trivial, removing the former costs reverting
> previous decisions to allow mmap of the MSI-X vector table for
> performance, esp. in larger PAGE_SIZE systems.  If this is an issue,
> (tph >= 1) would need to reintroduce sparse mmap for MSI-X, but higher
> tph values already allow for increasingly direct ST programming.
>
> In general, while the proposal here presents progressively increasing
> access and direct use of raw ST values, this access is not considered a
> security issue.  TPH only allows addressing specific caching
> structures, it does not present a correctness issue.  Abusive use of ST
> values is at best a QoS issue, where access to a device capable of
> these features imposes some inherent risk of exposure.
>
> The feature ioctls therefore take this sort of form:
>
> VFIO_DEVICE_FEATURE_TPH (SET/GET):
>
>      struct vfio_device_feature_tph {
>              __u32       flags;
>      }
>
>      @flags is reserved (0) on SET, returns VFIO_DEVICE_TPH_CAP_* on GET:
>
>      #define VFIO_DEVICE_TPH_CAP_CPU             (1 << 0) /* CPU sources resolvable (_DSM) */
>      #define VFIO_DEVICE_TPH_CAP_LITERAL         (1 << 1) /* LITERAL source available */
>
> VFIO_DEVICE_FEATURE_TPH_RESOLVE (GET):
>
>      struct vfio_device_feature_tph_resolve {
>              __u32       flags;          /* IN: VFIO_DEVICE_TPH_* source + namespace */
>              __u32       src;            /* IN: CPU id or dma-buf fd, per @flags */
>              __u8        valid;          /* OUT: VFIO_DEVICE_TPH_VALID_* */
>      #define VFIO_DEVICE_TPH_VALID_PH    (1 << 0) /* @ph holds a processing hint */
>      #define VFIO_DEVICE_TPH_VALID_ST    (1 << 1) /* @st holds a non-zero steering tag */
>              __u8        ph;             /* OUT: processing hint */
>              __u16       st;             /* OUT: raw ST (DS presented or LITERAL) */
>      };
>
>      @flags is common for both RESOLVE and the following TPH_ST feature,
>      bits are allocated according to their order of introduction.  Some
>      bits are only applicable to the TPH_ST interface and are reserved
>      for RESOLVE:
>
>      #define VFIO_DEVICE_TPH_SRC_DMABUF          (1 << 0) /* dma-buf fd */
>      #define VFIO_DEVICE_TPH_SRC_NONE            (1 << 1) /* write ST 0 (TPH_ST only) */
>      #define VFIO_DEVICE_TPH_REQUIRE_ST          (1 << 2) /* modifier (TPH_ST): stop on
>                                                              resolved ST 0 */
>      #define VFIO_DEVICE_TPH_SRC_CPU_VOLATILE    (1 << 3) /* CPU id, volatile memory */
>      #define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT  (1 << 4) /* CPU id, persistent memory */
>      #define VFIO_DEVICE_TPH_EXTENDED            (1 << 5) /* modifier: Extended ST
>                                                              namespace */
>      #define VFIO_DEVICE_TPH_SRC_LITERAL         (1 << 6) /* literal ST value
>                                                              (TPH_ST only) */
>
>      The source type must be uniquely defined, therefore only one bit in
>      the source mask can be set:
>
>      #define VFIO_DEVICE_TPH_SRC_MASK \
>              (VFIO_DEVICE_TPH_SRC_DMABUF | \
>               VFIO_DEVICE_TPH_SRC_NONE | \
>               VFIO_DEVICE_TPH_SRC_CPU_VOLATILE | \
>               VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT | \
>               VFIO_DEVICE_TPH_SRC_LITERAL)
>
> VFIO_DEVICE_FEATURE_TPH_ST (SET):
>
>      struct vfio_device_feature_tph_st {
>              __u32               flags;  /* IN: VFIO_DEVICE_TPH_* source + namespace */
>              __u16               start;  /* IN: first ST table index
>                                                 (IV: interrupt vector) */
>              __u16               count;  /* IN: number of contiguous entries */
>              __aligned_u64       dests;  /* IN: @count __u32 (CPU/DMABUF/LITERAL;
>                                                 unused for NONE) */
>      };
>
>      Batching here is intended to shorten the TPH disabled/quiescent
>      window, but this is not currently supported by the TPH subsystem.
>      This could degrade to a single inline entry if necessary.
>
>      Batching also introduces a risk of partial success, where some
>      sources may resolve, while others generate an error or are promoted
>      to an error based on the REQUIRE_ST modifier.  The proposed
>      solution for this is to allow vfio device features to return values
>      other than 0 or -errno, as currently described.  This interface
>      would adopt a solution similar to KVM_SET_MSRS, where the ioctl
>      returns the number of successfully programmed entries.  Therefore
>      if (ret == count) the full set was successful, otherwise the user
>      knows exactly which entry failed.
>
> There are various intricate details involved in validating
> configurations where TPH can be enabled, and I'm glossing over the uAPI
> dependencies on implementation versus specification, but I think this
> provides a good basis for exposing TPH support on the device.  I'd
> strongly recommend the incremental enablement stages proposed here,
> even if we stop before LITERAL support based on current use cases.
> Please comment if there are gaps or anything is unclear.  Thanks,

Thanks a lot for your extremely detailed and professional design breakdown
for the unified VFIO TPH uAPI framework. I’ve fully gone through all your
design points and aligned my implementation plan accordingly. I have several
key implementation questions to confirm with you as below:

1. Plan for dma-buf TPH metadata storage
   I plan to add the following TPH-related fields into struct 
vfio_pci_dma_buf
   in my preparatory patch series, which can be fully reused after Zhiping’s
   dma-buf TPH patches land upstream:
       u16 tph_st_ext;
       u8  tph_st;
       u8  revoked:1;
       u8  tph_st_valid:1;
       u8  tph_st_ext_valid:1;
       u8  tph_ph:2;
       u8  tph_ph_valid:1;
   The tph_ph_valid bit is newly added to track whether a valid PH value 
is bound
   to the dma-buf. Is this field layout and validity flag design acceptable?

2. Validation rule for VFIO_DEVICE_TPH_EXTENDED flag mismatches
   The VFIO_DEVICE_TPH_EXTENDED modifier you defined is an excellent design,
   letting users select either 8-bit base ST or 16-bit extended ST when 
hardware
   supports both variants.
   But a mismatch risk exists: users may set ST entries via TPH_ST with 
EXTENDED,
   then later enable TPH requester in pure 8-bit mode only, causing 
inconsistency
   between shadow config and active hardware mode.

   My proposed solution: maintain two separate shadow ST tables inside VFIO,
   one for base 8-bit ST and one for extended 16-bit ST. When enabling TPH
   requester mode, activate the shadow table matching the selected ST width.
   For devices only supporting 8-bit ST, directly reject EXTENDED flag 
in all
   TPH_ST ioctl calls.

   Should we enforce strict cross-check between EXTENDED flag used during ST
   programming and the final active requester ST width during 
enablement? If yes,
   is the dual shadow table approach reasonable?

3. Virtualization logic for TPH requester enable bits with heterogeneous
completer capabilities
   Two complex real hardware topologies need proper handling:
   - Case 1: Single device with multiple queues routing TLPs to host memory
     and P2P peer memory via dma-buf flow; root port and P2P TPH completer
     capabilities may differ.
   - Case 2: Root port has no TPH completer support, while endpoint and P2P
     peers fully support TPH completer.

   I’m confused about how to virtualize the device’s TPH requester 
control bits.
   My tentative idea: take the minimum supported capability between endpoint
   and host root port. If root port lacks TPH completer, block TPH 
requester enable
   entirely.

   Is this the correct approach to handle heterogeneous completer capability
   across different traffic paths?

Looking forward to your feedback

Thanks,
Chengwen Feng


>
> Alex

