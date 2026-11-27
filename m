Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792341;
	b=gtjOFSmXPv4m4jkUiw1VGVu27zsLxYs/1uflFSP/4iFFHGGt9Tr3mBMF4diQi87jYwfC
	 dAfo18kSqLJdhjrelXkwvKuUytoUDAOFfTZ8QakRFIv3P/B6SM06pWkZLUkRwzgO6uTcC
	 sbXOm1hcIrSUuhsqlToelOUskX0fP/A9SbFuKck7w5jPY8/EVhtPXj6SoZB4E3piy1qOq
	 nRb5F95qyRHhU7qVViEFIDV2NNaJMaeXthsSZ+EZ5G4y+2QIOMxmMLkq4ls0TI+YERkYg
	 khZvrAcSYyh29vdOMkj3IzZ1Ui6Hs5/7j5UhphD5cUw+RtG+apK/1PByDyQKgsl5MUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792341;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=hG1UcIeD5kDsTZ/j31mkrP5xd0P4UvuVoAKHdexqypg=;
	b=5pRJku3gVLJzeKp0T6uZK+vNt66P52nR7G84MT++P4IIwPLk+ZKC01Fp7uOVFPvxEGmi
	 FPPK1Km2Qlgi7QVxpDZ6vzxCaOE9RzrxBfP9n1P74K+MCRI9Fn6UAWWi/2SBSHQa2usRD
	 6ucPmY4vTMwq0CEOZ9dAtfDt9Sz5n6DCt3iXEpbPwgFevljrL2wEHvxO+6zI4OSnwbEMF
	 TViWkw8gbPsR1bNz7zwLZPykWoUkL1Gk0VtrPJCpRiI6/XH38oXE0WWRG3tUZRrbFpmy1
	 KF2QB6jnd1ew/L9giR5GDb38hUXxi+GqH5O851mfNPRG8bPRAFOI53sF/GRSTOiShzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Aliu6mPB;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8A606A336;
	Fri, 27 Nov 2026 15:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C8A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Aliu6mPB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEC59169E;
	Fri, 27 Nov 2026 07:12:17 -0800 (PST)
Received: from [10.57.71.121] (unknown [10.57.71.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391CF3F632;
	Fri, 27 Nov 2026 07:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795792340; bh=UhKmPuC8DACVoypwIe16TXINMMAoEKBWaFZcV9+dSjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aliu6mPBwYN5HSMdptjc8jnPjK5BOd8wx9RKcKPyfNS43GcRQaSwUj25U3P1SnHAG
	 8xkH6zd4yykKSeWXRHwyLkTXOsmF5IqkPe4GzVXq7CVj3Yqh+r31vXJuppbFq1Fwe1
	 qxHQdEPjVzc2b7w4z6dBLBzE+oViDmSYGQd/rozE=
Message-ID: <b1733f2a-ed03-4f38-8c40-6e0e535f1632@arm.com>
Date: Fri, 27 Nov 2026 15:12:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Enhance TLP packet decoder with field-level
 parsing and versioning
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sizhe Liu <liusizhe5@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org, bhelgaas@google.com,
 yangyccccc@gmail.com, jic23@kernel.org, john.g.garry@oracle.com,
 will@kernel.org, james.clark@linaro.org, mike.leach@arm.com,
 leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, wangyushan12@huawei.com, wuzongyu1@huawei.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linuxarm@huawei.com, prime.zeng@hisilicon.com
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <aqB37YCMUYKodo3N@x2>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <aqB37YCMUYKodo3N@x2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnaldo,

On 08/09/2026 22:02, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 08, 2026 at 10:05:01PM +0800, Sizhe Liu wrote:
>> The original hisi-ptt-decoder only prints raw hex values with generic field
>> names for DW0/DW1/DW2/DW3, without classifying TLP types or decoding
>> DW0/DW1/DW2/DW3 fields according to the hardware-defined packet format.
>>
>> This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
>> decoder in perf tool to provide detailed field-level parsing of TLP headers
>> based on message type, and adds a versioning mechanism for backward
>> compatibility both in hisi_ptt driver and perf tool.
> 
> Series is sashiko clean by now, has a Reviewed-by, but it touches both
> kernel and tools, I wouldn't have a problem if it was processed by
> whoever maintains the kernel part.
> 
> - Arnaldo

Please could you add your Ack on the series, so that I can pick it via
Coresight tree.

Suzuki


>   
>> ---
>> Changes in v4:
>> - Add missing space in hisi-ptt.rst (Sashiko).
>> - Widen the pattern bit field in struct hisi_ptt_trace_ctrl (Sashiko).
>> - Add protocol defined TLP header length parsing in patch 05/08.
>> - Add MRd and DMRr message types parsing in patch 05/08.
>> - Add comment for enum hisi_ptt_pkt_msg_type in patch 05/08.
>> - Add DW0 and DW1 fields analysing in patch 06/08.
>> - Refine bit-fields parsing of DW0/DW1/DW2/DW3 based on different requests
>>    in patch 06/08.
>> - Refine the description of pattern=1 in the document in patch 07/08.
>> - Extract the bit-field printing of v1 version into functions in
>>    patch 08/08.
>> - Link to v3: https://lore.kernel.org/linux-pci/20260903075241.1445338-1-liusizhe5@huawei.com/
>>
>> Changes in v3:
>> - Add explicit inclusion of <stdbool.h> (Sashiko).
>> - Make patch 07/08 apply cleanly to mainline (Yushan).
>> - Pick up the reviewed-by tag (Yushan).
>> - Link to v2: https://lore.kernel.org/linux-pci/20260827140442.2031128-1-liusizhe5@huawei.com/
>>
>> Changes in v2:
>> - Split patch 01/10 and patch 02/10 from series v1 into independent patch
>>    series for backporting (Bjorn).
>> - Use bitwise operations instead of C bitfields for cross-platform cases
>>    (Sashiko).
>> - Add `pattern` parameter in hisi_ptt driver for layout compatibility.
>> - Link to v1: https://lore.kernel.org/linux-pci/20260604075005.2219785-1-liusizhe5@huawei.com/
>>
>> ---
>> Sizhe Liu (8):
>>    perf hisi-ptt: Abstract trace data buf and offset
>>    perf hisi-ptt: Complete the field names for 4DW and 8DW packets
>>    perf hisi-ptt: Extract the raw data printing part
>>    perf hisi-ptt: Merge 4DW and 8DW HEAD0 printing
>>    perf hisi-ptt: Add parsing of supported message types and proto length
>>    perf hisi-ptt: Add field-level parsing for header DW0/DW1/DW2/DW3
>>    hwtracing: hisi_ptt: Add pattern PMU config for trace format selection
>>    perf hisi-ptt: Pass pattern version to decoder for compatibility
>>
>>   Documentation/trace/hisi-ptt.rst              |  26 +-
>>   drivers/hwtracing/ptt/hisi_ptt.c              |  25 +-
>>   drivers/hwtracing/ptt/hisi_ptt.h              |   4 +
>>   tools/perf/arch/arm64/util/hisi-ptt.c         |  18 +
>>   .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   | 593 ++++++++++++++++--
>>   .../hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   | 241 ++++++-
>>   tools/perf/util/hisi-ptt.c                    |  51 +-
>>   tools/perf/util/hisi-ptt.h                    |   9 +-
>>   8 files changed, 872 insertions(+), 95 deletions(-)
>>
>> -- 
>> 2.33.0
> 

