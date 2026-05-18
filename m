Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E438F253;
	Mon, 18 May 2026 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131555; cv=none; b=n4CJyGWtNpcJUHizxBMF2Dwb6TVuQ5Yj/JA4/GXGnWqyX7V9BvR3a1CsBWPO7HM+V4EFGrku4VDdLPOiAsX1SIQfs0IWW4ZCwVR1p2vyO/mczcJu+tdD5ailmuBgRaBlOlQvzetz3w8zPCDVfz1cHLyt7VHgO+TRKq7EanLwZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131555; c=relaxed/simple;
	bh=qrUC0CR45vX2T8T3l6xZMm4+i/QGJtJXpk+nHDir1Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKD2BMLezDQi3WKG0pdL5usaxemFABV73Bw9SXYQgLrnL10T7xSlIAsMAm3mswSZouHKzJ2MzAfyIrouaA926tTso5mzb8nj+EHqrgjWihIViaMo/ZOpHyNsvxMqNnvd1K/Yqt00kxwatzqT0Qmdcat34jlBYF3roxj4Poz7Pdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YI72NuF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YI72NuF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9CAC2BCC6;
	Mon, 18 May 2026 19:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779131555;
	bh=qrUC0CR45vX2T8T3l6xZMm4+i/QGJtJXpk+nHDir1Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YI72NuF4o6Kv+z31uWnwShRerVfS3H1gPA5NxJTGJESKQqxNgt8xRiWc9rFowIQZ7
	 r+kgSFji+7aUr6Owc73XXHPh2LKCbXgEwaJAlOrnAO5kKEcSOVwpow/AojMy71mmXn
	 jP27KesUFrmX+rc6w553ojn+chXTetaoknLF/tA+5guhxEMYK/aqDwgDovEYQHWIgD
	 W6zbh01wW8tirSjCDtdAULKTgwpQ6oQsA82RXGxGj1pr4q3mtkJoQbFDWRx4D02Ksd
	 mMz1Y5v8a6nfEW4Jt7ZTfAMiEuiVdoWXLF1VXNIs6h7sWO3UhOJOAqZ0niod9PZNp0
	 povHzSKROQJtg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Marco Nenciarini <mnencia@kcore.it>,
	Michal Winiarski <michal.winiarski@intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Eric Chanudet <echanude@redhat.com>,
	Jean Guyader <jean.guyader@gmail.com>,
	Alex Williamson <alex@shazbot.org>,
	Sinan Kaya <okaya@kernel.org>,
	Mario Limonciello <superm1@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 1/2] PCI: Log device readiness timeouts as errors
Date: Mon, 18 May 2026 14:12:18 -0500
Message-ID: <20260518191220.636213-2-bhelgaas@google.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260518191220.636213-1-bhelgaas@google.com>
References: <20260518191220.636213-1-bhelgaas@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_dev_wait() waits for a device to be Configuration-Ready after a reset,
such as a Function-Level Reset (FLR), a soft reset during a D3hot->
D0uninitialized transition when No_Soft_Reset == 0), or a power-up sequence
from D3cold->D0uninitialized.

If pci_dev_wait() returns success, the device is guaranteed to respond to
configuration requests with Successful Completion status.  If it times out,
device is completely non-responsive.

Upgrade the log level from pci_warn() to pci_err() to reflect this failure
state.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..5a9af0bb2c71 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1253,8 +1253,8 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 		}
 
 		if (delay > timeout) {
-			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
+			pci_err(dev, "not ready %dms after %s; giving up\n",
+				delay - 1, reset_type);
 			return -ENOTTY;
 		}
 
-- 
2.51.0

