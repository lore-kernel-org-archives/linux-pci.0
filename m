Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C947B419;
	Tue, 20 Jan 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937441; cv=none; b=H1GAFdzTMI6893O6l2ClJ1kiJIxCsXVHOCg48IKPwbJpXgh3kBqrZNU4rHDEekLPfG4++YeLeJXuQYKKZto2WOtPIf+wNLp4pO86wgRXpNogruFMPVwjToCFYGdmUetg8BdXNgD5y7eTA6h9JL1d7R6JOnq3jLURU/x8V5uuEcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937441; c=relaxed/simple;
	bh=duDfUNxRb2+4OV0Wr0W9BTioqlLajwc9kNqY03AY41Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RspPvqrRJTcSKvcAlBIrAgCEUAx6+Tf1hPhGWe5fP4FokBsBh/iaD+3DtKm1FcdNrh6tec8ZQD618skatixc56dsTyhfYqOZo1zTW+XtKMbKkj63x4BWYaq3jxRi+FQfoLnevJhv+HyzMY0UxUTzm9fGi5biKD0/O0IHdqzx+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OowwdpmP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OowwdpmP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937439; x=1800473439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=duDfUNxRb2+4OV0Wr0W9BTioqlLajwc9kNqY03AY41Y=;
  b=OowwdpmP7e7YATU92g+j6wdNaysmHYhqDNFqtZ3KIVamlq+7Teli07Mc
   Tm895YkrBdfeFgQ6QNEMyGzWT23vJzd9XOxMH9NFUfyOAYUHZsyD1zDs5
   muswUVMR6/kOzA5MdX3/AEqI+Oq7NAKXb1OmLYZH2UQewW/WLaaxod0if
   VKk1LyE+cGqxoIG74aXQEtz8HYfjAHFr/Pms6hII2Udp8RPjny9VpuJ87
   o1BjQb9NajxqB2hSa8IXpE7PjqPeiELQ6F1aGooH88iKapWhvpyogIkXV
   BU4TzNG/PzGz19MxZG9qJ391EC16VG2DdY+TNph/SIXkz13+HWnvGScLb
   Q==;
X-CSE-ConnectionGUID: /N/VAzMHRyWed+XjWPPHeA==
X-CSE-MsgGUID: vj0gBM7MS+KVhiTdHOQOpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70129661"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70129661"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:30:39 -0800
X-CSE-ConnectionGUID: 58AhfOdLTfWLC/VbfJTZcw==
X-CSE-MsgGUID: 53zPoMbGSVOVaAz3ZUEdEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236881223"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.99]) ([10.245.246.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:30:35 -0800
Message-ID: <8ba05ae5-a2e7-44b3-9022-714806385046@linux.intel.com>
Date: Tue, 20 Jan 2026 21:31:18 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ASoC/SOF/PCI/Intel: Support for Nova Lake
To: Takashi Iwai <tiwai@suse.de>
Cc: lgirdwood@gmail.com, broonie@kernel.org, bhelgaas@google.com,
 linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.dev, linux-kernel@vger.kernel.org, kw@linux.com,
 linux-pci@vger.kernel.org
References: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
 <87fr80rtl4.wl-tiwai@suse.de>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <87fr80rtl4.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/01/2026 21:07, Takashi Iwai wrote:
> On Tue, 20 Jan 2026 09:31:44 +0100,
> Peter Ujfalusi wrote:
>>
>> Hi,
>>
>> this series adds audio support for the NVL variant of the
>> Nova Lake family.
>> NVL also based on ACE4 audio subsystem, but with higher clock
>> rate, more DSP memory and more DSP cores (4 vs 2) compared to
>> NVL-S.
> 
> It looks like that the ASoC patch is based on the recent change that
> isn't merged yet in my tree, so this series should go over ASoC tree
> for now, supposedly.

It must be the on_demand_dsp_boot support which is via ASoC tree.

> Mark, could you take them (probably with minor corrections of subject
> as Bjorn suggested in the thread)?

I will send the updated v2 with corrections and Acks

> For HD-audio stuff:
> Acked-by: Takashi Iwai <tiwai@suse.de>

Thank you.

> 
> thanks,
> 
> Takashi

-- 
Péter

