Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648329;
	b=B3731tRXimHe0MdyaU6eox+HAWPCOjoEHUcfG+/XtPc+YWsi0NPdzzOKU7Os+BY3rMnW
	 7HtgmBQtFXYIXfzs14dNlwWfll+jWB1MnZ6OgiUdcwXdmSCOoNf4YDCMyxpOrPal+jO09
	 MrViAXasQeOq/2j984s4WaOo2e8a7gyxf8ELg5KS3IiTawJBNrfW2ZaBhutyv7PzoLvuc
	 HqOPy0LrtYSHBcioHs7iRdyhXARZ9lgnkc9ruYB0P3MMW009Lgux0FF7Ahbru4mK2NwSO
	 s9/wT3jm7yEXa6e5Zbnq7AxjbvdiD9rTNHqaQkK2rGmf0/VnbsZVslb420V6Aa8q0fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648329;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=J65sboDxGHB+ZFpro2zBW6UtybYQ6p08zkXhKEDH0Uo=;
	b=QdTiexuPu7VG2Jidnf15llfxeaead55Jmq8zBSsP/s07cIR474UfS4kLabT8NTULSr+V
	 wJhCdnoGnh3EdpdJNq3d7j7AzCzpVZOPRr58FNkxjKpdwHw3EjxF7Pw24gTCr479dcA/c
	 2dQg4JLZ81/B4E/hpiwWO/oQQR4/8EUijei2lb9XbdPPI8MgUV9PGqGBmYQzL/qdeEWfc
	 ZNwpMf70kpC7zlK3hYOnJNd4CV8odtE0fvvlZYNP2kLm+WTvmyyStU49MIVZtedtLi3XN
	 AqmFR4bCHHtzAPgYUFaipUrYJSSjm03Onrae37rNhVQlRV9zk1hm6NjAIFjow/pFixA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JMY8WqJU;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD372606A335;
	Wed, 25 Nov 2026 23:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD372606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JMY8WqJU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648329; x=1827184329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t9G1Z10mmZe4W5gDXqqRwVxtfEFNyswpPldl+jV5IYI=;
  b=JMY8WqJU46LilCisuYAjrqYrgcIipDhteLFpqLgySg/JAvC9hELMfNoR
   /X/Cgv3f+48CojlKXcUHsJXOyoDG/PkvSZuSAB5oyu4DDweqjI27tolQV
   SbSCkULCRKGx/ZFQaVa5D+MPJU0O4cbZqwpf3FW/klk8Rb2ZBrhQIBJ9h
   jQrL/rjOBUg+Ry5g3bE2N4CEYmA6oCouVpa4+/VwLM53w8cTQ+aPG/xOx
   MsIgzVdz70SFSft7UoswDBcnpWbu++kZP9I7217m3SwdxRXD/bcepDTuC
   p5AAL4B9qEdFJY4GsZJnSl+caEea78oq0DOm3xTCan2GjGS1cqLE+Vc7l
   w==;
X-CSE-ConnectionGUID: OqquscdnQCi0Is+Jlnsg6w==
X-CSE-MsgGUID: BUIqP4pMRUqnjIPNi+5g4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4538279"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4538279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:12:08 -0800
X-CSE-ConnectionGUID: DpirYDSFTdaLAUUt4jpmYw==
X-CSE-MsgGUID: pLjlw2HJSAKW+OlIMufcvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12033061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:12:04 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 15/17] PCI: ftpci100: Convert to pci_assign_unassigned_bus_resources()
Date: Thu, 26 Nov 2026 01:09:14 +0200
Message-ID: <20261125230925.2441-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
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

The ftpci100 driver attempts to assign bus resources using
pci_bus_assign_resources(). That function makes bridge window sizing
disjoint from the assignment phase and is going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be a no-op.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-ftpci100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 28e43831c0f1..96b3deb70f57 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -509,7 +509,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	p->bus->max_bus_speed = max_bus_speed;
 	p->bus->cur_bus_speed = cur_bus_speed;
 
-	pci_bus_assign_resources(p->bus);
+	pci_assign_unassigned_bus_resources(p->bus);
 	pci_bus_add_devices(p->bus);
 
 	return 0;
-- 
2.47.3

