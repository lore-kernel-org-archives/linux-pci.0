Received: from esa.hc1631-21.eu.iphmx.com (esa.hc1631-21.eu.iphmx.com [23.90.123.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE63E4104;
	Fri,  2 Oct 2026 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.90.123.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928433; cv=none; b=Cmovw9a20lnXed1WcjjN7NYIAaOnSehZNGpNdmj9MKloCCiePizKrKH7O0Gu8icwSX1YC3+JqRrMVQVuX9zHmjhV/hsy+l7YbMYFoGKGcvfjxB0MD8WGLfj/hH7D1uJ3QB+NI3DAREIxZVl5yUlgjc++QHwFHs/JKxySWAhIqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928433; c=relaxed/simple;
	bh=lqQhEvydJ9IHnFgJBqUyAiAYeeuNJSilAD9ijJ/MDnM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CO8NpsFZzVptqVduYXDMX6KgYhaWtRXuEotLOvi+XKTJxYmMBYHobfriFkJXXQQbo1brENp9asqP63TOfN28SvjwsRRfaQp+tlbqb9/xlpSvM6hygwDIlRezNAkxS6gTRL4Mtm3CtLb2TB10wwgQzB5i7dE2WQQcydtECEoDHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com; spf=pass smtp.mailfrom=thalesgroup.com; dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b=mBrZ2nK9; arc=none smtp.client-ip=23.90.123.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalesgroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thalesgroup.com header.i=@thalesgroup.com header.b="mBrZ2nK9"
X-CSE-ConnectionGUID: +ts2OPL0TTyvveYAVUv9bg==
X-CSE-MsgGUID: Q1HcY71OTty3gnQmQ2lmnw==
Authentication-Results: ob1.hc1631-21.eu.iphmx.com; dkim=pass (signature verified) header.i=@thalesgroup.com
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="61274374"
X-IronPort-AV: E=Sophos;i="6.27,136,1787004000"; 
   d="scan'208";a="61274374"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=thalesgroup.com; i=@thalesgroup.com; s=bbmfo202603;
  t=1790928428;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=KVqcsKEjFuwb0SmCphnGtN7YjArxbise3AvFY0B870o=;
  b=mBrZ2nK9bSOwdCYZJj0uB3QYbF/kMz8ZRK/FgxJaUrFQXIG6nP6k0YE+
   bFUcFHUCVqvYmgU625y1PER9fnMrb4JbXpQodTu6hXwxTTzfa02U3KOqj
   dfKVck1xAJ9hq8ycx2xTC+22OYyM7IKzuPgDl+B1HxJreSQXV0DW7tuMD
   p+dEy0UF0Ks72r/CYyIYVlizou7o7czKQNbjyNuoO6Tkv+19gNUe/aQsa
   +V3+m6n9gRPHQKC7fmL0ysAtM0y5EoiXYJxc77CeEviUdCr9+nKqWivnJ
   F/DfG8RXyvkWszhrPB3cTz69Yemkm/LNCsfyyMoyM6H4wyFJdGNYhL2O0
   w==;
X-CSE-ConnectionGUID: ZXBMwr4GQzmriU70iimbcQ==
X-CSE-MsgGUID: /aVJwdI1QoWtJ69/fZ8WxQ==
X-CSE-ConnectionGUID: ZKm6oRrJSwqV18D+Y2Asgw==
X-CSE-MsgGUID: 00vUCNjYQR6AnvjQunqq7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="74161015"
X-IronPort-AV: E=Sophos;i="6.27,136,1787004000"; 
   d="scan'208";a="74161015"
From: LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>
To: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>
Subject: [PATCH] PCI: dwc: Correct PCIE_DW_PLAT_EP reference in Kconfig help
Thread-Topic: [PATCH] PCI: dwc: Correct PCIE_DW_PLAT_EP reference in Kconfig
 help
Thread-Index: AQHdUkGxeWvbg4ZBpE++slZyP7bfKA==
Date: Fri, 2 Oct 2026 08:07:07 +0000
Message-ID: <305ef70ecadb4db9aa42c66607240aba@thalesgroup.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-endpointsecurity-0xde81-ev: v:8.26.10.670, d:out, a:y, w:t, t:16,
 sv:1790893315, ts:1790928427
x-ms-exchange-nodisclaimer: 0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

The Kconfig help text for PCIE_DW_PLAT_HOST and PCIE_DW_PLAT_EP
incorrectly refers to PCI_DW_PLAT_EP.

Replace the typo with the correct symbol name, PCIE_DW_PLAT_EP, so the
help text matches the actual Kconfig option.

Signed-off-by: Philippe Lecointre <philippe.lecointre@thalesgroup.com>
---
 drivers/pci/controller/dwc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dw=
c/Kconfig
index dcfbe7e229fd..0a0d56fcf0ac 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -295,7 +295,7 @@ config PCIE_DW_PLAT_HOST
 	  Designware IP.
 	  This controller can work either as EP or RC. In order to enable
 	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
-	  order to enable device-specific features PCI_DW_PLAT_EP must be
+	  order to enable device-specific features PCIE_DW_PLAT_EP must be
 	  selected.
=20
 config PCIE_DW_PLAT_EP
@@ -310,7 +310,7 @@ config PCIE_DW_PLAT_EP
 	  in Designware IP.
 	  This controller can work either as EP or RC. In order to enable
 	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
-	  order to enable device-specific features PCI_DW_PLAT_EP must be
+	  order to enable device-specific features PCIE_DW_PLAT_EP must be
 	  selected.
=20
 config PCIE_QCOM_COMMON
--=20
2.27.0

