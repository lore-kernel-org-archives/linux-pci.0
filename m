Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800173A5E63
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547549; cv=none; b=iprABCZ64/bdx+NX6Amz5axJmE9wzxeJnRhwFyRpVmgnjmIwl5TqFsOUpMbjuLgpD+EAZXJcL2TtCCt7aT00vhId84oqOK/tx9RKWfXsheJTUIPN9gUgqIiZWVSw8b1uh4/JUM98KxqkUMAlEFISoZ0ivSKf87tUMW+4BFvutnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547549; c=relaxed/simple;
	bh=4k2UoAa3jGPese7gKbNGoKxBaJIVrDFT42bD1vn0Q0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsTG1UIYo4Rt0EnQG7s1O5idk30DJ9jihFaSPAebaWgUhyrHh6G4fw9aTlUAj2mzGXf0BUKtc49Cqlw7qUmqr61laYvR9MT3+83nFq5IZPRFQM5LVrVSaIYCyP0bzzJ7QMdbX1eLAvjJxX4Ne4XvFYLN6GOXEAfzoIciuqgKQe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNTyzfTI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNTyzfTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774547545; x=1806083545;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4k2UoAa3jGPese7gKbNGoKxBaJIVrDFT42bD1vn0Q0o=;
  b=LNTyzfTI5O14QCSzjRxuldBo8rbjnoW5qkcchHdgLnwV49jhkkh7K+ve
   uNItKpHBpt27dALO81XgIFU6TQarjUKjnhsl5P+ty5ghEN1IoTF2j+iXD
   9r6WhGANo4UmBSjdCCC5oI4u36IMnLOyDkmy9LRdDQBK8uo0YE2MyfaV7
   GrTudv0qPsfrm75jjwSilP5IyVQIFLVHkOXIxlU9F/X7nE3pJZahBpM0w
   5RWNQSUqDMYZENamTVIHSBBNoO9H+/g/gXe2D6W7oz6MYwqnqt32MY4w+
   UIpPpz2CpeoxmEZ2Q3Y8cRUazkkVnQhHidmfKs07399sQ9WC5pgAkp8FY
   g==;
X-CSE-ConnectionGUID: 3uSO+R3LSM6eDCFjAlLuqQ==
X-CSE-MsgGUID: DWK6pdbeSrG5UoEF8fp9HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="63172704"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="63172704"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 10:52:10 -0700
X-CSE-ConnectionGUID: TtybrToDQ36N8J30nTRZuQ==
X-CSE-MsgGUID: TzhGUMQ5Q/CER0ZP3jQesA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="255569170"
Received: from patelni-desk.amr.corp.intel.com (HELO localhost) ([10.2.248.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 10:52:07 -0700
Date: Thu, 26 Mar 2026 10:52:07 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Lin Mohan <beilingyu65@gmail.com>
Cc: helgaas@kernel.org, jonathan.derrick@linux.dev,
 linux-pci@vger.kernel.org, szymon.durawa@linux.intel.com
Subject: Re: [Bug 221137] New: [BUG] PCI: vmd: Missing Mode 3 (Dynamic Bus
 Offset) support for Intel Arrow Lake-S (0x09ab)
Message-ID: <20260326105005.000041a1@linux.intel.com>
In-Reply-To: <20260227012039.85131-1-linmhwork@outlook.com>
References: <20260225235631.GA3793102@bhelgaas>
 <20260227012039.85131-1-linmhwork@outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 09:20:39 +0800
Lin Mohan <beilingyu65@gmail.com> wrote:

> From: "Lin Mohan" <beilingyu65@gmail.com>
> 
> On Wed, Feb 25, 2026 at 23:56 Bjorn Helgaas wrote:
> > Lin, there's no need to open more bug reports for the same issue.
> > More reports just become distractions.  
> 
> Hi Bjorn,
> 
> Apologies for the multiple reports. This is my first time reporting
> a bug to the kernel, and I am still getting familiar with the
> process. Please consider Bug 221137 [1] as the final and formal
> report; the others can be ignored or closed.
> 
> > One of the comments here does point to a patch series that looks
> > like it might address the issue:
> >   https://lore.kernel.org/all/20241122085215.424736-1-szymon.durawa@linux.intel.com/
> >  
> 
> I previously attempted to modify vmd.c myself to fix the issue, but
> my changes were not successful.

We are working with the feature owner to submit patch series.
