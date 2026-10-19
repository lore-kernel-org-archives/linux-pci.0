Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445481;
	b=gp+ka7G4Cq6Q622bBwa/98xhAZx0dsgogGm2bhbpKaXbXwTKG1+YKv8SGK7TIsLMLuCE
	 z3TRzEDiu4BhgdNnR1+H0qGukzdgllkIrTGZ8yDpVw8yRZNIlify24q3PAy2ar4jLv9O9
	 dW+VMDvPD4ImcGfBt8ofNfEw2D9sVhmchBAiBnVUp3RCUXlrS+OUyEIG80S3srRbmQqWU
	 EdIdNKyPIxwCQZwOWvUxf3hfdYjUutEAlKjlmQV32JvYlChKTyl7M90XnLS49hoIlTfeP
	 MkpOjEn+fQrhrLyI0VtgjKTAd0nBYB3/UBS0wEhoFqcxGB+tyd8gz5SDCwT8L5o0npA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=LkNUC+PMoXZDStaNEegSy7SLi35cqcuQZkVqC98j7D4=;
	b=I58c7LIyo/D2sAh8mRtcCRrK2aETb7cSKKUhqLflGB3tzmFh6Xxc/kZo8eax+bnZ47iH
	 //eKbhQp7jZgTF4bDS4+dqfBUItlWp2I1HIswBQL2dLkSs8W3U3kUD9lPHp2ug37CPv21
	 ePOr3HJDIFr0ju8pgoybDuAlnW6320qd4TI91DU9DV70pe/k9R7oD34Hp7PxTjmr6CfSm
	 Xq3dn4XJl40SRpQyhwcEr1ZVqbk/fTYG+7exilfcOvBbY3WBH0J8Juk/KF3Ct0+SbuUXj
	 DDwN8UsYDaK3U2Oqc3QvWeLUW2V+mK4s9pTT2o3CxJnmgC79m8/LOt8UhgN4L7RxIoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RA7QnFtY;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBA606A319
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 21:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41EBA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RA7QnFtY
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cec4226c70so24192655ad.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792445481; x=1793050281; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LkNUC+PMoXZDStaNEegSy7SLi35cqcuQZkVqC98j7D4=;
        b=RA7QnFtYGxgoSyhi+JwX48hhzCfyOvyG/mMQcrKOTEsk3fciaibaqgs65FQRNe7A3D
         /XPstBmK6AexRx3g1DNWcu+l2IcGPrsyH95HancT4uwqmg3ypTU8AeSz9TcnZWrMK4NL
         bLSmPEBz7A0/ypIX5P4UxBHT+nMv5ZODuxLBIlEroX+WH6UJyWiLGUYKUIX7ukY8nOmT
         PjvalkpirhLODR0TxPK+Btd3OaQgNRTyLi8SSMcJ+bxlf4cDozODYkhToB63swg5Kqhm
         4akaYc87dQ+wyXZMuHckT3i7v/nILZcY4C7GvS7LB66QXXqGjy6uSxBLE+GB6lvjlyRL
         PaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792445481; x=1793050281;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LkNUC+PMoXZDStaNEegSy7SLi35cqcuQZkVqC98j7D4=;
        b=KNk2X0+VUv7R1sKi4E1vd89Js+yJakLE/x1nBMNUfobTQ+TIQaOyJ//jbpWtZm/Uvo
         ciFM3vdjTGBiqXiVEkKoln+kzYwntskV/ygIognjbP/pqSaJ2yvPxQXRZ94ug0h+OJ9B
         MApmy6eSSEmNbk9vjuGNNGChev/Ieij42JTD9PZ61r3eTSzokeSDsuiC+a0ueDy8SmZx
         NO6+0bs7Sz7vLzFfuL1gqPwMsgS+wlK/BPVJkFeX3Q73jYGpVfGM79ywJkIC6lXrfjNJ
         xQfxvNtXkwwJ3+moxc4pi+UDs4kPtLZVdEUGaH7ChLfmjT/eQzFf86AmQTPMbmH6BeWw
         ri2g==
X-Forwarded-Encrypted: i=1; AKwUvByhF+8PTYXY6hFx7x9TqTYhMINDAnK8mzpr9nsCMbAcfCalCPP8+xMkVpIHGwcmQ1QBNtq+gApSM00=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5qF/8+aN8usg04iycRoEqHeQfdCKslhBa1Neph0rIbLQ/K0w6
	dDqw9zL85YypNzf0wzFRs+wUcFzO7HKYZRI5etC1JuhyhM8O3n8Ls2OiG8Sq7WZf9YNQdq5gIAC
	CGFxza9/d+LpT/Q==
X-Received: from plcn2.prod.google.com ([2002:a17:902:d2c2:b0:2e5:40ef:ff34])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d2c6:b0:2e8:4f3f:60dd with SMTP id d9443c01a7336-2e9a69e9987mr69340785ad.37.1792445480207;
 Mon, 19 Oct 2026 14:31:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:30:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019213054.3157159-1-dmatlack@google.com>
Subject: [PATCH 00/10] PCI: liveupdate: Keep preserved devices accessible
 across Live Update
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pci@vger.kernel.org
Cc: Adithya Jayachandran <ajayachandra@nvidia.com>, Alexander Graf <graf@amazon.com>, 
	Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Matlack <dmatlack@google.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Logan Gunthorpe <logang@deltatee.com>, Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, 
	Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/pci/p2pdma/v1

This series builds on the PCI core support for Live Update [1] to allow
memory transactions targeting preserved PCI devices to proceed
uninterrupted across a Live Update. The base series allows preserved
devices to perform DMA to system memory across a Live Update, but the
next kernel still sizes, probes, and may reassign the BARs and bridge
windows of preserved devices during enumeration, which disables
decoding or moves address ranges out from under anything that is still
accessing them.

Use cases include:

  - P2PDMA between preserved devices, e.g. between devices assigned to
    the same VM via VFIO.

  - MMIO from Orphaned VMs [2], whose vCPUs keep running in guest mode
    on dedicated CPUs during kexec, and therefore keep accessing the
    BARs of devices assigned to them throughout the Live Update.

To support this, the BAR addresses and bridge windows of preserved
devices must not change across a Live Update, and the next kernel must
not disable decoding or forwarding on preserved devices or on the
bridges above them while enumerating them and assigning resources.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
[2] https://lore.kernel.org/kvm/20260920193650.3373435-1-pasha.tatashin@soleen.com/

Series Overview
---------------

This series implements the following:

  1. Avoid sizing the BARs of incoming preserved devices. Sizing a BAR
     requires disabling decoding. Instead, have the previous kernel
     pass the BAR masks (the values the BARs return when read after
     writing all 1s) and decode the BARs from those (patches 1-2).

  2. Avoid probing which windows incoming preserved bridges implement,
     which temporarily disables the prefetchable window. Instead, add a
     generic mechanism for passing the results of probes that require
     writing to the device, and use it to pass which windows each
     bridge implements (patches 3-4).

  3. Skip programming bridge windows that already contain the values
     being written, so that pci_setup_bridge() does not temporarily
     disable the windows of preserved bridges. This applies to all
     bridges, not only preserved ones (patch 5).

  4. Claim the BARs and bridge windows of incoming preserved devices,
     as programmed by the previous kernel, while scanning and before
     anything sizes or assigns resources, regardless of how the host
     bridge driver sets up resources. Panic if they cannot be claimed,
     since that means something else may be decoding the same address
     range (patch 6).

  5. Prevent the PCI core from assigning, releasing, or realigning the
     resources of incoming preserved devices (patches 7-9).

  6. Avoid enabling INTx on incoming preserved devices, both while
     probing whether INTx masking works and when the device is enabled
     (patch 10).

All new behavior applies only to incoming preserved devices, i.e. only
after a Live Update and only until pci_liveupdate_finish(), except for
patch 5, which avoids redundant writes for all bridges.

ABI Changes
-----------

This series uses the optional feature flags added to struct pci_ser in
v10 of the base series to append new fields to struct pci_dev_ser:

  - PCI_SER_OPTIONAL_BAR_MASKS: @bar_masks and @rom_mask.

  - PCI_SER_OPTIONAL_PROBED: @probed_supported and @probed, a bitmask
    of probe results (which windows a bridge implements, and whether
    INTx masking is broken).

The ABI only contains hardware state (register values and the results
of probing hardware), not kernel-internal state such as IORESOURCE_*
flags. If the previous kernel did not pass a field, the next kernel
falls back to sizing or probing the device as before.

Merge Plan
----------

This series applies on top of v10 of the PCI core support for Live
Update series [1], which is targeting Linux 7.5. This series is
targeting Linux 7.6, or 7.5 if feasible.

Both series will be merged through liveupdate.git, matching the
agreed-upon tree in the MAINTAINERS entry for PCI LIVE UPDATE.

Testing
-------

This series was tested in conjunction with v5 of the VFIO PCI driver
series:

  https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/

The full set of patches used for testing can be found on GitHub.

  https://github.com/dmatlack/linux/tree/liveupdate/pci/p2pdma/v1-with-vfio

Testing was performed using vfio_pci_liveupdate_kexec_test with the igb
selftest driver, which keeps the device performing DMA while kexec
happens. QEMU traced every PCI config write, and each run checked that
the next kernel did not write to the BAR, ROM, bridge window, or bus
number registers of the preserved device or any bridge upstream of it,
did not change their decode or Bus Master Enable bits, and did not
enable INTx on them, and that their BARs and windows had the same
values before and after kexec. The following configurations were
tested:

  - x86 (q35): igb behind a root port.

  - x86 (q35): igb behind a PCIe switch (root port, upstream port,
    downstream port), with a non-preserved device on another downstream
    port of the same switch.

  - arm64 (virt, SMMUv3, generic ECAM host bridge): igb behind a root
    port. This exercises the path where bridge windows are not read
    from hardware during scanning.

Future Work
-----------

Please see the PCI core Live Update Roadmap:

  https://lore.kernel.org/linux-pci/20261001232133.560284-1-dmatlack@google.com/


David Matlack (10):
  PCI: Factor out BAR sizing from pci_read_bases()
  PCI: liveupdate: Avoid sizing BARs of incoming devices
  PCI: Factor out bridge window probing from pci_read_bridge_windows()
  PCI: liveupdate: Avoid probing windows of incoming bridges
  PCI: Skip programming bridge windows that are already programmed
  PCI: liveupdate: Claim resources of incoming devices during scanning
  PCI: liveupdate: Never assign resources of incoming devices
  PCI: liveupdate: Prevent releasing resource windows of incoming
    bridges
  PCI: liveupdate: Don't realign resources of incoming devices
  PCI: liveupdate: Avoid enabling INTx on incoming devices

 drivers/pci/liveupdate.c    | 363 +++++++++++++++++++++++++++++++++++-
 drivers/pci/liveupdate.h    |  26 +++
 drivers/pci/pci.c           |  18 ++
 drivers/pci/probe.c         | 110 ++++++++---
 drivers/pci/setup-bus.c     |  62 ++++--
 include/linux/kho/abi/pci.h |  52 +++++-
 6 files changed, 589 insertions(+), 42 deletions(-)


base-commit: 312200e9211ede3f9a03cc17d094805e06e4674e
-- 
2.56.0.212.g129ede20d9-goog

