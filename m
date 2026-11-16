Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842724;
	b=fmxnp9geqUj8QkYMu9wnb4fjB60cKn4Ge7eIf2nbR7RbrPffy3d7C2p0KhRw7QSXaZg3
	 0EqS8XquRIiV/LkfvvMbTJ/7w1AJJENQ4Qs0X+7kb9lyYwkgqjofS/1uB+Z++gzxTOrui
	 JKgYeDSXnfwDfsx8Im7xhhef4s9If2t+62OuPs16W1YTWo8LkOE7P9guJHKzBI4fp5T8g
	 cjXvk6VEPmW/3tp99aD0dNQU1Aqe7zXc0RJjDU8OMxVV7pCELATWkJPdw4YjPIuGid5pf
	 IraI8NBcg1Vl+Dckxv6hQc3NJ3LEu/hBrkEptM3FVbzl8R683nzN80R2mazxUkwKsxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842724;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=J7u09Gb4YFcCTom3atIHfT4Aw6tjkCjLvtzqe4wS7hc=;
	b=f7pIvuIZyAGRp93WC1lRjHXW4OoIo3IekWTbi6++CCFeR9MzkxONKxZPA2csoPtDb//K
	 bS6SlF8p8ytucAeX7eacuf+FjrxYFf3gqpSjbcN8KvujipVPRQzv5AamzlNCraSYfBB+8
	 ZVzpJuSmTGKPyXzUtBnfoaRL/O9ClL69Af8LKbewcRioW4TRoHNExn5G5ymM4FDJZS0m0
	 vibT/5yT8i8HL9d7DXZqyGBucYyji7qR8P2tO+ioCeUyOmasL7AQHk1v2/7Ez8HP0UnuE
	 eki6H60WzWs69kQbedwrRRlJBjCfqKPNl2kLZKeZwUFzhsDfFzgu0/Edv2zqZY5GJLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oj1SrJZD;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F402606A337;
	Mon, 16 Nov 2026 15:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F402606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oj1SrJZD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842724; x=1826378724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a00a1aG6oEnxFB2bCNQIdZq9JN1uAYsDsgUhhh2jScQ=;
  b=Oj1SrJZDEs8DPbKYaPK31gZNR2SPT9FPPSzMpr7Bwiwk3cWoWqT1Ymy4
   QfVCDAZIbRlLq67C4GHYSlF//RUr5M13lXEQlKxtcwIK7fpDyj6ptoGK6
   oJaN26778ZephSBIqGe6QARFPESR5bUTZLd5DJx5Wfnq2Z5PJEoGKssdq
   8eR9DSZqicAX0snCg0+MoOsnu8sz+4JwzDV8mrDxjxD/vj8ylkgZEkCT1
   GQfmTeJfkxKdJcLHUu4wHVG74jWWKf3Z5AFVhwZjuWwfpPnhP9Wq0f88A
   kF40s40t1Xtg7f0ZcnsFcMwpezE6GUDfEUko+qLmtF1zGVMnGZ6+B64BT
   Q==;
X-CSE-ConnectionGUID: tPMjMMPpQiaHgSDDjRmq+A==
X-CSE-MsgGUID: fXi+L5rBTEyfuyTkrLD0Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3457360"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3457360"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:16 -0800
X-CSE-ConnectionGUID: 0EjFyMKqS4a3DkoYzWAU/A==
X-CSE-MsgGUID: DXHe4dZBR06777UXQ1KHwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9769626"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/13] i82875p_edac: Convert to pci_assign_unassigned_bus_resources()
Date: Mon, 16 Nov 2026 17:23:51 +0200
Message-ID: <20261116152403.2672-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
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

The i82875p_edac driver scans single device and then attempts to assign
its resource using pci_bus_assign_resources(). That function makes
bridge window sizing disjoint from the assignment phase and is going to
be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources() which is likely no-op in this case
as it looks like bridges are not involved here.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/edac/i82875p_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/i82875p_edac.c b/drivers/edac/i82875p_edac.c
index 869de8e372b3..59a92a209dea 100644
--- a/drivers/edac/i82875p_edac.c
+++ b/drivers/edac/i82875p_edac.c
@@ -290,7 +290,7 @@ static int i82875p_setup_overfl_dev(struct pci_dev *pdev,
 		if (dev == NULL)
 			return 1;
 
-		pci_bus_assign_resources(dev->bus);
+		pci_assign_unassigned_bus_resources(dev->bus);
 		pci_bus_add_device(dev);
 	}
 
-- 
2.47.3

