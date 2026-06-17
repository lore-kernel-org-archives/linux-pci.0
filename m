Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A21F7575;
	Wed, 17 Jun 2026 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781659852; cv=none; b=Y3DFJfNB9hsfzyrgEUUF6TTbg4PVuvH0S21D1h7rN32nLRRq79msKpfrXbKMZTgdiR4H/4OJctWClUiYAidv/Xkw4eZz95ayp3nUvLjUBOx1Nj/ibpjHWNsvg8BfPKlEE4WWVp6IWbZdzBnmYRwUWqlhIyDziwxjakMA9JRkzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781659852; c=relaxed/simple;
	bh=vXRCLLx+AJfpVBKthpROkIpnxRLu9slx41CkJRxl0xw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cuK6SF9MDzAGwzrtmRVuWRNPZVgk0UnhJm8XoJwW2FM9Fco4O5vXNd2WJfkhQgkX7XlHwCauQEfgdofwc48Yvmld44KK4h9pL6SOBUdne7S7rTxjQO1KNtaoQn9983FGSWyTHJhgKiUupSarZDwrUBWWwGlZKi7OPIfcMvBxYFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=AoIgdxFk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHvG8fm0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="AoIgdxFk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHvG8fm0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39BA37A018F;
	Tue, 16 Jun 2026 21:30:46 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 21:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781659845;
	 x=1781746245; bh=Hk/mJrt816vQzjV7UNfO1ovMRAjL57Mgt+8zt1Tyur0=; b=
	AoIgdxFk38H+IPkxmpXK15t+JXqXNYwC3NRR3so6sywo1E+rRzKtgc8itLH4dVNK
	oSg/lmthtg6rDg95qqxsbOo8ySwEFt4qqzdJo+zdaX+ksv/qj5HXJJTdTY5M8aHk
	AcLVn6qFnYmINnu4QXl6qgqZ8JvymcBSySBYFNlKKSC2YA6OiqQJhgE3H9FACOlO
	7x5zZHlLIT4LlRpRNS+J18KnX549p0BIM3fT/s+m2zSukg7gzPjaA8TimEKD9gMg
	ROwTjr62utWBHYIHTHvX0a/UCoVsJLaHkbgPWAmox5Xouj5pPxTqiBEs3g0KsyC1
	SjP4Ti0pggF0tQZbQ/uR5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781659845; x=
	1781746245; bh=Hk/mJrt816vQzjV7UNfO1ovMRAjL57Mgt+8zt1Tyur0=; b=P
	HvG8fm08DoA9Oiku5btCbObuyzeHuK7R8duL13JxvGTngFl60BJM928CT2UsvBoq
	+JN9ZuFoRyHfY/51E7Ut++yA5nun6hq56G/OkLYph+5MIg2Mtd04AB0tLd5/j7q/
	a3xmIu1Np/MEXO2wEeXYZNd09xRnxscUXJEv9aY7Hv1jwk6q58aoaq4w79BbeENr
	T6DiPei0a32HEie9B+OwfXvT6p9xoMYPwpDdaKciq7W1GfPOtn6KQ2dtziUDtKLo
	O9ZVSFWjAVN3F+Q1ZacIHl58wFXAx2XueQA59fVUgfvZhatlIqhUxWmcNWXFe+N+
	0icS5WX8ievtpkVJs/PPg==
X-ME-Sender: <xms:xfgxaov_APPJWtRpv3gWD3EKMp7VGuFoNzI8bT256Za3lqm8plj6pA>
    <xme:xfgxagSEtlbVcw3_67inCBK-sCOBwKtivmkLDqIuiiZuu8zUh5ZiujNZHvckEUHbC
    CXS6czJp4WlVqEKBMxlp9n2QobqIktyBXV2JbRjUfmmh3VY3WQ_>
X-ME-Proxy-Cause: dmFkZTEqvIVzSjLKK5ArE51NTBIgSwmBpUsnYudzeiPDoA3qbtKjOA1sP/dpMciunvMhTB
    QH40kcwD5iFjzNm3J+2yl2p+0yLJ9yK5A201knNGac1/r05xp4twnG8W3SrHhclNv9R8nB
    H94i1JpWbKhyg3y1B/u4ObyUcxOUTD8FQBiqFSG5k0BIeLb8cqZmn6C9EJZfpl8llXaLxY
    rGthGwdLGZi+De72Rz/hpmqHcXbH8efgLqzXWgm8c9zzdWGSpUklp7n+TQB6K68ij+VRJk
    7vTqq9oN7dDP08xzVgOel9XzqH8m4Esh0SAkUYz06mAZmDa6HCby71/d5+ybYRv9xlszjS
    wpKgiyOJHq/q9IU1D65wVLiL74+HdgTJBT5uD4qbyrwrst3ELubR+OqOaVp4T7QYcHLcpi
    ORiZSxiymQ8imKMm+hN4I4zjFHEablIizlIddKZRFzqjONGUQs5t+S5hRUd/0pECSYaJ4U
    0S7/QnIngR+1QGBSEpjRBhzC4JAXdw7NyitfLWmmZwKIYinhACgQEr44F9QkkKo7hkHs51
    B3SFNH9f77YM+IcQVi4OzWhGuLXtnFMWLu9mH87PXPr+ac9V3GaTjnyeWvxXYAeXDD4Vza
    MSNqrn6IkuADsbTvR77dCM02OAIRLpDY9O9/G1n9KjZHJ3MQgD1NYGBxmVhw
X-ME-Proxy: <xmx:xfgxasRlXISBsIQ5Aab3ZCCaCmkGfi-CpGWB5YfykCpnzZw0jxbZrg>
    <xmx:xfgxalo_Wh6z2N0eCDjc7w9zVd4DJFBV6gRioay3bFQsIgDF1-MS-g>
    <xmx:xfgxam3wGkROfVJOV5WN43JuWicjFqhnqwalJSH6U2fz3Lb80Dbuog>
    <xmx:xfgxak63JxspbFVQz5NT_pKmURoedXdlPKKAiCnR6cODQKvh6sm3rw>
    <xmx:xfgxatEzw2u98DS3a2F27AbyiK0QBAhnzcZoCQHwD3gJK7rRBOYnLbST>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F58C15C008C; Tue, 16 Jun 2026 21:30:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AnXwzOjrN2xN
Date: Tue, 16 Jun 2026 19:30:24 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: fengchengwen <fengchengwen@huawei.com>, "Jason Gunthorpe" <jgg@ziepe.ca>
Cc: helgaas@kernel.org, wathsala.vithanage@arm.com, wei.huang2@amd.com,
 zhipingz@meta.com, wangzhou1@hisilicon.com, wangyushan12@huawei.com,
 liuyonglong@huawei.com, kvm@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <a81c3479-1749-4b9b-b913-cfb20c621690@app.fastmail.com>
In-Reply-To: <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca> <20260616105754.784be22d@shazbot.org>
 <20260616172728.GC3577091@ziepe.ca>
 <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU to
 steering-tag mapping
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026, at 7:18 PM, fengchengwen wrote:
> Hi Jason, Alex,
>
> On 6/17/2026 1:27 AM, Jason Gunthorpe wrote:
>> On Tue, Jun 16, 2026 at 10:57:54AM -0600, Alex Williamson wrote:
>>=20
>>> IMO, this implementation in sysfs more so proves that vfio is the wr=
ong
>>> place for the interface.  vfio has a use case to consume STs, but it
>>> doesn't produce them or own any of the mechanism by which they're
>>> generated. =20
>>=20
>> I would argue only a VFIO user can consume this information so putting
>> it in general sysfs is overkill.
>>=20
>>> The weak point is whether this bin attribute, exposing an array of
>>> structures, fits within the socially acceptable norms of sysfs. =20
>>=20
>> I'm pretty sure this style of sysfs is not accepted and
>> counter-examples are things that are ancient or slipped through.
>
> After weighing all feedback, I'd like to propose a lightweight single=20
> text sysfs node
> design to resolve both your concerns, without introducing binary=20
> binattr or masses
> of per-CPU files:
>
> 1. Only create a single r/w text attribute =E2=80=9Ctph_cpu_st=E2=80=9D=
 on Root Ports, no
>    hundreds of separate per-CPU sysfs files;
> 2. Usage flow: echo target cpu_id into the file first, then cat it to =
fetch
>    formatted human-readable ST/XST text line (cpu_id vm_st vm_xst pm_s=
t pm_xst)
>    for that CPU, e.g.
>       echo 10 > /sys/bus/pci/devices/<BDF>/tph_cpu_st
>       cat /sys/bus/pci/devices/<BDF>/tph_cpu_st
>       and the output will like: 10 2 20 100 120
>    In the case of concurrent access, users can determine whether the f=
irst value
>    (cpu_id) is the one they expect by making a judgment.

That's a terrible workaround for an inherently racy design.  Thanks,

Alex
