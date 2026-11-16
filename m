Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842683;
	b=DAHKNSs4LgxDkRf6TukxLHcmrrfmiKUd5B5Fw0SzATQ0gFNSj4Jh7NG6uEIwhxpmBESG
	 FIhmwHmQkgXuCuiidtvguasM6OBwm/SGE3U9WMSxoIFVhbfBLAiP9TcRQ+2xvS2kHfnq4
	 iKLIZeWGbylcoQYLvZ/lqafGmjjIpbor2ynt0jVxJ4Ztn0ktw+ZTQkqfk5uxCoy9NnuT2
	 hoOJuyoSdTq3q6FqdemCSfrkHw7GLXuZunQ/e3ehEp7HhPhl0UI0R2jZr/Ccin13aVR/p
	 r3wlRiyyh3dREYSi8VFhwVBLzudjWY0wMa1wAjcTFZyBlLTbufm00w/gSabR2njkXlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842683;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZagMFuwoqQmG7RfPFuV2agqCMwWb+eWrIodA0wVAt/I=;
	b=kc+qn0m9gEyx/Qgf4yecT5abdYzugUrV/Q/o9Sq392whO0ZQH5QibBD27tvaaCnTlc3z
	 2OuyCmrE9KDiZHQFWINoBX5YcACstYnLaWcYlUi9+q4HaV4COwwKN6lAKx2CVTEiVsuFQ
	 PGYxVOV82hYJ8ZLOXfVcOHUfgLDxo6U904hWUstlTURYOgvXKK/8Mn9EUzzbl0JGFsRJw
	 9siTJL9ZTaI+yp5I3jAbuawDuXqZyBTetSKpbCxwyhpixRBEi5trJaVxZ8sIcqflprfNm
	 Ebjkcwm5x/RaFitdfa9vZdCOPhPDvjMyqi+GrU3H6kY3pPXPOaYSGgnV/y4xkIOJacw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQAEBG+e;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A78606A31C;
	Mon, 16 Nov 2026 15:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A78606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LQAEBG+e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842684; x=1826378684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GRh4SofygV+5aDjOZUvpz9bJEvSN9BNrYyA01TPktTU=;
  b=LQAEBG+e5yDTLH0I9Cd/+8QXbHAJ1cORu4IughwbFD5HQAo4CJHuQX/B
   G9Bu7zyApIiftAeWYXRZn2HJzXroISW0TFctzsa5AD2B07jCDFH69H5AY
   UUXvxyIz4s4FrzWmmniJg6IJSaS6CfZVzaokzDnC0cCs/JtMa2py/2k0O
   CKO0R4qpBh83cS7J8Gydc3Khhk1RH7ucQmRfzDdBsOIvQuosCFJlIwPPq
   UXhGYZn72YeO0ghhblDmctPFoekwCjkfhtpr02coeDnzIHsZCogaLowG3
   Jowl/crJvFpDschhYpAhGU2SXQGHIXfnTE98HYZGZ4bc7AErbqV9khAcs
   g==;
X-CSE-ConnectionGUID: Zqg6AYh+S/uUmTjN/rMhtQ==
X-CSE-MsgGUID: +CCt2wvsTJycjzMqiV+tgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3455499"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3455499"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:43 -0800
X-CSE-ConnectionGUID: vLg1fQ+tQ1Wz85DhiZowLg==
X-CSE-MsgGUID: ZZVSnkYZRCikVX+dlHplTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9414106"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:24:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/13] alpha/PCI: Convert to pci_bus_size_and_assign_resources()
Date: Mon, 16 Nov 2026 17:23:47 +0200
Message-ID: <20261116152403.2672-3-ilpo.jarvinen@linux.intel.com>
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

To serialize bridge window sizing and resource assignment, PCI core
needs to hold locks across both phases. Alpha nautilus PCI code calls
pci_bus_size_bridges() and pci_bus_assign_resources() separately
because it needs to do special resource alignment and setup after the
window sizes have been calculated. At least the former would seem to
belong to some existing __weak pcibios_*() hook but the latter might
need yet another pcibios_*() hook just for this single use.

The nautilus code runs during init, so nothing is likely to race with
it. Converting it is mainly about consolidating the sizing and
assignment entry points of PCI core, which eventually allows removing
pci_bus_assign_resources().

Instead of trying to do a complex rework of the code, which is risky
without the ability to test on the hardware, simply convert
pci_bus_assign_resources() to pci_bus_size_and_assign_resources(). This
adds a small bit of extra work by performing the sizing step again, but
the calculations should yield the same sizes, so it seems safe.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/alpha/kernel/sys_nautilus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 13b79960b4b9..23a74fd4a83f 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -263,7 +263,7 @@ nautilus_init_pci(void)
 	if ((IRONGATE0->dev_vendor >> 16) > 0x7006)	/* Albacore? */
 		IRONGATE0->pci_mem = pci_mem;
 
-	pci_bus_assign_resources(bus);
+	pci_bus_size_and_assign_resources(bus);
 	pci_bus_add_devices(bus);
 }
 
-- 
2.47.3

