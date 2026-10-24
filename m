Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820836;
	b=KkszAfo0PwyNO7XxyGUY4V0RflepSL1bIZuWm/lcAWmDslwW/fg+K2Rm52AthxLoVbOG
	 GnFcdEcERTDziV1S8FYNZvRTLVCHKOP8Jii1ILCYyEP7wXpoHUQ1XZpJE9b6gF3Dl45lf
	 Va3DIItIqm33/JINVeXDvRsHwKctQkhA1JFML5W2+wj1B14dm8YpIFXxi7L1lOT4QactZ
	 erhdHtRabvGGD5oWQSys/qoH7/4SqJm5MS8QKjLV73cOhIjmUeqWkIYqezF+zmZGXcGsm
	 lFwmqMMCtcnQsjTQ8+Tat+CxWDuHdBsLzXfgzEdLQj0IuvgkUEeR+dkleQUv29ZmWJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
	b=W91tGoq9/iczxrDjkqoTEs10W9+I9s9SttYEzkuFejJJQW6zdJtAzDvIJ9kYRtearpow
	 kavhjIWkY7YVJOSgPhByjj3RNMV7K1ezlXFBuu8BdzasvKes94iEGJxpBADfysPT7oIfy
	 ImTb7aqS2TAp1Bwdsr2mx1ZDYQilHhEtU+VPSIMNagHG+MfsJUJYv90R66V4PlCRSY2gQ
	 qyh/VRqtmkGMdTyWWrVwR+XRRfkCFyi7AXomQUq/caylBvbehN9vSXNZ0/VDE/8654ETs
	 4af9dA6pujpW1+bjJdEex5J2Y2uKsEtA0TzC1zukHAB6IQCjDVBDFGpWn0qBEY1eyJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yuw4ixgJ;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A6B606A31E
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 05:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A6B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yuw4ixgJ
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso1522565e9.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820833; x=1793425633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
        b=Yuw4ixgJc6bzy2bcfbKthETR1aV1KVTchu3ycgR7/NVAXtHhd80u0bNyC3XZmU5Q9a
         7nFiaAO0SGPvpxkbtFvr78kqPDoSRpZv2OEHpVI02E2vHo7FxiTuzkjPayNJtmPZqWPu
         GBfVz7OixWqhoxpGPbjn/yKao1ZNgwJfR/BZz7I9T9WJQL3q6LTUJnlN0xQHRHvcS+WO
         SSVrq+yFdxDUZiy8dppA4CwpQhMpykb7hlaaWmamK3wFMyzjbNpwSAcTcx1ydkZYBmW1
         PCp9BnH1oKZKB3XpPCVEwsM2E+ahQikbxi5VLFV1ZVihHYexv6mQuxAXi5DF7PfLP560
         Uv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820833; x=1793425633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JVRdE/3Jnet+h8SyIDy0Hc/nWbQ9iRRU6k7zkm9yJs4=;
        b=Y/nWsv3GBUsDDKvBfCYahtcvxIQTs5gRYZ89/i/J0bh9GRvRtKacaBQLV5c9U0vJ3J
         L/2jfco5UeZdgEmS9kVicd3/nK90gNHepmNaXFfEEWiPnrIjlLAPN7cBqZtvi0mZ37p3
         lrRh2P6BE4rMJ0znwhJt50HzjfqF6fb7JxKNuIyIaGembYiC20nLpQVTjBapUJJor7PH
         fH7hfcqOSwHVDhF9v7ZxRB+3qf88/Zbu4v8DhuSMt8GMyIwiLK2d1Z2w2RNfgBuMkc3A
         pZeIXke2W1Lf9tFXwmeYrD4k/oxD0ZLpQmmRhJ1R96hBS2BkTHVETvYR/lFX2WSG780J
         fr+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzODPIiDOEYd/B41bheWEiPNXWMrJeorSKyAU8yRL1aq2I0JTykXV4X98XilMjv9KPEXZqmHnqZHMU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs6jZ1s4WuMuFaxS+uPRgTiTZjH9qWSuqgKGU8oVnmEloqX5RX
	BAA/DNDSYqY89OQ7cfbtgHr0QX2y3xsGPZOtGSwhTtZHBgxbdV1V76x5
X-Gm-Gg: AYBFou2zjv55P+ljZRdZMMHnT4KybEA0c9V6w6z6tN1sPz0ad4eFwy7tKWj3sWZdNYm
	fnQAX55AurPEzdBy7WlJe08ZBuG6vwvvdFlzqGr0AfxTzOZOQXUv0DXLW9Lf8sycAZxk/ZbDqR5
	xHoWkdL6I3PSJghlQ5BRihDdSU3eQXmS+vx4WBtKRGXZur6YwmSxLy3MGa/C7wHsQa59y3q5GXT
	4Ex7TJTDQOl1E8WoJsksj61TU/N3SgCld+VzMUbBRrHyNiBxPvt47vnBHknuvQiwMnjnAosigOF
	QUZB3sAEGXvY5w4+nLPOydeuz8ijtyNLxGeJcvJQZmc/QU8s6yYo/2qWyKsD5Nt14iPqtsdIGco
	GBcZ7xhOYF/Km1PYj0ASyKqaYzEX0wn+ERTbtpNlnabshHhs2gWSjDLFvIc4OTACXlE/tDjXtc3
	IKfHQ5K6A5QPkiU5Oi4V0kD53oZ4qeysFf7qsZ2GKiXB/i3OZBgbfNFvoSMM3H6Bnyds3dIQj/D
	tw/tRNYERz9p2ejRMqHBA4EY6WCfTx/j1yA/yWN4zpj7jT4nrWDxMDhVUYBBvjs1Cecpd/8Nr4K
	nyYp8uU9lcq5xN/IAcy2V/eIxIsUKw7tMgoEq4d4Bw/yptxfsUtv
X-Received: by 2002:a05:600c:8b72:b0:4a1:e11f:b2d5 with SMTP id 5b1f17b1804b1-4a35ac3948emr13955165e9.2.1792820833100;
        Fri, 23 Oct 2026 22:47:13 -0700 (PDT)
Received: from Sheldon ([185.4.35.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a00e1b0sm25917465e9.3.2026.10.23.22.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:47:12 -0700 (PDT)
From: Victor Carreras <vicajilau@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Victor Carreras <vicajilau@gmail.com>
Subject: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594 dGPU root port
Date: Sat, 24 Oct 2026 07:47:11 +0200
Message-ID: <20261024054711.21587-1-vicajilau@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179272791966.20251.3697951431087014523@gmail.com>
References: <179272791966.20251.3697951431087014523@gmail.com>
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

On MSI Summit E16 Flip A12UCT (motherboard MS-1592, BIOS E1592IMS.111)
and MSI Prestige 16 Studio A13VE / Summit E16 Flip A13VET (motherboard
MS-1594, BIOS E1594IMS.115), the I2C touchpad (ELAN0305:00, 04F3:31FD)
permanently stops generating interrupts as soon as the discrete NVIDIA
GPU (0000:01:00.0) and its parent PCIe Root Port (0000:00:06.0,
\_SB.PC00.PEG0) enter D3cold.

In the platform's SSDT (MSI_NB / AdlP_Rvp), \_SB.PC00.PEG0 sets its wake
GPIO (WAKG) from the BIOS NVS variable P1WP, which erroneously points to
GPP_A20 (INTC1055:00 pin 62) -- the GPIO interrupt line wired to the
touchpad.

During boot, \_SB.PC00.PEG0.PON() calls \_SB.SHPO(WAKG, One), setting
PAD_CFG0_GPP_A20.GPIROUTSCI = 0 and HostSwOwn = 1 so the OS GPIO driver
owns the pin. However, when the root port runtime-suspends to D3cold,
Linux enables ACPI wakeup via \_SB.PC00.PEG0._DSW(1, 0, 3), which sets
WKEN = 1. Subsequent evaluation of \_SB.PC00.PEG0.PXP._OFF -> POFF()
executes:

  If (CondRefOf (WAKG))
  {
      If (((WAKG != Zero) && WKEN))
      {
          \_SB.SHPO (WAKG, Zero)
      }
  }

This switches GPP_A20 ownership to ACPI GPE mode (HostSwOwn = 0,
GPIROUTSCI = 1), silencing the touchpad interrupt until the dGPU wakes
back up to D0. Under Windows, _DSW is not armed for S0 D3cold on this
root port, leaving WKEN = 0 so POFF() powers off the dGPU (\PIN.OFF(PWRG))
without touching GPP_A20.

Add a PCI quirk in drivers/acpi/x86/utils.c for boards MS-1592 and
MS-1594 on root port 0000:00:06.0 (8086:464d on 12th Gen Alder Lake-P
and 8086:a74d on 13th Gen Raptor Lake-P/H) to disable wakeup capability.
This keeps WKEN = 0 so the root port and dGPU still reach D3cold
normally while leaving GPP_A20 owned by the GPIO driver.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220725
Cc: stable@vger.kernel.org
Signed-off-by: Victor Carreras <vicajilau@gmail.com>
---
Changes in v2:
- Move the quirk from drivers/pci/quirks.c to drivers/acpi/x86/utils.c
  as it is x86-specific (Lukas Wunner).
- Drop clearing adev->wakeup.flags.valid in the final fixup so ACPI
  power resource dependent tracking between pci_acpi_setup() and
  pci_acpi_cleanup() remains balanced.
- Link to v1: https://lore.kernel.org/r/179272791966.20251.3697951431087014523@gmail.com

 drivers/acpi/x86/utils.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index 4189516..84a6ca7 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -665,3 +665,50 @@ void __init acpi_proc_quirk_mwait_check(void)
 	 */
 	dmi_check_system(acpi_proc_quirk_mwait_dmi_table);
 }
+
+/*
+ * On MSI Summit E16 Flip A12UCT (board MS-1592) and MSI Prestige 16 Studio
+ * A13VE / Summit E16 Flip A13VET (board MS-1594), the BIOS SSDT (MSI_NB /
+ * AdlP_Rvp) assigns the touchpad's GPIO interrupt pin (GPP_A20) as the PCIe
+ * wake GPIO (WAKG / P1WP) for the dGPU root port (\_SB.PC00.PEG0, 0000:00:06.0).
+ *
+ * When ACPI wakeup is armed on this root port via _DSW (setting WKEN = 1),
+ * subsequent D3cold transitions (\_SB.PC00.PEG0.PXP._OFF -> POFF) call
+ * \_SB.SHPO(WAKG, Zero), switching GPP_A20 ownership from GPIO driver mode
+ * to ACPI GPE mode and permanently freezing the I2C touchpad (ELAN0305:00).
+ *
+ * Disable wakeup on this root port so _DSW is not armed and WKEN remains zero
+ * during D3cold transitions.
+ */
+static const struct dmi_system_id msi_peg0_no_wakeup_dmi_table[] = {
+	{
+		.ident = "MSI MS-1592",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-1592"),
+		},
+	},
+	{
+		.ident = "MSI MS-1594",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "MS-1594"),
+		},
+	},
+	{}
+};
+
+static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
+{
+	if (pci_dev_id(dev) != PCI_DEVID(0, PCI_DEVFN(6, 0)))
+		return;
+
+	if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
+		return;
+
+	pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPIO (GPP_A20) takeover in D3cold\n");
+	device_wakeup_disable(&dev->dev);
+	device_set_wakeup_capable(&dev->dev, false);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_wakeup);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_wakeup);
-- 
2.55.0

