Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537C2DB791
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788598163; cv=none; b=mcoUEGcT8zsFo0tjwrtwzRbXbKTdIeNX13DRWMVvUydm/dseNha6F2RzUYX18OeDpPJsWxpILQ0gJtgxXDmGyRmBBDZUi1fqHcpvOn72iVsDb5D8jMV+r3gV8uhwi1Sr/5VK9ArVFRfK8So+T1p9V4jsNDYQSUvOgqtatgHE6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788598163; c=relaxed/simple;
	bh=xIYiLKWaJMwJkehNlPTmmW7l1oeBPiPWKXBdPvsnTR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E1LKTYmUmPelcztoALwiPEnt5MVBcuom2byMn/4JWhXqt7oIkVnD4313iP29VRWd8PqGrFR8aJ8WyAt1Mie7TLTHzJAQoD2ilmntvaBsH//vTuUG5Y+S5tjyl6nadYWusTVpk9Th7kmYl2YSvXN9oMcRU+ZZaEwRa5/ai8LN1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fb/K/wLD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fb/K/wLD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-482f2ee53e7so1246721f8f.1
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 01:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788598160; x=1789202960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SXXgK3vFKr5ZlJy42y1su29qXhHDXXAMM02bZzb7nLw=;
        b=fb/K/wLDJTVKw8sOLlnR1GMqCGb/27h6bvMXhm8W18tv7BgATYn4Ai0j4JTpTo6vTp
         TOuqioczZI7jBDmpF59daGPLJB7hE6Uzxs8MgylPPliz2p6VEsRn0dIuYmoQEGMUS4KO
         hrBg2qzs2TSfED4SeV2FkMxkAXKMBfYrsjefKPaiFVEs6/fzkUfhnn0YxnClg9rbZp//
         Ba5exf96CSlizR1q5KSitezwdBDgj3rcomRHnCMoTw5wBTFEPFJlnI3tSDdUHBHPoYqt
         viCSYzOziYQ+qWbZaUm8Hhqb22gXOYV4I3HdwczQqKMzFbK0wkLIe020my+PAID92VFh
         3ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788598160; x=1789202960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SXXgK3vFKr5ZlJy42y1su29qXhHDXXAMM02bZzb7nLw=;
        b=IBe+YTj4xv4aKeBhc715+hO8WC+xBScf0EmIZGWJqLZn5BDIUq4YMcEJrIBCOvyUNv
         2cXkclMCeatj87UPOWxuinGb8bNZ40ZqPsh6rdUbmCa07FBCaroJ4llql5ATSKoBUei4
         ENwV4ZOJF3zv1F8FEFLPxh2iGvAMAuIJ+CphVcFNF0TKXeTaR/4x5hzMzPzXnibKS7GL
         WdZbW9tgHdh1WAYmagTplXNJxWKKF83xLzfwMZMlCuB1KhpdLGYuJeqLbhmycemnCdMu
         cmHGqOvOqGNiTO8Lwr5WO8v2YT+r5swewrFeNNHYtV7rnszyNcJLsgpsSELE5pbZMMP1
         F4WQ==
X-Forwarded-Encrypted: i=1; AKwUvBxw4Tc9c8oHlQbnQYfC7CFhUndZWNkaXBOvxOIjSYBJn4aMl0ktsU3mioQtaa6PFXOgM/RzJaeXdSU=@vger.kernel.org
X-Gm-Message-State: AFuF++kWYt/QROVnEg+K68IeoFqCxhp5nSJRDRTk7VSwuiMmAg/0NKvj
	or1Bab7azqEMxHfKWzerTDdHqzDDO0IRnT50Hw1vgR+dHN+/8UBwpeUf
X-Gm-Gg: AYBFou1SJnukuw991IfvjgJe+GX5WfoynUCpNu1+vtfrMiebmHNEUpsj8ZZIe7etptJ
	XSUUsT1b9xFWxhKRLhdoMYKdwPrVreU70UNDr8DRgGcEYD7ygU8dR7pfphuHSgeVDm+ZQc0vLh3
	ICZG6nUq26HUrh2KD7QRQbnWtl9BpqT3NeljBWNCmMQuDl5xPE72J4qD0T86Mq1UGA/5xNQxyjM
	WxuT4IXvaGycCtXQJxnbkB/yITRF00ozseDjKq+UWC8oe0WoBRs9zzcvqapL8fsREvu9yEltITk
	zJqBNPXol5ccxChctOCmW3B+yruawLT92C/eoozxZiggt3kJ7tYEv9/FSdkhPfS7pFAIXvkL5fk
	zILvIdh21UGYFOmjZgfbOkq7s3/7BwP7tAxSHw75Mx+JCEwq43IpFPkOSESiGGXH/GyJv6MUB1t
	nD7Ct2W0OTc4hnBND7+++W92Vn4LQWR05bOrotwiZQkcqejrxkQTMgx58jaIxyINm/EbvrqsbZp
	PLvEmcX9diutOT+R157LIaNXdCEVEoombjV+un78QyhHEBInciGepxXDPO+EIE4tAE4MBFIXvE6
	L0aryjOAo9/Z88FdSL3/7amuW7B2BoF/L7Z2jXjcsiI7yTzUIin7bD5pv1Py5ASgH/96
X-Received: by 2002:a05:600c:a0b:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49cf8262133mr117706095e9.16.1788598159566;
        Sat, 05 Sep 2026 01:49:19 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d07b371afsm9098615e9.9.2026.09.05.01.49.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 01:49:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-pci@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: [PATCH] Documentation: PCI: Point the pci_device_id kernel-doc at device-id/pci.h
Date: Sat,  5 Sep 2026 10:49:16 +0200
Message-Id: <20260905084916.40196-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci.rst pulls the description of struct pci_device_id from
include/linux/mod_devicetable.h. Commit ad428f5811bd
("mod_devicetable.h: Split into per subsystem headers") moved the
structure and its kernel-doc comment to include/linux/device-id/pci.h.
Since then the directive finds nothing and the rendered page no longer
shows the structure.

Point the directive at the new header.

Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/PCI/pci.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
index be35e9a1ee75..71c42b0bfa8b 100644
--- a/Documentation/PCI/pci.rst
+++ b/Documentation/PCI/pci.rst
@@ -84,7 +84,7 @@ initialization with a pointer to a structure describing the driver
 The ID table is an array of ``struct pci_device_id`` entries ending with an
 all-zero entry.  Definitions with static const are generally preferred.
 
-.. kernel-doc:: include/linux/mod_devicetable.h
+.. kernel-doc:: include/linux/device-id/pci.h
    :functions: pci_device_id
 
 Most drivers only need ``PCI_DEVICE()`` or ``PCI_DEVICE_CLASS()`` to set up
-- 
2.53.0

