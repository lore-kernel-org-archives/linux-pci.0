Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBE376BF1;
	Mon, 13 Jul 2026 08:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932354; cv=none; b=lbkzQW4Yf8fJFIIt/1odT22hztkKF6P19VgSeMi7H05IVL2CsVqJQPB5oMA0pvhAV9s417HAWXEoE5xVokn14lY+gzGTZG5LAhylCbPYncT5IJ9fE/53vyKRGmG4v3E22WQ5hY+42E5e8KoT0axrlqs/rM81TENHyEw8gRVAkaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932354; c=relaxed/simple;
	bh=gq2MvhinX35Ycm9JnKQm6WEoiO2n4ya3XhAAJ5aqtM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hfp00wk85KaUg5fMfoWUeYfiKa4I9LREZ/YG8GcKgYlw8hurXKSkX5n/Kpu06OSUJ62UiMtybeY3u1erum1KalknSz/oEYjL1UYHLYr3/TIjH0k54+fR5WeIOOZMcCtUijsRNvUipbEv/dBE6a278Q/NxVHybEHWk6vvq0VABS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Il7C+t8W; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Il7C+t8W"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=wANqFl+rvWRG8f7SGehgfFmwU4caU9XO+4Yu3gI6HvM=;
	b=Il7C+t8WK84sxOAftbzQuuAIyXr+bNLDxFgDL59dSKW6JVHciZqV496FWYChF5l2UIf50vvlI
	VkZRlUSu6v1AlH5d1paewg673opDFHlxCMRx+TmR2fzYQ723Oc8byFYS+EcsmTQ6qVgNV1OCIca
	AZ1cll/pwc6aivWfyZldmwM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gzG4R5TWWzmV6m;
	Mon, 13 Jul 2026 16:36:23 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B0E8402AB;
	Mon, 13 Jul 2026 16:45:41 +0800 (CST)
Received: from [10.67.120.233] (10.67.120.233) by
 whupemo200004.china.huawei.com (7.152.184.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 16:45:40 +0800
Message-ID: <e767f7a6-0462-49e5-b8b8-b32149ab0778@huawei.com>
Date: Mon, 13 Jul 2026 16:45:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] perf hisi-ptt: Add field-level parsing for header
 DW2/DW3
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-perf-users@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260604075005.2219785-10-liusizhe5@huawei.com>
 <20260604075857.734541F00893@smtp.kernel.org>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <20260604075857.734541F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo200004.china.huawei.com (7.152.184.18)


On 2026/6/4 15:58, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Host-endian-dependent C bitfields break cross-platform trace analysis on big-endian hosts.
> --
>
> commit b5a1a94b81406195d7c90b32fd8a96a3d26602c2
> Author: Sizhe Liu <liusizhe5@huawei.com>
>
> perf hisi-ptt: Add field-level parsing for header DW2/DW3
>
> This commit adds detailed field parsing for TLP header DW2 and DW3 based on
> the message type parsed from DW0. It aims to provide more structured
> information for users analyzing PTT trace data.
>
>> diff --git a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>> index 59ab8ec3a03da..46f11d5719aca 100644
>> --- a/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>> +++ b/tools/perf/util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c
>> @@ -127,6 +142,45 @@ union hisi_ptt_field_data {
>>   		uint32_t type : 5;
>>   		uint32_t format : 3;
>>   	} dw0_8dw;
>> +	/*
>> +	 * Header DW2 for MWr/Msg/MsgD/FetchAdd/Swap/CAS/IORd/IOWr TLPs.
>> +	 * Affects both 4DW and 8DW format.
>> +	 */
>> +	struct {
>> +		uint32_t header_dw2 : 16;
>> +		uint32_t tag : 4;
>> +		uint32_t t : 1;
>> +		uint32_t tv : 1;
>> +		uint32_t rsv : 1;
>> +		uint32_t request_segment : 8;
>> +		uint32_t reserved : 1;
>> +	} dw2_mixed;
> [Severity: Medium]
> Does using C bitfields here create an issue for big-endian hosts?
>
> While le32_to_cpu() correctly handles the byte order of the raw integer,
> the layout of C bitfields is implementation-defined. On big-endian systems,
> won't the compiler pack these fields starting from the most significant
> bit instead of the least significant bit?
>
>> +	/*
>> +	 * Header DW3 for CfgRd0/CfgWr0/CfgRd1/CfgWr1 TLPs.
>> +	 * Affects both 4DW and 8DW format.
>> +	 */
> [ ... ]
>> @@ -211,6 +265,85 @@ static void hisi_ptt_print_head0(struct hisi_ptt_pkt_buf *pkt_buf)
> [ ... ]
>> +static void hisi_ptt_print_head2(struct hisi_ptt_pkt_buf *pkt_buf)
>> +{
>> +	const char *color = PERF_COLOR_BLUE;
>> +	union hisi_ptt_field_data dw;
>> +
>> +	dw.value = le32_to_cpu(*(__le32 *)(pkt_buf->buf + pkt_buf->pos));
>> +	hisi_ptt_print_raw_record(pkt_buf->pos, dw.value);
>> +
>> +	if (pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MWR ||
>> +	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_MSG ||
>> +	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_ATOM ||
>> +	    pkt_buf->pkt_msg_type == HISI_PTT_PKT_TYPE_IO)
>> +		color_fprintf(stdout, color,
>> +			      "  %s %x %s %x %s %x %s %x %s %x %s %x %s %x\n",
>> +			      "Reserved", dw.dw2_mixed.reserved,
>> +			      "Request Segment", dw.dw2_mixed.request_segment,
> [Severity: Medium]
> Will this result in extracting entirely incorrect bits when a big-endian
> host processes an ARM perf.data trace file?
>
> Since perf tools are expected to support cross-platform trace analysis,
> could we use bitwise operations instead of C bitfields to ensure the fields
> are reliably extracted regardless of the host architecture's endianness?

HiSilicon PTT deployment environment is strictly little-endian (ARM LE), 
so the current layout works correctly for supported platforms.

I understand the endianness dependency of C bitfields, and I think it's 
better to use bitwise operations instead of C bitfields in 
cross-platform cases.

I will change these in the next patch version (Reply to all comments 
related to C bitfields).


Sincerely,

Sizhe

>
