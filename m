Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597883A3E9F;
	Tue, 31 Mar 2026 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983666; cv=none; b=UFU+9/nYNgCkMSFTfQtEJ113Bkdi/feG8YerutiL7W2vnDxms+8ATpmbRQvZrLgyDdP4DW/Rz/gGjNerije6FvFpGM/InvrKueuJZCKEvMS07fwXrP+J/zFKgaP1buln5ZLwATUBe63T+7cxSc5ewsVpCdz09oWZCXB5Pys1qpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983666; c=relaxed/simple;
	bh=3uHrsF3qZfNn9H8Vl0JvpMLblR94CJB11jyUyCdYt+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWdMIwAahpN5RceiG4wZDMlmkwwET3sSp5Ck4H3y5oRMHpgs7kE30+ULmsMSWg+IqffbqQpfYrTPyvNqlCtolVK968nbYWSbrsFDzEAVpJGvf5fRApUFoNgjQpH1d+VfsyamSb+WI55FAYiwIByr1XmxK0RrrmDvk2CoW8wxd+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qroe8Hr+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qroe8Hr+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774983665; x=1806519665;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3uHrsF3qZfNn9H8Vl0JvpMLblR94CJB11jyUyCdYt+Y=;
  b=Qroe8Hr+rG30xpeVTVpp+EJdciEyDL7tIBLjE4TsNIxMZC8wiKpacuhV
   ANv6gNBEnQsWLNzlHVXyEL/1B1Rnd7KE7WA4n5zQV5vG3CF03xRex4V5z
   4+vtKtwfVBseO/Oqg4ObXYRyfPiqZO1q7grt31hUR3j6Q7F7qeQm00/9H
   WP+nfxxnBUmI+yosyk8rTX5YfY00FnvNwn9Hhnj+RdbRu51l31/Wf2IG7
   DmUz097QVrf2gNmj3dBziKtswog7fuLD+sps75pKQiS9s5faa3CHEZ1sd
   z3nsxY6IQv4r4ChgaoS1kIKMIDXwVWDYxj2sf9AYLm0FmfgUoazahbDA4
   A==;
X-CSE-ConnectionGUID: mBnej+hYRgewv+E/8dKl5Q==
X-CSE-MsgGUID: 8pYxFpOZTV6/+jB7eTGozA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75902219"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75902219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:01:05 -0700
X-CSE-ConnectionGUID: A7llO41NQSyugjNg6Rseig==
X-CSE-MsgGUID: rcMlSJZbRa6BaM772mg2uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="249663436"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:01:01 -0700
Date: Tue, 31 Mar 2026 22:00:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Matlack <dmatlack@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	Raghavendra Rao Ananta <rananta@google.com>
Subject: Re: [PATCH v2] PCI: Disable ATS via quirk before notifying IOMMU
 drivers
Message-ID: <acwZ6zYo5bjp2t3l@ashevche-desk.local>
References: <CALzav=c7CuJmRjW0-KVk013r4pZZ_CsRtApn0rw9py9cTE-K+w@mail.gmail.com>
 <20260331183852.GA150014@bhelgaas>
 <CALzav=daA0ut2FE-Y07WtYoj45afVte=kh=SNegQ=wGyD+tWvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=daA0ut2FE-Y07WtYoj45afVte=kh=SNegQ=wGyD+tWvQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 11:46:22AM -0700, David Matlack wrote:
> On Tue, Mar 31, 2026 at 11:38 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Mar 31, 2026 at 09:01:53AM -0700, David Matlack wrote:
> > > On Fri, Mar 27, 2026 at 2:17 PM David Matlack <dmatlack@google.com> wrote:

...

> Yes I would like to work on another version. I have 3 things I want to
> investigate/fix:
> 
>  * Fix the bug Sashiko found with early vs. header fixups.

>  * Investigate whether no_ats be a u8 instead of unsigned int to avoid
> increasing sizeof(struct pci_dev).

Use `pahole`, it will check the layout and suggests correctly what's going on
there. It's not a fuzzy AI :-)

>  * Investigate Boalu's finding. Maybe this issue is specific to VF
> creation, and changing the order of calls there would be a better
> solution.

-- 
With Best Regards,
Andy Shevchenko


