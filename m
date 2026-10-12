Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BD32ABCA;
	Mon, 12 Oct 2026 13:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810769; cv=none; b=p4R71tRs9q3dzL+BxlDJ82GnOe/eKQSE+cePTO3w2lKVK5XeaR6ZRGB1cWt5/W+4jAackQdJaWAH3sTyPI9zr8+zs1bZUAdkWyOOS8+Am8AdTlEMmSZRNKv7xf3FJAQb3ioBzO4Vkae8Vjt5GziN/8+HsJjtLhhMRdwULQEY45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810769; c=relaxed/simple;
	bh=DFOmA+AOsDzyJf+XM9lhlS/m5FZtFNfid60UCzwXUMk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R7bEOaBwdk0u4fSUqEa557TYL9Qy89BaNiMrpK45j1jQQOGBJjLf2u8OWnEHf+/fSb148gemVIdyteaI+G7akWtPJ9A0S53I2n3kMKzZOt/vQb4c9jENS/1GjKZpwFqva886DcZgXHHRD5ZKIcS4OjVApAzzdXpKLcE9DAUCMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Y/QH6/jX; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Y/QH6/jX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791810756; x=1792069956;
	bh=C0687MqkzK93a2FUh3Kh8XN9xkTwPB8dxYC9MnSBE8Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Y/QH6/jX5C/F8Qc2vuvgGi0SimPOcowAYhf/sq0CbVcpDBcj9F+PkCCFBy1Rktvxk
	 WNTyNbH6tg+HnAX6UStkn7cmA+1J0NPF3tnJxvPzzUg7IflDSMtsggPcS+wKYe60UZ
	 miXGKCC6ym0hl0Y+etMFzNf06G1mrgM4LIIYO+WV5muwVEgrLqp3qw7q1JoANGJhej
	 xXviJpjK6dJWLfltOUYiPnlhuuLi3FEGfCrfSR1Jcj2BCsTZr0b1FcgjAOd4Zf/utC
	 5pe4nFsrdD3Aljh9Y2X0TRVo/us71sM7cdNdPiESCDyqrwtigfqa6Ybpd+JSBYh9cF
	 VEa+TiC8me+Xg==
Date: Mon, 12 Oct 2026 13:12:31 +0000
To: Manivannan Sadhasivam <mani@kernel.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: Rob Herring <robh@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: qcom: Power the controller down when hibernating
Message-ID: <179181074907.22199.10556821368232442334@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: e9ee3dd7f4a0228c554bdcf4c5721b50102305e0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

qcom_pcie_suspend_noirq() leaves the controller powered when a device
below it cannot go to D3cold, and qcom_pcie_resume_noirq() then carries
on with the controller as it was.

That is fine for suspend. The same two functions also run as
freeze_noirq and restore_noirq for hibernation. Devices are normally
still in D0 at freeze, so a controller with a device behind it is left
powered and the image records it as running. That image is resumed
after a power cycle, by a kernel that may never have brought the
controller up.

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

Give the driver a freeze_noirq callback of its own that forces the link
into L2 and powers the controller down, whatever state the devices
below it are in. A hibernation image then always holds a controller
that is down, and thaw_noirq and restore_noirq bring it up through
dw_pcie_resume_noirq(), like after any other loss of power. Suspend and
the poweroff phase of hibernation keep the D3cold check.

Suggested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Birk Skyum <birk.skyum@pm.me>
---
This applies on top of "PCI: qcom: Implement shutdown() to avoid
SMMU/NoC errors on reboot" v6 [1], which adds the force parameter of
dw_pcie_suspend_noirq() and is not in pci/next yet.

Changes in v2:
- Do it in pcie-qcom, with a freeze_noirq callback that forces the link
  down, and leave dw_pcie_suspend_noirq() as it is (Krishna).
- poweroff_noirq keeps the D3cold check, so a wake-enabled device is
  treated there as it is today (Sashiko).
- Link to v1: https://lore.kernel.org/r/179157746908.73485.2343672865542690=
797@pm.me

Tested on a Lenovo Yoga Slim 7x with v7.2 plus [1] and this patch,
booted both for the image and for the resume.

- A hibernation with a real power-off resumes (one run).
- pm_test=3Dcore and test_resume pass (two runs each).
- Both controllers go down at freeze and both links come back at thaw
  and at restore. NVMe and Wi-Fi work afterwards.
- On a fresh boot of that kernel the image is looked for at 20.7 s and
  the pcie4 link comes up at 22.0 s, so the kernel that loads the image
  has not brought pcie4 up.
- A suspend (deep) and wake still works, and neither link is retrained
  across it.

Things to know about the test:

- 7.2 has no global interrupt in this driver, so my backport of the
  shutdown callback in [1] leaves out the two lines that disable it.
- The test kernel also carries the smp2p patch [2], a later version of
  the pinctrl change [3] and a change to the GENI serial driver that is
  not posted, all for other hibernation problems on this laptop. The
  Bluetooth driver had [4] applied.
- ath12k was unloaded and the remote processors were stopped for the
  hibernation. With ath12k unloaded the Wi-Fi card is in D0 at freeze,
  and the wait for L2 times out on pcie4 ("Timeout waiting for L2
  entry! LTSSM: 0x11"), as it did with v1. pcie6a does not show that.

[1] https://lore.kernel.org/r/20260909-shutdown-v6-0-62b7bd123236@oss.qualc=
omm.com
[2] https://lore.kernel.org/r/179158127177.70185.5691100900886332545@pm.me
[3] https://lore.kernel.org/r/179163141354.18006.80461347454353634@pm.me
[4] https://lore.kernel.org/r/179163212446.46972.2306254853726299632@pm.me

 drivers/pci/controller/dwc/pcie-qcom.c | 27 +++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controlle=
r/dwc/pcie-qcom.c
index 170932e42..212e344fc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -2475,7 +2475,7 @@ static void qcom_pcie_shutdown(struct platform_device=
 *pdev)
 =09pm_runtime_disable(&pdev->dev);
 }
=20
-static int qcom_pcie_suspend_noirq(struct device *dev)
+static int qcom_pcie_suspend(struct device *dev, bool force)
 {
 =09struct qcom_pcie *pcie;
 =09int ret =3D 0;
@@ -2488,7 +2488,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev=
)
 =09if (!pcie)
 =09=09return 0;
=20
-=09ret =3D dw_pcie_suspend_noirq(pcie->pci, false);
+=09ret =3D dw_pcie_suspend_noirq(pcie->pci, force);
 =09if (ret)
 =09=09return ret;
=20
@@ -2537,6 +2537,22 @@ static int qcom_pcie_suspend_noirq(struct device *de=
v)
 =09return ret;
 }
=20
+static int qcom_pcie_suspend_noirq(struct device *dev)
+{
+=09return qcom_pcie_suspend(dev, false);
+}
+
+/*
+ * A hibernation image is resumed after a power cycle, by a kernel that ma=
y
+ * not have brought this controller up. Power the controller down even if =
a
+ * device below it cannot go to D3cold, so that the image never holds a
+ * controller that is running. Thaw and restore bring it up again.
+ */
+static int qcom_pcie_freeze_noirq(struct device *dev)
+{
+=09return qcom_pcie_suspend(dev, true);
+}
+
 static int qcom_pcie_resume_noirq(struct device *dev)
 {
 =09struct qcom_pcie *pcie;
@@ -2653,7 +2669,12 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, =
qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
=20
 static const struct dev_pm_ops qcom_pcie_pm_ops =3D {
-=09NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noi=
rq)
+=09.suspend_noirq =3D pm_sleep_ptr(qcom_pcie_suspend_noirq),
+=09.resume_noirq =3D pm_sleep_ptr(qcom_pcie_resume_noirq),
+=09.freeze_noirq =3D pm_sleep_ptr(qcom_pcie_freeze_noirq),
+=09.thaw_noirq =3D pm_sleep_ptr(qcom_pcie_resume_noirq),
+=09.poweroff_noirq =3D pm_sleep_ptr(qcom_pcie_suspend_noirq),
+=09.restore_noirq =3D pm_sleep_ptr(qcom_pcie_resume_noirq),
 };
=20
 static struct platform_driver qcom_pcie_driver =3D {

base-commit: 591d89f23a7cbc668579521513c7f53b0968754c
prerequisite-patch-id: d3815646fb89c43e4d28ab00c7ea2f3ae1ee4e4f
prerequisite-patch-id: 7de2989d30c1a223386b0d6bf991d820759e976e
prerequisite-patch-id: 42cb336b2b595db9faa485068e6b77b733713fc8
--=20
2.53.0


