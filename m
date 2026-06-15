Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628442FFF8D;
	Mon, 15 Jun 2026 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519391; cv=none; b=eJQA0kAPdQRpiRMNgEyFXtJOw1bXMD3oNmar7NdgBAPiCmEw1J0QPziwhrKWQsb8n+qpeWZvGcVJTSnhTU6RfzTsOaTMF72SlNzaK3jPz/bGrWzZL32G9kSFEC9guel1BkoM115xoi7Cs1BduhXVp8AXpeKZeXAetrdT00+ttOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519391; c=relaxed/simple;
	bh=95oikCD6bcqDfa/hPKgyJHYAikFQMLcqrex4GlXjGLk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AmrbbudHTtvjhltGfgPIIt973EZ8jF83FKRB7OE9aXFWZZdIblcxrqLMEUyoGLcweKnyIRFKgWmtg35j15KYjsN4ZSKMxQOQH2vSZU7Jvud5iOCgKsHwnEPUutnTfBFdrS7SI5Yl56FbMROt7e+HasTH7U3SJK322DxarxBTCIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN9yJb4h; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN9yJb4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781519389; x=1813055389;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   content-transfer-encoding:date:mime-version;
  bh=95oikCD6bcqDfa/hPKgyJHYAikFQMLcqrex4GlXjGLk=;
  b=cN9yJb4hJ4u+hOtaF4/14IRgn1rSPm5ogRFKsbshLJ1R/OaRIPTxWd/G
   T1/DwId9ny86f4CMY76VhvdMQrknxij+mlUP+pxbxyTcTDxeSNflYtMY4
   eUxpZ0GDyphlWCGwsxG55ORpIOqUqjNZXSQdrXzHK9C2TJ1YP7vSx5MhL
   BJTbfdgGUDnH7gGRxcBeplSu4E5oX4ZeC+ZFKBnJc77C8HXS7e8trc2BI
   4QjiZUVhXwa0Z/NveP4uqN2NYUXQAk/T6jfSMy+pzuxWeqfMjp+qUqBDp
   EXTsAKDMLEXWdL9jU5Q0bfFE3Au82ZF3N6SC1YSRn86rUmj127XDRsDL3
   g==;
X-CSE-ConnectionGUID: Pk4RBvYuTtO3Gx8U09/lMA==
X-CSE-MsgGUID: XQby1sgtTjSfOxXCsM+oTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="86154841"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="86154841"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:29:49 -0700
X-CSE-ConnectionGUID: b1opete7TyStu6SmRrAh3w==
X-CSE-MsgGUID: kvuXepRwSUmDqydFhXSoRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="247309757"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.246.140]) ([10.245.246.140])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 03:29:44 -0700
Message-ID: <f2fea5d4e22b97c26424aba0e70bb1dd6d2b84b5.camel@linux.intel.com>
Subject: Re: [PATCH 0/2] PCI/CXL: Recover CXL Downstream Ports from PM Init
 failure
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron	
 <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Alison
 Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny	 <ira.weiny@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Bjorn Helgaas	 <bhelgaas@google.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
References: <20260428182454.464655-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 12:29:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 

On Tue, 2026-04-28 at 20:24 +0200, Fabio M. De Francesco wrote:
> Subject: [PATCH 0/2] PCI/CXL: Recover CXL Downstream Ports from PM Init
> failure
>=20
> CXL r4.0 sec 8.1.5.1 Implementation Note describes a scenario in which a
> Secondary Bus Reset, a Link Down, or Downstream Port Containment on a
> CXL Downstream Port prevents Port PM Init from completing when ACS
> Source Validation is enabled on the Downstream Port. The spec states
> that another SBR alone does not recover the port and describes a
> software recovery sequence.=C2=A0=20
>=20
> Patch 1 extends cxl_reset_bus_function(), the helper backing the cxl_bus
> PCI/CXL reset method exposed to userspace via sysfs. It saves, clears,
> and restores ACS Source Validation and Bus Master Enable on the CXL
> Downstream Port around the SBR it issues. This keeps the userspace
> cxl_bus reset path from leaving the port unable to complete PM Init.
>=20
> Patch 2 adds a recovery pass during CXL enumeration. For each CXL
> Downstream Port in a memdev's ancestry, the CXL core checks whether PM
> Init has completed. If it has not, regardless of what caused the
> failure, it invokes cxl_reset_bus_function() on the child below the port
> in the hope of restoring the port to a usable state. CXL enumeration
> re-runs after events that tear down and re-probe the memdev, including
> DPC, AER, and Link Down, so those paths reach this recovery.
>=20
> This small series is developed from an old RFC v3:
> https://lore.kernel.org/linux-cxl/20260330193347.25072-1-fabio.m.de.franc=
esco@linux.intel.com/
>=20
> Fabio M. De Francesco (2):
> =C2=A0 PCI/CXL: Allow PM Init to complete on cxl_bus reset if ACS SV enab=
led
> =C2=A0 cxl/core: Recover from PM Init failure via cxl_reset_bus_function(=
)
>=20
> drivers/cxl/core/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +++=
+++++++++++++++++
> =C2=A0drivers/cxl/core/port.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 22 ++=
+++++++++++++
> =C2=A0drivers/cxl/cxlpci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 3 ++
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 52 ++++++++++++++++++++++++++++++++++-
> =C2=A0include/linux/pci.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +=20
> =C2=A0include/uapi/linux/pci_regs.h |=C2=A0 2 ++
> =C2=A06 files changed, 109 insertions(+), 1 deletion(-)

v2 of this series is under active development but its design has been heavi=
ly
reworked wrt v1. All comments that are still relevant to the new version ha=
ve
been taken into consideration.

Thanks,

Fabio=20
