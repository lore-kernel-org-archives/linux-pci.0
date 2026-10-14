Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D950315D49;
	Wed, 14 Oct 2026 10:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974979; cv=none; b=FwKA88rwrBZORmoEOQAYoS7SZdRz4aoEWlZwuMDDQop2kIinj+9/bHYBTbukGKhYoaJ3pB/kdOTVjHRGMmV3UCWpn/6DiI1eMox5Rz+k3FfHrK1LklMZE5WNF7eIHD3VS2R1UtfR7C3jOA3uzyqGbKy/oJpPy+heXGXGPcu1fgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974979; c=relaxed/simple;
	bh=SYndeIL2OyGAgFcsQ/c8b1TXaO0N4OHAMqKFnt96oV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roaDtz4aLxR3FvPwQhhSBlrMhl1FE/zLvE3JizczJgHhVa+kHD02QBRe5/GY8g5fok4XGeKR8MdyHMAFMl5uUYnVqbguHGMWOoEAO8oTR+q+f1gW8Rj+gCdQc2YyGa/lGa1+URs5/+c6GfXSmwfh7nT7AITUPBjjqTuqdI9HcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uqjc/fmB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uqjc/fmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791974978; x=1823510978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SYndeIL2OyGAgFcsQ/c8b1TXaO0N4OHAMqKFnt96oV4=;
  b=Uqjc/fmBWX3B+jaQz5XHl3uRYaoMeFzWTWF9QXwti3c9YkglM1aTpnx4
   79IRXeYbU2AkYyF007C65fdMeUtfMWgoDbeq7feLqfnyRLhI+ZSVEC3rI
   R7jpII9mn61zTx+/NC3PW66UJu+HpFQtNLWn7u6BYA879hWPL/DjcdcQn
   PLQvbkTQGNQinjie60Vcdclvq/VvwIMR2FnAS0WCEKD+b/J1bmcEuPTTg
   QjeN7EITg9t0elArAYq+LHPrQtnlvBfHNldomK+kPRzIkbgxYMvF34zC5
   EFlqWm8D3jfpslpiw5mxpUeyyI2HW4FPZf4AeIsfMQB0xiAEVzdh2nUxH
   Q==;
X-CSE-ConnectionGUID: /eNERzT+TIaPGRk8kXEopw==
X-CSE-MsgGUID: 0WtaaTIzRamUHrEaTi1CIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="728330"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="728330"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:49:37 -0700
X-CSE-ConnectionGUID: vhvZ6D5ZTIWyqAVTi2e/Wg==
X-CSE-MsgGUID: KQ139RqBQFa/9SuURfgOcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1345846"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:49:32 -0700
Date: Wed, 14 Oct 2026 13:49:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Hans de Goede <hansg@kernel.org>,
	Kai-Heng Feng <kaihengf@nvidia.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Message-ID: <as9eOZjjRtW7dqAM@ashevche-desk.local>
References: <81b4f4bf-b721-4b5b-8ddf-d040865f02b2@amd.com>
 <20261013224010.GA1589480@bhelgaas>
 <20261014004321.GBas7QKRYgjdcIPLHb@fat_crate.local>
 <3f578b9f-cdac-4bdb-8f0a-f5b3a48f6622@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f578b9f-cdac-4bdb-8f0a-f5b3a48f6622@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 09:41:48PM -0500, Mario Limonciello wrote:
> On 10/13/26 19:43, Borislav Petkov wrote:
> > On Tue, Oct 13, 2026 at 05:40:10PM -0500, Bjorn Helgaas wrote:
> > > But I'm frankly terrified to touch it because I'm skeptical that two
> > > more quirks are enough.  I just expect that whatever strategy BIOS
> > > uses to build these maps is likely to be used on many models.  I do
> > 
> > Do we have an explanation why BIOS is doing that shit?
> > 
> > Mario?
> 
> If I was to guess; because Windows allocates MMIO space differently it
> hasn't been a problem.

Oh, I can confirm this part as I noticed the issue on 64-bit addresses for
Intel LPSS at some point exactly due to different ways of allocating space for
the devices for PCI. Id est one is goes upwards (from the start to the end of
the region), while the other downwards (from the end to the start of the
region).

> Which begs the question; does Ilpo's series improve things enough that we
> wouldn't have these problems either?
> 
> Maybe we should just tail my patches on Ilpos' series and then land them
> linux-next the very beginning of next cycle and beg everyone who was
> affected to test linux-next.
> 
> > Btw, Mario, you should replace "Genoa" with "Zen4" everywhere so that it is
> > more clear to people.
> 
> Ack; if I send mine out on their own I'll adjust.

-- 
With Best Regards,
Andy Shevchenko


