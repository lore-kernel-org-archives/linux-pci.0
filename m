Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842761;
	b=yb+w00psBVdx6DqCGCnCqhze1RjSbjngeAmnBImK66ikYBfGyHdcTJnvVoijJaOAk+EE
	 Iet4bG+334yeN+hUg0kmX2hOdje/Kelz0VBRw2vlVJH8drXViHXzh9hcXm/tQHGl7DvyR
	 uDHXoROgTKoZjJ3y2s8D/qnIhQ9zudNPDeGhxBjnOkL1gHg/6ltLMMnVo+PcgypoHkoTV
	 Y43PKJu1HVb++rb/HcwzIqdjsJXKwDYQdG4DOQA01U4EKXkyi/mm52koMj2FQ20LXc8YX
	 wKKilKHn+V/xjH3jIf5N0+Hv+QVRcvgkQiBWnrK4qVvSVPeuGpXvYDqMNZrILldQzGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842761;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=q7/61DJpZqVAzU/lp3tA1TjqPxPxpZW3XhcnUgOsj5I=;
	b=PTVkD0kt6jbE/klkpRKoEEMNAwBRCJHEI8sVUpg3W2Pp/9XwtJPng9PeV23Q2eQ5CR5c
	 i2XM8zZUa70g6iCK7OtRDh4xckxe2JBIVErm8SOSEqEf4F2onZqInHdqERYVq/3iptf0d
	 iSpgq6du+FTKPYq4/VzIQRod50ZtPnDPy0duJpeQ1eHzlNCIX7ny2nhqGZArZBU+vMMRK
	 vcN6FC7wdqq3r/Li+1x7GgsMBksI3wBB01l18WpMG93uvIA49GA92L4H57uOD8fzPu41H
	 LdBoTmkP/SpPhQmTl3bRXJXGhcYk2ipq83J62OMWiJSQ9hf+SOu3sCKrS9PIHseRRFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W2+ZIrYl;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557AB606A336;
	Mon, 16 Nov 2026 15:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557AB606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=W2+ZIrYl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842761; x=1826378761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Mk+n4f9COSEhhAxBsR2WnK+nb7NvmfeHmSi4n7v+0U=;
  b=W2+ZIrYlJmbTHIsd/sV23l9aXf701TASPwmoAxT49ZL3Pq/DG/ewvxPo
   kKdiAcUJytabOSqCV35iw5ORUzO2Zwm6VnvOjBvAcZ7NhvdBhLXbSud2O
   MX9sddpIfxUIf7cW66ycqzaUtwOT0h7+vkeeSZNUpNvO88Kx0RTZE3C0Q
   YuEBdEhRtk5fbmluELe8cvcsZaxLXPtkiVyOxmKAuZ9MSshT/5kZqA4mZ
   bSkBH5rqjgQFE3kkAM+eH3CNnpFBdQsxSqGuVPn3n9FdYwK5gagYp7Zp+
   xR3R6ZVuKNfO1xujQcgBpyl9leyjHO6RWZobdMFaKB1qGCjpnOy1bSAjJ
   Q==;
X-CSE-ConnectionGUID: yWKBxWyzSKeqeygU1H1WfA==
X-CSE-MsgGUID: XMKlLrVzS3qLW2mFJEViyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3617426"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3617426"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:26:00 -0800
X-CSE-ConnectionGUID: sNE+wF2GSe+kXuvOoH9q9w==
X-CSE-MsgGUID: ZmC8IAkvSIu1//pbKbl14w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9649233"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:25:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/13] PCI: ftpci100: Convert to pci_assign_unassigned_bus_resources()
Date: Mon, 16 Nov 2026 17:23:56 +0200
Message-ID: <20261116152403.2672-12-ilpo.jarvinen@linux.intel.com>
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

The ftpci100 driver attempts to assign bus resource using
pci_bus_assign_resources(). That function makes bridge window sizing
disjoint from the assignment phase and is going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be no-op.

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

