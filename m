Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD0F368D63;
	Wed, 13 May 2026 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654914; cv=none; b=foNQ8l+zLCotDHQ0xMnpFrYidoH5Uw/pF7qW3Upasz0+tnm5Qu0px6q4B48tcDlZWssyATbGXxKWdWSoesXL/X6Ipf/xS28MmaIpdKmR1mwyWTKGAFz7GFVL6npFGjALcmCKoc6xClICWV7+nEjkCaEG2KB0m33Xw2udawMUAPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654914; c=relaxed/simple;
	bh=2RH8tKgpPmkhEa9e0IOqJAqA/QLBYFdqcE4LuWPNWzs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JoL00OMvedZoYTdYkP5zulHSnrFP28xQy4tXGImxkbtDiGUnGnI40vhbTUfxq0I35SPALyiVi+WW9bwPyJYac32TPD6+sYcpdHo9adiUOlnS/E998YN07QvdrMxmzLvlR4ESsYJupeW51qW7FqxoHx0nHhTb5FewB/5XU1z8Cj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wo5Cffxm; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wo5Cffxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778654912; x=1810190912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4050Ja60FBemT1rYhgq1Wu5eT2TLOSkcCjhtsGlN2Rc=;
  b=Wo5Cffxm5SZTwSjL9ogp/bYssN9MOkRxglH9+qY0GeZw2bDGmwHpreqV
   SVr31vpew8YZnyaKBRu3SE1941QJBqOFBNJRFjY+AUJtNBWCcVUSzK796
   Yy2wSiDYT83MohXcoMDvAPU+eNfjJyCGDf4ZcX4QrdgXbjc5rYN+mINGM
   bDdjUoVNxKmEDSdnGZzCO6Qs4PxvhaS+vb5RVfF1ci2xo5soelwszBfUT
   OpfQXF4wKmN5QIQMkk/qNisku5LKNZ5sdJUzkVqSEIFtIEo6taXNkUbHi
   V/UCo5ONvtc681Dw7fVYUqAsWaWdRMYWwh8zNCvAufnx7D2b3gmvvIynv
   g==;
X-CSE-ConnectionGUID: RRWaW79YTCujp9jG8qol1g==
X-CSE-MsgGUID: np0IMev6SLaOeP5q7f8BOQ==
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="19394097"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 06:48:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:23374]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.235:2525] with esmtp (Farcaster)
 id 808be7b2-09df-478f-ba29-20f50300f393; Wed, 13 May 2026 06:48:32 +0000 (UTC)
X-Farcaster-Flow-ID: 808be7b2-09df-478f-ba29-20f50300f393
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 13 May 2026 06:48:31 +0000
Received: from dev-dsk-ravib-2a-f2262d1b.us-west-2.amazon.com (10.169.187.85)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 13 May 2026 06:48:31 +0000
From: Ravi Kumar Bandi <ravib@amazon.com>
To: <kwilczynski@kernel.org>
CC: <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<ravib@amazon.com>
Subject: Re: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap handler
Date: Wed, 13 May 2026 06:48:20 +0000
Message-ID: <20260513064822.39534-1-ravib@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513043934.GA4124219@rocinante>
References: <20260513043934.GA4124219@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

On Wed, May 13, 2026 at 14:07:02 +0900, Krzysztof Wilczyński wrote:
> There also exists pci_device_is_present() which would attempt an actual
> read of a vendor/device IDs, so if this succeeds, then you have a more
> solid assurance that the device should be working.  However, this adds
> latency, and there might be side-effects, potentially...

Yeah, exactly - it adds latency and will be more profound if applications
mmap the resources periodically.

> I wonder, if for you, you could forfeit setting any flags on a resource,
> which drivers don't customarily do, such that we would only rely on
> checking pci_dev_is_disconnected() on our side, so to speak.
>
> We won't be setting any precedent here, as the helpers such as
> pci_read_config_byte(), perform this check internally already.
>
> Bjorn and Ilpo might have different take on this, though.

Thank you for the suggestion. Yes, we can forfeit setting
IORESOURCE_DISABLED and rely solely on pci_dev_is_disconnected()
check in pci_mmap_resource(). I have submitted v2 patch, please
review.

Thank you.
Ravi Kumar Bandi
