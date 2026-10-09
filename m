Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351A4FC8F3;
	Fri,  9 Oct 2026 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577486; cv=none; b=BGr94/yQbn/MbbtrHdzfzaaUSDeZsuiHRKIYYdu41LDa4h+RTrVICO2+DVR5S4QeERlHobt1i0TktEIjhqRbrf/PeR133Ly8+0x3Y4htbuI7ZVFdGPSytBXIk2GCVUfETBSc52MNiuaH7/xGeryxY3k/uZUqhIFJ9QUuOu8bzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577486; c=relaxed/simple;
	bh=RF9SaaEdUyx+FcPebl8EX4giQo+egaqj3XAYu2EBg1s=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UEcK23CyeeCjcmKYF56M6YJBTkVEqKvympMMnBtnLAfUG9r7xw1+Iaj40bkRHON392EEyKU7o5Mg8SMMtecxFgwDN6v5n0ZJqr5+lvuYO/moM+Ur3CCYDB53s4XKujLi1QQCM144YVLxCzVGhhhyeVuvO2GCNERW+kW17TYFtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GZScJI5K; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GZScJI5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791577477; x=1791836677;
	bh=I+a0if4c2UWUy+sL+HktIUbpBbdgiWxSaud2Qq8P3PQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=GZScJI5KWXwe85/p8Ig4CsFP4lTB2A6F+gc1YU7QhcdxUM1tc0H0ukUdctvu4tna+
	 Pp3RQ4yw1ia4eH/pUa4o/UV0JFhq2xOxYyNemrZeVbpao/jOta9KU4v/NmigBNWkbn
	 463nj/vJvP75cTTb3Ve91rDy6Bh+QgZ/a6BIxSfFqffJneVOFpK18HQFSwI+RV4E6P
	 WaH8oCPQisZSgPC+67nn7W4kqMv3xwD4In0tTC1U0+el2N50b2FoJGoR4b6yn6l2/l
	 56lqf3Yiw/RMFCvhtuxH5QYMRmKt/DvclZqcv/R4gpSzPYjkasu47wCSnrMPyljNZ5
	 KtlkQmBZVZX7Q==
Date: Fri, 09 Oct 2026 20:24:32 +0000
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] PCI: dwc: Power the controller down when hibernating
Message-ID: <179157746908.73485.2343672865542690797@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 9d1e7e5081e13ee1b52bf0ec9a68154ae32691ea
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

dw_pcie_suspend_noirq() leaves the controller powered, with
pci->suspended false, when a device below it cannot go to D3cold.
dw_pcie_resume_noirq() then returns early and the driver carries on
with the controller as it was.

That is fine for suspend. Drivers use the same two functions for
hibernation, where they run as freeze_noirq and restore_noirq. Devices
are normally still in D0 at freeze, so a controller with a device
behind it is left powered and the image records it as running. That
image is resumed after a power cycle, by a kernel that may never have
brought the controller up.

On a Lenovo Yoga Slim 7x (X1E80100) this resets the machine on every
resume from hibernation. The Wi-Fi card is behind pcie4, whose link
only comes up once the power sequencing drivers have been loaded from
the root file system. The kernel that loads the image resumes before
that, so it never powers pcie4, and the restored kernel then reads the
DBI registers of that controller:

  qcom_pcie_resume_noirq()
    qcom_pcie_icc_opp_update()
      dw_pcie_find_capability()
        dw_pcie_read_dbi()

The machine resets at that read. pcie6a, which holds the NVMe drive and
is brought up by both kernels, gets through the same path.

Take the shortcut only while a suspend is in progress. A hibernation
image then always holds a controller that is down, and thaw and restore
bring it up through dw_pcie_resume_noirq(), like after any other loss
of power.

Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
RFC because this changes the freeze path of every driver that uses
dw_pcie_suspend_noirq(), and I can only test qcom. If you would rather
have it in pcie-qcom alone, or solved on the restore side, I am happy
to redo it.

Tested on a Lenovo Yoga Slim 7x with Arch Linux ARM's v7.2 kernel plus
this patch, booted both for the image and for the resume.
dw_pcie_suspend_noirq() is the same in v7.3-rc6 and in pci/next, which
this is based on.

- A hibernation with a real power-off resumes (one run). Before, every
  attempt reset the machine.
- pm_test=3Dcore and test_resume pass.
- pcie4 and pcie6a both go down at freeze and their links come back at
  thaw and at restore. NVMe and Wi-Fi work afterwards.
- A suspend (deep) and wake still works, and neither link is retrained
  across it.

Two things to know about the test:

- I unloaded ath12k and the Bluetooth UART driver for the hibernation.
  With the Bluetooth UART open the resume stops later, in the GENI
  serial driver, and the remote processors do not come back after a
  resume either. Both are separate from this and still open.
- With ath12k unloaded the Wi-Fi card is in D0 at freeze, and the wait
  for L2 times out on pcie4 ("Timeout waiting for L2 entry! LTSSM:
  0x11"). pcie6a does not show that.

Nothing survives the reset, so to find the read a test module wrote
each step of the restored kernel to an EFI variable before it ran. The
last record is the entry into dw_pcie_read() for pcie4, after
gdsc_enable() and icc_enable() had returned.

 drivers/pci/controller/dwc/pcie-designware-host.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pc=
i/controller/dwc/pcie-designware-host.c
index 77aa79ef0..458e4c6e7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -19,6 +19,7 @@
 #include <linux/pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/suspend.h>
=20
 #include "../pci-host-common.h"
 #include "../../pci.h"
@@ -1231,7 +1232,14 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 =09if (!dw_pcie_link_up(pci))
 =09=09goto stop_link;
=20
-=09if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
+=09/*
+=09 * Leaving the controller powered is only safe if it keeps its state
+=09 * until resume. A hibernation image is resumed after a power cycle, by
+=09 * a kernel that may not have brought this controller up, so only a
+=09 * suspend may leave it powered.
+=09 */
+=09if (pm_suspend_in_progress() &&
+=09    !pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
 =09=09return 0;
=20
 =09if (pci->pp.ops->pme_turn_off) {

base-commit: 591d89f23a7cbc668579521513c7f53b0968754c
--=20
2.53.0


