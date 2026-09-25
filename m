Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75D367291;
	Fri, 25 Sep 2026 05:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790313567; cv=none; b=Qnkq0LbqTOKmdbIltuMV5Ld6YaadWpFBtmy1wyAE01BK+MDRxkPlGNsUm7TibTO5Q9ko+7NnkQAnfwauwTvT9EG55EnVaQRkqe8yoelCeP0e6h87BgfxPOM5Yh5fHAh4mBqCpUyrb1xaGVU+NAJGu1NupQZduKuoh4z29jkPg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790313567; c=relaxed/simple;
	bh=QvipE+nmmvIqL3oEgR09getShPzEEdCiYqzdEJrvai4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/Eot3zvKGJaxXJRQliHILNCA0k4FbthqKoMT6fJlfrx0MFxomtzvIG9o0XqG7oX4fulbH6Zpkv4rLam43I/E95+neWVfaDqHMZ1KRBPNdm5esYBOY3f9OHBL92rA70z+u+76ivmQofexi0im3yW9cb3zvM/13aBpwSkz8TyZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuJgaEdK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuJgaEdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790313566; x=1821849566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QvipE+nmmvIqL3oEgR09getShPzEEdCiYqzdEJrvai4=;
  b=iuJgaEdK64ybMb4LFsoPm7ySy5dPXusr8XI3T+jbBaYZB0xmz/KVgzif
   6JKxdBx1z7NERYU6A+4RxA1wpNXIfrMNnhEagWQgdXDy16vKvXosAnlD1
   ZpkTTw0WuVRk75uDKOjMwNbyoVKULF6/cAQ/GQja3+hZ8D6g4Bn5YrQ26
   LlcrEBcbAgrtD/Zij3kOu66iXZNNLI0MhOdw0hBNHu/sO1jdHwri5UOwv
   BXkyXPGhSeSiSlBVNJ9PtkIBHCqeoTaQVbAzaspE8kpbD0X6IuqFf7D/L
   5eekI66I5rStWUGPHDT2mKVGt1ibiHtW7QRCu4yD7siu1+wsiTCGkRiFi
   g==;
X-CSE-ConnectionGUID: jwCNswsoT8+sXgpW/ywu+A==
X-CSE-MsgGUID: 6ETbksimRcGg7bNecynjHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90962047"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="90962047"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 22:19:25 -0700
X-CSE-ConnectionGUID: nMbAXwXoSAyFezTuicmMVQ==
X-CSE-MsgGUID: /GSdbPWCSH+S3KPzRuJFSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="282322635"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 24 Sep 2026 22:19:23 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 4C76199; Fri, 25 Sep 2026 07:19:22 +0200 (CEST)
Date: Fri, 25 Sep 2026 07:19:22 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pciehp: Fix hotplug on Catlow Lake with
 unreliable PME status
Message-ID: <20260925051922.GU106095@black.igk.intel.com>
References: <ca15feda-5d63-405d-a4c4-00cbb9991fed@linux.intel.com>
 <20260325061131.GY2275908@black.igk.intel.com>
 <5d6d94b4-458f-473c-84df-c6fab7805dbe@linux.intel.com>
 <20260326061200.GA3552@black.igk.intel.com>
 <3a97fb38-70c7-4ca9-8c49-4c95e1623c91@linux.intel.com>
 <20260327111616.GC3552@black.igk.intel.com>
 <633cef07-2991-4ce8-b8c6-6b091deaeb0b@linux.intel.com>
 <20260407070800.GF3552@black.igk.intel.com>
 <bd8e9c59-afd8-48ac-ad54-64abad8bfbd1@linux.intel.com>
 <161e11c7-af4c-4cc7-8ad5-a5901f231d54@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <161e11c7-af4c-4cc7-8ad5-a5901f231d54@linux.intel.com>

Hi,

On Thu, Sep 24, 2026 at 11:46:04AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi Bjorn/Mika,
> 
> On 9/11/2026 10:01 AM, Kuppuswamy Sathyanarayanan wrote:
> > Hi Mika, Bjorn, Lukas, Rafael,
> > 
> 
> Gentle ping on my reply below.
> 
> Bjorn, could you let me know which of the three directions you would like
> me to take for v5?
> 
> Mika, could you take a look at the acpi_pci_bridge_d3() findings and let
> me know if they match your understanding?

I have already forgotten what this is about ;-) Maybe some refresher would
help here.

If I understand right the root port has _PR3() but no _S0W so
acpi_pci_bridge_d3() returns false for it? Then pci_bridge_d3_possible()
returns false as well and the root port stays in D0? And that should make
the hotplug PME work just fine but you are sayng that's not the case on
Catlow Lake?
