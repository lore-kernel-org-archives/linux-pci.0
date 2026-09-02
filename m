Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB635A3A4
	for <linux-pci@vger.kernel.org>; Wed,  2 Sep 2026 02:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315147; cv=none; b=NH3x1ibzs0DTOXSQIwJgP1Zrksaf22oB8Ufy8hH42CvQrzCath38/hD9FtDJrrPN8DP6qsh+AP7cbdscB+MgAIxpFCv+kNH6OD61XrN0vN45fD+Oypb9RabybZ7R7bQhJbjwJkvYp7aU6hFRdk/CrKLkehQ9la5Q3L6BbAfCxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315147; c=relaxed/simple;
	bh=M99JmKWcrLHU0r0FrIqPbA2I/sj6H0qv2/5vaRniUQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyzW3Pyyp3ILxnrCZOCGOHKEqhrUtiE+hVPlDDhkYbYdudpzNyVX+47QGhRN1DVNUdQlF+mBjTJIBjtfprxMuxln0YKKyW/iyJmkQHIdLtnP6vUNdD0JCZ5sNnf+QMtqiR3ZdJl6TkKKzbHddBwtO9Auaiwx2isSDD5weRA5gHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sm/21Ztq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sm/21Ztq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788315144; x=1819851144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M99JmKWcrLHU0r0FrIqPbA2I/sj6H0qv2/5vaRniUQQ=;
  b=Sm/21ZtqAGeP1b6/6qMFRXpF4dRN5C5Nu2u594mv7ruaNcNJfAZpxUIH
   NbkSjalJI8+ceTevkQ85cRtTEjoAP5yC84ZAnIcDXYAq0uVJFMssFOq3y
   vQqx9kQ4d1Y/gcf/v1ZA+hHUtx+tdfHtSDTXJH9BUb18XVIX6/5kLtZQS
   S6/ZTz4YLIm+6LJciPnhTvuVOt8/dCiJ2RQDv/Awom3nvfTtfEKoEX4Xp
   aKKiNXceQa/lgu18IH/w5oZRLWmsmpxZRG+T1mZ68P9LzZZE6YmdiHu4q
   KxAAD6uTgRSxuh7SvmAIFIY4G8GkwFDBOJYLFg8zZFaXK6G1qBz5PF5nw
   g==;
X-CSE-ConnectionGUID: Ud6LnT8LQymGUQ00VWAXJg==
X-CSE-MsgGUID: QuUKOZcOTKmoakAfe3Spuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="76313671"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="76313671"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:12:22 -0700
X-CSE-ConnectionGUID: 4Xe6dTtPSSy7EjngLXTjow==
X-CSE-MsgGUID: cuOZuHybSh6IscNsR27guA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="264978348"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa006.fm.intel.com with ESMTP; 01 Sep 2026 19:12:15 -0700
Date: Wed, 2 Sep 2026 10:12:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, ankita@nvidia.com
Cc: Alexey Kardashevskiy <aik@amd.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	ankita@nvidia.com, Aaron Tomlin <atomlin@atomlin.com>,
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
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	yilun.xu@linux.intel.com
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805005533.GB28508@ziepe.ca>

On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
> 
> > Glad to see you all here to make progress! Intel can also help on this.
> > Can we have a meeting to discuss on these topics? As Alexey mentioned,
> > previously we had a bi-weekly call, perhaps use that for our first
> > meeting? Or what time works best for everyone?
> 
> I prefer we defer such community discussions till September, that
> seems appropriate given some dates I've seen.

Hi Ankit & Jason,

Do we have a plan to schedule a meeting to discuss next steps?

If so, we can figure out a specific time on the Discord channel.
https://discord.gg/KKqC438c

Thanks,
Yilun
