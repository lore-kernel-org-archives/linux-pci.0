Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525533D45E6
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951821; cv=none; b=T9ukdwlShRGYKVyxNoWGxPfVL+6UiRvF49419No8L1vdWzUgQmZdaxgTGAnvfowQdKfgVSyinZtfEOgpBZY3XqmM08qVpzv0/FRIGo2qaVdC5+oxR962ySWagBILPRX5X6tbeUTMk+TIdvzEeyCO5XzJ653lSFygNw2zpiFHYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951821; c=relaxed/simple;
	bh=2qGmjHr8BwdKNMGlgNqfwjpserR/vsZjDyu+inwXvPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXaIvnvX1QQY5Dn3/K3Cu/L6lxj2501Y4vrMEMVGIGNQ+KBLvQg8FxXSnJc10Rp+QVI55fZIXm4ksmTMVJ2F1Q2WuelIvm8+Pwj3GaGtwaH1/phVX80c7C17fhFhxXJNU1cgYAm9kT7Rn9zukExumYqtJulyx/WfF9db6suNZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dygMw3aj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dygMw3aj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785951818; x=1817487818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qGmjHr8BwdKNMGlgNqfwjpserR/vsZjDyu+inwXvPU=;
  b=dygMw3ajNTw7r3ZSZ9akPNkZWPMY+RCE0CYQh4idiA599iP1jIc0GrFM
   /RNcGZ1mgzNXp5FbujMPQruyke6xkmW8As260iKuSNLFRbnipluCcwpi/
   AmLFkmZ7wS9PASRZRNznEoTvltxAV+oNX8j2bl7vCzIO8PUWEJIcJUsjV
   ZIK2Q+Jr5pti/vu+TZSW580sozymS7Ubke5J5ECztK5RdzahNWxIBbYK2
   I26wbMGQcMV7VfJpH/bH+3IBBW7D7OCxMZ4ZyPeivp0gi6/zx9yKAFs6Z
   0FDV7nbUzyI+AF1dtnLS1ZA+CJrfxicFXgqLWgxIw73VsSuh4jw9IJ2Fw
   w==;
X-CSE-ConnectionGUID: 9Z25MsFNRj23RnUf6dSuUg==
X-CSE-MsgGUID: WfEWnnxJRmaz/f86udti/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="96886589"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96886589"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:43:37 -0700
X-CSE-ConnectionGUID: FXHi+W/HTN+APuAuGM2vGA==
X-CSE-MsgGUID: V2Ge+fcOTf2qvRb5QF0yhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261936207"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 05 Aug 2026 10:43:31 -0700
Date: Thu, 6 Aug 2026 01:43:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Ankit Agrawal <ankita@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"driver-core@lists.linux.dev" <driver-core@lists.linux.dev>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <anN2QsDpKsAAfAgv@yilunxu-OptiPlex-7050>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <SAWPR12MB999267F65E7DEB49B1F4D9FD58B0D42@SAWPR12MB999267.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SAWPR12MB999267F65E7DEB49B1F4D9FD58B0D42@SAWPR12MB999267.namprd12.prod.outlook.com>

On Tue, Aug 04, 2026 at 08:33:35PM +0000, Ankit Agrawal wrote:
> > Hi Jason & Ankit:
> > 
> > Glad to see you all here to make progress! Intel can also help on this.
> > Can we have a meeting to discuss on these topics? As Alexey mentioned,
> > previously we had a bi-weekly call, perhaps use that for our first
> > meeting? Or what time works best for everyone?
> >
> > https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?password=80705486-101a-4e19-8f11-0baaf92104be
> 
> Hi Yilun & Alexey
> 
> Thanks for the suggestion for the Aug 6 bi-weekly call. Unfortunately I'm on vacation
> for the rest of the week and the meeting timing is inconvenient for Jason (PST+4).
> 
> We can perhaps consider syncup sometime after Aug 16th. Does that sound fine?

It's good. Let's sync up later.
