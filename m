Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB52E22B5
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917455; cv=none; b=kaFQWJC9I9FWyeHQ03uIqwui+l3szPGf/C4eJPiC6dXdPTfLpOQJbzABs6U5u5x0qfjY9PGMDFVk2QGmdUsECODtW8DmOabO9jVS/Wmm/tnUoM0v+jnDBwvEGhDB9YfUy/KiifKvKWvVRXShCqGqr0D1NAU8ASJph7XXLGh1OJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917455; c=relaxed/simple;
	bh=7wMkTNUERnaBjBTCO5sTnBvLOxumYwX+e0q8caYes/g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CKnaSE08BkON6eLWuWs8/94wQUKfFpUJk53LPLWdtwJcKT7I3ShZoABB4VgkOfmWrSPrAv33sFg2rEP9K3tgQaEJlh6s4emekWxSa93N3AHAGwCCS6ptv9dSOYzJt7rmUuwK5EPn5XY/qzinPMUq2EFf4+SRfEluOEtkgonUXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMLXxVe6; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMLXxVe6"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4b28d7c729fso3463484b6e.0
        for <linux-pci@vger.kernel.org>; Tue, 08 Sep 2026 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788917453; x=1789522253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=95z6ZToa6ULbmEQJKG2ytEvJnP27Yp1f1HfgeEMdNVo=;
        b=XMLXxVe6q0b20dUefFNbKdDIgVW9fF2gF1+ndPzqVkcZwCXG/N/k52XN4Mq5tDW6iq
         aAOtgfgXP7kqpGKAGm9tTFE3WD+GociL5EcyKPjLz7q5jJFC7R/pAfZZsztsUYpOpNFC
         6BeoVccT75zQK1c560jnzwxIqWT706FThT3kAxkeGaCCFSjcjVjJ5jpkWhobIM4lbWg1
         GXQNlxDC3qklynQTwldoYuWOsytq8beyeGG/SKfNQLH6k6p6DidFqXSQpVziRP3P3DGK
         GFhaK8x7ARdkQ4r74lRRkOpw38rpxp69Ad2s0HriZmqagcuC2sc4DpspvGeLjj+rZzQ8
         jRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788917453; x=1789522253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=95z6ZToa6ULbmEQJKG2ytEvJnP27Yp1f1HfgeEMdNVo=;
        b=BwvxIgVW7d74y2YMTDpzux/uY7mTZYboWZDx6Zn66/HjZ/tQQR+xrJEGtkPcxg+n+j
         V71idIG9PEfK03uwD5eOM71TLWdadcXkUF6nFcXJr5AA9XxAJhYjlWLjTqEq4PWwEgI0
         TKurk3aUXZk0AOZ8xkeiAJ6FuDjZBdcCY8FTK4WQdvaXwtMJWEUaAx6FwB6pQg4G3clH
         vXAAxmS5ssQ+0GBYBDXMV0jLlLPVnuxfPNWW1AHzN/OcZ7sbEs7WD31yahjxWb1ENZzw
         bU4cUgzm7AxM5f52PETqrb67gvqS2P3JmPCMA5zvEkqo0Qhlv1ygfTB4/f0o+2LhHCNB
         lzZA==
X-Forwarded-Encrypted: i=1; AKwUvBxE76Rewn7iO1LDKdcanjlnj1lLe81oTdcf4JVtyLi9JDhnHZkXfYpIhS7ES5jPQWVsNCh5zUNMDlk=@vger.kernel.org
X-Gm-Message-State: AFuF++kgsVvGU3mRkv2DlgcQ0MXaY8XdMtT5tYM7HkdCuMwshOpACcYt
	YjDa86Ve31aOP4xtA6RQ0w8TIKjmuhC5w36+idV9QUt1Gevid15ULYNM
X-Gm-Gg: AYBFou0dyidD6m0cA6k94ZnXN71hNAt9v1zv49R5R9JLQhGM4uhl0oILDg7uMJb6kuR
	2JVQS+NFewIQGFRAHnDlcCACML75ctCc30Z4IMQWsQXhgxn6VXED1H4Uk8wC7UY+x2otAXSJQj0
	Z5Ehtys37ZDrTHODw02xiGMXMiffiQXzUTVUNoxQuxpgpXtfg0IF3SCApn0DB4s7XTLqDF1Vtza
	JYz9uRLQmhjcVtlRG5MbVc/fUrArwoJn85aMIV2jpwGAp0j3+sSy/BcJscZaGoEpnhIY0bgjUtm
	lPuqGwEi923EL+jW48mRGN8/s4/V1sBOWjt0CeEwGp/0uqhxIIG2LT73RTAW3RyxgJExp15TU1/
	zLYdirXZmBWg3Dcv+bQAN3ne2G+Nd0NX3JH9cwSJPa+LNTqjq7zAx9gRcGom/2gHWCBEYhbt6uD
	VpQIPmoa7TcLzXpo44ir9qAEywDPZpgMnvdkA1FxvPgnU3rjJCwZVWnuObK75Y8wejUjLcCerss
	OGJevQm1JYGruLlXf/Ztk0s1g==
X-Received: by 2002:a05:6808:d4c:b0:4ab:230c:5faa with SMTP id 5614622812f47-4b9645205bdmr19640115b6e.18.1788917453364;
        Tue, 08 Sep 2026 18:30:53 -0700 (PDT)
Received: from david-hassan-Inspiron-15-3567 ([69.162.230.54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971c98e07sm14177197b6e.18.2026.09.08.18.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 18:30:52 -0700 (PDT)
From: Fahmy Hassan <fahmymohammed@gmail.com>
To: bhelgaas@google.com,
	fahmymohammed@gmail.com,
	kees@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] PCI: cpqphp: Check pci_hp_add_bridge() return value
Date: Tue,  8 Sep 2026 19:30:28 -0600
Message-ID: <20260909013028.508870-1-fahmymohammed@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpqhp_configure_device() calls pci_hp_add_bridge() without checking
its return value. If pci_hp_add_bridge() fails (e.g. no bus number
is available for the hot-added bridge), dev->subordinate is left
unset, so the subsequent pci_bus_add_devices(child) call is
correctly skipped -- but the failure itself goes completely
unreported, making such problems very hard to diagnose in the field.

Log an error via the driver's existing err() macro when
pci_hp_add_bridge() fails, and remove the now-resolved TODO entry.

Signed-off-by: Fahmy Hassan <fahmymohammed@gmail.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index 81c58b1ec200..34803f36ba65 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -100,7 +100,9 @@ int cpqhp_configure_device(struct controller *ctrl, struct pci_func *func)
 	}
 
 	if (func->pci_dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
-		pci_hp_add_bridge(func->pci_dev);
+		if (pci_hp_add_bridge(func->pci_dev))
+			err("bus/device/function %x/%x/%x: pci_hp_add_bridge() failed\n",
+			    func->bus, func->device, func->function);
 		child = func->pci_dev->subordinate;
 		if (child)
 			pci_bus_add_devices(child);
-- 
2.53.0

