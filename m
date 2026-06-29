Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD9337BA6;
	Mon, 29 Jun 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747814; cv=none; b=D7ise+PW4DMCW8ls8Jz+XdD2VrbyX+Yr0sDPieYp/x12XrLA9rora3emqpgPIn6c0jKmfOmsprzq3DQvw7PKWCuD34mVLMD75TK0k9Ev6Bxuv4KaBl0UY80Qf1FzIPAhj/u6tdkxXwMLwuxOQbFA/mabh54U1lF0uV7wuugjAVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747814; c=relaxed/simple;
	bh=5Y4BEJ8zwWvQTQHdqVwuTQLfjjB+iTFJRFh5ABHDOtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJFb75OfJbgjRE5PB3LW8iUrOMsJYvoqzp3RJddgfL4A7dC/wKCsm59wKtHrmmOnpgxvagcSJOyYRZgnytwjYCRJxMfdntxUfWwONuiRxpU4pOEytZTVPGQ03kVE5nazR3CU4awG0+K/1UbVGHFRWE93MwOvU4HdlMyl5eyXGyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=D0uvl3Eh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjcQppJ/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="D0uvl3Eh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjcQppJ/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E605EC00DB;
	Mon, 29 Jun 2026 11:43:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Jun 2026 11:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782747810;
	 x=1782834210; bh=oBO9AlUgesLs7bhNb3C7hDuAqAmu4BXNEtMP6hAnZ4o=; b=
	D0uvl3EhJ2nxveUtN2hJABuHyt+1M1gZkjd6hx+VrZ79ppspk5Zn0zuH/NpLm/hc
	CwKh4yas4SWqU+drQAVxeDibCwX/IpLtw9lLwqqby9v8HPdhbVqMVQZLK6so2poi
	7TO7572grW3nAW45CsbvyRCcFC8l3A+o++DFEFkPymQwKrbeOsRv6AJvQ7LCn+zG
	FBYdi6I4RGibX25tYuUOVZpFeI6ryAr3V8dmE60hYKUSps/Zd+maIIHUNYtw3AiS
	PIiZW3KmIX3K4JYuxbFwoh1DR2F+D7BxADAFpaHwDDdbwV2Z2VShshhCiwKv2BK3
	TgEc1/IiEX5eIPWV9dcumQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782747810; x=
	1782834210; bh=oBO9AlUgesLs7bhNb3C7hDuAqAmu4BXNEtMP6hAnZ4o=; b=Y
	jcQppJ/IxGqBduXNk/9nPJbAhKjzZG4cBAmmjPD6+1RgX85V/+M3whIYeESWrYUB
	rD0jdyS+pLhqgW6MscCYM2SOKC3C4LgBDo4aAhXOaOUmickDvPedenGdR/g/Idfc
	dZNj3XNYSIQbk/adwd3YuKSuqfBujLYGIPiJO1R4SBPt+16AU7Hku8OIw+JYLlP6
	qXbUaPQ2IDfk2KnknO3ilLUh8M6UAmRLt0+0z0fA5UjsMMuZClZw/9KdvWFZwHPH
	XhADZ7GI1j7EFnQjPhcTthkvSehWU/t8j3g2Q2YW0cNkyT6mdWxL1tapLfEnYSTA
	RjMWqCRC+bUm6CHFJzjOA==
X-ME-Sender: <xms:oZJCaqn7E7GYlbrjvtza_sKhXD9RmAacgQtAFB_ovUUZMJc71i4_jA>
    <xme:oZJCajY6FhobIvyFza-_UKKsPuo7h1FdmiY2urwjj52wTumc7ul89uWH1QSl1qkY-
    eJJMkbw0NzZrT1Dhquw0UR1PxgALCvoTV2cidwW3UIleLI4vMV5Rak>
X-ME-Received: <xmr:oZJCan7jFdj7sGXn0tIYLLRt3ll4K48EAzul60vsYJfv2FDo1IN8j3Rhch4>
X-ME-Proxy-Cause: dmFkZTEHn75k5CFgeznKWlGGIrXbvs7qL+tjerljiXXOxMghxwvyGDwfT2S9oP9uhlX1A9
    tuC4l6Vby03CawJ4JK7jAm/X3lKp5zXwWo1fjjxHIy6M/eEuqVh+q5JDBzJCLyESFMau0y
    NVjUBZn4gCX0hkV0YU14kuqtEO9MwCJqgHvoJ3CJIwhaQ1ukdtTAKzLNJzJB1sG9g4kqSh
    WhMHVxxBDHlZsrHs7aNm8PWsIvtWajeti0lzUrCXNV+b+GLyyUPmTzH7bF1UzRFHD0YogB
    hmYlKsWmhEiWBpHeQpQmSCkXVtheO5p2FLys8xbSdIhP6bjBClZyhEBtl3zP+JDoZxVBVz
    stZNU8ReUms4iutYZ8bWlZUVpBX2I64Fp8HSnjhsd68LRspWKO6AqftAsEhvCk4TX2m9jm
    zsl3i3DXHeDmp2xy7BV2Ivz55DDyAOXx9IwHijY7/fL8Yx74yPNkGJ9HABwbf6j9zmW20C
    OWJ+6lknm/hd/b/4ebBK1PlAMeGCzm4CVWKH+Lg5gsNQpTl/r+wnA4oeKvz9J1+oxDrQRq
    /aw/lu8FdKwcJXZAfRBuY9AnVCUL41CopXHHUM83HtzC6Q5hF9Ym9czDDuYt+FBsWL+x2Y
    QXMFK6wN9nnVMnBVm2uAWUgB/0vvof0FKiPiFrt5WTL/9tv2iKlyJFdI/CLw
X-ME-Proxy: <xmx:oZJCalDi29KAquSyCPTfi9VtRyzDDkp_NPIGd4nkt2TMhkFN2oTxIw>
    <xmx:oZJCat9JTCCBufPxC8iNE087OOX_B257OMbgP8PRmIqqZaE8VzRQyg>
    <xmx:oZJCaoFM2BiKXwxM2Kg3eX504Rr9PQtF6cErSMCyUvVWIgivyiB4mA>
    <xmx:oZJCanSasMq-HTDje7cIMomZF91S22UiBChdb9T5QXSp-GSMLc1_wg>
    <xmx:opJCalYc49Sc2tAqYUmjU7LvPTXEXnTj9Zh-DBF3DqibJNVdziyu_MCy>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 11:43:28 -0400 (EDT)
Date: Mon, 29 Jun 2026 09:43:26 -0600
From: Alex Williamson <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
 <wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
 <wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 alex@shazbot.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260629094326.779ab0ff@shazbot.org>
In-Reply-To: <5b389fb6-7d0e-8fea-1fd9-b873efc028c3@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
	<20260616104621.41915-9-fengchengwen@huawei.com>
	<20260616144224.GB3577091@ziepe.ca>
	<20260616105754.784be22d@shazbot.org>
	<9105ceef-5e27-4e3c-8903-d46aef52a2bd@huawei.com>
	<20260626092232.53ed3a7c@shazbot.org>
	<5b389fb6-7d0e-8fea-1fd9-b873efc028c3@huawei.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Jun 2026 19:58:09 +0800
fengchengwen <fengchengwen@huawei.com> wrote:
>=20
> Thanks a lot for your extremely detailed and professional design breakdown
> for the unified VFIO TPH uAPI framework. I=E2=80=99ve fully gone through =
all your
> design points and aligned my implementation plan accordingly. I have seve=
ral
> key implementation questions to confirm with you as below:
>=20
> 1. Plan for dma-buf TPH metadata storage
>  =C2=A0 I plan to add the following TPH-related fields into struct=20
> vfio_pci_dma_buf
>  =C2=A0 in my preparatory patch series, which can be fully reused after Z=
hiping=E2=80=99s
>  =C2=A0 dma-buf TPH patches land upstream:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 tph_st_ext;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0 tph_st;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0 revoked:1;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0 tph_st_valid:1;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0 tph_st_ext_valid:1;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0 tph_ph:2;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8=C2=A0 tph_ph_valid:1;
>  =C2=A0 The tph_ph_valid bit is newly added to track whether a valid PH v=
alue=20
> is bound
>  =C2=A0 to the dma-buf. Is this field layout and validity flag design acc=
eptable?

In Zhiping's design, the PH completer validity is bound to the ST
validity.  In my proposal, the user makes a request relative to the
namespace, EXTENDED set =3D 16-bit, clear =3D 8-bit.  Internally we do a
.get_tph on the dmabuf based on the requested namespace and get back
success or failure.  On success, the full PH + ST is provided to the
user when running with DS or LITERAL capability available, otherwise the
ST is withheld and only the PH is provided.  I don't see a need to track
the ph validity separately.

> 2. Validation rule for VFIO_DEVICE_TPH_EXTENDED flag mismatches
>  =C2=A0 The VFIO_DEVICE_TPH_EXTENDED modifier you defined is an excellent=
 design,
>  =C2=A0 letting users select either 8-bit base ST or 16-bit extended ST w=
hen=20
> hardware
>  =C2=A0 supports both variants.
>  =C2=A0 But a mismatch risk exists: users may set ST entries via TPH_ST w=
ith=20
> EXTENDED,
>  =C2=A0 then later enable TPH requester in pure 8-bit mode only, causing=
=20
> inconsistency
>  =C2=A0 between shadow config and active hardware mode.
>=20
>  =C2=A0 My proposed solution: maintain two separate shadow ST tables insi=
de VFIO,
>  =C2=A0 one for base 8-bit ST and one for extended 16-bit ST. When enabli=
ng TPH
>  =C2=A0 requester mode, activate the shadow table matching the selected S=
T width.
>  =C2=A0 For devices only supporting 8-bit ST, directly reject EXTENDED fl=
ag=20
> in all
>  =C2=A0 TPH_ST ioctl calls.
>=20
>  =C2=A0 Should we enforce strict cross-check between EXTENDED flag used d=
uring ST
>  =C2=A0 programming and the final active requester ST width during=20
> enablement? If yes,
>  =C2=A0 is the dual shadow table approach reasonable?

We've abandoned the apply at enable-time approach in this proposal, TPH
must first be enabled in device config space.  There is also no
buffering of user values, they're written straight through to hardware.
If the user has enabled only 8-bit mode, then a TPH_ST with the
EXTENDED flag set should generate an error.  Likewise, if the user
calls TPH_ST while Requester Enable is 00b, this generates an error
regardless of the namespace.
=20
> 3. Virtualization logic for TPH requester enable bits with heterogeneous
> completer capabilities
>  =C2=A0 Two complex real hardware topologies need proper handling:
>  =C2=A0 - Case 1: Single device with multiple queues routing TLPs to host=
 memory
>  =C2=A0=C2=A0=C2=A0 and P2P peer memory via dma-buf flow; root port and P=
2P TPH completer
>  =C2=A0=C2=A0=C2=A0 capabilities may differ.
>  =C2=A0 - Case 2: Root port has no TPH completer support, while endpoint =
and P2P
>  =C2=A0=C2=A0=C2=A0 peers fully support TPH completer.
>=20
>  =C2=A0 I=E2=80=99m confused about how to virtualize the device=E2=80=99s=
 TPH requester=20
> control bits.
>  =C2=A0 My tentative idea: take the minimum supported capability between =
endpoint
>  =C2=A0 and host root port. If root port lacks TPH completer, block TPH=20
> requester enable
>  =C2=A0 entirely.
>=20
>  =C2=A0 Is this the correct approach to handle heterogeneous completer ca=
pability
>  =C2=A0 across different traffic paths?

In case 1, this is why it doesn't work to allow the user to buffer per
namespace STs to be applied based on the value written to Requester
Enable.  Register value 11b allows the requester to operate in both
namespaces simultaneously.  The only governance we can provide is to
disallow EXTENDED STs to be written when Requester Enable is 01b.

The peer completer's capability is provided through the dmabuf.  The
user can ask for the requester's preferred namespace, use the alternate
if available, or fail if there's no compatible namespace available,
which includes no .get_tph support.

In case 2, we're gated by the Linux TPH implementation and carry it
through to the uAPI.  The overall TPH feature opt-in needs to depend on
both TPH support in the requester (the user's device) AND TPH completer
support at the root port (unless the requester itself is a RCiEP).  I
had missed elaborating on this requirement in my write-up.

I'm glad you're onboard with the design, please let me know if any
further clarifications are needed.  Thanks,

Alex
