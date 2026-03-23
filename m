Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93193C0638
	for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284094; cv=none; b=OI7cZJChCf7zydMLqOqj6y2Em9aErgmkA5vECKWHiu9QrkQSfDWj6t4/2xLGl9oz5ePZokxlR0BuNgFZWbaaHaoNrCKp3RQRVCJdwpoVEneHwCG1eiGHMpY8tjCqhB9liQf3vrrdTxIHY2jwXIaKfYfdkC25Qt7LN6QrlzvO7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284094; c=relaxed/simple;
	bh=kwohdgYd8IrLunvMAoMYuVyc58nNiOpsOSgXMSwxgWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PbI+PME3AzPxz4can+5wLh3e8mwjQ0Cl7iSX+jTzk5kEi4BeohSm/nxE0AYyJ0Z4mbZ7oDF53RGJd9ziSqN3NPU+ixVa4GOaNI5U6907pvjg0eRwfQLZX9YY5+/lKqdzopv9RIAGUloH3vNHBlknN7/Ftqpbgk9lstM9nI/3mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZv5D5gX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZv5D5gX"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82ae378fff8so2252614b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774284093; x=1774888893; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nndZJkI5xG5h3HrUaxNzDDVTCF1PjouQEC2KLzwoYn0=;
        b=iZv5D5gXlyp8/IfFkSMs0FQ9GZvMNTMSM+9iic8KrGDptfX0X0iwVz/oMh2IX8yr2g
         TEnSGvhh2FFW+hW5dpcpdit81bQQRdCuBxQwwVDbM0c/DuKBmcN0WDw1ZIxLwxh/B9f3
         GzzJYZUpqOlTKetszka7EZcEf9DJ0kqcqDMBwzEKVPLosiFPDRVe9n0avKLfEdtT6Cv4
         8ZevzRHf8FcOWVGZ/KgskGr3sfPLKKO0/qiza7vtVLxDDLTQCHJ1JdV7Nbuhul4fezBY
         tBeXP2Bdj1oLICtgv6gsIbGJYgBkX3d2v9mEl/tGHsaOspbz6D0s/vKLiVHmewUnN7sE
         uMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284093; x=1774888893;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nndZJkI5xG5h3HrUaxNzDDVTCF1PjouQEC2KLzwoYn0=;
        b=NqL3XBusYkhLJeExiy1+9RPGJgGPsBe/VIxT38DnUtSI3xs/CVI6zacSzn14R8bL/c
         NfVxY3TYS1MLIHV0fi1ArAWkyf1MNpx2NecKB5JIC28oF0+yGBn0jSupAMep/gN0lqgj
         Wc5QGSaRWxP+/QG+aWXNpP0s9UkUzOUR7J2g5wmuA0ep82i+kKgqu2stwwKIPPHHwleI
         RAiWeEW31CVxpEvXvr05H617+JuzjJexzwVTuoad60CDNFaTIcBRqt4SI7YUShwWYu8a
         7wh1YF4/uKODcYgJZs7+Ye0WU1fOfx7s114w4L/r3Hue/tG5xFZ1XjptVBcKSJiWkQ74
         8/DA==
X-Gm-Message-State: AOJu0YyglNIADxeo1Od7h1/x1d5RMUK4S/hRzb03AtQIfdKCsykPaGG6
	4FjIkzfhPsGA/KQFoiNNUH4BLnMcXBf4xSCKVzz090qsKlHra1CufyciQJ2nUdN6zT8=
X-Gm-Gg: ATEYQzwdI1LTVyDlbrYQugCn11s0my4eVYkO6sFVp3DXAiyKGuoo1GS4pIsW3olrMBa
	j+NiG5DQDW8EGpzV8ScLo9+6ECzaGgIHYZgM+FAfl8A9g+QHvhNZHzlcV03PbycbPsZxSnqQPnA
	EGSXg4E6gifAY+f9gb54qNzYFE6AbajbGwZAJf2IyVWmwrKTtJembAOtFz5pocmHd4cHgfH50Bq
	K5nwC6KccqTXjtryF4wPk0XwlQCSGYaYT17I07fI3DiUm2cYn3saMkodeVQUOj3RG9MrlhPuuc5
	kkFXElthCEUBTnrnnxUQGdiIPQ3nY2EiWEu7u+6qOUzg88pULUOufJ0gyvAjsR5h4VHmslAPoRu
	4l3JlHqsspPvbiYygUmc4hXeWRfHNgM8sMZG+Rd/YNAV+10/z+AhrrFQiMUHcp7pIL2JtM03p0M
	JrUS02/nF6L+8IwZgBo42NZzsASpwQyzek2BI0
X-Received: by 2002:a05:6a21:6d9c:b0:39b:e321:784e with SMTP id adf61e73a8af0-39be321794amr9295685637.60.1774284092836;
        Mon, 23 Mar 2026 09:41:32 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a817cffsm8191116a12.11.2026.03.23.09.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:41:32 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Tue, 24 Mar 2026 00:41:28 +0800
Subject: [PATCH] PCI: sky1: Fix missing cleanup of ECAM config on probe
 failure
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-sky1-v1-1-6a00cb2776b6@gmail.com>
X-B4-Tracking: v=1; b=H4sIADdtwWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNj3eLsSkNdC0uDRCAyN0pKNlMCKi0oSk3LrAAbEx1bWwsAo1XYOlY
 AAAA=
X-Change-ID: 20260323-sky1-890a90a72bc6
To: Hans Zhang <hans.zhang@cixtech.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774284090; l=1262;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=kwohdgYd8IrLunvMAoMYuVyc58nNiOpsOSgXMSwxgWQ=;
 b=ghymkqUJvu+v4wi/ti+ML8CDhq5Lw/lK/ST6y/0+VoUgaql5hghTqO8BAeCwS5bdMkR0jbOZu
 F2Mk+0b4vQZDIDuosd5djgx/0bNWDdtHwo3+daahwZ45qhqXk1atOq0
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

When devm_kzalloc() for reg_off fails, the code returns -ENOMEM
without freeing pcie->cfg, which was allocated earlier by
pci_ecam_create().

Add the missing pci_ecam_free() call to properly release the allocated
ECAM configuration window on this error path.

Fixes: a0d9f2c08f45 ("PCI: sky1: Add PCIe host support for CIX Sky1")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/pci/controller/cadence/pci-sky1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
index d8c216dc120d..9853a9c82c0e 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -176,8 +176,10 @@ static int sky1_pcie_probe(struct platform_device *pdev)
 	cdns_pcie->is_rc = 1;
 
 	reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
-	if (!reg_off)
+	if (!reg_off) {
+		pci_ecam_free(pcie->cfg);
 		return -ENOMEM;
+	}
 
 	reg_off->ip_reg_bank_offset = SKY1_IP_REG_BANK;
 	reg_off->ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK;

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260323-sky1-890a90a72bc6

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

