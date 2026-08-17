Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AF37FF68
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996287; cv=none; b=RIZZHXRLHGlKVuEbrDtmwu8a58HoO/yhsQHzj9ud8xxXQRL62/bIa53klFKQNzPZJcVqUcROj28tTQLmAzj17B8mLC7IfJVvyACH5NaxerJLCA3fIMqCUZN95Vyau2sveiAtInIJ5tuk6kx3e3xRoyJlSg3lIAX5JHIX0Mk2QUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996287; c=relaxed/simple;
	bh=ZVQgv/wkgJu04lezL+VEvjojP8GirnSWQEe+M+MyHHs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YNLffJ4RVq8qj3fwBC+s3RQXIyqICNS1+u5dNWVh2O0h1godHbM+UFLm0Ck7V9SwEA2TFv/XP50xP5CNuz4ZTffaMT0gnc9ZJ6ehaduMAI62+CrpuBEFchPKrOEtrZ+rPMo3rY5NwCGCYtzOBtsVhLcaCy2ixVe2iYYYDdgIPCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HUks8nd1; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HUks8nd1"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67HJXrvE656787
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 12:51:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=AGjXtVlXK
	s9Or5zuAC/XGWs7QH2feKKkgQNHjc8EfG8=; b=HUks8nd1GAv9wQmj2J/g6s3ZQ
	FjgWlwgJ/hMosjg1A6Og9hx9oLKTA3KCl8Bpq+bIRdUM27KIBf/HTVySQDNyI+ay
	DtU+K7dHdbXdcPOOXtmgGMNdmAPs011J5TwBG4tuCG4NyqsyErCna1JJSefC53lU
	A6ZS0p66lgpvq/1pImnXFVsmYQejP7vOcWQsts26RDI91W3zAhy/2cZwFoqzXXaE
	aeJqGzSHXWrhX0tPMVvmdi0EtO3PMLKYjJirF22vKFuskSjaYa+XgTQTNOYZq9tr
	rZYsce831IzviVrq7FJ3PAayFk6vby4Z9wjJvDwjDvkYYF/GA8ifisJTCNHGg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4g2ks83gdk-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 12:51:24 -0700 (PDT)
Received: from twshared51612.31.frc3.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 17 Aug 2026 19:51:22 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AC76A2857750D; Mon, 17 Aug 2026 12:51:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <alex@shazbot.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: <mattev@meta.com>, <matt@ozlabs.org>, <nekto0n@meta.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] vfio/pci: Restore standard PCI config space in .slot_reset()
Date: Mon, 17 Aug 2026 12:51:10 -0700
Message-ID: <20260817195110.2077698-1-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MSBTYWx0ZWRfX3/7OXfHzyGZn
 DCbcrlm831zXRkdRSaYC+rD+2U7Z/LBwOeGqfQOWa6AgjtYb3m1kcYo7I9rWSXv2X2Ur7vsx079
 WFACVn9ybiJWsiQvkwu3k48HFzzw5ZFFYHwOG/sYrxH6RnvcZVuRM8h7vHv18hwdD0cwX8421w0
 McUHV5JfetSnTF/XuLS2Y3a1xsFRj+M01DHaUuTu97SbG3Nve8mxqYt6qjKp9ny55GjCBuct1Qe
 KSio7ooMPD+QlwvOW8IMWvP/Ewr7T+VqIG8NJ1W9FleB5K2afZrGTPCnpfqQulOJYvDzWgdsLrE
 s9dhngHo9zrqYflAf4h5vK79rETWgWfmYlz9FL0UYin1B107qqMjtgeTcg2qnXIq53j5bV35Vtu
 Yqh0R2Jk4so+0VZXURrYMJ2PlmMntj94eRb4/5yvE9mdN7Ht8XUwhTgc/s/qB9T/oEaA7iDE8Pv
 bYeooKJ7xaNXhjdv7GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MSBTYWx0ZWRfX/Jbc6zwO4okx
 XC6aA3Y1evs9xrl4EvpARsz4HWBgRwXIZS70Q2U2OD/Cb7dJcrh3p7OH1wk5A7HI0JaQjrsMSsk
 /E8ysd09+FahA11tjU5DCqYNpW5wEpU=
X-Proofpoint-ORIG-GUID: PpLEPERArf84WWlECi0HHxH5zGBMX2-N
X-Proofpoint-GUID: PpLEPERArf84WWlECi0HHxH5zGBMX2-N
X-Authority-Analysis: v=2.4 cv=WIpPmHsR c=1 sm=1 tr=0 ts=6a83663c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sm42_5VQJLERfNZvqZYA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Hi Alex, Bjorn, Linux-PCI, and VFIO,

I'd like to initiate, or maybe restart, a discussion regarding the
current state of PCIe AER and DPC (Downstream Port Containment) recovery
for devices bound to vfio-pci, potentially expanding to devices not
bound to anything at all.

Currently, when a link reset or Secondary Bus Reset occurs due to an
AER/DPC event, the kernel PCI error recovery service executes reset
routines across affected downstream devices. Since vfio-pci does not
implement the .slot_reset() callback in its pci_error_handlers struct,
the standard PCI config space (BARs, Command register, MSI-X setup,
DevCtl, etc.) for downstream devices is left entirely uninitialized
after the link is brought back up.

Historically the PCI core introduced early pci_save_state()
checkpointing prior to driver probe (e.g. commit 30d52f6385d8, "PCI:
Save device state in pci_pm_init() before driver probe") precisely to
ensure that the kernel maintains a valid baseline config space
snapshot=E2=80=94even for driverless or stub-bound devices. However, that
infrastructure was never fully connected to the error recovery callbacks
for generic pass-through drivers.

For bare-metal userspace drivers, like custom user-level drivers, this
creates an operational deadlock:

1. The kernel PCI error handling triggers a bus/link reset, but leaves
   standard PCI config space wiped back to power-on defaults.
2. The eventfd (VFIO_PCI_ERR_IRQ_INDEX) alerts userspace that an error oc=
curred,
   but gives no indication of when link recovery/reset completes.
3. Userspace attempting to re-initialize or access the device races again=
st
   the kernel's reset sequence or operates on zeroed/uninitialized config=
 registers.
4. While QEMU originally included stubs intended to coordinate AER recove=
ry with
   guest OS drivers, that guest-host coordination infrastructure has rema=
ined
   unimplemented for over a decade.

In scenarios where userspace simply needs the underlying hardware
restored to its known-good baseline state post-reset, having vfio-pci
implement .slot_reset() and leverage the existing PCI core snapshot via
pci_restore_state() bridges this gap cleanly.

We recently saw related discussions around VFIO error recovery on s390x
(https://lore.kernel.org/linux-pci/20260603182415.2324-1-alifm@linux.ibm.=
com/#t),
where platform-specific mechanisms had to be wired up to communicate PCI
errors to userspace. However, for standard PCIe setups relying on
generic kernel error recovery (pcie_do_recovery), vfio-pci still lacks
the fundamental .slot_reset() handling needed to restore standard PCI
config space after recoverying from a fatal error.
---
A few questions I'd like to put to the list:
1. Since the PCI core already takes responsibility for holding the early=20
   config space checkpoint, is calling pci_restore_state() during
   .slot_reset() the appropriate place for vfio-pci to apply it, or
   should this be explicitly driven/triggered via a VFIO ioctl?
2. Does returning PCI_ERS_RESULT_RECOVERED here create subtle state
   issues if userspace directly modified config space registers that
   were not captured in pdev->saved_config_space?
3. Should we pair this with an explicit "link restored / reset complete"
   eventfd notification so userspace knows exactly when it is safe to
   resume access?

Appreciate any feedback or historical context on how VFIO and PCI error
recovery should interact here.

 drivers/vfio/pci/vfio_pci_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
index 3f11a9624b9c0..5b42430337e29 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2347,6 +2347,13 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(st=
ruct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
=20
+pci_ers_result_t vfio_pci_core_aer_slot_reset(struct pci_dev *pdev,
+					      pci_channel_state_t state)
+{
+	pci_restore_state(pdev);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2419,6 +2426,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
=20
 const struct pci_error_handlers vfio_pci_core_err_handlers =3D {
 	.error_detected =3D vfio_pci_core_aer_err_detected,
+	.slot_reset =3D vfio_pci_core_aer_slot_reset,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
=20
--=20
2.53.0-Meta

