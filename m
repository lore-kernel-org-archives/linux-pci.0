Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8043A7EF;
	Wed, 29 Jul 2026 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312812; cv=none; b=Jj0f5+POVFNputI6IcZHYrRz1ZtRkAXJU7CJMzBrrSApBgUj+KtPTiXLElxbRUr0vjxnKHM7ZNuoflad2dJhMERhFwOq+EICTndKcCLAOsBPUsL+yl61T+vXVOzX0OQrrUPcHWThqAxyy4VciGe/vd022CbojWiA5EUEGklFTmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312812; c=relaxed/simple;
	bh=rhLEvcU2rNwQKBp+jzc+27i1xt2fV4Dmz34FnJF4SDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hUvzW2CPkjvcjbqKo1n5KX4X2N95oc6eajQASxV7HF948lYUOtvTHvi90hVcKJhIzGwSMp9MKgn+UcCB9Qd/g/oCh8/mLqUVsR780reVAWwa7F4rPNLs5pLL2/RpCC6jqoNWRcaQpb6qQUQD89VVX85vwo4q359dMm8iuhOtC5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=b/7PYiGE; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="b/7PYiGE"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JU4nTNnLiZUM9Y4cL70aHfB9uMSR3Cje60IIvYTXm7M=;
	b=b/7PYiGEnOFZRp4z6UdillzQIPhnDeCWtQ08l6XjL96ksceD+0d3USfxauif4Xt9E1NnvMFR8
	n/KJc7CUzuLHpEu7gM3RqsV7U0e6fONurcxOmWANHGG1lGlbdT+LZ/D+6sFLVcU/zYeKgQ3/fwA
	tcytb8LJcfWz36pXskS0VUQ=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h94bg1DznzpSvb;
	Wed, 29 Jul 2026 16:03:59 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 6100740561;
	Wed, 29 Jul 2026 16:13:16 +0800 (CST)
Received: from [10.67.120.233] (10.67.120.233) by
 whupemo200004.china.huawei.com (7.152.184.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Jul 2026 16:13:13 +0800
Message-ID: <d216745f-a23f-4f36-a462-22f4814baf48@huawei.com>
Date: Wed, 29 Jul 2026 16:13:11 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] perf hisi-ptt: Add decoder version compatibility
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <bhelgaas@google.com>, <yangyccccc@gmail.com>,
	<jic23@kernel.org>, <john.g.garry@oracle.com>, <will@kernel.org>,
	<james.clark@linaro.org>, <mike.leach@arm.com>, <leo.yan@linux.dev>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <wangyushan12@huawei.com>,
	<shenyang39@huawei.com>, <gaozhihao6@h-partners.com>,
	<yuzhichengcheng@h-partners.com>, <liyihang9@h-partners.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <wuyifan50@huawei.com>
References: <20260713174951.GA1245033@bhelgaas>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <20260713174951.GA1245033@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200004.china.huawei.com (7.152.184.18)


On 2026/7/14 1:49, Bjorn Helgaas wrote:
> On Thu, Jun 04, 2026 at 03:50:05PM +0800, Sizhe Liu wrote:
>> The hisi_ptt packet decoder now performs detailed field-level parsing
>> of TLP header DW2 and DW3 based on the message type classified from
>> DW0 (added in the previous patches). However, trace data recorded
>> with older versions of the tool does not contain the information
>> needed for this detailed parsing, and should continue to use the
>> generic field-name-only output.
> Add blank line between paragraphs.  Also applies to 05/10.
>
>> Introduce a version field (V1/V2) in the auxtrace info record to
>> distinguish between the two data formats:
> IMO a blank line here would also improve readability.  And consider
> indenting bullet points a couple spaces.  Also applies to other commit
> logs in this series, including sample formats.
>
>> - V1 (legacy): auxtrace priv contains only PMU type. DW2 and DW3
>>    are printed with generic field names only, no message-type-based
>>    field decoding.
>> - V2 (current): auxtrace priv contains PMU type and version. DW2
>>    and DW3 are decoded according to the TLP message type (MWr, Msg,
>>    Atomic, IO, CPL, Cfg) with detailed field names.
> Could use imperative mood, e.g.,
>
>    - V1 (legacy): auxtrace priv contains only PMU type. Print DW2 and
>      DW3 generic field names only, no message-type-based field
>      decoding.
>
>    - V2 (current): auxtrace priv contains PMU type and version. Decode
>      DW2 and DW3 according to the TLP message type (MWr, Msg, Atomic,
>      IO, CPL, Cfg) with detailed field names.
Thanks, all the preceding suggestions will be modified in v2.
>> At recording time, set the version to HISI_PTT_DECODER_V2 in the
>> auxtrace info. At decoding time, determine the version from the
>> priv data size and the version field:
>> - If priv_size >= V2, read the version from priv[1].
>> - If priv_size < V2, assume V1 for backward compatibility.
>> - If version is unknown (future), warn and decode auxtrace as v2.
>>
>> Also add the version to the dump output alongside the PMU type.
>> Adjust hisi_ptt_pkt_size position to adapt to compilation.
> AFAICS this series adds new functionality and probably doesn't qualify
> for "stable" tags, given the documented rules.  But I think the
> maintainers are pretty aggressive about backporting things anyway.
Hi Bjorn,
Thanks for your response and for clarifying the policy regarding the 
stable tag.
You're right, patches 03-10 in this series are new functionality and 
shouldwait
for the next merge window.

For patch 01 and patch 02, they do fix the issue of inaccurate packet 
parsing,
I think it is better to separate them from the patch series.
I am sending them individually after fixing the C bitfields issues if 
that makes things clearer.

If you have any suggestions on this split, please feel free to let me know.

Regards,
Sizhe
