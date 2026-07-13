Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAB03D0929;
	Mon, 13 Jul 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783932579; cv=none; b=QjVNnqKfUfr8OwJVClOQfsnqowB91uPbWYYRR9K3zsF1gwgoYRE9qDny6et2aaVSDwj1LnB6RonJ+UESaJZ6v5h9LAth5gfk28lmmaPbXjmw1O/nk8DtUTGMhWmRfzsdPmuzOXzeynotAV7T0De8EAhjOGXU3WqLq0qNNJcp8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783932579; c=relaxed/simple;
	bh=sxfQflYPeFYevVQ6mFcMjDr1xqwFE6A3HME7QH4zMog=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hqZNf8xWY5lMljwBR/kBNQvTdkRpZWr8GMOJ16ptNq7EjZhF9W2f1Q00QFLjPgtOjW5FFd3TzdfG2oPXp8Tpx4PH6Lca0J2lalFrlrEFWbPMSKCP4rK6HTxUUoGhSiz+7dz2GcdO8A1IG1FGT6kIeYD3puRVuMMsOvT26uH5LjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KSh4RwCd; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KSh4RwCd"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=SKHdSP5nQMb3Q5XWdhIYg9uoiKMFPcMO13oydIAbY+o=;
	b=KSh4RwCd+h82LOgcgRmZXF7gdYP9e08nV6f71vL3l33c84A+9euuNH4rLmjDm/PhH8NDRt9si
	/dQZ9KWfpNU798pmW5gwYWXPV7JafoIpQt0zBR9W5gHw1qQvG6IShKd7YPVvXghJ3Ujy1gzecbk
	Aje445tgq5oqm9psoX5+zjo=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4gzG8S6N0bz12LDx;
	Mon, 13 Jul 2026 16:39:52 +0800 (CST)
Received: from whupemo200004.china.huawei.com (unknown [7.152.184.18])
	by mail.maildlp.com (Postfix) with ESMTPS id C97E940561;
	Mon, 13 Jul 2026 16:49:31 +0800 (CST)
Received: from [10.67.120.233] (10.67.120.233) by
 whupemo200004.china.huawei.com (7.152.184.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Jul 2026 16:49:31 +0800
Message-ID: <9b944a92-c83d-4388-bdda-b633948f27e5@huawei.com>
Date: Mon, 13 Jul 2026 16:49:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] perf hisi-ptt: Add decoder version compatibility
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-perf-users@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260604075005.2219785-11-liusizhe5@huawei.com>
 <20260604080356.9F8761F00893@smtp.kernel.org>
From: Sizhe Liu <liusizhe5@huawei.com>
In-Reply-To: <20260604080356.9F8761F00893@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo200004.china.huawei.com (7.152.184.18)


On 2026/6/4 16:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The code silently accepts unknown future decoder versions without warning the user, contradicting the commit message.
> --
>
> commit 81956f61abf20a5e88b7e9d82765dace1fbc899f
> Author: Sizhe Liu <liusizhe5@huawei.com>
>
> perf hisi-ptt: Add decoder version compatibility
>
> This commit introduces a version field to the hisi_ptt auxtrace info record
> to distinguish between legacy and detailed packet parsing formats. It updates
> the recording and decoding logic to process the data accurately based on the
> detected version.
>
>> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
>> index e321f393601b8..4f52cfb4e1903 100644
>> --- a/tools/perf/util/hisi-ptt.c
>> +++ b/tools/perf/util/hisi-ptt.c
> [ ... ]
>> @@ -159,10 +166,13 @@ int hisi_ptt_process_auxtrace_info(union perf_event *event,
>>   {
> [ ... ]
>>   	ptt->machine = &session->machines.host; /* No kvm support */
>>   	ptt->auxtrace_type = auxtrace_info->type;
>>   	ptt->pmu_type = auxtrace_info->priv[0];
>> -
>> +	ptt->version = priv_size >= HISI_PTT_AUXTRACE_PRIV_SIZE_V2 ?
>> +		       (u32)auxtrace_info->priv[1] : HISI_PTT_DECODER_V1;
> [Severity: Medium]
> The commit message explicitly states: "If version is unknown (future), warn
> and decode auxtrace as v2."
>
> Does hisi_ptt_process_auxtrace_info() implement this promised warning?
>
> It appears to silently assign the future version directly from
> auxtrace_info->priv[1] without bounds checking or notifying the user. Could a
> warning be added here to match the stated design intent and prevent potential
> compatibility issues from being masked?
Yes, a warning should be added here.
>
>>   	ptt->auxtrace.process_event = hisi_ptt_process_event;
>>   	ptt->auxtrace.process_auxtrace_event = hisi_ptt_process_auxtrace_event;
