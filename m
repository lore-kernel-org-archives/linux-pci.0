Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40C33F368;
	Mon, 14 Sep 2026 03:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789356335; cv=none; b=OIZKS0SLSbuorQ/PjZMraz4MCDErEk0aLROY9wFE5f9UrPBVuEn8Q5XaUBjaLxMRGiThAnbHJR2ARbEP3qslzAhwObcqEyP9M8Cbopwq4Sn5jrTw9Nd3xW+13DUP0ciLnehB6kNyawQT2sttQ9WEiurj8wGal7pjfpY4IELFlFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789356335; c=relaxed/simple;
	bh=IfYsHEx+dOEMQvXwuS4Xc+ipk1ag8b/cNpivaCbIiCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C9q+x2YMXyy2xSQ8QfH2TKb/CwDHj5tSr93aOgLGTTsewwUAv6wVxkoZfquefuH/dwueysliqk5EtH0XmJa7FS1X+MtwFNENvlMtaSuvDCTBHFAgIRh8bv6dfr2xyPDdild3VWkzquPhYD7RGNfJBs6YUiszbyuZDVtmBR9E5zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YHg+SJUo; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=NVYyaaRJ; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YHg+SJUo";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NVYyaaRJ"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hjrBb1wS5zMlGx;
	Mon, 14 Sep 2026 05:25:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789356327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QE3DwC9lelsk2shdi0iKu40ERDnwThYWKwgZfqGr5DY=;
	b=YHg+SJUoRkWTT2P9SbT9katzwCv9KeGugMT/3EbomDXIO45rQNGlH3XnQ4TyVpCgest2Lq
	womAmTZVZL7B+MV8hldzF6J/lbFiwHZuxkpyeFojKf1WNhGf4aa8vbPMUmv5ihW9HVLo9R
	EgYP821paC+crOGDluqWq+cfvSTas5hCq0CFz9xgBVMKL6aJDCGH5kH8W+6wyqr1wpxi8O
	ZPFyf2XpMH3SaluA7hZ5Ye97Vuo9gKs3csj2re6a7fZRwdLUBi+jyQdDtm5akxTysyO+WX
	8L/zrDGtQTyrEatc8SRaH2Brfn9+KFwlVXdHUN8cS3wZ1ZqAozPHUm/HcA6qig==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1789356325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QE3DwC9lelsk2shdi0iKu40ERDnwThYWKwgZfqGr5DY=;
	b=NVYyaaRJLB+1gv3cC/cmzSiUB/b5fwDSbaIREvkKwdfrn2Yc1y+nKhjLN5GkRtLPrGTJK8
	sPQW+zoFICZYDsVaMOES4yiZKtGcwUyzO5eGM/stSFx52lrFcrGWWzcMAvPHGYmGKRdQOU
	znz3HQvZjocJJJ4DFPd7jYRWYlX4eGaQNMo2yXQ65KaJstn35eMb0ZxTC4BTCNqFkwDGld
	07dxhQbDpKJiJWl/uG7CGmzcGPUwBdCIB6PClCijQ/6wlNUOykb2qWQAEchMTJMwZ9hPsb
	tXJWxdFw6wE+sAhBqX5ctUwCFvWdSTsFC5gFsYD/NoQVzkcw/lQbD5UqaHCjdw==
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
Subject: [PATCH] PCI: rcar-gen4: Update how to obtain platform firmware
Date: Mon, 14 Sep 2026 05:24:58 +0200
Message-ID: <20260914032520.99699-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hqp166d518p71f9fi7c7zzu85utw4ewu
X-MBO-RS-ID: 7b1d09850c6af42e9e9

Renesas R-Car V4H (r8a779g0) has PCIe controller, and it requires
specific firmware downloading. The firmware is now available via
linux-firmware.git repository, update the documentation about how
to obtain the firmware and drop the conversion script.

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
 .../PCI/controller/rcar-pcie-firmware.rst     | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/Documentation/PCI/controller/rcar-pcie-firmware.rst b/Documentation/PCI/controller/rcar-pcie-firmware.rst
index 67d3bf66e3158..edf4a156fff21 100644
--- a/Documentation/PCI/controller/rcar-pcie-firmware.rst
+++ b/Documentation/PCI/controller/rcar-pcie-firmware.rst
@@ -7,21 +7,12 @@ Firmware of PCIe controller for Renesas R-Car V4H
 Renesas R-Car V4H (r8a779g0) has a PCIe controller, requiring a specific
 firmware download during startup.
 
-However, Renesas currently cannot distribute the firmware free of charge.
+Firmware file "rcar_gen4_pcie.bin" is distributed in the linux-firmware repository:
+https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/
+since linux-firmware.git commit
+56bb432a65bc ("rcar_gen4_pcie: add firmware for Renesas R-Car Gen4 PCIe controller")
 
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
+Download the file and verify the file checksum as follows:
 
 .. code-block:: sh
 
-- 
2.53.0

