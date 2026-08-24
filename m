Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BA5376468;
	Mon, 24 Aug 2026 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560305; cv=none; b=r9ls4ydCCgXnNowv80B3dX51bpQBHXJktW4qlkMrc9i/2HgqOVbYw7W7pppYwMhMekTECY6zCZQlCSmE8N/XOFSD9Et0zIAd1UnEEmq98BSK4iDKqFOaHuIQOE1wc7LhSKpbIU++dfpCzNXCpSjyaqDEysnrTInBZ5Ql2ryU3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560305; c=relaxed/simple;
	bh=DWKiYU4i24WUZH4CXWdxvN78k5dwvNbtFfCATLJNa4U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hxyrlaKFRCH9rAUk9hJ1FIpkKUI7erluAFnNAG7pt6RtMbeVIH6eN3N21e3F4llF+CrDyd1PYMV9gpt74qt2ZkixiEzElSuuC3Cj8TiavfeuOTzOHqMxkGRI/IJyoY5ZmwQxVaRzwI5QJhppexnU6CTbHXROh4hg/6OduWN/o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a4ygZDsw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a4ygZDsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560304; x=1819096304;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DWKiYU4i24WUZH4CXWdxvN78k5dwvNbtFfCATLJNa4U=;
  b=a4ygZDsw3x0Kaag1cM246LqqOOt2ytOYpSG54Vg2mhSnIoqTLJcVQYOD
   X8EOJLrCTJhFoQVB6YD2I6QAt3g8OPtuZFQayTe4ssQJ/iB1ZJCZZhruz
   wimGVJgUvvTjmJrLl40V1ue/Y4sbYP4G3ouNF0YS4lu9xQD6cPYx42jjO
   YwlTe+7zja5Mwnl8W41MDRz9CfDGSx3Sp7v18eZh0AcMpPPk1YxcTq4o2
   kVELtC7psj1WLM/SXSXZW3udU5I9X/b4IPktNpC+E2EB0r9ODXlK43HPv
   RRYEF+kUwQiOMNPfv8wCsa8no0mA/zZQ5xKHYpN3bOCZHUUX+bDfS9W4i
   Q==;
X-CSE-ConnectionGUID: ihAOmNLiRBObrDxOrhU+RA==
X-CSE-MsgGUID: yx8jOyIySmeYfwrkrfAOiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="110790607"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="110790607"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:31:43 -0700
X-CSE-ConnectionGUID: uCn8Vy/dTO6+JLE/90JS3g==
X-CSE-MsgGUID: slspkhB6SMKEbKUpS5Jerw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="291791478"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.154])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:31:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Aug 2026 11:31:35 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Bjorn Helgaas <helgaas@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
    Sergey Senozhatsky <senozhatsky@chromium.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] vsprintf: Add %pR human-readable size
In-Reply-To: <ang5fyuOzQkCSmlC@ashevche-desk.local>
Message-ID: <0ba9c036-2202-88b7-3d8c-fae84f22d8b7@linux.intel.com>
References: <andqwn7I-YCDqmXI@ashevche-desk.local> <20260808234530.GA402575@bhelgaas> <ang5fyuOzQkCSmlC@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Aug 2026, Andy Shevchenko wrote:

> On Sat, Aug 08, 2026 at 06:45:30PM -0500, Bjorn Helgaas wrote:
> > On Sat, Aug 08, 2026 at 08:43:30PM +0300, Andy Shevchenko wrote:
> > > On Sat, Aug 08, 2026 at 12:23:07PM -0500, Bjorn Helgaas wrote:
> 
> ...
> 
> > > > +	if (res->flags & IORESOURCE_MEM) {
> > > 
> > > Besides we have resource_type() macro, why only this? I would expect
> > > IO as well as 64-bit MEM version.
> > 
> > We could use resource_type() here, but would have to check other bits
> > directly (IORESOURCE_PREFETCH, IORESOURCE_MEM_64, etc) since they're
> > not included.
> 
> Sure.
> 
> > I considered including IO and certainly could do that.  IO resources
> > are smaller and it's not as interesting, but maybe we should.
> > 
> > 64-bit MEM resources are already included because they have both
> > IORESOURCE_MEM and IORESOURCE_MEM_64 set.
> 
> Is it guaranteed to have MEM when MEM_64 is set?

While I suspect nothing really guarantees that (by checking if invariant 
holds), I'd expect many things to do weird things if a resouce only has 
MEM_64 but not MEM.

-- 
 i.

