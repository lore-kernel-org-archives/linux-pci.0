Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688331;
	b=XWPKsmI9+Ak5y7+4uILP04IEAf1jgBrlH32nHE9SWUsbkH56QEQFwyxGFLc0QWvbaJyQ
	 mTYow65emvZ4BWKN5jHltH0hADHZh8MFYCwoWuvf+Ucc4/l23javvf37C05onPtXgOgRq
	 URtiyNvru7hra+CUVppM8mk2mELG48RXXpZ4m5cjXVALtS76ZPeohMxpcSulbcGCPY1jw
	 388jrwf5uXCFT8eOxnna0r7Tjf5syPmoVmMRJnyc8lGJRdZL+bY/riRsxwlSkPg3syxBC
	 Uwi0a4ciZz78zNwoCaoBlFirO0r3vqrKr4hd4hDkIAZEyUzpfBlyAvVHYsrum5RBgqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
	b=drpBxWZdgGqRC6F/1vxlyVZV+6T63N30qhyIy2ssGQTTxEswHu9td9MTqW6u8mFUCW8e
	 etCY2HWxrzEPYab8FMxc7aJT5OMSb3Eb6kWwpNT+6eDGa6uq2qSTZ8Bl5oYMqf6wKNVq5
	 c+o+9uTkUDASO9hUhY1eUzOK0p05t3RCrGrxAoORY6eJebiEN6WGQRamKmdHyTr3OmfMQ
	 JQ1jRM8aQsI6ZviVJcY9SXiXe3UvPLmrKeW+wOkopBcBFhGTmRlbTy4nErykseMeDD2zu
	 bp3gRpbcOzqeB1JnkR37lYh5Xe57P6vsBGSxWYPgaSBtWDb73/EPP7IjJhRrbe4ZTIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arista.com;
	spf=pass smtp.mailfrom=arista.com;
	dkim=pass header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=eQRcHZvR;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD91606A322
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 16:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD91606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arista.com header.i=@arista.com header.a=rsa-sha256 header.s=google header.b=eQRcHZvR
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1931ff67a29so2702798c88.1
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1792688330; x=1793293130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
        b=eQRcHZvR2vd9ZIlpOH12y640m9H2xfPxm9TswHnMTQdHUoqdFjEZvYpAfUxySnpznM
         Ct1fnWck5tZHcH7DYwVIplagroS9AML3MEcIMtLvNhXbYfkcpdb7rSh0KVyGspQsNq2I
         iiN6n7n0TPoO3XUj79+oKa6ESqi+hbfz4hGZTfsEpJR4tdT5TpvgXioAab2N8zXDW40q
         Cx7vcalkW9o7vGWXWChDD5/FTlp28bUydovKVNvaL6aoBmTh5fYbFnztkjeldTE9vk/F
         lzcSi8cpTvUBHeomTbKmOAqhZHRxjDlRPZ9ZOPiaiGUuF1+8XSRXz0V7WjCKA6ugdwSZ
         m7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792688330; x=1793293130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kpOt4UmE34zQC/DX62zHDyPBfP69CykHM4P4Um1qwuM=;
        b=HSfAaCNYCkVN3FgDi1GTgPakLGE7/qBQEkEJOeRBHxnfy6LRwEc0AlEDAUSjRIsTEW
         0qR00fljbSoMNw7yGJrRBQ5tWDTDOX/d7u00OJgjnbVi3V6TmNXF7Xq5onA/0I4TH0bS
         raNc3vvxyaOxVLp4lDQ9iyIg2X5nktjGkrVQWnvsAmsqXNv4ue5fDaGOUKscCS1W2yRv
         vqdd4let2B4JjlxEoeFb8Fp7nrafA1EbEROkkq3+53pY6RS+KFf/5BJoaeB2qZs+xiA8
         zY2fmt+liVczVibg8WiwQy3HtoHcS9ubuCaV8HHeIPkeF9Wwd9Uenl8gQ/UuApqIYJle
         DJXA==
X-Forwarded-Encrypted: i=1; AKwUvBySd8Na+M6RUrWqYD5J31uVmasfYI1siQ7Sxg9Iv2hqELMARh46lZiMRhpjKZacb/z/m1poZ5Xo+1M=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlsr1sQ/tZffZgFlF3KohJTwjt4PU6P/6qWrcfgHugy1iCJj2X
	PTAFL02mhL4QFSLampqj37lMuIy//BKaJf4kyDytpirvH7Oe/NesbSfpZ2xnlfCjBg==
X-Gm-Gg: AYBFou3Wmmhsz/zPjniDaByTI/oQDb+vN1dGN1hNqokBRtlr/bimCAFCWQad73IhXcH
	+L5ibsw94UrtHiwYw5mjl/nZJ7ps9jq98eCibvkSD9hW3IzsX+sGxLLswema7w8l7p+wgBeyPUM
	dsNcHDcDKIE5K6VYoEUVGd0ycLrAm811osfviSOs0cejJsVJyqihA5eG7HY11ZSS8tOVVEvCVE8
	jnewgVoqsbBOU209JNPN/bm/rZK1maN0VCUEDT6dAEFadOyMtjSIEKw0XeJbZUULgHu4EwOKNAH
	X2Gf4LScs2TzTTIhTDSCsb2LGocmSFpqwPLJy42Q+vwmRH1UwNJKwMwJhNFb1gx852yCjIYLFsb
	rI8ExYQ+oDy7pOVelsVRhzzYCvQgGtt6/BQivFz7MgSn9BDjg0KXSWya2auV97gTo1mUqbLiEHY
	uoNImnX4AVWkDNOy/K8nfim/QSjZbzsxupJJqehiLF6YgxQNcNSscBbtmBNj6HGyk6KJWnCfAfp
	I8CMPJi8ZGMT0F4rBnfAe6bp9iPjEFugtqFy+qnod8govv39v1Ecwz4db5n329BLc6Yk/i7+QAC
	8aLg/GWZX9ulPeiLp5YT4nPG9Ot5hTJKU6M=
X-Received: by 2002:a05:7023:a81:b0:168:3243:c911 with SMTP id a92af1059eb24-195a0effa19mr34185c88.37.1792688329950;
        Thu, 22 Oct 2026 09:58:49 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903d3ae06fsm15951151c88.19.2026.10.22.09.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:58:48 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/2] PCI: Add boot options to disable DPC and AER recovery
Date: Thu, 22 Oct 2026 16:58:40 +0000
Message-ID: <20261022165842.1463451-1-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On large modular systems with a complex PCIe topology, allow userspace to
inspect uncorrectable AER errors before Linux attempts recovery and to
opt out of Linux DPC and EDR support.

This series adds two PCI kernel boot options:

  pci=noaer_recovery  - Retain AER logging and correctable handling, but
                       skip uncorrectable AER recovery, including CXL RCH
                       callbacks and recovery of GHES-reported errors.
  pci=nodpc          - Disable Linux DPC and EDR participation, including
                       ACPI negotiation and EDR's DPC-enabling _DSM call.

Firmware-owned DPC settings and firmware error recovery remain under
firmware control. The two options can be selected independently.

Changes in v3:
  - Patch 1: Check the recovery option before dispatching CXL RCH and
    ordinary PCIe errors, addressing the CXL callback bypass.
  - Patch 1: Preserve current GHES cleanup and device-reference release.
  - Patch 2: Add pci_dpc_available() and use it for DPC services, ACPI
    DPC/EDR negotiation, and EDR notifier installation/removal.
  - Patch 2: Skip the entire EDR registration path before its enabling
    _DSM, and prevent native-port overrides from defeating nodpc.
  - Clarify the Linux-only scope and rebase onto the PCI next branch.

v2: https://lore.kernel.org/linux-pci/20260709185429.627968-1-yurypm@arista.com/
AER review: https://lore.kernel.org/linux-pci/20260709190616.DF0CF1F000E9@smtp.kernel.org/
DPC review: https://lore.kernel.org/linux-pci/20260709190730.E19A11F000E9@smtp.kernel.org/

Yury Murashka (2):
  PCI: Add pci=noaer_recovery kernel boot option
  PCI: Add pci=nodpc kernel boot option

 .../admin-guide/kernel-parameters.txt         |  9 +++++++
 drivers/acpi/pci_root.c                       |  9 +++++--
 drivers/pci/pci.c                             |  4 ++++
 drivers/pci/pci.h                             |  4 ++++
 drivers/pci/pcie/aer.c                        | 13 ++++++++--
 drivers/pci/pcie/dpc.c                        | 24 ++++++++++++++++---
 drivers/pci/pcie/edr.c                        |  5 +++-
 drivers/pci/pcie/portdrv.c                    |  3 ++-
 include/linux/pci.h                           |  6 +++++
 9 files changed, 68 insertions(+), 9 deletions(-)


base-commit: f4319f548f7d8cb595ac1c91bfd459876399eeb3
-- 
2.51.0

