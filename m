Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4433E345;
	Wed,  2 Sep 2026 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319850; cv=none; b=rCMDbAkkRWfzcBfMF4KxKZG/6jdzS01pC8A8WZ97FLGm4s/Wi+iMSpFVAYMMvQMDgrpsxHH4XEGGzwPkltJ2hZquGgGTYFFR82U0/XNq+Ds3x0TqJL1O06fh9mTeGdxEC+ZLAEtcrJPeOTnJyr49KF2Dhcz4MbtWPTuUCoBn8P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319850; c=relaxed/simple;
	bh=FdCmjnxdPI0buBXQZNyH2/bWboyb/iT079BWchYO6h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pFzUxe/XGHAKUMpbGAsRGwYoQNKg+oEUzMgLQZ2f5pkWPDmZgt0b3hG1gXk9dtEGsFOdY0/9D+ut7BiuuZSYz42XnKvFl/nWYtUX4AouzkZ7KTuzd1jZhxawZCE4BweLiq1gqrk4YUJ8qVIskzBQjiZqfCPaNg65edQrHYpfD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FaVGjP1Q; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FaVGjP1Q"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2PCd37bUtBEqv1gFYGYVEnb5d1bwivJr+yX7tE1LZVU=;
	b=FaVGjP1Q7NfGGgo8JXMhEjjDW0Eg4lk6xn5ToA4TV1G2UCOAIEiqUifFXYuvajR6tBY4PKe6L
	bsaCCYZwdOdExuBgFdaMe9R3h06PF93SoU+WO7kSF8RGIKha4PyFcSAZUg8SvJrCXKzeAkp+5c8
	88u2AOlm9MGsLC7EBv7MSxg=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hZSdh1zRTz1K9Ws;
	Wed,  2 Sep 2026 11:19:52 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 4039A4048B;
	Wed,  2 Sep 2026 11:30:42 +0800 (CST)
Received: from [10.67.120.233] (10.67.120.233) by
 whupemo200004.china.huawei.com (7.152.184.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 2 Sep 2026 11:30:39 +0800
Message-ID: <08e19f22-f0e7-4c79-8938-110e5150b507@huawei.com>
Date: Wed, 2 Sep 2026 11:30:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] hwtracing: hisi_ptt: Add pattern PMU config for
 trace format selection
To: Yushan Wang <wangyushan12@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <bhelgaas@google.com>, <yangyccccc@gmail.com>,
	<jic23@kernel.org>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <wuzongyu1@huawei.com>
References: <20260827140442.2031128-1-liusizhe5@huawei.com>
 <20260827140442.2031128-8-liusizhe5@huawei.com>
 <c00d649f-aa24-40a8-849e-789ce1a6aca9@huawei.com>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <c00d649f-aa24-40a8-849e-789ce1a6aca9@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo200004.china.huawei.com (7.152.184.18)

On 2026/9/1 9:31, Yushan Wang wrote:
> On 8/27/2026 10:04 PM, Sizhe Liu wrote:
>> Introduce a `pattern` PMU config field (config:36-39) that controls
>> which TLP header format the hardware traces. bit[3:1] are reserved for
>> future extension and only bit0 is used currently:
>>
>> - pattern=0 (default, compatibility mode): the driver sets bit[8] of
>>     HISI_PTT_TRACE_CTRL so the hardware traces the data in compatibility
>>     mode.
>> - pattern=1: the driver clears bit[8] of HISI_PTT_TRACE_CTRL so the
>>     hardware traces the data pattern including some bitfields of the TLP
>>     header defined in PCIe r6.4 sec 2.2.1.2.
>>
>> Note that bit[8] of HISI_PTT_TRACE_CTRL is inverted with respect to the
>> `pattern` value: bit[8]=1 selects the legacy format, bit[8]=0 selects
>> the new format. Bit[11:9] is still reserved, which is consistent with the
>> PMU config field. The driver validates the 4-bit value in
>> hisi_ptt_trace_valid_pattern() and applies it in hisi_ptt_trace_start().
>>
>> Document the new parameter in Documentation/trace/hisi-ptt.rst.
>>
>> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
>> ---
>>    Documentation/trace/hisi-ptt.rst | 25 +++++++++++++++++++++++--
>>    drivers/hwtracing/ptt/hisi_ptt.c | 25 ++++++++++++++++++++++++-
>>    drivers/hwtracing/ptt/hisi_ptt.h |  4 ++++
>>    3 files changed, 51 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
>> index f6a2655f99e5..c95eaa12f4d3 100644
>> --- a/Documentation/trace/hisi-ptt.rst
>> +++ b/Documentation/trace/hisi-ptt.rst
>> @@ -255,7 +255,28 @@ directly from the TLP header.
>>         DW2 [                     Header DW2                            ]
>>         DW3 [                     Header DW3                            ]
>>
>> -5. Memory Management
>> +5. Trace pattern
>> +-----------------
>> +
>> +You can control whether the trace is taken with the new version of the
>> +TLP header format by specifying the `pattern` parameter. The default
>> +value is 0, which means the legacy format is used for backward
>> +compatibility. The parameter value is 4 bit and bit[3:1] are currently
>> +reserved for extension. Current supported values are shown below:
>> +
>> +- 4'b0000: legacy trace format
>> +    DW2 and DW3 are printed with generic field names only, and
>> +    no message-type-basedfield decoding.
>> +- 4'b0001: trace format v1
>> +    DW2 and DW3 are decoded according to the TLP message type (MWr,
>> +    Msg, Atomic, IO, CPL, Cfg) with detailed field names. It is recommended to
>> +    use trace format v1 when the current PCIe link generation is higher than
>> +    PCIe 6.0.
>> +
>> +For trace data recorded by an older tracer without the `pattern` parameter,
>> +the decoder will work as `pattern` forced to 0.
>> +
>> +6. Memory Management
>>    --------------------
>>
>>    The traced TLP headers will be written to the memory allocated
>> @@ -274,7 +295,7 @@ will commit the AUX buffer first and then apply for a new one with
>>    the same size. The size of AUX buffer is default to 16MiB. User can
>>    adjust the size by specifying the `-m` parameter of the perf command.
>>
>> -6. Decoding
>> +7. Decoding
>>    -----------
>>
>>    You can decode the traced data with `perf report -D` command (currently
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 94c371c49135..1696c30ac4c9 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -233,6 +233,10 @@ static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
>>         val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
>>         if (!hisi_ptt->trace_ctrl.is_port)
>>                 val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
>> +     if (!ctrl->pattern)
>> +             val |= HISI_PTT_TRACE_CTRL_PATTERN;
>> +     else
>> +             val &= ~HISI_PTT_TRACE_CTRL_PATTERN;
> 
> Hi Sizhe,
> 
> This hunk seems not able to be applied to mainstream cleanly, otherwise
> this series LGTM.
> 
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> 
Hi Yushan,

I will fix it in v3. Thanks for your Reviewed-by tag.

Regards,
Sizhe >>
>>
>>         /* Start the Trace */
>>         val |= HISI_PTT_TRACE_CTRL_EN;
>> @@ -805,12 +809,14 @@ PMU_FORMAT_ATTR(filter,         "config:0-19");
>>    PMU_FORMAT_ATTR(direction,   "config:20-23");
>>    PMU_FORMAT_ATTR(type,                "config:24-31");
>>    PMU_FORMAT_ATTR(format,              "config:32-35");
>> +PMU_FORMAT_ATTR(pattern,             "config:36-39");
>>
>>    static struct attribute *hisi_ptt_pmu_format_attrs[] = {
>>         &format_attr_filter.attr,
>>         &format_attr_direction.attr,
>>         &format_attr_type.attr,
>>         &format_attr_format.attr,
>> +     &format_attr_pattern.attr,
>>         NULL
>>    };
>>
> 
> [...]

