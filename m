Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B711A681B;
	Mon,  7 Sep 2026 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816875; cv=none; b=tbNsSkPJT+6BOqcpfKPcP5JzzYi5WPDi+nNKPZfSXvRlbYMY3/VnftbNGCu7uQ36r2WJ/i3yrDJMyUJeu/sY4sIdoTZiAOqUcJ/AbfT7ZWRhFnAFLWki5D1YhTuk+cVYAPBFKrNKOitOBan4iaqWjl4c1XDDVIDKDBKS0k15MwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816875; c=relaxed/simple;
	bh=vm2McZkHqaANVqUSfuCQ1ACPPaLD7b8TIB/iVn8Q+Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DM2lR6Q4EP6UCRYiYEqHNYQNKMJYtSJPEqrkij75g6V/9JK2vKjtdGR8IOErUR5pPcu4UXGcoU6FXdS5ylB3f1RCskJYTUE9+sO4A6N+ycdMdKzFCg50WSptZr+ySdzdOiL7PvFXjKDIGXQOzlm8fgC0k/9WNFwdA7v1mOpfoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAtD7Ww7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAtD7Ww7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788816873; x=1820352873;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vm2McZkHqaANVqUSfuCQ1ACPPaLD7b8TIB/iVn8Q+Ls=;
  b=kAtD7Ww7zzrI1eWEzWDNN+0l3mQQVfDX1dfHoW/Zkj84zTkjdFXOqNmb
   gvNMwNZp2ON+M7jvVjvhP/D/uUR7vnZWPoCpBoAeTrts2MWnTnilz+JNP
   hKD50UlJLnh9MOvxQoOXWWiTKwMHAPE1tqYdgBIAyYe52euN3CYMiSEvK
   Sje++/G2dNxfnfmKGM3LBPzsnOWu6LfkTibrzVJ1eMJuD8tou3BN2b3WB
   EnxGuiz02qOvJ2WCo76DWnfuhQYgcdOWuTtdmoP6v00bwk7pvIjoxP6YI
   lTWykfraV8kugz+yL52ofL6OVl9OGdcnJAWDuspXIThAi1dz2t6XFrWOV
   g==;
X-CSE-ConnectionGUID: exKeijBKSSW2zqSRQ80sBw==
X-CSE-MsgGUID: wFTv1MR8TjGvTEbA1tNPjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="106732943"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="106732943"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 14:34:32 -0700
X-CSE-ConnectionGUID: gXsGUaejTeiVdLQQWiFsfQ==
X-CSE-MsgGUID: rQR0vMokQgKZrvUuLshzwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="271326046"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.80])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 14:34:29 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 90A7611FA3A;
	Tue, 08 Sep 2026 00:34:30 +0300 (EEST)
Date: Tue, 8 Sep 2026 00:34:30 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peixin Xie <peixin.xie@linux.spacemit.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/4] ACPI: scan: Adjust power management
 initialization and PCI devices handling
Message-ID: <ap8t5qhuEll-Xx4N@kekkonen.localdomain>
References: <6044499.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6044499.DvuYhMxLoT@rafael.j.wysocki>

Hi Rafael,

Thanks for the set.

On Thu, Sep 03, 2026 at 06:57:09PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is an update of
> 
> https://lore.kernel.org/linux-acpi/5144065.31r3eYUQgx@rafael.j.wysocki/

Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
