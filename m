Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62E35B631;
	Sun, 30 Aug 2026 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074611; cv=none; b=Mb3qLiKOLlBf6eGcCMjXqkZ73GySQtf9l7+q+dH3aeA1VR1Isru6QqVF3BTs8T8hROGwYGOq3YkvDrTdxi3qbU7Q3FCcrFmrX0IZpTst/2WEG9Dd0ZondJ8g3xUw6i73zWCVfnY7YAP/LZ7nBAbiVbWejHtcK/Z4C53sHwQ36VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074611; c=relaxed/simple;
	bh=4NIkVkD5IvKDvnVKdz5knljrEMZIwTM5ZESMN5teC6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWso3ine+F0HAH4rkS4uXCLa2Qc8PpkbSTmDl31H643xJp1WHaOKR8VZFxHOQK+AvwxhGQl9HrjLd3mUai5lOGShK4GviCpx1NpHEpIboxeOC/8xiaVT9AlGde4EuS01wTYp0om103i33a08CnMJI/Af96Gpd1d+tvyiad2KkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QM+63VNU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QM+63VNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074609; x=1819610609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4NIkVkD5IvKDvnVKdz5knljrEMZIwTM5ZESMN5teC6Y=;
  b=QM+63VNUaX8vnAUiWsdu1D5M84ImwtfZV+k7MahN5+zNY+Jwq8lfdP7X
   c2bcndSY8A/ASxPSOMHqEfONwI0xEZcKJMfqpWOD4uIraFih6SjIv13/6
   3YzwrC1FG5M4AwcZOw/UttShsj+MSPdf1V46xMVX/10FiaxFegA2t8dca
   vpEh1IIMtCBAI3dxg+2vrKD/kjTz6vvDt45uZJ6524RBTVhoNk8svKH5U
   0q5Ing5vpYafWFrtOtjGHUftwjqISf4g6Bxom6XyoX40SVnXBByqzNGe9
   9Puv2dQLT7SesLnWfARPqHAubqVTE29d+w7bGyVwhfBFnAXdQ9LhMTBAa
   w==;
X-CSE-ConnectionGUID: nyUtlR7WSVi17clsqFTXDA==
X-CSE-MsgGUID: Ot5BrIJQQp2f3jq5aPETUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648965"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="87648965"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:23:28 -0700
X-CSE-ConnectionGUID: cENpL7x0QM2cnZX38v3x2A==
X-CSE-MsgGUID: Hn8JnOpjTG2OFbJHZZERBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="266710519"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:23:25 -0700
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
Subject: Re: [RFC V2 09/10] hw/cxl: Wire SVC and Dev3 capability to CXL Type 3 device
Date: Sun, 30 Aug 2026 15:23:05 +0800
Message-ID: <20260830072305.399573-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1437941060.21787732282637.JavaMail.epsvc@epcpadp2new>
References: <1437941060.21787732282637.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:09 +0530, Shrihari E S wrote:
> +    if (ct3d->svc) {
> +        /* SVC capability of the type3 device */
> +        rc = pcie_svc_cap_init(pci_dev, 0x200 + PCI_ERR_SIZEOF, errp);
> +        if ((rc >= 0) && ct3d->flitmode && ct3d->uio_comp_capable) {

The cover letter says x-uio depends on x-svc and x-256b-flit, but this
only gates the config space capabilities.  ct3d_reset() passes
ct3d->uio_comp_capable straight to cxl_component_register_init_common(),
so those dependencies don't reach the component registers.  I checked:
a type3 with x-uio=on and neither x-svc nor x-256b-flit boots silently
and its HDM Decoder Capability reads 0x00043b12 -- UIO set, UIO
decoder count filled -- with no SVC or Dev3 capability in config
space, and hdm_decoder_commit() will then latch ct3d->uio_enabled from
the guest write.  Failing realize ("x-uio requires x-svc and
x-256b-flit") would keep the device consistent; alternatively deriving
one uio gate at realize and using it for both the capabilities and the
register init would do the same.

It's asymmetric the other way as well: there's no x-uio on the ports,
and x-256b-flit defaults to on for a cxl-rp, so x-svc=on alone is
enough -- a cxl-rp with just x-svc=on reads 0x00042312 -- while the
type3 has to spell it out.  That assumes root ports keep the bit at
all; see my note on 5/10.

Related: ct3d->uio_enabled, the dev->exp.svc flags and the two
pcie_dev3_*_enabled() helpers are written but never read anywhere in
the series.  Same as on 3/10, I'd land them with the code that consumes
them -- here that's the data-plane series.

With the full docs topology (patch 10's example) the layout itself
looks good: on the type3 device SVC lands at 0x248 behind AER and Dev3
at 0x2bc, chain intact, and Dev3 advertises UIO/14-bit-tag completer
with Segment Captured tracking flit mode.

Many thanks,
Junjie
