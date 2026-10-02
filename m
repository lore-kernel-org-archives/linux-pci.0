Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3C13BED55;
	Fri,  2 Oct 2026 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940832; cv=none; b=CIrPpw57Jp6J+2kJwFIMg5neqJOWQAyxczp13UjLO2WDHvNQ1JO2SCw0n9Izw6MYSXXU53BiD6WbQUQm74aHAL1857fMpWnFiN0d4yvLN/RdZcGiTEEtWW6BtDHwT1IpmEqUqr4lWUAub6hXjxo8JOs7FeXnI15GXHY4KQrcJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940832; c=relaxed/simple;
	bh=uWw7miYY/K6HKIHWabwfzSPo+0rir5K2/cFJqMnC8U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdk4V+63IDs+OGZHdh5bFQJLZd/U9N8RFT5u/WHB+vPXEcMMKsxPLDdiQa9TqI2jvdDtYDS4jhxI93CzxMPf8zfgwNHnY064a81drhUAA26M1Vqc0uechVYfzNF9D3x9VJ1HB8yeFhuX0E6fjwLDteIA5+fQtvOGxi78Q8Os4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNJTENJ+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNJTENJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790940831; x=1822476831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uWw7miYY/K6HKIHWabwfzSPo+0rir5K2/cFJqMnC8U0=;
  b=CNJTENJ+CG0kgGePshaNhl1MwipFYbGYB3KPjfT90MYDtEeZHe0LKK5H
   CA5MC2Nkh14eH9dI83N7eUKWrXSIWS1oc+lHp82QJWE0WJRYXhb67MshJ
   nD7/xs/3l+razVv+i+Ceab15LZJsC0UcZBOk8WD5w9UvococnF1WpkyYG
   LoPZqu2Q1hf1qHfw4LXJotEx6/3iIBGETgV6v7LunC7JvmOHx9t9Hx4Bf
   2DiuQtjNx0hqLzGfTITr6R/V63JryyXqadnQ5erGYxXZGjXlvK8rXt+eh
   tUS08kDp3y6JCa0h3b8bwkMXpDKdO5bZMotFspmMOGGQmsp4TgegQBfqv
   g==;
X-CSE-ConnectionGUID: WSqGEpUfTLuyj5EVw4J5xw==
X-CSE-MsgGUID: 3n/yeX5ORpO25EyPzAgWFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90659729"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90659729"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:33:50 -0700
X-CSE-ConnectionGUID: 3eDrIy9qQpy1QLXBn0LJeA==
X-CSE-MsgGUID: FXjfGBwEQTuOtnS4oa35sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279969470"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.243])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:33:45 -0700
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
Subject: [PATCH v2 1/7] resource: Mark free space assigned
Date: Fri,  2 Oct 2026 14:33:09 +0300
Message-ID: <20261002113319.6652-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
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
 kernel/resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index e60539a55541..17e7fccd859c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -731,6 +731,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 	resource_alignf alignf = constraint->alignf;
 
 	full_avail.start = root->start;
+	full_avail.flags &= ~IORESOURCE_UNSET;
 	/*
 	 * Skip past an allocated resource that starts at 0, since the assignment
 	 * of this->start - 1 to full_avail->end below would cause an underflow.
-- 
2.47.3

