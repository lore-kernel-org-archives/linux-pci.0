Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972644;
	b=ib9G/hpuV7yWKZaODqKTVj7mqX6HG/oVSR7D5+h0ISWRmFeJcQQhTNxYQWWNkp/Tqya3
	 P+MnWKFxnSlhkchmFN3lpUJBCVJQ2OyVnDKme2057gQu32KO8lbTHGO0T75PNirW+FVHB
	 scaS77uT++YIlYwc4rCQAYqsMUwAmIxM5LCVXkgw41o8pSfMH/qm24nMlb4Mg4xIqKOxh
	 4VSc2K0vdUxo0CmboaLB1oTeVNoNfSFdTzdpaxhCaYqCqnCyl80Ehj82oPVdskbR4091X
	 f0B4jfv1Bv51dkoyPZBHuBtmp3b69+UbPZqWvu2oIlHFGk/NM9UpE8nDP374vcVsZdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972644;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MVtcyiwwIpQrlalc2ffQ1V7g80g9u1Dt15kZSc33gac=;
	b=VCGAWS3lvr0+QOG/B0n8Yt1zPKR61y05OvbqGtOLp00p3NNpmpDFNoul0TTEngxbJVkL
	 A+waVciEdRdKdJ5ZRDQ7Z4cP8+km/FbjJMQI6Su4DdK89/rGma+dcdMeervFhfY3rC+Xf
	 inYLtd/6ZQfo8YpOkB2H0P2ur8K2nHH6RO0w6i9Feh9xMtD1HfO6LiZRqQqQIvOQHxfDK
	 LV6P8udrL+WqMZMqoZHQrfvEsurNT+0Mzk38gyB9PvRCB0dnHdqeyIjztasGP08HRkp6W
	 qeQz9o/EM9tVcfBgQRSDesrx1fA5lMe5fdnBg6derGNfVkCQ/jVvMQZ3wWuNMkjQJ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CwJRBLdX;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02625606D805;
	Fri,  6 Nov 2026 13:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02625606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CwJRBLdX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972645; x=1825508645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+65uSqUKD3zoC+C0IuzTUHsTPSi3Hi77oa7a/RxjKVI=;
  b=CwJRBLdXCgvzaZmtbKkGgkvVeKmREKbFv8ihh06Zc3QtXfx5LnTN2pbe
   B7soSovrWiBxIND/SV/NYsSEoDkVvZ95Yf2epePKcwcEUPvOpaMuy4+MG
   2KgVJVfe4BqugDSbMPwP5nDVG3R0ZWhGDjJ5gsGabm3q1A81BeSu+oX9F
   umSjnEL4qKwoXFIq/Qd8gUph8E+n+weqaDgKhjJarKsfkYqqsGJ5k7c7Y
   uYpokIvHD8WmtOlXKlM+p337lvG3ixfE2RzhjhZho6DUSKilQ0/6GZCAK
   LT/Q06mEO+/XGoxGkXrQ1sV3sc72pk9ueEr+yiiboci2lBCa6t12F7CEI
   Q==;
X-CSE-ConnectionGUID: Ww2e/+sWSJuh9mD+lpsJRw==
X-CSE-MsgGUID: IIVRgweNSFOWpHozXVmCrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2815508"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2815508"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:04 -0800
X-CSE-ConnectionGUID: RLS2mJJlSy2n6mIPITc+og==
X-CSE-MsgGUID: 8Gi+XH8cSWS3H/pJCHJzvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7609177"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:43:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v5 01/14] resource: Mark free space assigned
Date: Fri,  6 Nov 2026 15:43:22 +0200
Message-ID: <20261106134341.39493-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Free space ranges are (part of) assigned ranges. Since new resources
have IORESOURCE_UNSET, the flag gets copied also to full_avail.flags,
which hampers printing them with %pR.

Clear IORESOURCE_UNSET for the free space indicator resource.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 0c315c917fbb..eb38074ce5da 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -731,6 +731,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 	resource_alignf alignf = constraint->alignf;
 
 	full_avail.start = root->start;
+	full_avail.flags &= ~IORESOURCE_UNSET;
 	/*
 	 * Skip past an allocated resource that starts at 0, since the assignment
 	 * of this->start - 1 to full_avail->end below would cause an underflow.
@@ -754,7 +755,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 		/* Check for overflow after ALIGN() */
 		avail.start = ALIGN(full_avail.start, constraint->align);
 		avail.end = full_avail.end;
-		avail.flags = new->flags;
+		avail.flags = full_avail.flags;
 		if (avail.start >= full_avail.start) {
 			alloc.flags = avail.flags;
 			if (alignf) {
-- 
2.47.3

