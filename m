Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5D366075;
	Thu, 27 Aug 2026 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864298; cv=none; b=ImliQo9ngzeXlAnSmi3rbOtyLoR6K7O8j0RpZz5dPbET0PSXXEMqxx5Ou0aBD7xHttdWbRYcza0aH3/8+GHY3BIo0i50acpSNjOw/STQcRPH1og2wkD/7u/RPmlUaYnjjjx/nZNyE1wbV1TBbJkSsSVwCWBIm1wul09FHsRJT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864298; c=relaxed/simple;
	bh=/TlWKr4McZNs1ASGXrHzvfLJ/Uf1Hj2JbyuuDXtkYbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNsDNc2LZDWt7kYtIMtdELkMIh9XnqriRHMNwb1jBuch5lkRJZDfxbMc4hXugzEOoUBM8cvrrxsOL4OYpZ5ByYEm7eHwAiHkBm/4Ay+skf5WnjWLQNBKuHAbKeTuRLd0+5eszX6Byib+Md3D1Gmmsg9S6zI8kA9j9MsL5kHnIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=ZMlXfAyT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aESHjVrn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="ZMlXfAyT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aESHjVrn"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 90C221D00147;
	Thu, 27 Aug 2026 16:58:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 27 Aug 2026 16:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787864294;
	 x=1787950694; bh=OA0cEuqmAckaSq+6h/IJOeNtvGP1snmO6+q9qzzYAgo=; b=
	ZMlXfAyTgOldy3c8Xai4i5hvFONRufht8GlHX3oHZsLGzf1mJU5wwXPJV+hz2pRk
	cFOuw5l6IpNQf4LvnyihmWyIYyq2QRD7fVexrdcjru6Grsfy1J0df6pZ3puVO7A3
	adPkALX/nGHDeGXrUyt/HbsvAl3N2+WX+o1Fcv930saTl+Bv1BKEe5wX3RthQN2F
	ySCdowzWzM7IcGd5fzWOdCqCio7tl3eQvOPcsAW4kUKEdT7khRemmZ9XjALwF/2h
	BwqWyRjFFQObF1jWnGqwzP/+Rfqtevyrnsl5Yk/0XV+P3bd3QliUicvLVscnxD19
	kNZiDyvtxF2WgPJiYZtmTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787864294; x=
	1787950694; bh=OA0cEuqmAckaSq+6h/IJOeNtvGP1snmO6+q9qzzYAgo=; b=a
	ESHjVrnCvk/1eHHB7bczM3QYOiXLPDe1rDvYbGVWidzlnyS2bJRCqd6DkLxR+Cc8
	rkANGPM5xSmIBxxEPTluxzYJn2KcMPHQaIS/Gz5RCrSweBTKR6V47aUE6pzb8Nin
	6YQqtJAFYDsEyh546KyufzI/0qKSBDbn6MLV5iRdI8pmuRZ6cTSbwkJw+n88KWSJ
	6D7FfyO0KfS4j4rBVmBlGxTFSqgHfEssqor07NbWk52mnuLx+M2iZ8gDj4dPwwXF
	LlFyMWL2ZVal2CMybKgYS2WKjWbp3+WSNamEkvAW/qQ6hZWIzO2OMmFFp/BB1/w7
	nF5ixTFbrufi+VgEadvZw==
X-ME-Sender: <xms:5aSQaojeUWmHxJWDpYOZ_PZaHXrOZHprkI8uMLFT5gna4SIwUZgzSg>
    <xme:5aSQauqqyci5wrblJPatdNdyd9wZdS41rEpXAS5WInJoSVyNlUKOeOGdtyIU2jXCL
    E0iK-FC_g6qlMLK0EBnSmd8VyqWLHJgeK-KmSM08Mqim9xOHB33DQ>
X-ME-Received: <xmr:5aSQaneTXPi4mJtBfkt2Fdz-kCxwqkcp7jDutMjJbYfeqX3i-8ykDTvmebZpnA>
X-ME-Proxy-Cause: dmFkZTGeDunkvp1BFFT1T4/3lfPMwi85rhuTfg+DHrBStwGaAV66WEnFYJCB8LFq0MsKI8
    6BeCr3nuBhMVV7ksec53XgaRybwClucYOZ82e6dyTVCxaC3OmvvmnsjlNzI8KoXSOsAhC7
    1qkH4Y1lYrPVWjqC89t9/IOeZY3XZbOpfz0pXJUc4ZlpD3H7KsieqmSuN/lmIfXDDnWaCs
    r8Ajzm2XNNaJQ2nPl9RQcmUeBzfu0ZH70dk0erzjASgkbuJFjAuaqMGaZicdw3JYmECnN0
    4K6wikgOp592ilQ8IYN6noOsqm/t5fkMwaFvVkFimm4GhptC1qwuUTNNCUOltUl2jwR5Ql
    o68g5WbM+WZ0tnHiJmQAhB5dCctjb99+3WJIvalGLAp4b5jEArGXRabdGR4UJXgTBfQRgF
    BvM6Y9JMItHGyyAov54AZ+B5BHsCdxEU9hacjZ1z8MFpaQQ94uUx/ecYXalpe0cKXpekx6
    lE/R+Nd2bkXwP1Id/Guk9u66vAd/pz2evweFurFWAL/SawRAzvwetZSWyGkmDphxuHzeC/
    I7skzzihYmlCYjBjS4odscVlBT/skFKvEvwPt01QZ0qi6BFRdrPWNgaCrBlkM70N4OXERP
    YAZjwPFDjAYSZZgunJv0KCnxsCjE+0cvvL2bM+MpEoWo/VZzPF93eXuNB/Zg
X-ME-Proxy: <xmx:5aSQaheAw-FLPQOz_ZMfdG4y7gDUFw6iMFWLc1PLIRtm9t6InMb4KQ>
    <xmx:5aSQatfrbdbJ1DEQ5y9oeu7-P6hY2yzPZiHo_ZXlES8ulvTUo7peGQ>
    <xmx:5aSQanoVdM4WnTQRDB2ihU3lw0t7hw9XxmFf6dvhmxBYbky596bJIg>
    <xmx:5aSQatwLD9YCAromQMZ0M9dGWkjWHGHCY_oFgsGo4NxqvNmO55CqGw>
    <xmx:5qSQagrrDpITEbhi_3ClZj9L6FyaJTWeT6WXxSKbdGb1O0nkqFx_pNey>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 16:58:11 -0400 (EDT)
Date: Thu, 27 Aug 2026 14:58:09 -0600
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
Subject: Re: [PATCH v4 10/27] vfio/cxl: Reject unsupported decoder
 topologies at bind
Message-ID: <20260827145809.71bcca71@shazbot.org>
In-Reply-To: <20260813093631.2288172-11-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
	<20260813093631.2288172-11-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 15:06:14 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> The guest drives a single virtual decoder whose memory maps 1:1, so a
> device with more than one HDM decoder, or an interleaved one, cannot be
> represented. Turn that assumption into an explicit refusal at bind rather
> than a silent misprogramming later.
> 
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 125e11354a46..7edc53b25576 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -36,10 +36,30 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
>  	if (!pdev->hdm)
>  		return -EPROBE_DEFER;
>  
> +	/* The guest drives one virtual decoder; multiple are unsupported. */
> +	if (pdev->hdm->decoder_count != 1)
> +		return -EOPNOTSUPP;
> +
>  	hdm_size = range_len(&pdev->hdm->settings[0].hpa_range);
>  	if (!hdm_size)
>  		return -ENXIO;
>  
> +	/* Interleaved decoders are unsupported. */
> +	if (pdev->hdm->settings[0].interleave_ways != 1)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * The guest drives resets through the CXL Device DVSEC and polls the
> +	 * shadow for completion. If the host cannot service a function-scoped
> +	 * CXL reset (no reset DVSEC, a multifunction device, or no HDM reset
> +	 * support), that guest request could never complete, so refuse the
> +	 * device rather than advertise a reset the guest would poll on forever.
> +	 */
> +	if (!cxl_reset_capable(pdev)) {
> +		pci_err(pdev, "vfio-cxl: Unsupported device: host cannot service a CXL reset request\n");
> +		return -EOPNOTSUPP;
> +	}

Why does this particular error deserve such a high priority log while
we silently fail the other two cases added here?

These don't seem particularly noteworthy to split into a separate patch
versus rolling them into the previous.  I'd probably also group the
easily testable EOPNOTSUPP errors before we actually start evaluating
things like the hdm_size.  Thanks,

Alex

> +
>  	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>  					  PCI_DVSEC_CXL_DEVICE);
>  	serial = pci_get_dsn(pdev);

