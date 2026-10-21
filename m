Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587021;
	b=Y3aiikELISI3mB6dXuk8Xeu9Zx+Gmh+NcNeyni+/ap8TxZ2n+FtOetdFUjJC1Y6dlXpS
	 BVkvo8oFhAjFjgPRR5fb8xwHdhO9jwX48qJr53ePU5N2B/Z2FIE3iFgr/uEJu23gyv7P1
	 ja6r+rij9HTgV+A8FzJwmZkn3ueQzymYXmJAbSAZdElvsvFjTTNDogyMyassPquFefsk7
	 ZIBLI51DRmJtb942E8VGwNc+KI2YjcNPiXxm/jgQjrBvZ7mLzWFq1xjweE3LatZAwXGhS
	 UR2pBDg9nB2Kvd54BF+4LFHYWDU0H/76UDzrIQqz82UAD8+YPaYoypDBNbF4nyaO9MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587021;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Z+u3phmepWscmKjsO3edyc7Qwanorrfls75VOaos2c4=;
	b=yl2rkl7eYa9hyKdJ9WHEm1WKl1aFOXfcvo7TQYg26k8Ts+ycRKL/BC+pakZv50EXAjkc
	 kBRI4LK4FkGKD8MzXgHPYwiFRtWk803YTDqrTt8ORDTIOv463+5Bn82/EuN1WyQgoC0ak
	 LgcRCzQHxFJ+ISw15K5SMA16YIfwjfbwH0BXRT2camHEryCdKVYnftCiwG6ngOZ4y++K8
	 DsD6J7Fz+zdX6QUFfsxmfMZ56oLr1T0wTTeqpzDtHTsoZSiAvlIheBg4HVUjRqgmTU49k
	 AY2qjhxNRFY/SCxLFK3Z6J74IjcP3wuldT+iPmGcUOY82j3PBfWcZoLEXeOD8raH6Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BrCqpnQm;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B5F606A319;
	Wed, 21 Oct 2026 12:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08B5F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BrCqpnQm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792587021; x=1824123021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JD41fnYqEESLO6k5Y6NhG6FWIGnJsG7F0pv3j8DtJSA=;
  b=BrCqpnQmp8JxG4+XNvXnj8dcWGtlrasEWTQIXAHjUmyBQZBdQyzTJTfL
   jNEUyEKXIqVqysBB0WqDiJ2vv7qJl4f/pGPHzrZwyZy7gjIsUukFqB2mH
   mNucdsKDe2iCuToRhWoStNKNvPLTvv3eMkDPiHEWE2QmcjkLIAvFyin03
   2lZdaPRs2ytUhTgQo5aY74U4MHhmiDD89uXjYhAvta1nBWb4Xk0M1jjX3
   V+68rgz5IJXIeOJQ/ucBV3KN72NxN2vPxOxCoRYl6ocShWfR+EcgPSteR
   NaY1/D9GgaunxzRHdngB7XhZnjpPhyEbIPjPy5wtLLzZMh3EmuTgjmNe5
   g==;
X-CSE-ConnectionGUID: U0Ljj3hqSl2ggwy5iWpeRg==
X-CSE-MsgGUID: 0akziz75QyWWYRp58WsOBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1326102"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1326102"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:50:21 -0700
X-CSE-ConnectionGUID: LU8ibb2wS4iAm1+6fRS3Dg==
X-CSE-MsgGUID: jlBTrELnSr+X/tQb+k4ISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3184103"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 05:50:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: Bradley Morgan <brads@mainlining.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/7] resource: Mark free space assigned
Date: Wed, 21 Oct 2026 15:49:46 +0300
Message-ID: <20261021124956.4250-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
References: <20261021124956.4250-1-ilpo.jarvinen@linux.intel.com>
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
index e60539a55541..9e5fb021b199 100644
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

