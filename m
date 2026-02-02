Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D542882A8
	for <linux-pci@vger.kernel.org>; Mon,  2 Feb 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045061; cv=none; b=k+Uv9y799bnRa9ujMmwH5b8pua2vSLUWX5IWG4h37ijofXsJM+EJcdUF7jAzLRatwlNu9r0TbXljSW21+i2Q0OJv+Vn+BRg/cZDrNF2BxQHtsElfOuTsQO3znov61/kr+lVAXFyQSl20rEDVfpDazyTqpkcRsRfIc3gBTIA57mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045061; c=relaxed/simple;
	bh=btc952EXnNWwdQlMg+H9RbtOd9pcgav+Aeu0irDTT9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=po16EmdGQDtNBCu+Vv7jLU/bVEYKlvNHfS71zQ4LJTPm4jqLiJVADkaIaC0MWHVF/2asYCtfFIbQs/XoOKr3QOejGB9vimVKExJ4SqXO5cUe/eNQTzdOQyWt5L1dYJtyWWlJZjf2r1X+i9Gaw80pClMcpZlA0A7DNK0wP5CWNBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vMdVBndC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMdVBndC"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2670932so4209642f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Feb 2026 07:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770045059; x=1770649859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QLQJlIi1xp3GOgxJrSuyTGl+kKtHgLV5lTV9J+BYkDY=;
        b=vMdVBndCHwhhq8lTTOrA0HVYARA+uPLK78PeYrJ+tXombRUvfjKfM+e5VL8wZPAPWG
         0HJXfV8+WE3QklokxNX3mdXUcdK7cWVEHEf0czMfi7swxn9RnkmFVnxGrahr+moX76OY
         3laWrtHTKzAF/DnsrSWjPEs2BHo58m/cAPVYEx/NrJHvhJIBUXhDu8c6RypC0BX67448
         tkfg5v3dCwjFJM73ygCLbfdlI15F2/V8NRBn9mngPviHWXDBQPUqbzPQN+ke7+ihezr5
         dFftO2Nh9TfXi/AHR+a8TXHP+q32S7n1hMJJmWbdq91AR8upRYgKZY3z1yWWygW7pZfs
         x2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770045059; x=1770649859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLQJlIi1xp3GOgxJrSuyTGl+kKtHgLV5lTV9J+BYkDY=;
        b=OHQOMmrZ7ZzjnrEIqGPSpW8t+FqmvzoWo3JRdyJ/o7sw23VmsuVaH699T5R6QSXOup
         h1QBtWJzC+dEkgK/q/nMyczjGM8SlXL4V7HLM725yT1UXQCLY0FX6VMm3tWtvE1+fGHp
         hVFkhtPnkWAhhuN7WX9+UKFysT6qs/r8xLxcawsNC9sf37AmnVgDs28Njm/daA0B1eRi
         dPPRSDEt3FO/+vUU2+/S15SeVVVKHs8hkD036h65FG+ojiXOxTlMcapZaqqSt3e0kHru
         UdhX0FAsmpdiomFOSuDzOhLyfTLmig1IGKRfj1M1AncO8Zk/2Dw1Wyy2mmtV9qsBO8Yy
         8dsg==
X-Forwarded-Encrypted: i=1; AJvYcCW17nxKfIig1C3VpuNoaHSg1PLe4A0xTEdiqvavfhjJeUgS5JChZXgZtxEXPIekVfP/EY7/uJHNM+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk8UIrMuvnoQ0IC8/1yrEUyJSDY8ZxpBJ3mMvpXE6ij/Lazc44
	MLoGXHbVLy1/5fy78g8n4BJRCNN/5N7c2azP4F89QUXUMLIMxaiqur4cDV5MfJ46kUk=
X-Gm-Gg: AZuq6aIoyeovKqtvcB9cwzWJWT3xgJeUAMlAVuu5rY8TwJUe3EFyMu7xu0RA5+V/0CF
	smZO0I/xa9m34HLo+42Caliq33AiRelza/N8wKU7Y9BNjdneec17FgOBFap366mZqklvd+qKfy7
	Ym5aQUsgM7cckdHYtoYfbNhn+zvRBzK5XphNIyVzgCHdsWAUB7VEOIW14qVjrHcsNalkauSr8tr
	UJTCuIXkHw03A3v3Aw5MyiOJZLvxQQOT3knsL43OLA824JRh/XAzG+tEIQ7deTlJ8qHNszNsA/S
	8LVOKbzNYWr8ajw7zVu+NhtYU64Sh+46FZwwmdw6Aojz8uMXly/1FxaqYpVQfqzEmHFy+ie4cC0
	ugxP5UP6RZzyjKynESaDvVyVYr2bfcBQxKj1fp6/IIiqhDqUQDk8LULRdXUmQUHJzYB8qGn1XUh
	FWDVaiUj0pYIxh5G30AKWjA1i86pk=
X-Received: by 2002:a5d:64e6:0:b0:435:982d:97ee with SMTP id ffacd0b85a97d-435f3ab9a44mr19652025f8f.57.1770045055569;
        Mon, 02 Feb 2026 07:10:55 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:7cf3:628:f0e:cd4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm42845021f8f.17.2026.02.02.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 07:10:54 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: ciprianmarian.costea@oss.nxp.com,
	s32@nxp.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] PCI: s32g: Fix ports parsing
Date: Mon,  2 Feb 2026 16:10:50 +0100
Message-ID: <20260202151050.1446165-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No error return is missing after the loop resulting in removing the
ports from the list.

Fixes: 5cbc7d3e316e ("PCI: s32g: Add NXP S32G PCIe controller driver (RC)")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

Change since v1:
- handle correctly the case when there is no child port

 drivers/pci/controller/dwc/pcie-nxp-s32g.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-nxp-s32g.c b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
index 47745749f75c..b3ec38099fa3 100644
--- a/drivers/pci/controller/dwc/pcie-nxp-s32g.c
+++ b/drivers/pci/controller/dwc/pcie-nxp-s32g.c
@@ -282,12 +282,12 @@ static int s32g_pcie_parse_ports(struct device *dev, struct s32g_pcie *s32g_pp)
 
 		ret = s32g_pcie_parse_port(s32g_pp, of_port);
 		if (ret)
-			goto err_port;
+			break;
 	}
 
-err_port:
-	list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
-		list_del(&port->list);
+	if (ret)
+		list_for_each_entry_safe(port, tmp, &s32g_pp->ports, list)
+			list_del(&port->list);
 
 	return ret;
 }
-- 
2.43.0

