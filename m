Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139235DA69;
	Thu, 16 Jul 2026 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224943; cv=none; b=q4UzrFYCFokpn85xzZEr4ECCyyV1s1sj9bZP9QHine19WO38GVjDHvt5HbFYVa7IJq30sf2ZpByx8w/QJQ18z4oiFWhkFc9voqq+JeILlJBAnszS7us03y9uobWrgdSR5BbsquCujbxaMT37+JcVJNp0a1/5o7ab4fEx7snTF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224943; c=relaxed/simple;
	bh=+Xp7f/ArbdV6yx+vb8etVADLloYPsK1aH1uNXOgeeXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkwqghJSkPv9MBEWv+h/OFcJ2eEf+jRsNA+5NLl/8gz+Ne3fHDCNJTyP/da1j9IvOUymbFnY7+zd4VSfvPpd+Nf8kW18HDJO1SPTvBYbBqHkQK+pqYo2ymoq5FQjGr5CXvOLbtTAIuTOIpjZ7sOnYe4UchXf1FxdsP+MSRPrQS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=linzj3GU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="linzj3GU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784224942; x=1815760942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Xp7f/ArbdV6yx+vb8etVADLloYPsK1aH1uNXOgeeXE=;
  b=linzj3GUkdGD2A7yxdxevMXyf+E863deLylTcLtjhY1Grcpqi3lQnKFB
   EgCm0qZMnmKLd2b64ndtKJTFLNDRrsIZNUe4IeC66lO8IoOcokr3uwXVG
   NDiq71AqG8mT603NOnkYzXMegkfoqe3SETQP68oUUZd/lQdPENZ3i6zha
   rNdTCEZNXuKXLLwiUeUdVqyWD4afxUv8lFsNQUHaizoojC2JQZfQWmriI
   akHM1wBt/G5vgKxgnUwjTygeXUs4y5ZBanQJjLbNr3Q87bTFfBpx/9V2e
   7+VPxNPXkUWBqqZSOQ6nDz3v5faA56phQd7hoWupoa3oJRVWEOwA7moKa
   w==;
X-CSE-ConnectionGUID: io58n1m+Sq+1L2jPHM+Z9A==
X-CSE-MsgGUID: jRRPNqrHRyey+jFNjhUPkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95547465"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="95547465"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:02:21 -0700
X-CSE-ConnectionGUID: o4wmGmrKR7G3nyJ85y6ovw==
X-CSE-MsgGUID: wR4O9qYvRbCHWa7TKnC3vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="253177234"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:02:20 -0700
Date: Thu, 16 Jul 2026 21:02:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v2 1/4] ACPI: PCI: Use a mutex guard to simplify
 acpi_get_pci_dev()
Message-ID: <alkcqWLeYNukQZXt@ashevche-desk.local>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki>
 <3056272.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3056272.e9J7NaK4W3@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 04:04:43PM +0200, Rafael J. Wysocki wrote:

> Use a mutex guard in acpi_get_pci_dev() for the physical_node_lock
> locking and drop local variable pci_dev that becomes redundant after
> that change.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


-- 
With Best Regards,
Andy Shevchenko


