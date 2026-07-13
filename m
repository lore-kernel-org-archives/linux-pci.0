Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF4032FA2C;
	Mon, 13 Jul 2026 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964994; cv=none; b=LP21VdbfiN3zED+rhrtxEMhbqLHqfNO/swUghyv0MJIbx2H0lJE81k2cdsxCIrbNs25LhAaZFpMgS1LFDE6QUBVnvfMp+CFQlVKxtY6YZ4Ooer7spDj4XksOjE4o+MmESV7PEjKUqRiyKnke1QlbaxWu5M1UrxycwKP5Rphko0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964994; c=relaxed/simple;
	bh=l9xptwCqrDcL06hNlsfWMqewFLS3zCNKCJrPoFp78Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ACsIWo57gQMRx2F6TjWPdtmISI3KU4uWwWMHfNmZRZ7xx/+D3kPwJdxo0+mbIybcXIJs7YmpzfIVjWO0I8d36fox/RtP/15iGqOuIcixuPnm8b34WmGzW2OyjGN/alb/GKFkTG2AvFxN30UiNPxquzlP/rSpvPLkMpHfVTUgHbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Dv8C/l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Dv8C/l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1B21F000E9;
	Mon, 13 Jul 2026 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964993;
	bh=jt6It+v7z+tXpx1Z7OeXNKteySBBPvQKPn1/Qt4r5FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=C9Dv8C/lGyayTy+Fug0LPOFQy2hccYVCmLvkAyaF7kCWiT3G/CPG6Gze7vr0WUMEw
	 WNDwfh+7VsCHWtFQ40w3Gixzo21G/Z1pFarQ5zBBFegCOpDsmYOGbPw3r6SKH25c04
	 tRaReXfY4sWnGg0xqUbMDb5jD20OaA7KS6c9cHU42ZH6kO3xM/cFTWpGXnvn9IZMbD
	 AZIIXSMabIkcggdqizIwO0AB/WmiNars9yhd/CVosbvl+4PAfmPcuwlHhf+Fy4SnBG
	 pJGJr8li4zukZXJvuz7+jztQ8scI4tZsKfeE0jElKLM/wwnvLNh108edkfq01yuguf
	 XmCfmFkBrbNNw==
Date: Mon, 13 Jul 2026 12:49:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sizhe Liu <liusizhe5@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, corbet@lwn.net,
	skhan@linuxfoundation.org, bhelgaas@google.com,
	yangyccccc@gmail.com, jic23@kernel.org, john.g.garry@oracle.com,
	will@kernel.org, james.clark@linaro.org, mike.leach@arm.com,
	leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	wangyushan12@huawei.com, shenyang39@huawei.com,
	gaozhihao6@h-partners.com, yuzhichengcheng@h-partners.com,
	liyihang9@h-partners.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linuxarm@huawei.com, prime.zeng@hisilicon.com, fanghao11@huawei.com,
	wuyifan50@huawei.com
Subject: Re: [PATCH 10/10] perf hisi-ptt: Add decoder version compatibility
Message-ID: <20260713174951.GA1245033@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604075005.2219785-11-liusizhe5@huawei.com>

On Thu, Jun 04, 2026 at 03:50:05PM +0800, Sizhe Liu wrote:
> The hisi_ptt packet decoder now performs detailed field-level parsing
> of TLP header DW2 and DW3 based on the message type classified from
> DW0 (added in the previous patches). However, trace data recorded
> with older versions of the tool does not contain the information
> needed for this detailed parsing, and should continue to use the
> generic field-name-only output.

Add blank line between paragraphs.  Also applies to 05/10.

> Introduce a version field (V1/V2) in the auxtrace info record to
> distinguish between the two data formats:

IMO a blank line here would also improve readability.  And consider
indenting bullet points a couple spaces.  Also applies to other commit
logs in this series, including sample formats.

> - V1 (legacy): auxtrace priv contains only PMU type. DW2 and DW3
>   are printed with generic field names only, no message-type-based
>   field decoding.
> - V2 (current): auxtrace priv contains PMU type and version. DW2
>   and DW3 are decoded according to the TLP message type (MWr, Msg,
>   Atomic, IO, CPL, Cfg) with detailed field names.

Could use imperative mood, e.g.,

  - V1 (legacy): auxtrace priv contains only PMU type. Print DW2 and
    DW3 generic field names only, no message-type-based field
    decoding.

  - V2 (current): auxtrace priv contains PMU type and version. Decode
    DW2 and DW3 according to the TLP message type (MWr, Msg, Atomic,
    IO, CPL, Cfg) with detailed field names.

> At recording time, set the version to HISI_PTT_DECODER_V2 in the
> auxtrace info. At decoding time, determine the version from the
> priv data size and the version field:
> - If priv_size >= V2, read the version from priv[1].
> - If priv_size < V2, assume V1 for backward compatibility.
> - If version is unknown (future), warn and decode auxtrace as v2.
> 
> Also add the version to the dump output alongside the PMU type.
> Adjust hisi_ptt_pkt_size position to adapt to compilation.

AFAICS this series adds new functionality and probably doesn't qualify
for "stable" tags, given the documented rules.  But I think the
maintainers are pretty aggressive about backporting things anyway.
