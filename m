Received: from mail-pz2-f37.google.com (mail-pz2-f37.google.com [74.125.228.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1883F492E2F
	for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2026 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207061; cv=none; b=lMWXw+Nl15uYv/Kl8hKW8/v7S1vC5aHCvpJnOlAQfivlgnGgSHBOuMwOWkH73JiyVwwShWR10al4YgkLpOrJghjUbmh4FVAwlczCIwKaEGTRM/9oosNzbJyH8c9oIDepgEWk6FSVX8fzaBb2JNQuIjG85eZjIu2VMPEJy+lFSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207061; c=relaxed/simple;
	bh=7YAOrOKWVpnc8qBi0WwzMvYslWCxYmzgw+UnAPdIX9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQI5ylV58hB6VjM1zXQIs1lrX8WcVFXsGlTB45Tb4TL4z7sFG4VIyGW3IWKF5dRhrFYJ8mmQlL1ujwbvPSSEQnfVBp34ciciH4lDqTNIg/7nEjd20m/8HwgDB8XhFQIOIdz6K08R4tD0QQh1N0QIMPtSWGPvSBz4bC6ZUgwnXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=v+GcUbpJ; arc=none smtp.client-ip=74.125.228.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="v+GcUbpJ"
Received: by mail-pz2-f37.google.com with SMTP id d2e1a72fcca58-88826f3ff80so593355b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2026 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791207059; x=1791811859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZLBHWc5heFG+SpSm8h2sc4e0OVYT+vhm1QY+Gsi3sRw=;
        b=v+GcUbpJAUO027B26pzF9mEaYXKtKY/xDvHD87xWirNT8++jX0Hp9AiD+yPvI7LIzs
         foRcjVl+vXAqVIOMLeH/ZZfcpMWPh61UADvT+YSpILy1BzL/NJv3fXbQr2dz2cwieyzF
         61UpjKOnTrtBgCWJX/L/zd7vhyxF4N/uKoLzAe60vzb7ejMzW66VJpUTqq3bT1MuqMJe
         daPKRcePKnGj/bMWOo+Exbbbj6IRsanxtOnxy5JcFCgH7h8n7SR8fwsmTcy1FotgKYjU
         yFeK3f5EBZIJFPLL2wd+sDDnVyrPNE28gIARFrpZZhGipIfJbFi2r6yC010rdgHaC/ma
         B75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791207059; x=1791811859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZLBHWc5heFG+SpSm8h2sc4e0OVYT+vhm1QY+Gsi3sRw=;
        b=ry4vpqZoorK8V0NK4nLFeIz6oGXhI/iMgqrqbz9h/ZAs6a09fKyEPrnVF6zh5rWJpB
         uLNtNaPeGjzNPkGM70zVW2JoZd8/KzHjifsLbgFGYPme5z0gvy9BfngVz+BW38nINsQn
         AtJyogigoiRQE2VSk7jwfGanTwx4bQhxEmndB0xDGqWzioRHuFmYKru7TEE+pQQUGB+S
         pao1oDy5ayjZMDI1Odjgv5pwxHJxa39s/nclELzsax38OPVWIBahGRJUJixdi0WxHiyP
         DcVEnfm6bevPczoAfAOr+onL6/xeeUsIyUjqZaOoAYiC3er0xiNSK0VZjdBpcg5jRe00
         idwQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSNnhSpefwJpRLOWv7I8z1pxm3kK+3bGPuIdJA1GGJGY4TmLZ1iQe33jpikKpq+XQ9mOpJXKwzwF4=@vger.kernel.org
X-Gm-Message-State: AFuF++laXGXS0499Mdbelun4+qqG2jGMDAf9n8KSQq02xyIZUFXuS6AO
	LvRcvYh1JigkkFFKDlfB21IaUPTBRUNSbZoO/BtUVHtIeZkwxXuFmZk7ROo1leNS5F0=
X-Gm-Gg: AYBFou0+P49o3MGGMItLRUYtMigrFwCl4Bl0jtjlWjapqbYhWdBtjAhf/dSGZbrJTmk
	iIV73Mq7t3JNgMCVM/PgxhgwWy0bXYA3zoVkQKDyn8BqIG12cXZ18No6XFiWpOYOYD/x1j0W2/D
	33i5p947ZOCAUOQp1nfHmom1ZTXQR0IeK0wdZibQJsjH1Kz5ESqNkXAwwQtbe7gFNOANMbkuYSY
	McuuKdsP9gYuaOT0vuiYDio12g0YZIdZKFqrjZkZwab8vxQZ8Tu1WEEklZDoUhP+TDkf0/kIdUm
	O5OfdEITYb/CmJhB3T2iWSfrx358nrF5oRoHWq/DPOI1BQJ9iq8g/lGL+KLhsg3dIcsQpS8Pf8/
	XLTy1LBQ7FsLDezu2VjcvdsqcOnWiYG9QGtzKzs+XeOkQzqanb+sIPwqdBTYC5tlM++BHQy41rQ
	+vDIhhbuEsrWKDUWBsYdxI/6lmyU1DK5uS8Cy52fisdv0mbD8ScR8Fwwbaau6EHIl2QgxPuRjyh
	aX2ox0wibzTmU/GQc5vzQ==
X-Received: by 2002:a05:6a00:1595:b0:88d:20ff:15c0 with SMTP id d2e1a72fcca58-88d20ff2cacmr5378745b3a.11.1791207059207;
        Mon, 05 Oct 2026 06:30:59 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:5364:bba9:2adf:d611])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0b8f21e2sm3535988b3a.12.2026.10.05.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:30:58 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	bhelgaas@google.com,
	jbeulich@suse.com,
	konrad.wilk@oracle.com,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	Jan Beulich <JBeulich@novell.com>
Subject: [PATCH] xen/pcifront: check that an AER callback exists before calling it
Date: Mon,  5 Oct 2026 22:30:18 +0900
Message-ID: <20261005133019.284053-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcifront_common_process() handles an AER request from the backend by
dispatching on aer_op.cmd to the bound driver's PCI error handler.  It
only checks that err_handler and err_handler->error_detected are present,
then for the mmio_enabled, slot_reset and resume commands it calls the
corresponding callback unconditionally.  Those three callbacks are
optional -- the PCI core NULL-checks each of them individually before
use -- and many drivers (for example igb, igc, ice and ixgbevf) install
error_detected without all of them.

aer_op.cmd comes from the shared ring, so a malicious or buggy backend
can send XEN_PCI_OP_aer_mmio (or _slotreset/_resume) for a device whose
driver leaves that callback NULL and make the frontend call through a
NULL pointer, crashing the guest.

Check each callback before calling it, as the PCI core already does, and
fall through to PCI_ERS_RESULT_NONE when it is absent.

Fixes: 956a9202cd12 ("xen-pcifront: Xen PCI frontend driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
There is an in-flight fix for a refcount leak in this same function
("xen/pcifront: Fix PCI device reference leak in AER handling"); this
change is orthogonal and applies in either order.

 drivers/pci/xen-pcifront.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
index cffc32d660327..490913676f244 100644
--- a/drivers/pci/xen-pcifront.c
+++ b/drivers/pci/xen-pcifront.c
@@ -599,12 +599,17 @@ static pci_ers_result_t pcifront_common_process(int cmd,
 		case XEN_PCI_OP_aer_detected:
 			return pdrv->err_handler->error_detected(pcidev, state);
 		case XEN_PCI_OP_aer_mmio:
-			return pdrv->err_handler->mmio_enabled(pcidev);
+			if (pdrv->err_handler->mmio_enabled)
+				return pdrv->err_handler->mmio_enabled(pcidev);
+			break;
 		case XEN_PCI_OP_aer_slotreset:
-			return pdrv->err_handler->slot_reset(pcidev);
+			if (pdrv->err_handler->slot_reset)
+				return pdrv->err_handler->slot_reset(pcidev);
+			break;
 		case XEN_PCI_OP_aer_resume:
-			pdrv->err_handler->resume(pcidev);
-			return PCI_ERS_RESULT_NONE;
+			if (pdrv->err_handler->resume)
+				pdrv->err_handler->resume(pcidev);
+			break;
 		default:
 			dev_err(&pdev->xdev->dev,
 				"bad request in aer recovery operation!\n");
-- 
2.43.0

