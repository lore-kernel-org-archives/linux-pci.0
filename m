Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797579;
	b=ydfN4oVilP4YFSqZTAeZOqkJaPTlJeUQ4Yq/GUu4lmSBymOXyf0yX9w/DllgmE03qI2Q
	 wJ4V36pdI/LBCQEi6wfdSXxcWuERpGREb4/3zPZ9ZPtiGPYAfqXW7VPX8tzBP6rONDpp1
	 EThahUXwohvAy47LdthuBUtd5ZZ1oqQglvkmNUCC/lHLyjGyge3piRxjclipPa8eWiwrO
	 N+ZcQow2gsJ4XiI8O0HfnWh6keO5TLg5KnBuj8Ky/o2zIrZTkOY7otxhTewXBBRyaxVo3
	 yW4NukKHa/bZt013Uj/WEfwQJLzhBRB2aKrcMNIKleudcAII0d0I+bC/Ufion4Wmqcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797579;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Zx1oVhA6VmSJRgH/LGhZzA7qtz4N/i4xfifsR87MlB0=;
	b=3+BVVA16+Xw5+i+ooXLDA/hMFfUrkrfglGqLg4/h2NVgFsJ7FQBIRJibut5vloGYKHNN
	 zrPIVhbwOiIMnNABrhw2cr+7duj8ULLV6iJSAKPCSZgYATBzvLKtsZyYXvgDYkNMYLHQ4
	 xfvWbnv6sR6AVEEIC+SLle5TvP/R8oB8ydHZmvh6/l7imuT8wAuLKUy2kO2CGdKSrd/ua
	 wPxXA8GvwJIF5TIRGv9gS1KKRiMu1QyNNutJhCVoR22tRLBlSi/yuqtQYmLCMKJdJZnxR
	 PmHaOW6NtFnFUkZV614YW37lTCcABCB4ojn8669InY6w520J74WWmuoPkH1GJA/p7eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XwawPmii;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E025606A69E;
	Fri, 27 Nov 2026 16:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E025606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XwawPmii
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E991570;
	Fri, 27 Nov 2026 08:39:33 -0800 (PST)
Received: from [10.57.71.121] (unknown [10.57.71.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C42E43F632;
	Fri, 27 Nov 2026 08:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795797576; bh=XhGanY3aQ88emXTEaZk5qtH//VWHLvLWmlIfZRuWgzk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XwawPmiiVgcGo4ddaZzciv06Q6JB/9Lp/Eiogo+D3FaM/zA2ofPdcYbP+1GvM0K5K
	 POTvta/F84ACVss1o4NNS/k+zjq8dApUR30yJj39bXs/u2SfmUwNdP1pg716b+DXXZ
	 AuncDOc2l1RekhOkfHV7jeCNKKwyGrvkfASsxkL8=
Message-ID: <73cf359b-365f-48fb-ae46-b6b3e13e1794@arm.com>
Date: Fri, 27 Nov 2026 16:39:30 +0000
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
To: Arnaldo Melo <arnaldo.melo@gmail.com>, linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Sizhe Liu <liusizhe5@huawei.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 corbet@lwn.net, skhan@linuxfoundation.org, bhelgaas@google.com,
 yangyccccc@gmail.com, jic23@kernel.org, john.g.garry@oracle.com,
 will@kernel.org, james.clark@linaro.org, mike.leach@arm.com,
 leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, wangyushan12@huawei.com, wuzongyu1@huawei.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linuxarm@huawei.com, prime.zeng@hisilicon.com
References: <20260908140509.2485649-1-liusizhe5@huawei.com>
 <aqB37YCMUYKodo3N@x2> <b1733f2a-ed03-4f38-8c40-6e0e535f1632@arm.com>
 <D6C7F85D-0A2C-4569-98FD-ADB616FA106E@gmail.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <D6C7F85D-0A2C-4569-98FD-ADB616FA106E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/11/2026 16:31, Arnaldo Melo wrote:
> 
> 
> On November 27, 2026 12:12:14 PM GMT-03:00, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> Hi Arnaldo,
>>
>> On 08/09/2026 22:02, Arnaldo Carvalho de Melo wrote:
>>> On Tue, Sep 08, 2026 at 10:05:01PM +0800, Sizhe Liu wrote:
>>>> The original hisi-ptt-decoder only prints raw hex values with generic field
>>>> names for DW0/DW1/DW2/DW3, without classifying TLP types or decoding
>>>> DW0/DW1/DW2/DW3 fields according to the hardware-defined packet format.
>>>>
>>>> This series enhances the HiSilicon PTT (PCIe Trace and Tuning) packet
>>>> decoder in perf tool to provide detailed field-level parsing of TLP headers
>>>> based on message type, and adds a versioning mechanism for backward
>>>> compatibility both in hisi_ptt driver and perf tool.
>>>
>>> Series is sashiko clean by now, has a Reviewed-by, but it touches both
>>> kernel and tools, I wouldn't have a problem if it was processed by
>>> whoever maintains the kernel part.
>>>
>>> - Arnaldo
>>
>> Please could you add your Ack on the series, so that I can pick it via
>> Coresight tree.
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks !

> 
> But you could have taken my "I don't have a problem if this gets processed" by somebody else as an Acked-by me, documentation says so.

Alright, didn't know that.

Cheers
Suzuki



> 
> - Arnaldo

