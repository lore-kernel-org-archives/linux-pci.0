Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B03B6344
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533945; cv=none; b=BO11APfqRko0sTxNx/ijuCAUDH6a7zIBvdJgbSZHbzZZu0/lQIAMs/peZKdKLV1Rawj4/GvAPZIbE55qOKgolkC1eW2fsU3j2jf2EPQ/b6AMXUvQeLxv3Q9tA0Fli2dy6WglyPpEV0G6zNYqAc/EZx29MYLvs5vyzlDTzDkEAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533945; c=relaxed/simple;
	bh=7RJ0AJSfor2EK5+EHKeonrhr/lPYVx0n0MzKPeGG3ZU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VGEBMcfx+lIcXiPUeY8kmWdq9QHiU3bmGH+tGHQm/Vb8dBBFu5dNbquYoAQ3RTgpNyOwyS85mVPuMtMh3Gd7P5DH4BvoG4fQFNx+cHCXfFom2WExFn3cBTp1kW9MWfjAQff9a7TqNjuH5UTz4yNR9uJF/wRbmwpeszNMvou8hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W68L2crZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W68L2crZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35061F00A3A;
	Wed,  8 Jul 2026 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783533944;
	bh=bhXwMTkUSSq2OJoCn7WgiPArt66XK0WJrB9Eloi8zpE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=W68L2crZFlEp7LOYfEcAscpDxPdNa1cyb3dDupeGZY17SS1pi8Inru5ULjOXugyOK
	 VJkYoBmixbY+i3zp2KedqQWIhyeQs6V9xu1KFWiJElPh3hAx2FX/GSRXv71tUa0J6A
	 rbQ0fiqZd4NdvtC/ywWJgKpydq/XWR1RcUmVnNaYnSzpVbAvQ+TvMSVoAxcXczzmvO
	 JXkwayzrMIfk2VzeiLo2smRYL0OzK+kSwDfJLIuM4LpsFSZzNmT/7lABxP23fkZt48
	 z6y1/KrWIWDoW0ZDSfT4N5pJABJFPTXUesgjBcm5ey3RoIyKGir3mgknWH24WbdsU8
	 MHJbX3pXG1kSg==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E8A9AF40069;
	Wed,  8 Jul 2026 14:05:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jul 2026 14:05:42 -0400
X-ME-Sender: <xms:dpFOahFVH9kUbn_VSwpkBEu9amkLKzXqsv6_6D2jE9ZrYaDBtqxjDg>
    <xme:dpFOao5eJPUDEhyHpA0gncnfIdEPbLA6zFn0df3cQ4azY2V-uf3yrXpRstOJ2lK8n
    sMXqd_14o621h4AoJBTVndi8tgsOMuAxrWWdXDGiq_ENUPPgU0a9gU>
X-ME-Received: <xmr:dpFOamyrdeN8-VBWwH8rvfnZM6cgutAcpqGXuxyuhhb9USs5IsNxqhMfoegqOc7P6aXRZQuTjnAgP-3jj5SR8vPHRAQtIw33ADM>
X-ME-Proxy-Cause: dmFkZTEFaEUhNLvrhUThmXUbGqg50RweRZBFQcLslRIC/ETno4DiIGyeFSHgZZbyIBr1WG
    fjPr+S9dkFDcEqXY1Dlu52Kz6LAr6ewnvlDg4Llg1KqETu8Hx0RzYLDoVNMjIACdlMh8mW
    5qwIusQeFP51D3Gda1c+/pelBKRI4egqVi9gUKAIkpa1kMmXUJ/1+I6opoQNyuAb5PHsOL
    sOcN3dpcZB8VYm0r2rK6VO7NC4Edfx1JPzsijGxDActMggmfSssXpZ9CnjT6fC7HORSe5M
    CGhpShst4URst+1l7UJsFVjktsh0/6gFpANBiXkIpcoND4LHKyBZYpTIs8E9RAjMHahKnH
    CjT7oURQujYqcNN56ftNGQoKqMIqjsWnCPsd0y6FrvxL3dMZlA62jczCGWrGnxQ30qEYSt
    b6hW0g60gG1J+CMuxTkkeR/CdrdUuT5BEiGL/QAWJ+hvOJ7jWGVVRbemEnWs3jrKFC8ecj
    mFzLeCPke8Ikl8OMVvJiXd4Konvi7JPGyUMYRgCR6nXsMvtYp5znSTpgSgH9fES64BYhPT
    rlexfTgKBEcQvAAcfn/dFgCjyIn1c6Nv+8x8dIHtmXDNQTLnz3FfmDwPftkROKI7KTUdsK
    3uW36WXHdjyfnH6x2msduw9KDTBDWoVhYymeJO1hPVYACNMj3E1DERSIUAVA
X-ME-Proxy: <xmx:dpFOanO6OU51BlVNKelosIX6KptzuNmX9uET57MPvUkvXCeQBJlpjg>
    <xmx:dpFOasnkm0kBT0k9zESDeyt4fTRqQe2otvQepwTweNt29xOpNHT8ug>
    <xmx:dpFOasS12q8I8Jk18US1EpkG6pp-OM4k-PDjiDY43raHgLKmOub4Ow>
    <xmx:dpFOarV4JLGE0juHv7waDVHK5x0cH1qzvJawg8w76Xq10d7G6e49kg>
    <xmx:dpFOagLqoeW1dlL7OL0k_SW_x6nxMFh4rM9l7S1jZcRGrQbjFToR7lBb>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 14:05:42 -0400 (EDT)
Date: Wed, 08 Jul 2026 11:05:40 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>, 
 Dan Williams <djbw@kernel.org>, 
 linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, 
 driver-core@lists.linux.dev, 
 ankita@nvidia.com, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Message-ID: <6a4e9174e2747_2f3f241001e@djbw-dev.notmuch>
In-Reply-To: <ae911d3b-682f-4c92-8f8d-d0d667388740@amd.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-16-djbw@kernel.org>
 <ae911d3b-682f-4c92-8f8d-d0d667388740@amd.com>
Subject: Re: [PATCH 15/15] PCI/TSM: Add relative MMIO offset support?
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexey Kardashevskiy wrote:
> On 6/7/26 08:08, Dan Williams wrote:
> > The RMM specification, DEN0137-2.0-bet2 section A9.6.2 "Realm validation of
> > device memory mappings" documents the expectation that the
> > MMIO_REPORTING_OFFSET chosen for TDISP Interface Reports is always BAR
> > aligned.
> > 
> > Ideally this change is not needed and all implementations share the same
> > expectation.
> > 
> > If this semantic is already shipping in production and/or the PCI-SIG
> > clarifies that an implementation can hold this assumption then Linux will
> > need to ask the TSM drivers for this hint.
> 
> We are changing it on SEV-TIO such that the host os calculates the
> offset to allow TDISP_OFFSET_BAR_ALIGN and passes it to the PSP during
> TDI_BIND (==interface start), others did not need it in the first
> place so I guess we can drop this one. Thanks,

Ok, yes, then this one can be dropped.
