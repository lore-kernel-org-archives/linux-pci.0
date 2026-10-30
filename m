Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373435;
	b=ujREvBSylOsWr19aLg1unOVGYAsuJ883g39SMqu6BjMrdAHGEIrDO/JHe1z0SctPIe79
	 TlPEGfzc9SmiB4o3RNxnp6ik7zuFSNdqeg0gzZ09mAI2ZlPpK9T4TGDeyp6BPKccwxXfL
	 p1fetPG5zR2M/t1LwHJ39fTByhd5u1zfRkv+buMjtAau+ff1INhZHDCRqw522UI7i6cZA
	 5m233Lb//w43QD9IAq/RXEQQtKGIsGUR9N/ARTSt1xUPqUkM4u5zJv0hId/chsohjHhWk
	 t+G+VQh+TSLf09tgq+CdUDEfVkYmKX2+4GC2NBwRytbEs/ne+u1Pi4Qm8XbL3/rb9aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sIU8CDTfsSV0E97VvcGSPbXyGHw92fm5udRdTkpjaSk=;
	b=igkI02ic7MvewxO28T/aRsOxcwiqu8c3MSgzCOqELFMBOQN7Muyh2JuNX63LFjN+CEiY
	 Yspntw/SMucSoFhlrRQiF/3Ic08xRf22sh5i1lr8Y6BkZ5zG3NFDAQtMHy5ihYfCk998y
	 tAAl+QtOA5nfUe3cye6guwq7Lu0bPRde+S1Eto8Qsq6pWI71G2n/vPcIMuSYL0nn8Ts1K
	 KMHPJxXxhOAsjTSEf85AAp3AnspNjKAzLQTAD//o08bSpMDrHWVxh/H4gfKoB02flq1k/
	 7LxmFrHYw35C9/jngTPUgtp2sWyf8PGRRekwApznF3sWlA6tPACdznxufP+E3JoJYPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoeKkhKe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8337606A31E;
	Fri, 30 Oct 2026 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LoeKkhKe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A9D1F00A02;
	Fri, 30 Oct 2026 15:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373434;
	bh=sIU8CDTfsSV0E97VvcGSPbXyGHw92fm5udRdTkpjaSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LoeKkhKe/WWsB+z8yuibYhAL85SMCgrtxxO+KUZzBucMUgNUgKA4d4i860097DnST
	 yBbXiBG3yJ1jn1qoOv8f3/5aArv8LyGjoGgxM1KU7VAH3DPshg79BF1WvBier6/XQd
	 76uSi81rpexoR4NYBxUE4JEWkEuWnU8N+kCMVCUxXudEYet9QK0njKr29EORP+tR97
	 RDHLZfc2ynRiVpoJsPNYdnHVR+ir47wbo+p15zwovPEoADyz2Wdrebx9S9bcik0gnS
	 9gFMBFnOYtjdDiMeURcDbU91r/cZ7xlAGRGefefpSCnmZEFaglro+RxiX4p5CHPIAR
	 ucNnssRgblUag==
Message-ID: <sashiko-outbox-191148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] dmaengine: dw-edma: Add trace support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030150742.2586776-6-den@valinux.co.jp>
References: <20261030150742.2586776-1-den@valinux.co.jp>
 <20261030150742.2586776-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:17:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] dmaengine: dw-edma: tracepoints use edma_ prefix instead of dw_edma_
--

commit 8d4bbe2d0d3de12559142ae2213cc91782526216
Author: Frank Li <Frank.Li@nxp.com>

dmaengine: dw-edma: Add trace support

This commit adds tracepoints for linked-list publication, descriptor append
and completion, and doorbells in the dw-edma driver to help diagnose stalls.

> diff --git a/drivers/dma/dw-edma/dw-edma-trace.h b/drivers/dma/dw-edma/dw=
-edma-trace.h
> new file mode 100644
> index 0000000000000..653b36acff158
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-edma-trace.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright 2023 NXP.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM dw_edma
> +
> +#if !defined(__LINUX_DW_EDMA_TRACE) || defined(TRACE_HEADER_MULTI_READ)
> +#define __LINUX_DW_EDMA_TRACE
> +
> +#include <linux/types.h>
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(edma_desc_info,
> +	TP_PROTO(struct dw_edma_desc *desc),
> +	TP_ARGS(desc),
> +	TP_STRUCT__entry(
> +		__field(size_t, nburst)
> +		__field(size_t, start_burst)
> +		__field(dma_cookie_t, cookie)
> +		__field(u32, id)
> +		__field(u8, dir)
> +	),
> +	TP_fast_assign(
> +		__entry->nburst =3D desc->nburst;
> +		__entry->start_burst =3D desc->start_burst;
> +		__entry->id =3D desc->chan->id;
> +		__entry->dir =3D desc->chan->dir;
> +		__entry->cookie =3D desc->vd.tx.cookie;
> +	),
> +	TP_printk("chan %u%c desc %d nburst %zu start_burst %zu",
> +		__entry->id,
> +		__entry->dir ? 'R' : 'W',
> +		__entry->cookie,
> +		__entry->nburst,
> +		__entry->start_burst)
> +);
> +
> +DEFINE_EVENT(edma_desc_info, edma_append_desc,
> +	TP_PROTO(struct dw_edma_desc *desc),
> +	TP_ARGS(desc)
> +);
> +
> +DEFINE_EVENT(edma_desc_info, edma_complete_desc,
> +	TP_PROTO(struct dw_edma_desc *desc),
> +	TP_ARGS(desc)
> +);
> +
> +TRACE_EVENT(edma_doorbell,
> +	TP_PROTO(struct dw_edma_chan *chan),
> +	TP_ARGS(chan),
> +	TP_STRUCT__entry(
> +		__field(u32, id)
> +		__field(u8, dir)
> +		__field(u32, done)
> +		__field(u32, head)
> +	),
> +	TP_fast_assign(
> +		__entry->id =3D chan->id;
> +		__entry->dir =3D chan->dir;
> +		__entry->done =3D chan->ll_done;
> +		__entry->head =3D chan->ll_head;
> +	),
> +	TP_printk("chan %u%c done %u head %u",
> +		__entry->id,
> +		__entry->dir ? 'R' : 'W',
> +		__entry->done,
> +		__entry->head)
> +);
> +
> +TRACE_EVENT(edma_fill_ll,
> +	TP_PROTO(struct dw_edma_chan *chan, u32 idx, dma_cookie_t cookie, u64 s=
rc,
> +		 u64 dest, u32 sz, bool flag),
> +	TP_ARGS(chan, idx, cookie, src, dest, sz, flag),

[Severity: Low]
This isn't a bug, but since TRACE_SYSTEM in drivers/dma/dw-edma/dw-edma-tra=
ce.h
is defined as dw_edma, should the event class and tracepoints follow the
subsystem_event naming convention and use the dw_edma_ prefix instead of
edma_?

Specifically, edma_desc_info, edma_append_desc, edma_complete_desc,
edma_doorbell, and edma_fill_ll export global tracepoint symbols under the
generic edma_ prefix (which is also used by drivers/dma/fsl-edma-trace.h)
and are invoked in drivers/dma/dw-edma/dw-edma-core.c from
dw_edma_ll_consume(), dw_edma_core_ll_start(), dw_edma_start_transfer(),
and dw_edma_core_ch_doorbell().

Renaming them to dw_edma_desc_info, dw_edma_append_desc,
dw_edma_complete_desc, dw_edma_doorbell, and dw_edma_fill_ll (along with
their callers in dw-edma-core.c) would match the TRACE_SYSTEM name and avoid
generic edma_ symbol names.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030150742.2586=
776-1-den@valinux.co.jp?part=3D5
