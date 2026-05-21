Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80826275AE4;
	Thu, 21 May 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372043; cv=none; b=Sw3J7bZYje1/1Y4nHPNy5yI1HBEvvtc7kgicPjGDi4sbhfRyn/xItidl5fcjKfeR31M2gjF3UIE0smbGADP6Oexgn43dOlvSdutsvV3QEO+wT28Qc/z3IZFcR+rEL+XwOL6O31ZWtx8eufFthFuGXyN5MLulzOFd/Z6KOdN8+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372043; c=relaxed/simple;
	bh=P2vvrMS0cA0nf8csD85gV4H/e4rsZnFQUK3vI4r1K10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMGqqigx2sJyzzUceayA/3dUxtA22kZhiZEfWMyl3wylAqPWSlnR+BIIYGvnVnMCkP2EDP8rpLGFhZ/exiodWSpm/bVRVnygkLlsZ7LmQrJuSHZ5ehAj1ZqntEtqvVkjCGX1de+AwAB42oCHG/VlO7Oi25FmvxDpGP0kdywAFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WERZwtec; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WERZwtec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779372042; x=1810908042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P2vvrMS0cA0nf8csD85gV4H/e4rsZnFQUK3vI4r1K10=;
  b=WERZwteclYq9FvOdksbIpwGlpeTKy5c5AINfwL4XVAkLKxJZBSGZFfQM
   GIh8Bu8OH/EUZ2Zjp1v3nw00ODBkqIp7JbEWQs1whoPU63cUly4ACSvbO
   g6BgWcpYTa9hcRLrsPawYvcJN9zg30pw2kqtaFAgkJQhfc2OmslQFoUcz
   ADlRYMXe1GyXeGJ3pxAEmOrU3wq/y1p+L6wP7QWDq2BWRBFNJGhsdXbzv
   x3tmRwRJKw4Y93yzsgSuwiIS1qh73OtxLCgypqQ04EKdDbbPzFPGiN5Hc
   43yRF0VLUVZcsE9s9LB0P4a0k4zKEWLkdLZ0qyuhh/d3UCgXY1HFRgNsC
   Q==;
X-CSE-ConnectionGUID: 3VNKd8h9QdO69QgqFmCc7A==
X-CSE-MsgGUID: /1s9mPMgR3uq1Y5sNuR4oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79437171"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="79437171"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 07:00:40 -0700
X-CSE-ConnectionGUID: LWLwqBgwSTWMNBmcK6XsTw==
X-CSE-MsgGUID: YwRXeLaPQYOODzDoC1fScQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="239682785"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.42]) ([10.245.244.42])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 07:00:33 -0700
Message-ID: <9aa73abb-0eb1-4320-a179-40f7d2458dd9@linux.intel.com>
Date: Thu, 21 May 2026 17:00:29 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] usb: xhci: tegra: Explicitly specify PMC instance to
 use
To: Thierry Reding <thierry.reding@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
 <20260506-pmc-v1-6-a6de5da7216b@nvidia.com> <ag67FStKnQcvNOrP@orome>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ag67FStKnQcvNOrP@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/21/26 10:59, Thierry Reding wrote:
> On Wed, May 06, 2026 at 03:41:57PM +0200, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Currently the kernel relies on a global variable to reference the PMC
>> context. Use an explicit lookup for the PMC and pass that to the public
>> PMC APIs.
>>
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> ---
>>   drivers/usb/host/xhci-tegra.c | 38 ++++++++++++++++++++++++++------------
>>   1 file changed, 26 insertions(+), 12 deletions(-)
> 
> Mathias, Greg,
> 
> can you ack this so I can pick it up into the Tegra tree for simple
> dependency resolution?

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>

