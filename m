Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74044A710
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843411; cv=none; b=BM94LB+JRwrhJzS8R14lLw30D0yP+bWaDfdRldtWUqk4IIorp8L1V5wXOrQs+9IeDY8lS7QLnpz5TPkjZ8YZhLRdwVMnxp4vaZfhQYDuv0ruZF1tI+V44ErylXM+sUIfSXNR74BVG5PNJO0zaytoKaVPPWp0yLA3oqzFXMqJPFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843411; c=relaxed/simple;
	bh=LYybX/vUqdwR2xiT9wIfcDWmsX8nGUpxSamDsxvKbtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWd7m5n6W1LYdqr4k5MurUUXrBaBw4cSldwbWQYeDsAFNl/RdTjxaUK9ddiRTvkDR1kLDDNYXHbULU/zqlYqom7uivGFLnNRj47WV9KtXStUCw2qROBGfmlhbkUr0BkpgFO5EAOYXaB/X7Oq8fJGTKaQPe8t9UqZn1CWnDlFC+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+zO03t3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+zO03t3"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c80167f5716so4060709a12.2
        for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778843410; x=1779448210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jV8777/fPwmr9JKYBjcGgveZ+Vz7Llcck9xzkIvVy9Q=;
        b=k+zO03t3xoOdoRysHjU1gK0E4He4GiN+OlBDVI8RBGo+neCPa/iGpTagAhSsNCXEr1
         AXKfR0csm1Dv632/NPg7hlVQy8j1XXpQKAUA8MVtzGW52GeGy0nqggo+skT6wc9467Cw
         Xgx6Ly4Y7behpMOmVuvK80pmXCxBJYIvo/a+JNb+zEjRU0AE08pbaZ/7IGfQyNxcNBsV
         KXGf2YJLJIgtCjpqR9NFyOizOmKDxlQBZzGZAiZgjXVhIJHp+alTEf9SBtWtuMzxWcO3
         HQ7ma9bD4TKmFO2h1N8U5/taLLr6MPRYIBnEUgH2/WosP9wEOLSwkhC8t98aUcBY76al
         jNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778843410; x=1779448210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV8777/fPwmr9JKYBjcGgveZ+Vz7Llcck9xzkIvVy9Q=;
        b=NPAredfSU39Y9s0IOThPWO+dWvsG32k8iEfWyBDS52tY2fXGVYzuR1XUc+SdtX3/66
         taij3Iz1D+GxjjYaP7WGddA/PkFUjHdBhrLDCvHjGsySekQwwfde/qtWrrCAKdYlujDW
         dFP1s19El0F0z2vtvUZoLBNYsJ0I8C+wPuaVS8sdMxpuYMleMQNNBEJJPz2fAtxYWFg+
         9ebEX5kCkUX/MDY4BpFaipr35FNzn3OKB4ilXGw/hRAaYpHQhzbiUfg/UJaUTzmPqfit
         9pK3dmV+cW3yrNu158S9RCMhSHUE3wwVzT3e5ctD8oyWd+HE81F8c20v/Hxtb6US5R2t
         9DgA==
X-Forwarded-Encrypted: i=1; AFNElJ9DAteV8QaLhZENcEVJQ7dIjTWwZg7nOkQBe7RuNp84POR+wZWY0ViyJyUeMt11WgYrIxrJHFblBoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBpkHlMPvUtNpKvDZWRK/r3zFw+BHeVS0czcVZeo2ltTsr3xhl
	o3Ixu0T1HMTTybww2YoROM6MyXZkqExXHx+Ll9BZ7I3zXDADwYEchut/
X-Gm-Gg: Acq92OEOH0/B8E1scNFMLxcivNIK/AX7aaeVe8DsUMoyXlY8EIOBxX7faYeLud32v/Y
	Jijm2nmsQFpcIww8ES4Sbv1aDMfefPh6OmiZ/Yh/1cZK5OAhFSNihQe5FwL9pJMgcrsBkKJw7Ql
	i6yidXdZB/Vk8EkS9v36icuY+zt5k47dAYZFC+GapNmeLiap1rzTBQet6SyV0YmJAivgwgt6+dm
	30spya0VNTCHVpPKiE/KR8S/h5CMPQk+YHtLsqsl9HxMOex6hjlWjMahxV69ROaf8wrV8sZDX2V
	Pgbak/cn1Zh8sApwwznVyNgaSLw73JvL9m2D0XxnPyvV0sEUFIiJnnVJRdhGkx+QPYqm29PHMf8
	jF6gGYWxCfgoSOlXUnwvfWPqYoUxml3Dunzk6I7YSPKoROkJIbzA93V8ImBll1y5NLKgWh2d9A8
	rBPbJ2b6u0csq/oMvRYn2Fjsqr5x01TzmgutsUqREc
X-Received: by 2002:a17:903:fa5:b0:2b4:5cb8:99eb with SMTP id d9443c01a7336-2bd7e8bd34fmr42942105ad.27.1778843409597;
        Fri, 15 May 2026 04:10:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d008:80b:a00:27ff:feb6:42dd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c264241sm54566645ad.36.2026.05.15.04.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:10:09 -0700 (PDT)
From: Pramod Maurya <pramod.nexgen@gmail.com>
To: bhelgaas@google.com
Cc: kees@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pramod.nexgen@gmail.com
Subject: [PATCH v1 0/1] PCI: ibmphp: Simplify ibmphp_init_devno() parameter
Date: Fri, 15 May 2026 07:09:43 -0400
Message-ID: <20260515110944.216993-1-pramod.nexgen@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ibmphp_init_devno() in the IBM PCI Hot Plug controller driver takes a
struct slot ** (double pointer) parameter, but the function never
re-assigns the pointer itself -- it only dereferences it to read and
write the slot's fields.  The double indirection is therefore
unnecessary and makes the code harder to read.

Root cause:
  The function was originally written with a struct slot ** parameter,
  perhaps anticipating that the pointer might need to be re-assigned,
  but this never happens in practice.  All accesses inside the function
  are of the form (*cur_slot)->field, which is equivalent to
  cur_slot->field when the parameter is a struct slot *.

Fix:
  - Change the parameter type from struct slot ** to struct slot *.
  - Replace all (*cur_slot)->field accesses with cur_slot->field.
  - Add the parameter name to the declaration in ibmphp.h and move
    the comment to its own line to stay within 100 columns.
  - Update the single call site in ibmphp_ebda.c to pass tmp_slot
    directly instead of &tmp_slot.

Note: a few pre-existing CHECK-level style issues (cast spacing,
debug() argument alignment) appear in the diff because the changed
lines are touched by this patch.  They are not introduced by this
change and are left for a separate cleanup.

This patch has been validated with scripts/checkpatch.pl --strict and
produces 0 errors, 0 warnings, and 0 checks introduced by this patch.

Pramod Maurya (1):
  PCI: ibmphp: Simplify ibmphp_init_devno() to take struct slot *

 drivers/pci/hotplug/ibmphp.h      |  3 ++-
 drivers/pci/hotplug/ibmphp_core.c | 30 +++++++++++++++---------------
 drivers/pci/hotplug/ibmphp_ebda.c |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

-- 
2.52.0

