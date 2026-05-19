Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B210367F40;
	Tue, 19 May 2026 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215107; cv=none; b=FxbLJJpIfX32EKSZNMN06+Ut8yapvgscilPxpuD35yn9qfSyfyfenZNtAjk/jdiVUXF1+UDgbXrIfoEtWaYDwjq+GOLKRhkAarS+PWlPtjvZK6IeOp9uDoaLTgwIrgjR2FsTzqDZg7wsbBcqFzLlcOEXsMmbeSBmzeVfiKQzZrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215107; c=relaxed/simple;
	bh=DhFHxDC4jmyD6ZFFXGdM6qmY+45A00ssBOXTzdglNJU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aVixfEyUO2YxjNpBnO6rih9nujUHLpSMeUuy7KVBqJHYL4rcRm5VhdmnYL3zNmFaUJ3f1DXTloRsdNf2gVUA7v0XTecccGEyMoqsKjGIR/YxoYluQlj0AfysYJOtofYE23rtr66C9GPbBTVW6hGbNN4dmwNdNvgm7zTe/u+iyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jV3GSc7J; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jV3GSc7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1779214556;
	bh=DhFHxDC4jmyD6ZFFXGdM6qmY+45A00ssBOXTzdglNJU=;
	h=From:Subject:Date:To:Cc:From;
	b=jV3GSc7JPAEsHyCYG3NRurGeZWSB2dZWwuYSI07kNPmPOtGJUqq8ID2JyFSzKZvex
	 a1K+0S0jAOijyQFhhTQqyIPMy/P56Trfv4PxRQSQdJLi4h3qSQn/E1d5VTDLjxmaTM
	 hY4HKgyaroBjOTuf+QROm1Q3JHBMOetN8nWs8C2s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/2] PCI: Manage hotplug attributes through group and
 make slot attributes const
Date: Tue, 19 May 2026 20:15:50 +0200
Message-Id: <20260519-sysfs-const-pci-hotplug-v2-0-16e90346a522@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBAFf8X0bE1bakFP/ofhYOtC15iWdAtKC
 P8uYDx6nOS9mYkRJARi593EEgxIGMMCar9jzt9CCxzvCzMllBFHWXAaqSHuYqDMO4fcx9w9+5b
 ryholdHmqNLDl3SVo8L2Zr/WXqbcPcHnVrQuPlGMat/Qg192vov9WBskFL6ywxpmm1JW8vACJy
 PneHwJkVs/z/AGR8NtK1QAAAA==
X-Change-ID: 20260513-sysfs-const-pci-hotplug-48b62047984e
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779214556; l=1098;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DhFHxDC4jmyD6ZFFXGdM6qmY+45A00ssBOXTzdglNJU=;
 b=IAV1SKUhWHsmklLS5SSXP/Y7Rkgea75rB1A6+5YI9jM9wbUXl4OMMVR3yOvuM05fj8tT//DU1
 7WXFGvjZz7JAou5oZbXN7qo3rdINop23YsPxJfP4okI3hS4Hkcboax0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Simplify the lifecycle management of the PCI hotplug attributes with a
'struct attribute_group' and constify instances of
'struct pci_slot_attribute'.

'struct pci_slot_attribute zpci_slot_attr_uid' is not constified yet,
as it will be constified together with the rest of the zpci subsystem.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Add a cover letter.
- Add a note about zpci_slot_attr_uid.
- Link to v1: https://patch.msgid.link/20260514-sysfs-const-pci-hotplug-v1-0-3b0b6c6f7481@weissschuh.net

---
Thomas Weißschuh (2):
      PCI: hotplug: Manage hotplug slot attributes as group
      PCI: Constify slot attributes

 drivers/pci/hotplug/pci_hotplug_core.c | 125 +++++++++++++--------------------
 drivers/pci/pci.h                      |   2 +-
 drivers/pci/slot.c                     |  14 ++--
 3 files changed, 57 insertions(+), 84 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260513-sysfs-const-pci-hotplug-48b62047984e

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

