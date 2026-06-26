Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059AB2D5C7A;
	Fri, 26 Jun 2026 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487361; cv=none; b=e7z+ei/53Mi+Zo/7QyNpldtf/zOW8CgBhWoukqbH7ihOfKfTe6xRLrbsIVx3o8SZ5fHLmwrylPEtgul5OoLrUMAvk6ow2CO68+NW+Uqnxn8rbVcD4ygeZNI0XcjMU2aOU9zk0O7rysZsjHglxtuMjbJM5v51AgAHzs3ZMrmbip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487361; c=relaxed/simple;
	bh=0JMYGlfTTSUEMjWsq22/Ug5CVvpU6u8qi/T5yUHqXPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aiUqkyhoOQakBcpQREMyiIjPOvVsTHiHemf61GHt5evRUryCcpF/Ww5B4aTIhXB7TYx0hLDD7Tk3BVJ1QGaElHV8iIBgZFV3KIZn2p0NtJJw3r9/063NBaQGMbjvb1k8hH0UVJRTgzzvY702XRKHThgOnwZhpTavocHAFoDHKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=UTgF4KqZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pgmd552c; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="UTgF4KqZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pgmd552c"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 075C01D0008F;
	Fri, 26 Jun 2026 11:22:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 26 Jun 2026 11:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1782487357;
	 x=1782573757; bh=Ub1TUYMxqQ4Z/O3yCkwOxsFlDlUTO7zgJLJGZkSwxAI=; b=
	UTgF4KqZ6lNirDTRbNIHzm7xFn0lJzvD8yqCFitEphm2ZUg3Vb5UltnLY2Xs8RFI
	vsm5zVRc2qgVDb7b7sRc+OOgBEmmfgKdOr2KNgBIXTis8xNFOCTVeQZ4c4CisZm+
	ih7iNNzu20QkFJf/Dk5h8V6ntLRAF2nXVrpQJBTnycsVo9L0p5DZbACK9Bnw/CRB
	4QUvCha7unQs3Zk/hiWRLDzTLHJZIR/dsB9F0W8MQN2hmI7W06oxVR1bT3D994wC
	72t0mNYlgrAEFLRS7E9qU2LaVTPyb5FNMLcWiqjrYiYjsC+b3Pt0A4bgGC1x35n9
	ZncWpNgHE3WWY+y6UC/ZOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782487357; x=
	1782573757; bh=Ub1TUYMxqQ4Z/O3yCkwOxsFlDlUTO7zgJLJGZkSwxAI=; b=P
	gmd552cTon5zOxd+2arSuSisQKvuhqlIfkgGvHONk10KJV9RGlypkWC8Fz8DYgWN
	7XPlxU8BAVph16izf+8VDeru3kBj1gVIb9iYDDFeMGuqoUOxSLdW69OqJoIucIX4
	QclA/pZ8WBDZxNnHZ+AGy3vuRQDeEVo+nvMX8i7o24f50a6QSHBcmR+9wufC5xL2
	0YfSJL4J0pI6kQ+Dm5OfR85ekM3rlyEowzO0PR4Bi23otuvzyJ4pbS+Uaz3vVzLp
	wRQCokkKRcecYV8MTq+l70pIdDCZDClRqH9eX4iv96/9c+Y2UVHiNsvzrZOvbnlm
	XfH9ZEhhcXvV+QjJjPzDw==
X-ME-Sender: <xms:PJk-amxLosCJtf6pHqBIajF0pn1dkAiy6wp4R6lgHmuSqg61FY7y2A>
    <xme:PJk-aj1iGzfpfMtH39M4x11_nLY_4XyTERXc7qt_s8NfyhUt6aO8OgjLyyPmbvmhW
    qlj8fHpIxOfi1eDsC2gWTiudGt9VyZyCGLD82K9c3RXAkl-ikl8gQ>
X-ME-Received: <xmr:PJk-ank4ss0ApDcd1k1MpH4TdjiVj_Q3sbi9IswT63bgo0ggauWZmHM7pDU>
X-ME-Proxy-Cause: dmFkZTFpCNkEjLgUfWOImPtPAiOgwFxmuoWIeJu7YAJgRGN8l9wmZYSmq1zjWSfwGGVv7/
    aw1ivSietmgQ1oYeruzEp6xvo092EID0xF4gXELAnoB5aQeRn6FBSoJg2xMTiM80yqaYCQ
    iiHoF0bRCq55mj9AF06q/4fz4Xr12DQwOmDK3Etnq8D3uqtS8L34HiE5qDjS0/9G/z4zqi
    myFCBkGBuK6IPxIMGqmQCAtbHHEt5rBN4B7WR3bIEIMav87b5TzAfVASr1HE4XUqF2dHib
    N3+wadnajCggPm16O8pEHmeuLQUwsN2vfMrkD/Go5XX9ztnJKeg6nfxbjtopYu8Jk6MpKu
    GvKtCvvMw8eS9aIFRQfWtKdwkSwlhNINI64g4TAcUch8gbnIatBERMsEDaY0QaX+oxrtFf
    cS1t0/H81loa+JfCDV/8k0JIyy8mTkPOIgx1ZyM5IZuPeO8gxrXbUSY68hzD9xby7C3jfQ
    /upBUTBEjH5Bkq13lOhHlkD+Mj/mVM7n3RE+jXD1/vUb9NE0AOiIGFAc0Fe6+39DHU7/1K
    pLS1sE5Q30QkpdSUaGqUkvqILn2B8SjiwLbZbuzvZFfbPaIIZWwYGos4qWsIQWy0VoiWl6
    yGUm3ZDV+OrN5pilhTC5uo5YlPQxKf1Ih7vkSxDHhitHm3qIlLE7Yt8kPehQ
X-ME-Proxy: <xmx:PJk-ai-TKdxoxXo59e6f8r3McZXeKMa3J6rZ_sz-sAVrFKa9EQ0zVw>
    <xmx:PJk-atLy3FKMZhnuW6HVP0KbiSlQP6sRdOzeyVxWCy23nbII4D2t5Q>
    <xmx:PJk-aviNPhKqBuc2XoJHQOOFrd5bA1BvMpo5SymTn_IPjorO8EiPjA>
    <xmx:PJk-ah9kv2VmFXukVrEoBuDS151nfsFjcPZgUOhPWFHniCVhnL8dfQ>
    <xmx:PZk-atkuu3G77S1jC3rc_J28Nh0MXKMWutUcSoRUPfBQoy-t_RczoWWi>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 11:22:35 -0400 (EDT)
Date: Fri, 26 Jun 2026 09:22:32 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 alex@shazbot.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260626092232.53ed3a7c@shazbot.org>
In-Reply-To: <9105ceef-5e27-4e3c-8903-d46aef52a2bd@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca>
 <20260616105754.784be22d@shazbot.org>
 <9105ceef-5e27-4e3c-8903-d46aef52a2bd@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2026 17:56:51 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
>=20
> I=E2=80=99ve sent v18-resend of the PCI TPH sysfs patchset with all prior=
 review
> comments fully addressed.
>=20
> I remain open to both discussed implementation options. This v18-resend
> implements the sysfs binary blob approach on Root Ports as you previously
> suggested.

There's a problem with the pci-sysfs binary attribute beyond whether
it's acceptable from a sysfs perspective: it only solves the CPU-ID to
ST lookup.  We already know that this interface should support dma-buf
provided TPH ST and PH values from Zhiping's series.  If we take the
pci-sysfs route for CPU-ID, no subsystem exposes the value embedded
into the dma-buf.  Another solution is required.  Repeat for each
possible ST/PH source we might see in the future.

Therefore, I'm coming around to the idea that vfio-pci provides this
interface, but we need to do so in a way that it's not a wart on the
side of the interface.  I think we can do this based on an incremental
progression of features and support, where the ST can be provided
through an extensible set of objects, CPU ID, dma-buf, no-preference
(zero), and literal user-provided ST values.

The key components of the uAPI are similar to ones you've proposed:

 - An opt-in/feature flags (SET/GET): VFIO_DEVICE_FEATURE_TPH

   The TPH uAPI necessarily changes the ABI of the vfio-pci device;
   capabilities and control are virtualized.  An empty SET is the
   opt-in to the ABI change.  There are also feature flags necessary
   for uAPI surfaces not discovered through the PCI TPH capability, GET
   on this feature returns a flags field indicating supported features.
   (SET actually takes a zeroed flags field for symmetry in the vfio
   device feature API).

 - A mechanism to program indexes in architected ST locations (SET):
   VFIO_DEVICE_FEATURE_TPH_ST

   This includes flags to define the type of source provided, such as:

    - VFIO_DEVICE_TPH_SRC_DMABUF
    - VFIO_DEVICE_TPH_SRC_NONE
    - VFIO_DEVICE_TPH_SRC_CPU_VOLATILE
    - VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT
    - VFIO_DEVICE_TPH_SRC_LITERAL

   The requested namespace for the tag:

    - VFIO_DEVICE_TPH_EXTENDED

   And a failure policy, ex. if a translation results in zero, no-pref:

    - VFIO_DEVICE_TPH_REQUIRE_ST

   This would also include a start/count and pointer to user buffer to
   allow batch settings, if the TPH subsystem can be extended to
   support these, otherwise a single u32 holds all the decodable
   sources.

 - A mechanism to decode a source (GET): VFIO_DEVICE_FEATURE_TPH_RESOLVE

   This is necessary for DS mode, where the driver may store STs in
   device specific locations, but also for dma-buf sources even in IV
   mode, where the PH needs to be decoded for the driver's use.  This
   proposal also extends the API, through progressive opt-ins, to
   support virtualization, where a VMM may (in specific scenarios)
   implement a _DSM returning host values, and write through literal ST
   values from this source, or from a guest-based userspace driver for
   a completer, where the guest kernel can source a valid ST.

   In order to prevent this from becoming the side-car/wart, returning
   ST values is limited to configurations where the resulting ST may
   actually be used within the interface.  For example, No-ST and IV
   mode would operate only with DMABUF, NONE, and CPU_* sources, the
   literal ST need not be exposed to userspace.  The RESOLVE feature
   would be limited to returning the PH value for a DMABUF source.

   The structure includes input fields of u32 flags and source, output
   fields of u8 valid (bits declaring each of the next fields
   validity), u8 ph, u16 st.  Flag bits are defined the same as for
   TPH_ST, modulo NONE, LITERAL, REQUIRE_ST are not applicable and
   reserved.

With that rough uAPI, we can step through an incremental support path.

 1. The most basic level of support, and default sans module options,
    is No-ST mode.  After opt-in, the TPH capability is virtualized to
    report only No-ST mode supported, the remainder of the register
    zero.  Writes to ST Mode allow only 000b.  Writes to Requester
    Enable allow only valid, non-zero values.  In combination, this
    enables the device to operate only in No-ST mode.  The TPH_ST
    interface is inoperative in this mode.  The RESOLVE interface only
    accepts DMABUF sources and only provides the PH as valid.  This
    allows only the PH aspect of TPH to be used and does not risk any
    exposure or malicious use of ST values.

    NB. All modes, including this one, must also validate support for
    all reachable features through to the root port, ie. TPH Completer.

 2. Via a module option (proposed below), IV mode can be enabled where
    supported by the device.  This allows the unvirtualized interrupt
    vector mode supported bit, ST table location, and ST table size
    fields to be exposed in the capability register, and allows 001b to
    be written in the mode select control register.  Additionally, this
    brings onboard the TPH_ST feature, supporting a selection of
    source flags.  NONE and DMABUF can be assumed, based on sequencing
    of the dma-buf based TPH completer support series.  CPU sources
    rely on root port _DSM support.  GET on the noted feature flags
    above can indicate this support.  LITERAL is not enabled at this
    point, this mode only supports ST programming via objects and
    instance numbers.  RESOLVE support is identical to step 1.

    Via SET of TPH_ST, sources are decoded and ST values are written
    directly to the ST storage location.  The REQUIRE_ST flag indicates
    whether the user accepts a translation resulting in zero (no-pref)
    or if the API is to generate an error on this result.

    Support for translating CPU_* sources relies on platform support
    for _DSM, while other sources like DMABUF have no such requirement.
    Therefore, for this and following steps, the returned flags on
    FEATURE_TPH GET will include a bit indicating whether CPU_* sources
    are supported.

    There are some important considerations to resolve/document here
    between the TPH specification and Linux implementation, such as
    requiring TPH is enabled (and for MSI-X vector location, the
    programmed vector is enabled), before the TPH_ST.  We need to be
    particularly careful of a uAPI that relies on mutable
    implementation.

 3. Again, via a module option, DS mode can be enabled where supported
    by the device.  On such a supported device (and only on such a
    supported device), the device specific mode supported flag is now
    reported unvirtualized in the capability register and the control
    register supports writes of 010b to the mode field.  The RESOLVE
    interface now supports CPU_* as a source.  RESOLVE will now return
    both the PH and ST for a DMABUF, indicated through both valid bits
    set, and the ST for a CPU ID, only the ST valid bit set.  The
    TPH_ST interface still accepts only DMABUF, CPUID, and NONE for
    configuring architected ST storage locations.

 4. Finally, literal mode can be enabled via another progression of the
    module option.  Literal mode allows the TPH_ST feature to accept an
    actual, raw, ie. literal, ST value and also allows RESOLVE to
    return a valid ST even for devices only supporting IV mode.  This
    is intended to support VM use cases, such as a VMM configured with
    1:1 vCPU:pCPU mappings that exposes a _DSM to the guest with host
    CPU ST values, or if a completer exists in the guest that provides
    ST values through a dmabuf.  This is the only mode that allows
    writing unchecked ST values to architected ST storage locations.
    The user discovers support for this mode via a LITERAL flag
    returned from GET on the TPH feature.

The proposed module option is therefore a progression where the user is
granted increasing privilege to make use of STs:

vfio_pci_core.tph=3D:
	0: No-ST Mode (default)
	1: + IV Mode
	2: + DS Mode
	3: + LITERAL

It should be noted that even in IV mode, the user can R/W the ST value
via mmap covering the MSI-X vector table and could read the value in
the capability storage location unless we explicitly prevent it.
Removing the latter is trivial, removing the former costs reverting
previous decisions to allow mmap of the MSI-X vector table for
performance, esp. in larger PAGE_SIZE systems.  If this is an issue,
(tph >=3D 1) would need to reintroduce sparse mmap for MSI-X, but higher
tph values already allow for increasingly direct ST programming.

In general, while the proposal here presents progressively increasing
access and direct use of raw ST values, this access is not considered a
security issue.  TPH only allows addressing specific caching
structures, it does not present a correctness issue.  Abusive use of ST
values is at best a QoS issue, where access to a device capable of
these features imposes some inherent risk of exposure.

The feature ioctls therefore take this sort of form:

VFIO_DEVICE_FEATURE_TPH (SET/GET):

    struct vfio_device_feature_tph {
            __u32       flags;
    }

    @flags is reserved (0) on SET, returns VFIO_DEVICE_TPH_CAP_* on GET:

    #define VFIO_DEVICE_TPH_CAP_CPU             (1 << 0) /* CPU sources res=
olvable (_DSM) */
    #define VFIO_DEVICE_TPH_CAP_LITERAL         (1 << 1) /* LITERAL source =
available */

VFIO_DEVICE_FEATURE_TPH_RESOLVE (GET):

    struct vfio_device_feature_tph_resolve {
            __u32       flags;          /* IN: VFIO_DEVICE_TPH_* source + n=
amespace */
            __u32       src;            /* IN: CPU id or dma-buf fd, per @f=
lags */
            __u8        valid;          /* OUT: VFIO_DEVICE_TPH_VALID_* */
    #define VFIO_DEVICE_TPH_VALID_PH    (1 << 0) /* @ph holds a processing =
hint */
    #define VFIO_DEVICE_TPH_VALID_ST    (1 << 1) /* @st holds a non-zero st=
eering tag */
            __u8        ph;             /* OUT: processing hint */
            __u16       st;             /* OUT: raw ST (DS presented or LIT=
ERAL) */
    };

    @flags is common for both RESOLVE and the following TPH_ST feature,
    bits are allocated according to their order of introduction.  Some
    bits are only applicable to the TPH_ST interface and are reserved
    for RESOLVE:

    #define VFIO_DEVICE_TPH_SRC_DMABUF          (1 << 0) /* dma-buf fd */
    #define VFIO_DEVICE_TPH_SRC_NONE            (1 << 1) /* write ST 0 (TPH=
_ST only) */
    #define VFIO_DEVICE_TPH_REQUIRE_ST          (1 << 2) /* modifier (TPH_S=
T): stop on
                                                            resolved ST 0 */
    #define VFIO_DEVICE_TPH_SRC_CPU_VOLATILE    (1 << 3) /* CPU id, volatil=
e memory */
    #define VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT  (1 << 4) /* CPU id, persist=
ent memory */
    #define VFIO_DEVICE_TPH_EXTENDED            (1 << 5) /* modifier: Exten=
ded ST
                                                            namespace */
    #define VFIO_DEVICE_TPH_SRC_LITERAL         (1 << 6) /* literal ST value
                                                            (TPH_ST only) */

    The source type must be uniquely defined, therefore only one bit in
    the source mask can be set:

    #define VFIO_DEVICE_TPH_SRC_MASK \
            (VFIO_DEVICE_TPH_SRC_DMABUF | \
             VFIO_DEVICE_TPH_SRC_NONE | \
             VFIO_DEVICE_TPH_SRC_CPU_VOLATILE | \
             VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT | \
             VFIO_DEVICE_TPH_SRC_LITERAL)

VFIO_DEVICE_FEATURE_TPH_ST (SET):

    struct vfio_device_feature_tph_st {
            __u32               flags;  /* IN: VFIO_DEVICE_TPH_* source + n=
amespace */
            __u16               start;  /* IN: first ST table index
                                               (IV: interrupt vector) */
            __u16               count;  /* IN: number of contiguous entries=
 */
            __aligned_u64       dests;  /* IN: @count __u32 (CPU/DMABUF/LIT=
ERAL;
                                               unused for NONE) */
    };

    Batching here is intended to shorten the TPH disabled/quiescent
    window, but this is not currently supported by the TPH subsystem.
    This could degrade to a single inline entry if necessary.

    Batching also introduces a risk of partial success, where some
    sources may resolve, while others generate an error or are promoted
    to an error based on the REQUIRE_ST modifier.  The proposed
    solution for this is to allow vfio device features to return values
    other than 0 or -errno, as currently described.  This interface
    would adopt a solution similar to KVM_SET_MSRS, where the ioctl
    returns the number of successfully programmed entries.  Therefore
    if (ret =3D=3D count) the full set was successful, otherwise the user
    knows exactly which entry failed.

There are various intricate details involved in validating
configurations where TPH can be enabled, and I'm glossing over the uAPI
dependencies on implementation versus specification, but I think this
provides a good basis for exposing TPH support on the device.  I'd
strongly recommend the incremental enablement stages proposed here,
even if we stop before LITERAL support based on current use cases.
Please comment if there are gaps or anything is unclear.  Thanks,

Alex
