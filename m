Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBFF424669
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349774; cv=none; b=cNTU+sWSQH7M39XcsBg+Int9KqOfx7z7AqM12j1KkT50Saj1NhOizAuIdOehbmqAi5KybldSr4F4OWIaId69RxW845KVp6nWCufABgdZG8abK11Cii2zS5Qfnt/ZIyZqek3WHbpqotGrOB/pbacsG0nqQe9d+/haHgQjIFz+Y8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349774; c=relaxed/simple;
	bh=a0M53qNTJl7DdzDcuLnku7KG+8RSlJca0fHaK4tUanM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWBV78jm8Uen4ntt0AKU5njrL+rKVckrxz9f0sdLdkMlvh9XtdVkMGpQJOg0XALO0O/Iq/B2c+TvaW2iWN45UwkbzZz87hZ+MVXygDfTukza9dlY/iebQoZTubW7AaBnWxA4YnLWk5JIQl+muWUzez4FFLzORntGffOoqFWQfhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6qkyUNq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6qkyUNq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783349771; x=1814885771;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0M53qNTJl7DdzDcuLnku7KG+8RSlJca0fHaK4tUanM=;
  b=Y6qkyUNqAHElR8fKo8Lf2zizRdzGOUDHCRIDQR+lhG9YJrFJOWln4pm4
   URN2aemXj+TXXvZfxaxOfav+Qg05uivylDZl/0gl4pbxCK6HPyMBORIwG
   jqkvlIKtGVmqnZ8+1m1QYI5JtGaSX6I/ujV5XMN80J8uK1jkb7lFgCWYj
   SdLS967TFIpzEtkldlIU1lRIBncqo6K7GJgqGztg46udayLKyEEUYFI+J
   11rXs1rYY6ZV6PatXeVWUsIWXiCXMULLrT/D762iNhHoxPZocKwjVqPuj
   +M1MpvyOHQs+26mbedPj9osTNkzT3JzeItmuLeuSfoBuXGRDtt5iTqUp0
   Q==;
X-CSE-ConnectionGUID: cnd7+lLXRe6UWmkPMKaF6A==
X-CSE-MsgGUID: P40A7PaFQ1+jqDC5NxfsTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="86535355"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="86535355"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 07:56:10 -0700
X-CSE-ConnectionGUID: rcuqeXTHT+GHi4q4UWQbjA==
X-CSE-MsgGUID: inTadKs7SPK9iegipJ3YVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="278084991"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 07:56:09 -0700
Date: Mon, 6 Jul 2026 07:56:08 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: nirmal.patel@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 lpieralisi@kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Message-ID: <20260706075433.000075b6@linux.intel.com>
In-Reply-To: <20260630171003.GA143656@bhelgaas>
References: <20260629170243.269830-1-nirmal.patel@linux.intel.com>
 <20260630171003.GA143656@bhelgaas>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jun 2026 12:10:03 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Jun 29, 2026 at 05:02:43PM +0000, Nirmal Patel wrote:
> > From: Nirmal Patel <nirmal.patel@intel.com>
> > 
> > Copy valid _OSC flags from root bridge only when OS can provide
> > correct values. In virtual machine, all of the control features are
> > disabled as hypervisor will not passthrough root bridge information
> > to VM.
> > 
> > Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> > Reviewed-by:  Andy Shevchenko <andriy.shevchenko@intel.com>
> > ---
> >  drivers/pci/controller/vmd.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/vmd.c
> > b/drivers/pci/controller/vmd.c index d4ae250d4bc6..f9e38f2f926a
> > 100644 --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -910,8 +910,10 @@ static int vmd_enable_domain(struct vmd_dev
> > *vmd, unsigned long features) return -ENODEV;
> >  	}
> >  
> > -
> > vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > -
> > to_pci_host_bridge(vmd->bus->bridge));
> > +	/* Don't copy _OSC control flags in VM, it disables
> > features.*/
> > +	if (!offset[0] || !offset[1])  
> 
> Drop period in subject line.
> 
> Replace period in comment with space.
> 
> Kind of a weird way to check for VM.  I see it's already done this way
> earlier in the function, but maybe it's time to add a descriptive
> boolean based on offset[0] and offset[1].

Thanks for the response, I will add a boolean implementation.
> 
> > +
> > vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> > +
> > to_pci_host_bridge(vmd->bus->bridge)); 
> >  	vmd_attach_resources(vmd);
> >  	if (vmd->irq_domain)
> > -- 
> > 2.43.0
> >   

