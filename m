Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA0241686;
	Sun, 30 Aug 2026 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074637; cv=none; b=AUngEwOInhdVUbEZQKP/TyFu2+ywIl/btHSymGz+ShQ+Jz//y5I8RFZS4r26l651NkTMAR45vcK671E9X0fyBYY7p5oQx7HAmDwwsc5cchoBtWjzcTA81D2AcdssvaX1eJk1H6tpiw0AJCcDqx3u4g/5y5sX68HGNqJjmDkAcAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074637; c=relaxed/simple;
	bh=aQ3/GtP+7FT0jHBto6tRWGX4KNJFHv61L74w2OzzTPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQsOiDuoSopDM8t47MHbFoEZMsDgjfUkenRbBPGjD/PsGm2IRnNHXXbsUBxUbp2XOKI8wvbd/HTK/1oi4dKtBRgr17+Zz7UtsdM25Phvl0meOo7lV427bwMIa6+P8MhtgGa++HswY44n6Lbvzd/Jpe5eGj/qzgEhfeLdtc5YBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PboeEHVO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PboeEHVO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074635; x=1819610635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aQ3/GtP+7FT0jHBto6tRWGX4KNJFHv61L74w2OzzTPo=;
  b=PboeEHVO4ScInv/G1wz2owTOKfSpSzquTknjQduea9KgnRHUzfUsnFSe
   uKFhLz/QYZYg36Nc/PDUYa3Oye8j2ICx4PAUQUeZePzhAq6Fmoe6bnP49
   Q+KDx0qD5Dhi++pfAVbm0NImPwbbX3iFP7U1gliHCzDfhuaJEQz08cEdf
   XthN8BZBloahFKijwo9KefpQmXRy+s1zdABV1+QfVQci1Kf95Uau+eeC9
   VJmbiVOW3o050DTNz2ddH812v9MLBeJiAGgbKufDeo50DG+JnZAUeX6Vl
   aIsLN2ARYBbGpOf5WcBcS+NUKi+ezForLa8H6mr14Qsk/Bysaz6Tt2JsF
   Q==;
X-CSE-ConnectionGUID: WUgZhaLzQNKjaEcLgvFfig==
X-CSE-MsgGUID: N+8Fg1tvQhGMXo9Irpfs7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="99177853"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="99177853"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:23:54 -0700
X-CSE-ConnectionGUID: MX+8LuwiTAyCs4k/h1qcNg==
X-CSE-MsgGUID: HKeYRdhESpmqIchBYOqe/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="270452285"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:23:51 -0700
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
Subject: Re: [RFC V2 10/10] cxl: Add documentation for CXL UIO support.
Date: Sun, 30 Aug 2026 15:23:30 +0800
Message-ID: <20260830072330.399591-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <124323713.61787732282965.JavaMail.epsvc@epcpadp2new>
References: <124323713.61787732282965.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:10 +0530, Shrihari E S wrote:
> +3. **Device 3 Extended Capability**: Enabled via ``x-uio`` on CXL type3

x-uio on its own doesn't get you Dev3: ct3_realize() adds it only when
x-svc and x-256b-flit are set as well.  It does set the HDM UIO bit
with neither of them, which is the asymmetry I raised on 9/10.

> +An example of 3 type3 devices with volatile memory below a switch. All the devices
> +and ports support Unordered IO (UIO) feature which requires Streamlined Virtual Channel

The topology below this doesn't advertise UIO through the switch.  I
ran it -- joined onto single lines, the indented continuations don't
survive a paste -- and the upstream port reads 0x00000382 in its HDM
Decoder Capability register, UIO clear, against 0x00042312 on cxl-rp.
That's the gate in 7/10; worth re-running the example once it's
settled.

Many thanks,
Junjie
