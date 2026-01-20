Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8A357A28;
	Tue, 20 Jan 2026 19:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768937178; cv=none; b=Be+lhmXVl30RYD/hCjELRKWUVCm7PGRsUvhHQhsHsPorngn9KiUafDb94G86/3Xk06bNQ5fQ9MfXfFYYHeOzqaB23uY5vncsBV+9EEjhxmsSgIXqFI1gbcDXmzuugGi1WWIcibWVJnruEeXj6X7lAFJ3xUz+lA4q7wC2FfDNeoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768937178; c=relaxed/simple;
	bh=mt9GLUVzk71ka+ZPSbHQQoZdxxIVR2iHJ/IWzJVXLhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLL4HKV8Ca7QFlK3oxZ9Xyo06XDO9bvIQ5tT3ottInB7l8YWErkS4KJABXKK5ouitBRz77B9tMdgZWLthAw2sDejy5I54zhINmoZwx7s+QFTZHJl3aDrKmPgtqqVf5kjr4c5hA+7iNPaKD5P9HD+f68vE6b2PwJTuirvjJ3j4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eueR8jlL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eueR8jlL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768937177; x=1800473177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mt9GLUVzk71ka+ZPSbHQQoZdxxIVR2iHJ/IWzJVXLhc=;
  b=eueR8jlLr9hClys004REFm0VvPvCRx7ERgAxFF83YT+h4vtjEOuHZhZi
   sx1ZzgbdQIqg7yXJubu96xGZgsgjN5KWDfgm/HVyMri5fKHGX1dGGahUR
   Uj3o22a19fWUdL3vLNFfJO93ixUz+icKfarBnfmx8A6I+dnpkFRK3rZzT
   PPzw0ngElXIIR9kaVyBWLJBJOdyxOYpW283d/QCIHNvY4c3GXiLX1v/qa
   cW02hPCz2cHAgzNwzCrXpcjlpjDGlqBQzdq9B6bqnKldyFhHwdtctmO3i
   ncTMdTLITzwsZsiKQdQDyImaLRRoT27cwGTTPjEc4JgHHAT2gJe4bUcqY
   w==;
X-CSE-ConnectionGUID: qo0tZVRNSjWFwkFW3K9SsQ==
X-CSE-MsgGUID: yN9C1mX2S5aYxOlss9jQLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="70129267"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="70129267"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:26:16 -0800
X-CSE-ConnectionGUID: A9arKT9GQJC+1X/7XmYeJQ==
X-CSE-MsgGUID: F+70x/u/TF+wQZv6AG7UsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236880013"
Received: from lfiedoro-mobl.ger.corp.intel.com (HELO [10.245.246.99]) ([10.245.246.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 11:26:13 -0800
Message-ID: <2487832b-0e19-4922-bc1f-845dd50296c3@linux.intel.com>
Date: Tue, 20 Jan 2026 21:26:55 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ALSA: hda: core: intel-dsp-config:: Add support for
 NVL
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.de,
 bhelgaas@google.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 linux-kernel@vger.kernel.org, kw@linux.com, linux-pci@vger.kernel.org
References: <20260120181702.GA1160036@bhelgaas>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260120181702.GA1160036@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/01/2026 20:17, Bjorn Helgaas wrote:
> On Tue, Jan 20, 2026 at 10:31:47AM +0200, Peter Ujfalusi wrote:
>> Add entry for NVL variant of Novalake family.
> 
> s/intel-dsp-config::/intel-dsp-config:/ in subject
> 
> The internet (and other patches in this series) seems to think
> "Novalake" is spelled "Nova Lake".

Yes, that is correct, thanks for noticing it!

-- 
Péter

