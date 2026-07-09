Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966D3DB996;
	Thu,  9 Jul 2026 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583547; cv=none; b=k63UzjReXMiPbGgC1vmqSknZHrKUoAR9fDUfHCsGQ1Nl+pvJDd6yziIP8b7Cxu2pBNMAy+DarXjKQWme8sQ4EQnOpco7hmKrF/Mx7Hy1W5Fc5a5wKmXEgyL9xPEbPwxTks7oxVXCtQgBGApcVQWek0zOsKDwYiH0cFdTdGR5E54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583547; c=relaxed/simple;
	bh=AgHK5m8LdX9bIdaPiAWQvXOsPJYtiUxyT9YHT9+iDUY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COfFWF4X4CutzAmiAjj2R9w3Vif0WSVmvPlwr5GuNS32ZZmlMA7cCh2nJxh4BbGxuFFlILeNebxVAv+ANr/AQJFlngxp+KiyhXTW+/br6dy0OaS79X/54x3GvqPaTa09l+knJJC5nQ3m+qektxqRa/GjxQatembzUFBOdLzATJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=tBen0XDN; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="tBen0XDN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783583546; x=1815119546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+rQ79jz19DIlq4LI0VCq1QRDlcfSTI5fziUdQpu7ik0=;
  b=tBen0XDNKTv2/1x7o44XMHrfzAvmAUFUAsuEoZPdy31qMdDvtF4UUKCl
   /k1WGCTPV1dMaCqsgvJ/Dcg0/jTCCKx+AWuLzzPRZpNtQtWdndV8lNL44
   3Y1M6yaTqT1aarKbSzOFASMlUlDuGyttbCYAO+VAs193LSDBUM3vAJ0iV
   1BMGAAmlSHSaXH2CNoyenSaI7fWwAR6fTnAh8EAhVoaPtB2Hw03yr7p1Y
   RGNTEVZqV7e7C1ZcqcLJQeOqy94O4lC6m15T9ilN9/7/O2ORE+iU/EBqi
   PfOLqrHurjNfaCQi608FZNiikQHRlztWd4UYn0F/Rc07zuEJETYD8v9/R
   A==;
X-CSE-ConnectionGUID: 7HKZlVyWTA2d8zvLoJGKDQ==
X-CSE-MsgGUID: tni1ZQ8ORO2Ltt2XCJu17g==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23121363"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 07:52:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:30388]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.2:2525] with esmtp (Farcaster)
 id 13451079-5140-463a-af89-94df7f68346f; Thu, 9 Jul 2026 07:52:23 +0000 (UTC)
X-Farcaster-Flow-ID: 13451079-5140-463a-af89-94df7f68346f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 9 Jul 2026 07:52:22 +0000
Received: from dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com (10.1.57.121)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 9 Jul 2026 07:52:20 +0000
Date: Thu, 9 Jul 2026 07:52:19 +0000
From: Darshit Shah <darnshah@amazon.de>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <Jonthan.Cameron@huawei.com>, <darnir@gnu.org>,
	<lukas@wunner.de>, <feng.tang@linux.alibaba.com>, <kbusch@kernel.org>,
	<kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <olof@lixom.net>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v3 RESEND] drivers/pci: Decouple DPC from AER service
Message-ID: <ak9S1csRUf_tR8pV@dev-dsk-darnshah-1a-8576ca1e.eu-west-1.amazon.com>
References: <ai8h-wyXz8l30X-V@dev-dsk-darnshah-1c-a4c7d5e9.eu-west-1.amazon.com>
 <20260622170329.GA675275@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260622170329.GA675275@bhelgaas>
X-ClientProxiedBy: EX19D044UWB004.ant.amazon.com (10.13.139.134) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Hi Bjorn,

Now that v7.2-rc2 has been cut, can we please queue this up for v7.3?

* Bjorn Helgaas <helgaas@kernel.org> [260622 17:03]:
> On Sun, Jun 14, 2026 at 09:54:17PM +0000, Darshit Shah wrote:
> > Hi Bjorn,
> > Can you please pick this patch up in the PCI tree for the next version?
> > Anything I can do to help expedite the process?
> 
> Sorry, I missed this and I don't want to add new changes right now
> since we're halfway through the v7.2 merge window.  Can you ping again
> after v7.2-rc1, and we can make it v7.3 material?
