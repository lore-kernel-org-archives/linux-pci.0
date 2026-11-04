Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825220;
	b=Z6MOa19wylasPCd2qhrBcy6srNp1nF2ChEKuIvr+xqaZtXxBqrJ1U8p3fYhpDeqsNECi
	 IoV/YZKmy16l1HZeYJ0hQMWepZ4I/yIYMc96QhANBgGys8j1K/Rr2TKPccr444rXF/m0B
	 9BhKhcchixjbDYiyEc+AfXciET0QdZSUmzsBcTZqG9QdTQ5uKCGkxh6pFP38jy7nhzCVe
	 8aG9JQ1dg+jyDaEVkSppuvUwAStp3j90HSX8wp7AuE9MxRqGKI4X1PuT9SSSIVCwNItU1
	 EJnKop0W3QW/0J8qifQVypprws6kZ/rMsuPjpFWqzmkswPIyVyl5Axosw4WmUI6OYNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825220;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eRi8RhuRv2SJXOzZLsAPgv0589jsH/cmLNKcdsad3h0=;
	b=EI+KYwEKSh8gTyqrWBwzlkiaPr392NQV5/+sVkV5JC8yHgk7r4mxqGSqb7ang2VXVfwp
	 oMCyeoQKbpZRKBOH3WmcDjmnLw4F7O2DglPb7ch8Pa+GnlxB5WXXi0K71IU767XasczCa
	 TgmoSADRTsviNsEvLCAHfvzpZlPt6MxP4+YpRr87gyouSXsykIyDwlGxS0eP/Hwzdr/48
	 rMWXJLpAuDT89tSKzZXUTgRCVgfG7Wv3NtsGiFMHQlyH1n+ecxGd9FXLJJe9zr67aIVuF
	 SBXN3ntiHYv9ExRFv1YK0RqdonPLkOSrn2pncIwH6Er6e1B1xp7DnilW59D11Qa67AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YndeNSkr;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A0D6096913;
	Wed,  4 Nov 2026 20:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A0D6096913
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YndeNSkr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793825219; x=1825361219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YjyWnrTrQVq7ZBX8abJyAkTK5/Ot0nUJj61/vlmOhkA=;
  b=YndeNSkrgtoSw9czx398bMZ3UavEMb9dvokRy41tSUqg5qH7XnTDee4s
   Tg6lypKTEmhkyN3fNZj4Q42Q/8t0OPiMcSPNPXfqDpeWUMc4yU8327WbJ
   oxucXfpDAM9F/3nZBUADoVvVgEQzK6W5qatXhTPpSXBNUVfQ4afQtZJC3
   mIEPmhMWRwM0QwI84RourKrCbdhME1g8UEb2XCUyYiE9ctH/wSj1/Kn8T
   JlHvhyKbjc+8WYj4Uc1mt3KUHuazv8qPFvKVMjAvxPHfUOVe+Nf254EJ5
   MHVMnKCw9C9+KJKJqxBnCwkA9r9tRQtFQ0ylMi06TUw1J1XqZz4YZvN6J
   A==;
X-CSE-ConnectionGUID: 4FQ7906wSReHw+Z5u6cU/g==
X-CSE-MsgGUID: LgVwrbXST12UM4lBQ1iwjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2610685"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2610685"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:46:58 -0800
X-CSE-ConnectionGUID: QJnD8PsiRDG55Xn2Ee/n4w==
X-CSE-MsgGUID: g9wohO3RRNmrTkNAfU1MxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6942404"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 12:46:55 -0800
Date: Wed, 4 Nov 2026 22:46:52 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank.Li@oss.nxp.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	"open list:MHI BUS" <mhi@lists.linux.dev>,
	"open list:MHI BUS" <linux-arm-msm@vger.kernel.org>,
	"open list:PCI ENDPOINT SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] PCI: Replace chan->device->dev with
 dmaengine_get_provider_device()
Message-ID: <auuZvIjlTN_0AEch@ashevche-desk.local>
References: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104150202.3224971-1-Frank.Li@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 10:01:59AM -0500, Frank.Li@oss.nxp.com wrote:
> 
> Use the dmaengine_get_provider_device() API instead of directly
> accessing chan->device->dev to get the DMA provider device.
> 
> No functional change. Prepare make to struct dma_device private to the DMA
> engine.

I would also make line lengths balanced

  No functional change. Prepare make to struct dma_device private
  to the DMA engine.

Either way,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


