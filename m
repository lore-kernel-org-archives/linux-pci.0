Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83433126BC
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 13:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099839; cv=none; b=qaLer6+RPF8rwA7PjlkeZ7m9CpIHHxnopuqath/JWfHE351+SO4ZLCcX5e5PHr/oqeD7iyIZpwM/d6JkUt8G70r1LF7GMvalL0WxyajohFkUS/SvMEsTfWSvq9IT16yNhP2QCVppM6st1Y+SMs+qaNyWnHzdU7jx8y5b/uCbuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099839; c=relaxed/simple;
	bh=jhEX7/FS6lxXlNQGLQDRSRS8HDUqnvIrkXnVqEiejl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYjlgRjUXtr9h6WRbz8MaueEzrLprT2CuYjcIT3XCBaKfm5rnVsbF7YELsAAusfXnHfJOry/64aPC/Sy+DH6Nf5mgYDuuYobOiV3poC3r/ixMaCX1qDrx2w/2i2tMiIKospFIiCn2nlmHZySsX7PKiYcqR6Lc7OsaaUz1mB7bmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qB+jqXOx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB+jqXOx"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423efd76c8so4384784b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 06:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781099836; x=1781704636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=luE/S9CyPqIBAIDsBEyiho/bppWPRMLFj3pQo3rjwyU=;
        b=qB+jqXOxM5Vs+NNBnJid56QijMiUgO9rg15H7oZqXhzkG1beaxcGNFEq0APDk7+w3M
         8B0fNhYlJkNQHvAm2hDwp+KYJ1EzvBKlgoSuDGlUUx3tjwBSMp639zPRldkEj1eMFjtW
         +3YLadnWhqMKcatk0PV2Oe9DbvlMayjikzKjePgXtxQMT6Uv7jREW7FckiI69cmIBZKE
         tOfVBz1AKSNmlhMzLL4awakVhqlkmGPVLjS4Ber9BI4Q/qG89bLi5/zmOxfekFyekhyW
         TKhLrtGew4Oz4UiGKNVK1/QIq/7bMvJ4oC4M63PvA1ciD1NwjmQAnRdWNb+qd7xjwImk
         cpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781099836; x=1781704636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luE/S9CyPqIBAIDsBEyiho/bppWPRMLFj3pQo3rjwyU=;
        b=M1zN0T5D9Um6OU40MBocCfToZgPjF0JkPa19u6mBTc/b+EgMZyrvtnuRprRSGBGE+C
         PLgQwS9fWJ7D8CrgnEyvnP35ofPZMd4xfUuHNaB2rKUeYVrR8uA1aX9JUCZBdUTxA5Xd
         h3JcGU4FuS6WmRRfVaMC9P4qMBCCAHGYuHYSgE3WHxTtlZJ3w3WWjGDV33sVKrCh7vP/
         r0eXsLHHfYc+AJidkhP/A0cCHWjEqnzuMpkjgdvpbOr1WcsttbOKoOitMIdhYG7ZLkPf
         oB+caFWo3QUBNwv3PRhFFuxg4+Ybp2OaLEKa50v+yPQxpBCMGVDCrXrr70cXLsjozc30
         DZAA==
X-Gm-Message-State: AOJu0YzkYMqaVRX4UccqHlervrCXyJe2wuqBsyaVZbmo0Fp6KCoixVAF
	wAHomTyGeJfbMAiBIi3hjqWNjLt76CiLmbLJw8RmmguisUrdvMnD2h0a
X-Gm-Gg: Acq92OG4I9xjsofDll520vM0u+5+cwuMI39hHxr96cXn5wOQkivOwAcQhIBVHnZckD8
	QSgptn8KfaaeN6L6ZXDc8ASih3vRllCHyMJVKJLcpv7Y12rq4YIWHvR8SzTZPo2akGZHpwUlmPt
	cbt2oz72pXjIsDMag+7cu7kmqK0aaap0Kkbf6QlXcwX/oPX7rIDOuNghEy65xvTaaL3NyYhxGAk
	vbCvYHsAC1vp43wWKiI8xpZLvrvJ2gOGAGE/WNWY68iD/ZdSORVmseKiXBb0kZkoXFzHV5vgugk
	xevhpQdnFiqZQHjyouGbFm8NqJgi2+iKnDH9N2GE5ARHM4RicYb3e0AqZGTWT6K7Nr5ugaiYKMn
	NhJ0+gx9cCfLZ2G+75TVl+XPvuzOQSlyDCyoOO1ACUEzJloTWdxRl/YusOAObt6wpxHEAGXIran
	QaFRRvF3OH5noetdvuK4TVrKo+4u3qJ2yLRDhNZGqctVIQFZlweMQDxwf35aexDxyt+Pw=
X-Received: by 2002:a05:6a00:10c7:b0:83b:905:c9fd with SMTP id d2e1a72fcca58-842b0e3c995mr27210932b3a.24.1781099836081;
        Wed, 10 Jun 2026 06:57:16 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428706fa9asm24411168b3a.45.2026.06.10.06.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 06:57:15 -0700 (PDT)
From: Yuguo Li <cs.hugolee@gmail.com>
X-Google-Original-From: Yuguo Li <hugoolli@tencent.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Yinghai Lu <yinghai@kernel.org>,
	Yuguo Li <hugoolli@tencent.com>
Subject: [PATCH 0/2] PCI: Guard against NULL bus->self on SR-IOV virtual buses
Date: Wed, 10 Jun 2026 21:57:07 +0800
Message-ID: <20260610135709.1630627-1-hugoolli@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Bjorn, all,

This series fixes two NULL pointer dereferences in the PCI core that are
hit on x86_64 with SR-IOV PFs whose VFs span more than one bus number,
once anything pokes those VFs through paths that walk up through their
parent bus.

Background
==========

When a VF allocated by pci_iov_add_virtfn() lands on a bus number
different from its PF, virtfn_add_bus() calls

    pci_add_new_bus(parent, NULL, busnr)

producing a struct pci_bus with a valid ->parent but no bridge device
(->self == NULL).  include/linux/pci.h already documents this:

    /*
     * Note: we'd love to have a "device" pointer here, but
     * we can't have it.  ...  See virtfn_add_bus() for an
     * example of a bus without a device.
     */

The MSI IRQ domain path was taught about this case years ago by

    38ea72bdb65d ("PCI/MSI: Fix MSI IRQ domains for VFs on virtual buses")

but other paths in drivers/pci/ that follow bus->self were not updated
in step.  Two of them have been observable for a long time but only
trip on configurations where a VF actually crosses a bus boundary AND
something (sysfs rescan, resource reallocation, etc.) reaches them on
that virtual bus -- which is not exercised by routine boot.

What trips
==========

  Patch 1/2 - drivers/pci/probe.c::pci_read_bridge_bases()

    Only guards pci_is_root_bus(child).  Reached on x86 via
    pcibios_fixup_bus() during pci_rescan_bus() on a virtual bus
    (bus->is_added stays 0 because the SR-IOV add path never invokes
    pci_scan_child_bus_*()).  Dereferences child->self at the
    pci_info()/dev->transparent site.

    Fixes: f92d4e29d785 ("PCI: fix wrong assumption in
                         pci_read_bridge_bases")

  Patch 2/2 - drivers/pci/setup-res.c::_pci_assign_resource()

    Walks up parent buses retrying allocation; loop termination is
    "if (!bus->parent || !bus->self->transparent) break;".  For a
    virtual bus the !bus->parent test fails (parent is real), then
    bus->self->transparent NULL-derefs.

    Fixes: d09ee9687e02 ("PCI: improve resource allocation under
                         transparent bridges")

Reproducer
==========

  - x86_64, mainline v7.1-rc7+
  - any SR-IOV-capable PF whose sriov_numvfs is large enough that at
    least one VF crosses to a new bus number (mlx5, i40e, ixgbe, igb,
    bnxt, ...)
  - LTP testcases/bin/tpci is one off-the-shelf trigger: its
    test_scan_bus subtest reaches patch 1 via pci_rescan_bus(), and
    the resource-assignment subtest reaches patch 2 via
    pci_assign_resource().

Without this series, tpci panics within seconds.  With both patches
applied to the same tree, tpci completes its full PCI subtest matrix
on the same hardware without splatting.

Patches
=======

Yuguo Li (2):
  PCI: Bail out of pci_read_bridge_bases() for SR-IOV virtual buses
  PCI: setup-res: Guard against bus->self == NULL in
    _pci_assign_resource()

 drivers/pci/probe.c     | 10 ++++++++++
 drivers/pci/setup-res.c |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.43.7

