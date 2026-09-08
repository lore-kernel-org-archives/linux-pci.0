Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341543F8252;
	Tue,  8 Sep 2026 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901367; cv=none; b=iP0e9ymPRVJW8d4iMSJjDYJn4Ktqa+yCnoWK5QlY8Ct4zcRWGpXi8eR9Ldre4uSAeNaG76FxPO58SEYONm+VggeLpeZNEykNoPO6GsJRWpggynqC8GyuZzdwDNVnR3n+b2sbRYUlRWMrtnUoVNNV5/ro89tvWKQ+zHxVl+cgF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901367; c=relaxed/simple;
	bh=etGFNzryVHVIzhzIbWKVACbTFB0Fz5j+NBDjhPIvoYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDU57mGSwIckPWb3EW/jt3T0/IPzk/niHs6K4ZE4O0xfYDo0TCfRbE7POVMzNMMmUlKGe/n/aG5tFlXY8jtrUrWPkFIE9BH1AB56tg46d7LJvyb/Z+dk7cLqOBeADpRfmEZIwzcf+EWq1DBrEfAYZN+5iBBrvyVyUsKcMcXtlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfpLzjEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfpLzjEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7731F00A3A;
	Tue,  8 Sep 2026 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901361;
	bh=I1nTJJBN0/8Z3vREycaem0mdZLGZl8Q52gVbOoYMerY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PfpLzjEFh+YzweqpMsSnGG9nwRUxroZS6gFkwEHTj3mq1YzSe5uND/Uhcd0u8mAFj
	 shvFN9Hyi67FW3zR0+u0oV5tagVTmWfIPwHWh9bVV1Nbh53L1ttUdhi9Gu/AMehuTe
	 JljHe5fyWsA04oan5Ozd8olgrloRiUED0cnZbLhXCkpNh3zzt40q1mZkRRu6QjEkZz
	 yLDsKI+L8GaEDb3uWH+uou03ztcNJ1tLfkUL/s4B3gB+rGrK6p2I2zVdKzpXFwFsJg
	 mDNRepvV2unRPWVExIvkBegwGWqo1uBtYvUhTZvFPdy7LanRwaKX6LFvR6vcKFaEgc
	 yQ23sn4FI+MoA==
Date: Tue, 8 Sep 2026 18:02:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sizhe Liu <liusizhe5@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, corbet@lwn.net,
	skhan@linuxfoundation.org, bhelgaas@google.com,
	yangyccccc@gmail.com, jic23@kernel.org, john.g.garry@oracle.com,
	will@kernel.org, james.clark@linaro.org, mike.leach@arm.com,
	leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	wangyushan12@huawei.com, wuzongyu1@huawei.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linuxarm@huawei.com, prime.zeng@hisilicon.com
Subject: Re: [PATCH v4 0/8] Enhance TLP packet decoder with field-level
 parsing and versioning
Message-ID: <aqB37YCMUYKodo3N@x2>
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908140509.2485649-1-liusizhe5@huawei.com>

On Tue, Sep 08, 2026 at 10:05:01PM +0800, Sizhe Liu wrote:
> The original hisi-ptt-decoder only prints raw hex values with generic field
> names for DW0/DW1/DW2/DW3, without classifying TLP types or decoding
> DW0/DW1/DW2/DW3 fields according to the hardware-defined packet format.
> 
> This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
> decoder in perf tool to provide detailed field-level parsing of TLP headers
> based on message type, and adds a versioning mechanism for backward
> compatibility both in hisi_ptt driver and perf tool.

Series is sashiko clean by now, has a Reviewed-by, but it touches both
kernel and tools, I wouldn't have a problem if it was processed by
whoever maintains the kernel part.

- Arnaldo
 
> ---
> Changes in v4:
> - Add missing space in hisi-ptt.rst (Sashiko).
> - Widen the pattern bit field in struct hisi_ptt_trace_ctrl (Sashiko).
> - Add protocol defined TLP header length parsing in patch 05/08.
> - Add MRd and DMRr message types parsing in patch 05/08.
> - Add comment for enum hisi_ptt_pkt_msg_type in patch 05/08. 
> - Add DW0 and DW1 fields analysing in patch 06/08.
> - Refine bit-fields parsing of DW0/DW1/DW2/DW3 based on different requests
>   in patch 06/08.
> - Refine the description of pattern=1 in the document in patch 07/08.
> - Extract the bit-field printing of v1 version into functions in
>   patch 08/08. 
> - Link to v3: https://lore.kernel.org/linux-pci/20260903075241.1445338-1-liusizhe5@huawei.com/
> 
> Changes in v3:
> - Add explicit inclusion of <stdbool.h> (Sashiko).
> - Make patch 07/08 apply cleanly to mainline (Yushan).
> - Pick up the reviewed-by tag (Yushan).
> - Link to v2: https://lore.kernel.org/linux-pci/20260827140442.2031128-1-liusizhe5@huawei.com/
> 
> Changes in v2:
> - Split patch 01/10 and patch 02/10 from series v1 into independent patch
>   series for backporting (Bjorn).
> - Use bitwise operations instead of C bitfields for cross-platform cases
>   (Sashiko).
> - Add `pattern` parameter in hisi_ptt driver for layout compatibility.
> - Link to v1: https://lore.kernel.org/linux-pci/20260604075005.2219785-1-liusizhe5@huawei.com/
> 
> ---
> Sizhe Liu (8):
>   perf hisi-ptt: Abstract trace data buf and offset
>   perf hisi-ptt: Complete the field names for 4DW and 8DW packets
>   perf hisi-ptt: Extract the raw data printing part
>   perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
>   perf hisi-ptt: Add parsing of supported message types and proto length
>   perf hisi-ptt: Add field-level parsing for header DW0/DW1/DW2/DW3
>   hwtracing: hisi_ptt: Add pattern PMU config for trace format selection
>   perf hisi-ptt: Pass pattern version to decoder for compatibility
> 
>  Documentation/trace/hisi-ptt.rst              |  26 +-
>  drivers/hwtracing/ptt/hisi_ptt.c              |  25 +-
>  drivers/hwtracing/ptt/hisi_ptt.h              |   4 +
>  tools/perf/arch/arm64/util/hisi-ptt.c         |  18 +
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 593 ++++++++++++++++--
>  .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 241 ++++++-
>  tools/perf/util/hisi-ptt.c                    |  51 +-
>  tools/perf/util/hisi-ptt.h                    |   9 +-
>  8 files changed, 872 insertions(+), 95 deletions(-)
> 
> -- 
> 2.33.0
