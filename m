Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F283ABDA2
	for <linux-pci@vger.kernel.org>; Tue, 26 May 2026 04:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779769595; cv=none; b=SD77+kNGK8D+KZEbcI8qKEWeSpqi4fkDfmyVSA6d9+qXKxOp3ljZW5H5/gY2M/zrHexkAJeOYu3sZbUKqGFftbNuRRuGviyVGRviTDldtOq/qDUe/OmrOCVjOhAnzwhCMfepJXEcQ5xQ000yBvq0ggF3B/WsMe56PbBxhMEOBFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779769595; c=relaxed/simple;
	bh=x3tekH87wGGlm9/Qn54UhWRdZIZUIxu/583l2R4pIp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLAMrCZ9U1k/saiyaxUBQMLwd4zLc48Uoy/56QcelgFDdAEhn1LPU2SGaOjavwZerb8Y0K2L9a06CabX4dmekKXbnA0JIT92TCsrzc8twBcgFtGI23D7XsupeG4uV108+LKfE23hRj6RdDDiUMGr+OG0unfc+C7b6m9stQUmyDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJCjV8Uc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJCjV8Uc"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36ac67f489aso1154650a91.0
        for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779769592; x=1780374392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GudgJJHZbsUHPisZInCPF6lXDepNPrpt+98+m4g4yPw=;
        b=JJCjV8UcRDj08p0dLt1c0n+wi0MD2PcoaLq6VW2CLZLSmtc7awmQR+ITG1d7ymWk5Z
         C3r13zpnk5EA4sIKspa0X9mXieDl6fP+JODF6RRaJFZXrMcrr31lHIR/kj0KfqVbBHip
         K+74hTeS5pXfbT2n6ca68wK+5DDbcnwdL0gYCSj1+C4pUorhA9a37SiuyPe7bLnvbYLU
         pAveONK6QkF3zMQVSILKT3XNamr6N8sIIb4sBNTQOs+htN5w4JSsjaIxvGa2wKZcfEYU
         GVOiHO78LVXYR3LAWrFgKQkMl3fPWMSsEzAduXFeuuG11yO4eFfj9jizUBdvJv6PePOq
         I0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779769592; x=1780374392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GudgJJHZbsUHPisZInCPF6lXDepNPrpt+98+m4g4yPw=;
        b=sdLFKXJ5CinZmpKviPbt+3TKwhrbsiHd4W3KGwLj09S1p9lmc3ZoMaBC1KZOu/+6Qj
         4uqoT7pMA5q+9AtYUlUewDbmE5UCdqFuL7xiql64YIfgAPTQ+xXyuVnSjEuKISUDJiDT
         IXPELGmQHdNjNmDWL14jVSh0/LV0cV7qjZmsVLvaA8sTK7wEIphzyitOIYlTIJgA/AK9
         C5nYw3uIrkEjEPrTyXlX3x1Eq2dIdJ7w64lzHQc3hvnKZmQubp35dhlReH5rshfuI+uM
         djRPn/6Y/WQcNMYJDxIm8rnaEykAlRV5Dwdt44m9NFR33Q6EFdb2yAa4Grf+t4O6Qel0
         wDOA==
X-Gm-Message-State: AOJu0Yy2Y/tR14E2cfheI1+hiCOs5Ns+8iLi5KMvmaWH9xLHkUGNVakG
	enrNkQeFt8oFw083B375yGbXvnmTPpK32bqF92uHlUuay/1AH91dCl3v6BO0ng==
X-Gm-Gg: Acq92OFppdMUodwyNdy449eLPF/YsmnRIIm+c8qhA8gQaiUcK4Vr/21/aLe34Hel0ib
	GKr/futY/m12BZWODBjoUYVt7Kph+2x6WDvhZ849ZDV0pSpxqGCz0iQ+nAYD3JXqDotf4h5X1+3
	O+2HSSuJPmUyJVgJa52XQ7Z/waWL0OF2LgmZrwhUCIy9/lZO1J5t60wGDIeSb5rglpHlGY07lwU
	s2IKmH+R2PuAeVcW+rlNMBMYy0hx5tKVENXQ0r5cLzL5aTw+9egHZ7zVRS0AYHx0TOpZYEj/B1L
	fNAwRChkPjaQLpk+ek0FR+w/kOYT/Zdv4a4ndBmD8uY7VOS9GETuGY9jjfTOcPeqjfB6EPCYE77
	NYDcjsbVUmc+doTzUMe3mGH3npRYlHtvI6chfPykDwPOqNK9qL4KI7AaDorI6rkVto2fvVm/TO5
	COUqoWh0O+6VfpcbWj+S31HuBjqeaw54iI8RO3mXBltCqWptDfdZtiq6neFrUPD23JnzsGp3gwa
	cTcaFNQ5tqAtHPci6MS1V0EVCcDbFGog2M=
X-Received: by 2002:a17:90b:560b:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-36a6bb5b91dmr12330998a91.5.1779769592097;
        Mon, 25 May 2026 21:26:32 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a723cf27csm11044021a91.13.2026.05.25.21.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 21:26:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] PCI: hotplug: compaq: fix X86 dependency
Date: Mon, 25 May 2026 21:26:14 -0700
Message-ID: <20260526042614.1013867-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver needs X86_32, not X86. It does not compile on x86_64 because
of invalid assembly there.

Authored-by: Claude:Sonnet-4.6
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use X86_32
 drivers/pci/hotplug/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
index 891a81bac5e9..392cf75aeac9 100644
--- a/drivers/pci/hotplug/Kconfig
+++ b/drivers/pci/hotplug/Kconfig
@@ -20,7 +20,7 @@ if HOTPLUG_PCI
 
 config HOTPLUG_PCI_COMPAQ
 	tristate "Compaq PCI Hotplug driver"
-	depends on X86 && PCI_BIOS
+	depends on X86_32 && PCI_BIOS
 	help
 	  Say Y here if you have a motherboard with a Compaq PCI Hotplug
 	  controller.
-- 
2.54.0

