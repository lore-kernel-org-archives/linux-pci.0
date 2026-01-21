Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D1F2DCF58;
	Wed, 21 Jan 2026 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001272; cv=none; b=XaAi43DflUwV4VkYm1k1Al2zueq8r8i9mDgjGbzlAulgaam+KUSYsP2VEBP3YLZ7KumZGUVMuVNtR07PSNQJp/lnTBSsFzJv7Nayq/N0c3UOWCoiBRvi5SazpDW1Yi97kR2anYmvCXj45br0a/d3AdS1zYkuoR5IJXUhvlfvjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001272; c=relaxed/simple;
	bh=nHlRXVFODBMklV6fneZfIrwsIS3gfTip//Ro1BfcYQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r3pMk3qqEpke4ECaNTbmNvwN69nwhrlwuqhQF8fJ944hVhqVV5kn7YlbJnL4yU0WrCOrBYmx83eCTGTy7VSCSOXcJIWynHhGfHncigpEjM11BJRyxLNg/gywCG96n/sLbU1RpCXOI8CA0Eq2MRrC0ykt7oxw9giRfyv8CCW7oV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=db6rpM7V; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="db6rpM7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769001271; x=1800537271;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nHlRXVFODBMklV6fneZfIrwsIS3gfTip//Ro1BfcYQo=;
  b=db6rpM7V4k9bzoZEfjiK3xsrSW7+wtWqkV7+ZZWsJWZjCOF9FHfW6IlG
   CoDYZeXaG4h3tKh9H0Z+ZaSv8LGYHitG/VWeB5u1/td8ud0Fmbm0s6Ry5
   7BcuTFkVxZWkKrLuoWXpoJahurjpgZhpAj0Md8cswwrxyCynRMNzXWz88
   oN7uLPG4ylrgSNEir83s6ziolzgCpoTKdcZ+0O0qLHurqfCRlhnGXb5wE
   pDb7JlOzSCFc5ueyomQQn7zpSgSZFXCIJn2b6oR+9C1Eh2/p/1NRRZZbg
   gIPtGIFUU51wyd2npPYv0QONpnkZlc0/ofXS5XtgKgFSqDFoG9TlkNUEf
   g==;
X-CSE-ConnectionGUID: +CTEiyBIR9OQYtkrUC99yA==
X-CSE-MsgGUID: JgXc3xQJRNqtvOwIkVcJOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="69424266"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="69424266"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:28 -0800
X-CSE-ConnectionGUID: hjnjCxfXTJio3+iN3Nj4KA==
X-CSE-MsgGUID: snKksqMvQ9GoL9bbvcTftQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206872386"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 05:14:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] PCI: BAR resize rollback fixes
Date: Wed, 21 Jan 2026 15:14:15 +0200
Message-Id: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series fixes two issue in BAR resize rollback found by
Ville Syrjälä <ville.syrjala@linux.intel.com>.

Ilpo Järvinen (2):
  PCI: Fix BAR resize rollback path overwriting ret
  PCI: Fix Resizable BAR restore order

 drivers/pci/rebar.c     | 18 +-----------------
 drivers/pci/setup-bus.c | 23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 21 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.39.5

