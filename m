Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981170;
	b=O0kwZXswD+f/CYvJ5/I2KKxHaAG62uf9kcWymoQaaLSNZsC3CQSJGu9mGTR80jgJjz5s
	 0VbTfmSQEz3EeZHnNr83ihx4AbLzVKkSNdKB4SvVLWZjie4OOSH8RK3zwnftQVeS+bkcq
	 GvbPFZ+it2TtjGrvKV/J3fqqC0lrI2A5ZbylINJTs9n19XQzSb/7I6JvNtwiD1nTl0CTH
	 zI+4LtcU1LNFGbGf0pfCjuLuZQu/PxPgutPRnMROZPs4Emp1RYbaNr8yilLlIeqdcofFU
	 ktszzxagR4EDy5SJFIXOwL+/50MmJoN0f41LJs75n40BRgR2Ls46hdNNmawUNzc1B1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981170;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=0Vlq6ue+qh7BHW1GAYP75/3G3+W8nkqGjXsQh3xHgHI=;
	b=cSBLXGLndL6LtcGpmOPTRqJiJ4OKw8B/FpyK3Zl7BCCElkczRFgPvcC2+otGp693kZTB
	 KoGqME8T1PVdUVBBi/ajIu5DILwgYWNWwpx7Sy+f4WUGL6ufZmP0LMuQwbkY6K+bJsEdY
	 nsSDvKwWEB9a1UZMFyg5v4UkBYLEFAPCGHC6E2T/8Y06VkcOXQaC6fttvW773eIBGsOOz
	 Am030UaJwuBNAvcvXgBWgN//0iPT9kyGsMlTmzlcOzt4VbbUYSrJRr13Y01Ba6ANhNvsl
	 KgGr9vBx0KN5+idZ8H9B6aODP3Lojz1A9ac+MAlneeXMm90XFWZdImXD+BneHanOEIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PsYEo9qQ;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46362606A31C;
	Wed, 18 Nov 2026 05:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46362606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PsYEo9qQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794981170; x=1826517170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Op3BBcwuhcAl8R5kAUSSotauL18FdPRMmQONGuXPJrA=;
  b=PsYEo9qQbjd/0GeFTcpimUt2bFMi8a7ArlsqTnM85v8TdS4tnaZowijC
   gAsrl6qbvvhSFQ8X/zo/6lPAf69sQwL0TQE0v8qN7mw2Iwp0GI+h5GmI7
   ces30SMwoH/jQ2mmUHuf4NeP9RjkxZPJHrz4k80NJlMTpdGos+bt08ciH
   Gtnm4E5jQ976hq/UybfbF7+y4eqLgP7MVLZdjvv2vl+zfcwjvMyG2Ulgj
   Pg2SVBrXfQ6W6kQEDOaBxfoTk+Ao/EMlFsTlVlGjTtAqhSSDQQaGA8rdy
   dtg4WhRwZ8HwAHSIeRiejBMtaVnFHmj/o8skg6xZ2TTx+tZTH9JCTsyM5
   g==;
X-CSE-ConnectionGUID: FuzcPuq0SdmanTGNstJ3aA==
X-CSE-MsgGUID: WE8xQ217RhqHC0p50Ikb9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3675596"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3675596"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 21:52:49 -0800
X-CSE-ConnectionGUID: gXn+umyoQZWIFUgmMMjR3Q==
X-CSE-MsgGUID: 1wZpSS2/SGS1eozYqf7vOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10407132"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 17 Nov 2026 21:52:48 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 6877199; Wed, 18 Nov 2026 06:52:46 +0100 (CET)
Date: Wed, 18 Nov 2026 06:52:46 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
Subject: Re: [PATCH v3] ACPI: PM: Avoid initializing power management for
 absent devices
Message-ID: <20261118055246.GA229695@black.igk.intel.com>
References: <13013440.O9o76ZdvQC@rafael.j.wysocki>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13013440.O9o76ZdvQC@rafael.j.wysocki>

Hi Rafael,

On Tue, Nov 17, 2026 at 08:09:45PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Commit 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power()
> early") removed a device presence check from acpi_bus_init_power() which
> in some cases causes power management to be initialized for an ACPI
> device object and never used going forward.  That in turn may prevent
> power management from working as expected for other devices.
> 
> Namely, if a given ACPI device object is not enabled according to its
> _STA, find_child_checks() will return an error for it which will prevent
> it from being used as an ACPI companion for a PCI device.  Thus if
> acpi_device_init_power() initializes power management for it and its
> initial power state turns out to be different from D3cold, it may stay
> in that power state forever.  If it has power resources and they are
> "on" during the initialization, they may be reference-counted and never
> turned off.  If they are shared with other devices, they will prevent
> power from going down after attempting to put the other devices into
> low-power states.
> 
> To prevent that from happening, restore the device presence check in
> acpi_bus_init_power(), but also adjust find_child_checks() to return
> an error for absent devices (instead of doing that for disabled devices)
> in accordance with acpi_bus_init_power() and the existing check in
> acpi_bus_attach().
> 
> Fixes: 2f4ddf2bd1ba ("ACPI: scan: Stop calling acpi_bus_init_power() early")
> Reported-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
> Tested-by: Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
