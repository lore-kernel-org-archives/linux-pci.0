Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD444683D;
	Mon, 21 Sep 2026 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023047; cv=none; b=MHu5urq9mI1szkWpKFV9p1c4QR1qVAdoyDti1y2E0O2btvqIhzq6hfLK5jYWJjOOLw4G5r8FGXKr4iWsu1KSNrJa2AclAT9gB7jNgTOEs8xKCdU81stb8d4BgzejY0kb7TW7JQaqbkXEGdBTGlJmqaMHoyq5/lUP0EHmrK5B42k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023047; c=relaxed/simple;
	bh=W/mOa0T0f/2SO4j5UlmgBBx8+2NQZl75mcprKt5L5Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WX1dyzMTNYfLfed6KuhyMkG6PiEQxjhQLB0eiKGr1hytE/BeSPvwI9fZiLD7ZzT+pMvwKwltrJwzahj71hkQNKrZvLs6p4fZUtr3pvOrrvCmgQap02ATSTGav1WwgTCby8Dct+ZERtz1DacJa22wbIaETlUvORztA3F+iRfH6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=T7OqyNVK; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="T7OqyNVK"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hpZm15chyzMl0N;
	Mon, 21 Sep 2026 22:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790023041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dH5lOSn31N5rmzucBtFSBAHqxTHDPEZFrYlyKlhTR7A=;
	b=T7OqyNVKrvMu2Va7Vl+GJYIhH1SPd6TCRQ9CC7BcZtCzooll935LwEtDwI7ic4+e9ii8JB
	gp3uz+ki31lQtxAlmMe6yJKpTsq8RIceqAgzOmk0M9pkkiVZnOI6a7qz+ab9zk162IjYhc
	V1JDg/nVPW4TfQXl+owdDF+ojqk/LN44J4/Kz4SxhvtFj8Nn44+bCFHIkw19ANtYz1TpZy
	YO9ej5JHNOFPRIasilM7L4dS4HkxCP/6vsmDSobx2SRQQeDfv1A8KM81FHYpP07UyrBIs9
	Dvm5C7q/s7i/x4iRapadiF0dMWYKe/tksYMDLf9EKY8GNPlVaB444lXsjkXwyg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] PCI: rcar-gen4: Drop how to obtain platform firmware
Date: Mon, 21 Sep 2026 22:36:46 +0200
Message-ID: <20260921203716.73663-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f4692ff364f87b53fb5
X-MBO-RS-META: gbznwhfut3za5iz3ihny9xfd5i56fys1

Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
specific firmware downloading. The firmware is now available via
linux-firmware.git repository, drop the documentation about how
to obtain the firmware.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Drop the documentation and update the commit message
---
 Documentation/PCI/controller/index.rst        |  1 -
 .../PCI/controller/rcar-pcie-firmware.rst     | 32 -------------------
 MAINTAINERS                                   |  1 -
 3 files changed, 34 deletions(-)
 delete mode 100644 Documentation/PCI/controller/rcar-pcie-firmware.rst

diff --git a/Documentation/PCI/controller/index.rst b/Documentation/PCI/controller/index.rst
index c15e2c9ac855a..096d1c3d9807a 100644
--- a/Documentation/PCI/controller/index.rst
+++ b/Documentation/PCI/controller/index.rst
@@ -8,4 +8,3 @@ PCI Native Host Bridge and Endpoint Drivers
    :maxdepth: 2
 
    pci-controller-drivers
-   rcar-pcie-firmware
diff --git a/Documentation/PCI/controller/rcar-pcie-firmware.rst b/Documentation/PCI/controller/rcar-pcie-firmware.rst
deleted file mode 100644
index 67d3bf66e3158..0000000000000
--- a/Documentation/PCI/controller/rcar-pcie-firmware.rst
+++ /dev/null
@@ -1,32 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=================================================
-Firmware of PCIe controller for Renesas R-Car V4H
-=================================================
-
-Renesas R-Car V4H (r8a779g0) has a PCIe controller, requiring a specific
-firmware download during startup.
-
-However, Renesas currently cannot distribute the firmware free of charge.
-
-The firmware file "104_PCIe_fw_addr_data_ver1.05.txt" (note that the file name
-might be different between different datasheet revisions) can be found in the
-datasheet encoded as text, and as such, the file's content must be converted
-back to binary form. This can be achieved using the following example script:
-
-.. code-block:: sh
-
-	$ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ { print substr($2,5,2) substr($2,3,2) }' \
-		104_PCIe_fw_addr_data_ver1.05.txt | \
-			xxd -p -r > rcar_gen4_pcie.bin
-
-Once the text content has been converted into a binary firmware file, verify
-its checksum as follows:
-
-.. code-block:: sh
-
-	$ sha1sum rcar_gen4_pcie.bin
-	1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.bin
-
-The resulting binary file called "rcar_gen4_pcie.bin" should be placed in the
-"/lib/firmware" directory before the driver runs.
diff --git a/MAINTAINERS b/MAINTAINERS
index 05215fcc18a57..f097e556dfc91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21170,7 +21170,6 @@ M:	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 L:	linux-pci@vger.kernel.org
 L:	linux-renesas-soc@vger.kernel.org
 S:	Maintained
-F:	Documentation/PCI/controller/rcar-pcie-firmware.rst
 F:	Documentation/devicetree/bindings/pci/*rcar*
 F:	drivers/pci/controller/*rcar*
 F:	drivers/pci/controller/dwc/*rcar*
-- 
2.53.0

