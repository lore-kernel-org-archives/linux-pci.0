Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD27082D;
	Sun, 30 Aug 2026 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074478; cv=none; b=ZMiIYal52Usc9wRldrh9yeWLPVf1GtHagafzB+jwDTnmoHX/C6oPIdRj4eG0qTdRpZdAebRdQ69Y74W2K0l2yIrZ5piC3u81XZsRiLmOjMC2hQQ+6GvhxZNvaJbZY4bnjGGpzOETeS+nBfPQuPmYIaSb1sraS5CsI/la7a2ChV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074478; c=relaxed/simple;
	bh=nZzvt0iW2Q7KLQNgSo/G2fUMX1/yU6BP1yQMPTPTucE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSmP6fBYzS4jT6onbyO85AmKxG+rKXa2RcG0G2CAP+G9ZWtDi7wW736irnx8wUS5W6IEZtu2hP4z3xHtrIBaA65+/ne1CIdPi4e0RtyVHIW9/4KCs55w9CWPPmOS4BnY3Zk7SmK92FcHlWsD/X5TRmeMvE9Q/6GUvgBfrvouKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GCjqVewq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GCjqVewq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074478; x=1819610478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nZzvt0iW2Q7KLQNgSo/G2fUMX1/yU6BP1yQMPTPTucE=;
  b=GCjqVewq9MJCjZ2FeoevQy2hRj0IdbsaLbwk8WDBvBZ8Yg+MImn+xi9D
   sgbLhwlLPS09JeoKapEceJ/JGp2p1G7IfpJ3UZ7Sv9KJPpQONDj/UGguY
   LDNjkU5ijQiHj+ZmOLpnGCmrea+AAssy6viQ5htbmvhMwHsFCqdOAqy+q
   GmFWCvV/ZwTRBEiokx5Tfr3YhCps9t5+4eE2MhktZJnA0EJQcuXsR1WK4
   bIDuhJmaSJsuIs1sXefiSNdHKQuqPYPlnW1P0XOUyOA1kTVh05meKcR2A
   h9nPMZiafy6+9rjYlpKf1vjl4bJ2XqiEtJOBENh2zQHUzNT7lcvnca9ez
   A==;
X-CSE-ConnectionGUID: aha7nHb7TqSB0AxMrZo8ow==
X-CSE-MsgGUID: VUrKNL3iStGQk3JZ4ozsQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="88565404"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="88565404"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:21:17 -0700
X-CSE-ConnectionGUID: Scg0oMW4RY2iI0umtxW6dA==
X-CSE-MsgGUID: 7BYKUOHqQEmEENak+UP5wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="265948510"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:21:13 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	dave@stgolabs.net,
	arun.george@samsung.com,
	dongjoo.seo1@samsung.com,
	s.neeraj@samsung.com,
	vikash.k5@samsung.com,
	cpgs@samsung.com,
	gost.dev@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [RFC V2 03/10] hw/pci: Add SVC capability and UIO properties to PCIe ports
Date: Sun, 30 Aug 2026 15:20:53 +0800
Message-ID: <20260830072053.399466-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <124323713.61787732103161.JavaMail.epsvc@epcpadp1new>
References: <124323713.61787732103161.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:03 +0530, Shrihari E S wrote:
> +static const Property xio3130_upstream_props[] = {
> +    DEFINE_PROP_BOOL("x-svc", PCIEPort, svc, false),
> +    DEFINE_PROP_BOOL("x-256b-flit", PCIEPort, flitmode, false),
> +};

x-256b-flit is a no-op on x3130-upstream: nothing in
xio3130_upstream.c reads PCIEPort::flitmode.  pcie_cap_fill_slot_lnk()
does run from pcie_cap_init(), but returns early -- an upstream port is
a PCIEPort, not a PCIESlot -- and pcie_cap_fill_link_ep_usp(), the path
cxl-upstream and cxl-type3 take, isn't called here.  So with
x-256b-flit=on the Flags bit 15 and LNKSTA2 flit bits stay 0.  I'd
either wire up pcie_cap_fill_link_ep_usp() the way cxl-upstream does,
from its reset handler, or drop x-256b-flit from this hunk.

x-svc has no reader until 7/10 either, so x-svc=on has no effect for
four commits.  Same thing Jonathan asked for on v1: bring the state in
with the patch that uses it.  Here that would fold 3 and 4 into 7.

Many thanks,
Junjie
