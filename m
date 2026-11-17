Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941858;
	b=4w6RZCyMkYz5mdOvWAD4fcqKH64GEFMLf6m1ZQA4esjhXsz9nImjUdfBjs+ybzyuKeO2
	 E7/TgQ0u50UmVxHk3cYMoKoqnlbiGfpuyHGI7GtuOThyy2/yoBx1wK7G1OiLpD02jcLzO
	 /Y+Qw159FrqgoDf37fwKfsWn2EpByA++N6vgNyXG8p3N4MpQVXLoQD/Khy685Fi+p9FQz
	 CdgWVdrA/xXyb8j1SskEbFgTOeurJXgtk60CDTWMHeRuS7QybbMMaGkqZfedM9+X6y7iP
	 KQGJo2IvfD6gNfnevtryc15n4vcGAX24AS/OG5LAHumpB784SujnX+zaYzGcDpv4RsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941858;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HdkDes0ncCU4WGhgyR7YXxDGwX38qel+esSZ7Ve7TMg=;
	b=CduaPRnsKMVt/L6gHk2bNd+cQdU+DKnFJy+4RcBvxrNDuHsBBJn6ALRl9Jq9zLKsE0mI
	 EjE2j4I8O6COwVie3bWa5+A1+eQWnMC0IveoxJfu/8HF41PKWcV5D9k4Y/b3cVOr0KYEt
	 K/M2Z8f4epTb/nyjZid5VG/aeRHtAFBLoycsgW7H2cwk1dHgc6oa3lUaITBEBsGxpoDV9
	 QJBUE22Q8Cue67ooD6YJCQkOyGz66Ia6uTvFG7xGAmg65orsT1LB+WTVLfD4jg7sxU+PV
	 085i2fSIvAK8vrdZ6uEK/Q2LpNN3GoZlS/4X4noPDyiGnyH5E4yrttyybE1iSPxOVng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klSK5K0f;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74698606A31C;
	Tue, 17 Nov 2026 18:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74698606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=klSK5K0f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794941857; x=1826477857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v1NsJvl2MeAn+U0ELjw0P121EwhLfFQaHMoHS8YBAvw=;
  b=klSK5K0f0e3+1quJ7DkyIFQuOFiFpnnIy6p0e27w4zes6se1eYYIj1g/
   7HdWUdl9/xggNSP3k2OM/8sSsdUPRZSluyFqh10kQS1wzjotVTS1C58Kg
   YV64PwdvW3btFMNeCsNmcOaH467m8nt4zxHNLd4PExb43NCVoW6JQ+8cc
   Z9CpIeyBhE/hIOUeS5eNZfEFVXpeXJ0oeP/XzsQgUu6lujc6ykOdiCdlB
   eIZ2UmSbx5C4BPEaU0NXKV616bplFNi3xEvv+u877gdZRuYjEfZpyV+n+
   EC1UfN2y549bMcOL9r72QYr+C5Zyh/O+JnOZvIziXahK0kdl9DTYGwRlj
   A==;
X-CSE-ConnectionGUID: wh1Km1HVR5+D2kr1ZGNjNA==
X-CSE-MsgGUID: UsCCO0d7QQKUE7NlVHcGgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3753801"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3753801"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:57:34 -0800
X-CSE-ConnectionGUID: DPWAMEErR3Kxtj4lkE/CAw==
X-CSE-MsgGUID: y3FAroW/Sx6yGrYcfClEAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11733291"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:57:34 -0800
Message-ID: <28da8229-99f9-47c7-b2d6-d301ae34253f@linux.intel.com>
Date: Tue, 17 Nov 2026 10:57:33 -0800
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
Subject: Re: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
To: Lukas Wunner <lukas@wunner.de>, Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@oss.qualcomm.com>,
 James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>, Radu Rendec <radu@rendec.net>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Kai-Heng Feng <kaihengf@nvidia.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Breno Leitao <leitao@debian.org>, Terry Bowman <terry.bowman@amd.com>,
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 acpica-devel@lists.linux.dev
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
 <20261117111444.4185512-20-pierre.gondois@arm.com>
 <avw_daENKPcY7_04@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <avw_daENKPcY7_04@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 03:50, Lukas Wunner wrote:
> On Tue, Nov 17, 2026 at 12:10:29PM +0100, Pierre Gondois wrote:
>> Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
>> avoiding a NULL pointer dereference in pci_walk_bridge().
> 
> How can that happen?  If it can happen (which I doubt), why isn't this
> patch tagged for stable?

One way I can see is a device without a PCIe capability on a root bus.
pci_pcie_type() returns 0, which is PCI_EXP_TYPE_ENDPOINT, and
pci_upstream_bridge() returns NULL. Native AER never gets there. Only
firmware-first can, through aer_recover_work_func(), and only if
firmware reports a PCIe error section for such a device. If that is
the case, skipping recovery for !pci_is_pcie(pdev) in
aer_recover_work_func() seems a better fit than a check in
pcie_do_recovery().

> 
> Why is it at the end of this series?  Does the series somehow make it
> possible that there's no upstream bridge?  Which patch does that?
> If the preceding patches are not the cause of a potential NULL
> pointer deref, why isn't this patch submitted separately from the series?
> 
> Thanks,
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

