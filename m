Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A8449997
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623293; cv=none; b=XAMwFrzqGa+r3hszhCJdPNSCUaodgXXxLl6Bxz/RN15mlCACe3WvMU1J6Heb/tRk619Pyb9UoTgFfl4I4YJLNMVSGn3a6jlLOviYBvSxOOvPbt85brW4Tdn8bsbBtd90NlhDke4a9JyblIBeISHZh/jtE3HT7I5eg9x7m5QqeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623293; c=relaxed/simple;
	bh=r7l3sH9Ssf2UEleFSX2u+Zj+uzpSa4vwyq6ieakTVVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6vQJRn4q4Duy4mPqI5++tjjOcweunMKG/9lz2paDxrMXhH2M/vFZ0Z4qHNM+h08R2QegGMMboJuJYr9Rv3c8gDlkhSa163w4gwHDh2gvV2K0LG++sTu/eUCP4ru1VUE10w2swevh+HixbDez4Rrixgxx49hrw6GVkEAtuBl2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=ODbI0UNx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ODbI0UNx"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-384c94c9414so253774a91.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 11:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1783623291; x=1784228091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CwAEOJfLknybTUfP/QNSK3Dc8aL5FOhkk5/YS6kTpG8=;
        b=ODbI0UNxA0Mtq+sFYnST9T3GLGjj7pey6pekYz/vzXQuU4sNCX3jP88EhagigDOKGo
         WwbEnmCsLjqT/3Vo0hqG71rleMqwMtIsxVx9hQJ7NVIlnKbK0DMRdgD7IkNpw+J1HdEK
         AI9YgGlthwwMZ/MB75sCMN/vg3XxGqvuXoTplV4g8GUPmK2+NiexLN/y8QCJl4gEJ8Xt
         C+CCTLRz9IjR0b7Gbjbp9OLoC25zDuVfG+qq8c9sI9r7PQpmIp2W4MyCrhKAPHHPjyce
         7AI7InCptJIUb5FgeNnuNR+oTea/aOMwE7/3DWgs5G+tvKx2eg/J6gLL91F4C/DffzH9
         EBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623291; x=1784228091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CwAEOJfLknybTUfP/QNSK3Dc8aL5FOhkk5/YS6kTpG8=;
        b=rdrGFrDawC55sWOhAg3wM/iBcGcvBAl7BqRvLiAPut6lyoA0x2al1Fa2l4wymWZ0Pt
         QA9PFpffQVtuwhVxFWcTwO3SdECnsovav5Vy0ulsd0P1DO848p+/aamJSelWm449NvAA
         6nsavVOkDg4mjaG1hzZli+boDeyqjvL1PG7R7mr1GN7j7FTuX/BoTXCyChN/L1PDZsMM
         7qnNwD1HrxvH3yuE9Kx7qjQ+jt/s1ovgNcYwd7gKyXFvVhjJnphYpuY3wYBc1B/MaoPl
         8pHuiWd5aqDclnXyoNYroa71+DBSjlwQuCUdRl2aT0zTU8c1/3REvJ7y9DVV/wz2b9di
         /SFg==
X-Forwarded-Encrypted: i=1; AHgh+RqGM8PdP0XGxc75PUZciEigMUYOFW0i7UibAH60MWyYKPMH5QQoPa/kkrm05YonkeDB4iOhpcp4GMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCOQAjj9EmjIsEyAcVO35D6Fpm8XsI5OiCteIvlpilkKxLUp8
	Z6gzYPq4GIjfdFamWJfmQoP0pB+LKZRX3qtjUPmlACSET+4pfdXn+TrW/uPUGZbIAg==
X-Gm-Gg: AfdE7ckJJdEWnFTGYMsCuFfHNdsfhWqc0XEIWQL/A2e2eZrJPj1vV/HTUGkk50kbxL0
	W++hVkPbvEomZrdJe3/wwai1zXGszxxdUCdE1pOiyiOYSC3+8B800Y6OlQPPEd09OtN32Aswpgv
	DgTIOIrb+kTXCcTUvNlvPG/MruHGXIjcDz3xtlvCE6eM6DH/S1vZdq7R2SiEXrJopHl/l1I1ztH
	Fk5HNUXn+Q2thh2a6rZ8Gjk5VFR5y3YQS7fut70be1EcomVdQ9FnUaLK+sqqYRLWNhx7kCgIFrr
	IW3JTxvn0HVMBVBS3N3T7zc6guTS6EqgeoT+VpiqDkWxs0lwopQAqu/z6XVgvogL8aAvZyRQjsN
	fydfsOvZKCl5rxPL9NXUgC5v/SOWAvRVbYZQCmqxM2RIFju2iN8E8DZQysE8n2PHjuP4bse0ELk
	rxvIWo5xrJqMebVTuJKZSYMLFThVljKI0m/+LdFvWVKt8z
X-Received: by 2002:a17:90b:56d0:b0:37f:9ce1:735e with SMTP id 98e67ed59e1d1-38941bce343mr8584552a91.31.1783623291109;
        Thu, 09 Jul 2026 11:54:51 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm31297642eec.4.2026.07.09.11.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:54:49 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH v2 0/2] PCI: Add boot options to disable DPC and AER recovery
Date: Thu,  9 Jul 2026 18:54:27 +0000
Message-ID: <20260709185429.627968-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On large modular systems with a complex PCIe tree, the default kernel
AER recovery and DPC behavior could cause unexpected side effects.
Sometimes it would be nice to have the option to keep the system in an
unmodified state and be able to handle PCIe errors from userspace.

This series adds two new PCI kernel boot options:

  pci=noaer_recovery  - Disable AER error recovery while still logging
                        AER errors
  pci=nodpc           - Disable PCI Downstream Port Containment entirely

---
v1 -> v2:
  - Patch 1: Move disable check from pcie_do_recovery() in err.c to
    pci_aer_handle_error()/aer_recover_work_func() in aer.c for
    proper AER-specific scoping. AER error status bits are now
    preserved (not cleared) so userspace can inspect the error state
  - Patch 2: Also skip DPC port service driver registration in
    pcie_dpc_init() when disabled
  - Rebase onto v7.2-rc2

v1: https://lore.kernel.org/linux-pci/20260602105558.1799563-1-yurypm@arista.com/

Yury Murashka (2):
  PCI: Add pci=noaer_recovery kernel boot option
  PCI: Add pci=nodpc kernel boot option

 .../admin-guide/kernel-parameters.txt         |  9 ++++++
 drivers/pci/pci.c                             |  4 +++
 drivers/pci/pci.h                             |  4 +++
 drivers/pci/pcie/aer.c                        | 30 ++++++++++++-------
 drivers/pci/pcie/dpc.c                        | 19 ++++++++++--
 5 files changed, 53 insertions(+), 13 deletions(-)


base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.51.0

