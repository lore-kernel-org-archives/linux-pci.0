Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D23783C4
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617235; cv=none; b=iThJQl8BbF8X/Q9n0x1uDxHbotTE1n6A6R/2QcIGl/M4WuMkEQJjtW4tAaYhKFui5a/bicPNB5BJxu/jAJ1+qdRGl8Ii6CN5t1gGoHWN9RsumQ+XihwV2iCNVxCaosnXmqv3ONGcV95dSoGCTEYuPOFYv1P/Oju62DAgpw/eyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617235; c=relaxed/simple;
	bh=nPAqJ4uD5RYEM12wOUBT/UCW6qyyWcMP/dCf/ibr9Ws=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mcYz2q54eDCk+hnSvaEc8wfOpR4zS0zbpGFtKBjbGXyLTgvxR+JQxAcoewsRsl96afnKXef0WYp5wCyrKFzWx9QHMd5gOxHrDuNElgaBuTXB4vD9Id2WvtVx5uZPJmTIGVjQ7/5F6iBtpO2YX92xVZ5xWubdoOWvGZe/TfnHvW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUioNVFq; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUioNVFq"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so51716a12.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617233; x=1791222033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fYPTVor7lW3r9SolJqGFaqIvM2+F+nxKkoRVuMrFoD0=;
        b=gUioNVFqCpsN6pr1xXNikPn1cja1lW7izMXnswQ+46Y1/XkIo8+jGIUeUVlNH9oGLj
         6gdnYFrxE2VOTDEdO3wsbIULlOH0bD6lb7aIq+egctc5Q0gmEkOrs4SUvKkUnGcRbB7c
         /9+yIrbsA9kstOH9NGmRCznE+wH1v+yZBHASp2fg6G4EKcd63heXwd88ze9zlRr0K2uL
         IbeL+2iHxrJAuqAZ9MeRszkAPm/RHyEUBTV/EoRGVqL2u1whoHIuW7TWL1qS1MuT4oCW
         +cn/os+1cz9r6Z6CnAGRcZJ7V162YZQgQskGN5ZNwqNW97UtW64o1UZyICx+ndxmDntM
         +FdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617233; x=1791222033;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fYPTVor7lW3r9SolJqGFaqIvM2+F+nxKkoRVuMrFoD0=;
        b=1mE+2o3p2U2wxHMVcvXse3wFvOY6Ev4NI2B/Vxx+pBY0aXhbrGwC11+VAJpRcO4ryt
         0jNybv7QdTxCIKh0r+7ZAEEsCgOHhwcTspLACYZ5zWaDB2UScm/jHuhVNHodmJPMmV66
         lyttONqJyHs7a5nQrYviokYlzmnrCw88SKqv/Lf3yyZQtbRjeV98rS89xm9fjs+RRcOj
         DEhs+oenBxbutOO60KWlLHIt66dxdQhBmd6kRVdj8kXvGAknfcE0PeIeB7hdk3Zm3cqZ
         P2qONTAdGmR1Yw4Qh67AvPEfLm5kg/CpIMPJcuVCSfGZ+FnDLkKw++UpOmuMqdAFSMjs
         p+jA==
X-Forwarded-Encrypted: i=1; AKwUvBzkgtDg+pYGE3kLLYzDAAjxC6XqmcfKYSfEAi7AVZq84qIniVrRvrnurap7u0F5hs77IoxvYcPaets=@vger.kernel.org
X-Gm-Message-State: AFuF++lGvTEIXScDnX5PpVOVuQAEVSDjNRbqvTZbMTyc/XXgLgJbEDh3
	ltF/t7EsFDYjIvu/K2rzsD03yXGGnQx209IuJRubzbfBpxmJOSAacCop/rli+OzaHa6Ov2eIvJI
	7O9uTdrcxv/vzQ2hsN9KdFsQOG//DaFt9og==
X-Received: from pgbgj4.prod.google.com ([2002:a05:6a02:4944:b0:cc7:9801:78ce])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:790b:b0:3db:887:7868 with SMTP id adf61e73a8af0-3de7cd46233mr58280637.15.1790617232335;
 Mon, 28 Sep 2026 10:40:32 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:40:11 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHumumoC/43OQY7CMAwF0KugrDGKnQSSWc090CzSxm0jaIMSV
 IFQ7z6BxYwQLFh+y//ZN1E4Ry7ia3UTmedYYppqMOuVaAc/9Qwx1CxI0lZaqaDR0MULeM4w8nh
 kfyhgSHtsgmFrrajNU+a681D3PzUPsZxTvj6OzHif/nlolTVqoxVp44Ag+/OQwinHq58O331K/
 ZE3bRrF3Znpqfv2l5kAoQvoXCNxh114QdQHiKoI2x0at0V0Sr0g+h9xaN8jGiR00lNLyAEDPiH LsvwC0WDYiX0BAAA=
X-Change-Id: 20260803-b4-fix-aer-memleaks-524a1bd5e888
X-Mailer: b4 0.14.3
Message-ID: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
Subject: [PATCH v5 0/3] PCI/AER: Fix ghes_estatus_pool memory leaks in error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

When firmware reports PCIe Advanced Error Reporting (AER) events via ACPI
APEI GHES (ghes_handle_aer()), it allocates a snapshot buffer from
ghes_estatus_pool to store the aer_capability_regs registers before
enqueuing the error record into aer_recover_ring.

aer_recover_queue() returns void, so ghes_handle_aer() cannot release that
buffer itself; ownership is handed to the AER code, which until now freed
it only on the fully successful path. If the record cannot be enqueued, or
if a dequeued record cannot be mapped to a pci_dev, the allocation is
silently leaked. Under a sustained error storm this exhausts
ghes_estatus_pool, which then breaks GHES hardware error reporting
system-wide.

This series fixes both leak paths and documents the ownership rule:

Patch 1: aer_recover_queue() when kfifo_in_spinlocked() fails because
         aer_recover_ring (capacity 16) is full. The rejected entry is
         freed immediately via ghes_estatus_pool_region_free().

Patch 2: aer_recover_work_func() when a dequeued entry cannot be mapped to
         an active PCI device (pdev is NULL). The loop is restructured so
         ghes_estatus_pool_region_free() runs unconditionally for every
         dequeued item.

Patch 3: Add a kernel-doc comment stating that aer_recover_queue() takes
         ownership of @aer_regs, which must be allocated from
         ghes_estatus_pool. This is documentation only, so unlike
         patches 1 and 2 it has no Fixes: or Cc: stable tag.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v5:
- Add patch 3, a kernel-doc comment on aer_recover_queue() stating that
  it takes ownership of @aer_regs, which must come from ghes_estatus_pool
  (suggested by Kuppuswamy Sathyanarayanan). It is a separate patch so
  that the two fixes stay minimal for stable backports, and because the
  comment is only accurate once patch 2 is applied.
- Add Kuppuswamy's Reviewed-by to patches 1 and 2. Their code is
  unchanged from v4.
- Still applies cleanly to pci/next (94e8d4e94266), before or after
  Lukas' "Error reporting for AER-incapable devices" series:
  https://lore.kernel.org/r/cover.1790531238.git.lukas@wunner.de
- Cc Kuppuswamy Sathyanarayanan, Jonathan Cameron, Ilpo J=C3=A4rvinen and
  Dave Jiang, plus Shiju Jose and Rafael J. Wysocki as the author and
  committer of the commit in Fixes:.
- Link to v4: https://lore.kernel.org/r/20260918-b4-fix-aer-memleaks-v4-0-f=
0a2c21ed1d1@google.com

Changes in v4:
- Rebased onto v7.3-rc3+ (f259f446f519); applies cleanly to pci/next as
  well. No conflicts with the Advisory Non-Fatal Error support that landed
  in the meantime.
- Added missing Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption
  when error status data has multiple sections") and Cc: stable to both
  patches; that commit (v6.7-rc1) introduced the ghes_estatus_pool
  allocation whose ownership these paths drop.
- Patch 1: use braces on both arms of the if/else and fix the continuation
  alignment (checkpatch --strict).
- Both patches now build warning-free with W=3D1 and CONFIG_ACPI_APEI_PCIEA=
ER=3Dy
  (earlier revisions were only build-tested with APEI disabled, which
  compiles neither of the modified functions).
- Explained in both commit messages why the caller cannot free the buffer,
  and when the missing-pci_dev path is reachable.
- Cc: Lukas Wunner, who has been active in this code.
- Link to v3: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v3-1-e=
87159611933@google.com

Changes in v3:
- Resent to fix threading of the series.
- Link to v2: https://lore.kernel.org/r/20260803-b4-fix-aer-memleaks-v2-1-f=
d199b0171fd@google.com

Changes in v2:
- Refactored aer_recover_work_func() to ensure ghes_estatus_pool_region_fre=
e()
  is called unconditionally for every dequeued record.
- Added Patch 1 to fix related memory leak in aer_recover_queue() on kfifo
  buffer overflow.
- Link to v1: https://lore.kernel.org/r/20260803183853.432459-2-rathodpriya=
nk@google.com

---
Priyank Rathod (3):
      PCI/AER: Fix memory leak in aer_recover_queue() on kfifo buffer overf=
low
      PCI/AER: Fix memory leak in aer_recover_work_func() when pci_dev is m=
issing
      PCI/AER: Document that aer_recover_queue() takes ownership of aer_reg=
s

 drivers/pci/pcie/aer.c | 48 +++++++++++++++++++++++++++++++++++-----------=
--
 1 file changed, 35 insertions(+), 13 deletions(-)
---
base-commit: f259f446f5198d98e13756d2cd531812a0ad3064
change-id: 20260803-b4-fix-aer-memleaks-524a1bd5e888

Best regards,
--=20
Priyank Rathod <rathodpriyank@google.com>

