Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836509;
	b=bpJ6EiqqHlThRY4KWN/9Oc1sH8VJC8Pf5xoGhM3YfuiLLmcWEDz/CZ+Lnl+pgez1nuWC
	 4tebWySrYNm9bhONXQlhkYWybcZsS2U9iGBRh6hvCGj0eesc38Ol854+0V8txvbF5cOXL
	 yHRb/sV2c1tv4jK6ltE/PtbBSud9Kd/mlzSbkdite6MZ0VXfwy7IxXMRgEuwIolzumUQD
	 4qpzNjwcv3wL9XZrrcl3JKoa7Hztmt2pWpddrp+ngZXDcqxk+QL6VJ1mBcZT0mwgck9FM
	 em1Sconv3JXZj/MU9OqDKykqF95WdOSgT4GdDVdoQrEhXR2uhaSkEeF5iilH86g8hFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836509;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yYM7ejxsK/WekSQzcvpWlw+4AYB+YcCjwMSG/SOGOJk=;
	b=1AdTPIKyBk+JV1D+PZcsUiE9J+fpmvGxc06IYOBvosW7jmgco9tjeTlagZxybE6KX9dm
	 E3lCO9ccFsg0hvtKR218qrc8Qzk29XrtLL1Du32k5uVh7rhoOnll/wgukR98rjbfRNPy/
	 ohER8UwgPqJjNYfiFqHCFnX1OH45B73IMC5ejHKAsltWMqQfH2Qc7rf+LYF6S66spgM/n
	 AU6oo1G1sxsYNb46PxoPmE/Lu6agaHfaJ5Q+d98iMgVwyQ1SX8XP8O9/Xt63Pfn63XHEH
	 /hmKl5KCddrxOHC5ox4lI2+L7RqjJmVG/VjYqplVg0daSbzAP8ETAjTlF7/0FpmX3Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b="CechH/Am";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jm9pkgSM;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AE606A32E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295AE606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=CechH/Am;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jm9pkgSM
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6308EEC016F
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 18:55:02 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 04 Nov 2026 18:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793836501;
	 x=1793922901; bh=yYM7ejxsK/WekSQzcvpWlw+4AYB+YcCjwMSG/SOGOJk=; b=
	CechH/Am7FoRjL0s4MQIPtlPmsahLDjvlrMmgnylMpORnFSGFm6QBvmBxtPZySgG
	5g3vuQnca2BTHdxRX8WoP9uNMWrIbYxB/NfSDq0XV1CvS/xGPKIbKuHojZ3liuUN
	R8aY98SsIC6L1mVzG5ARFqyso80Wc6TGxMD2htqBEhcmmT7U8m+8fQVTliwO86kU
	io5IqQeLsSJ53PTeikCmC9VHMjOUS0MHkXD474uVP4WwsxUkFfhlofA/flVPpTAL
	UrsM/CkecqPBuTL9xF6jBoTx15g4kkGaHWBJ0+3h+YXHUvzhSuH7fqsrlQ+Jr6VB
	4O3QofpFDFInoL3VCKAsLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793836501; x=
	1793922901; bh=yYM7ejxsK/WekSQzcvpWlw+4AYB+YcCjwMSG/SOGOJk=; b=j
	m9pkgSMCZAnwJ7WUUj3QPVLCsZhrNGwDk4+KboSBhan/8J3/0DGcQ82IEvFqyahD
	qzOWhrOodXPyl/+42BtfTyrzxqsPG87R80gVMeoWEr8hOfMqYFl/l0tWrJdUy27T
	hqzW3rwIV/eR42qnCB1/CMZ8YXrG+rsoWqosDF07mPpyyMXedKoniqksHTzAl3bC
	Y+F29UDYh4DKcrDcSoIYhBxBhnx3sQGfpy7tnlp60DLFKcX/8hAx5BDdgzxjHTgU
	g2tGRzxO0AQJF4xeLWkQv46DMEdlbsREaxWD29uuGDHySPgN8+qGxmU8puHFmsjJ
	bj/N2fQ7kQdqK8eXAlbrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793836501; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:zl8VDgNXBS391sOaA2zS8FxvwKoPSLeFacclDP/LqZiahQf
	izMbgQOBgwFxQX3xRJNfVNH76oJlfRTQ8D25v/gevEBomQYxDuqvhCWllHeW0M3u
	Bg0GZD5Xv4jFrCCMbpB0poC8z8pg5SnLbPF1rvNVNeUzutvwK/c5CWXGovu1HihK
	Q/85gLZcg51S3vaZBxgMEO30Cimv1Zzq0IARatasUAG9fH24kWxLZ1Wjkdh++tab
	/yAvBATvIemmQTh9LKW7K/1vp596dm0HIOmpo1xk3YMtuwBPSnaFRs06uCQF2Fq0
	+OnucWGkL9RCqF6SsKa49Mza2wIZc9lO40WgTNg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XZas14fJoJ1GP6E/uNaTPdeSvxw2wWI9h3CPHCvWWR8=:glQ7Lw/gMt67x2C7GFcaTEl3b0L1F8vJEOkBxaYyLpI=;
X-ME-Sender: <xms:1cXrarJrMFrUU34H3NjrnCkJMQ94i5U7a1IsV8BqNGbV7vu8OTCZJQ>
    <xme:1cXrap9YsFpu6Ce5a92UyAUpRWUwmwiVfI3UTadwdBiuOh0yfbp_KFZnPPERorxgJ
    V7PjR1EQppOyGt8tO-dZQm6RTs95vgoFp8lYMwDaWQGeKaS52AOeA>
X-ME-Received: <xmr:1cXrah9icHMuvkOp3VTQmbl3dpPlFAMRufuMA59CUB2XuwY7PokrZchNmSc6Tw>
X-ME-Proxy-Cause: dmFkZTFQmWAuqahbE0pU7ZTuuJsHZIRhSQMEWivxEPlFlpH9LDKL3f0KHYwWm3kkDEpyFe
    KrIpKhUJTT2veHkpGFwVlM0pHfrWR0W9oVTzRZOZhTl7xOES5AScVhzhYSfOhTXEQpAvcc
    qFWu/7yePZhpK3pLZNTeU21i45lZxc6ABrLUppX5Dl0BPjv1g4FHppts7mHirAQjCqicuS
    1dSg04ZjaiY87o4eBXyi9RkMV3jelgo6DKAvjm0R8Yo7AWD2LTJTSUYXEHvlVEvxPj+q5E
    aAtjYzpXQH3pIzygvZV8igknQwVvYdr2BJKiGXvDF2ux0t+g2WGM8+h4kCcKHaf+nBzbBp
    4/bOPxUPQElsv129anOgUcprtNLOzbjljvlRWdj1SZ6RIVbkePH9msVAyM/X4759JoSnDq
    VuXRlqNBxGBUDSTsroAze7586O3OB+eCBIcMbd+pCw97RgW9KgsgzCptPM9zvavG3hefzy
    RhCim3U3NDJKn4zTq/tIHljflyZnOfslnwspXio0gARRk0kom6S+44nEV/4IsBuy1ctDyW
    Nv5iz1bSWzUfqAUAJwfmZ/PD3YH6p01llbA7O/uH2YKHRSd4bJGpQTvkKWcu0Dpa6Euwup
    m2uq4Xt7a05KzPJjLb/NfPnWhz2RA88B1oklFS/+7VxfxWtiZmvty74OMOQg
X-ME-Proxy: <xmx:1cXraj9ZfX8n_0WBfKQGhRpa41x7B03iiq2kK7TzmD1Sd3tJ-SfhXw>
    <xmx:1cXrasIaMbJSxUWqY6u-zb67BIGbMGM1HvlDUCwKcfN-aB3fEAUNdQ>
    <xmx:1cXraoT7qO4xVFDOm-ECa2kTLKUEElip1_31VYLYKloVfXyzBESYXg>
    <xmx:1cXral_L8II1rVgDAJeThLDDOs3Wu8-c2Hnrs5jN-YvGPF2HTNoIrQ>
    <xmx:1cXravI-7dLaK3o5ritzLvtvUHF_8HQOjVFfBcYTyA2jpcJNFHZstyoZ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 18:54:58 -0500 (EST)
Date: Wed, 4 Nov 2026 16:52:56 -0700
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v6 03/31] cxl: Move component register defines to
 uapi/cxl/cxl_regs.h
Message-ID: <20261104165256.09860477@shazbot.org>
In-Reply-To: <20261016161839.2765592-4-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
	<20261016161839.2765592-4-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:10 +0530
<mhonap@nvidia.com> wrote:
> diff --git a/include/uapi/cxl/cxl_regs.h b/include/uapi/cxl/cxl_regs.h
> new file mode 100644
> index 000000000000..276f9361c840
> --- /dev/null
> +++ b/include/uapi/cxl/cxl_regs.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
> +
> +#ifndef _UAPI_CXL_REGS_H_
> +#define _UAPI_CXL_REGS_H_
> +
> +#include <linux/bits.h>
> +#include <linux/const.h>
> +
> +/* CXL r4.0 sec 8.2.3 Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE 0x10000
> +
> +/* CXL r4.0 sec 8.2.4 CXL.cache and CXL.mem Registers */
> +#define CXL_CM_OFFSET 0x1000
> +#define CXL_CM_CAP_HDR_OFFSET 0x0
> +#define   CXL_CM_CAP_HDR_ID_MASK __GENMASK(15, 0)

A local sashiko review asks if this new uapi header should include
asm/bitsperlong.h since __GENMASK requires __BITS_PER_LONG.  We include
the other two header dependencies, but not this one, so it's a bit
self-inconsistent.

BTW, current guidance on the Assisted-by tag: 1e035297ffda ("docs:
remove Assisted-by references").  Thanks,

Alex
