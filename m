Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982737E5C4
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 21:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161372; cv=none; b=RtkbuZZ4IP2EazqiZo1w2LCf8CvL6mrvtG1SyoDhms5IdDJBneET246ILwLNG14UwWeZmq6Rl2OuD9kNaQ9REPo+O0ypwKz2leNgb8k53ykgqe4AlFAH9lNH6nA/Eu5nCriaHJsNS/sz8MutO+Z1Du4fFm03r9xajqnzeRqrT9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161372; c=relaxed/simple;
	bh=CkkoL+Mm5wrXLqQiEf4jOxWLB6Aj63iNCHVgZTJ+iiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kd0kqJqMXCAwoBNvO6lB5tFccRTi/oiqzSDKbL+CrmXaS+4TXEqbhxyWfWjhK04ZsqzXjhx4ZCRI2gd+GrpQAYJ+YXZJLDBX6G3YK5S02h6UuW0D9SINeceoutsnLDBvaB5L3EBcf+vUpGh1lGWu7ksnqDgka4f5l9ctT3SgN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLXxup54; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLXxup54"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b6so1542875e9.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 14:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789161369; x=1789766169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pK9Q3uGKA1u0ElzG2dqV80RIYwnVI0Uj5jzztR3o9vo=;
        b=FLXxup54uCKRJpkw3XRCqMzCjtsGb1MCVo9iEru28s7k6HPBxBMilYz1+haf5GO+6M
         2cUJBJfTONhwzggLzLt3FTn01PzFbJQfPa2p+3Wm1ZdHgsHnSQZmEVeeT612qlJSz+zb
         Ng4n+81M8IZ4LtA/NMw/7/LaAKUw5JJeoZpZn5fBBgXvdvEG4C5VgBUQ+vL+TaiYm5uS
         uLi5ThdOY/Ydt/anJZRMA/68zft9HvTJ0m1PgXCETTagqe8YXtHfndWkCYGewwbhfry4
         PHcZpJxyR1RtQkigqon0Tj71whbkSSnN0VdsHHM6krvsxINYY0FdKsc28mZltp7Fw8ST
         SlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789161369; x=1789766169;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pK9Q3uGKA1u0ElzG2dqV80RIYwnVI0Uj5jzztR3o9vo=;
        b=hdCR8fCJOgNeuvrQ+UtfZSOoTSiSQAtU8gE+i10CCXmCzMYFuWoTWh8pjg1ia75Z1e
         24wqCpJzoPcLZfqXys93iRe5b6XcgAy5LO7iPeYaIYbkAXgC2FGa4H1w4O6s2JuE4v/K
         5dmxXxhORZd/TT9As4vYbPxb0DOaMCtffp8IJoXtND6hMdqJNXoNwErzVdn1b0FS4jpf
         9gqTMisVZwVhz5CDSpxidgVu7wao0pNca/Rig+IORnVPK/M/98FmBnY/qwCOtDw/sDEF
         8a2Q0impvPrWLo2RY4tdTqR7FM1MbqklYCwVoMWHiBHjEDhLTFC+edjYRkqMuW9Tjhi8
         FCxw==
X-Forwarded-Encrypted: i=1; AKwUvBzW4eodna0afAm9R2uwiWoN7Wj9GSvRTS9Juddp1bFCTnzdnwSsFeJauIELS6uvMGDggImN8npfEFw=@vger.kernel.org
X-Gm-Message-State: AFuF++nMdfKaIRp9ZVXJlLsarWnVylKtKmkqNmsqPmwgoq0oeUzup+O8
	4k9XbCgxKYUI1GckpheqbA2XZKgUJeXFLv0xpf1HwNTj9BqS/uV27FrK
X-Gm-Gg: AYBFou36yLqEhqqOV1qbuBp2HKp4bExXwUAX2CBZ7DZ90uYFG67i++pG4O9VWfUXBWQ
	8pS1jKhAuNgv8clP1DfjwD8U5Byin+KgMTUdSRNDYRt6E6/WqaVvObxUqQ/l834ZjevfP2JJKlp
	xMneSP1D1f0VcTc/THz/JO6DL6EvFaWWcjJD1KLwKX7e5TAQBNHUY11b96wfq3iRGJWa6EmMHJK
	KXnSF5mxaDtAkF7FENDMVCs7EguheQwl2AelE2PyT11iP2FT9YAl+AquzE9LzolykBIrCRWCMIA
	y4SfbfJEynwF7BbLTF49uz4FfOSkYl3UCo0x1JwUVUlP7+1Z9xOLPN5BgvnLg18PAGD94WRTGxl
	NjNFR8z0n0iHFzc+yQb5UGkKX0VwqoZpMYcGrzl8Llz/D8iJvbRVDgpKpSmIQGL+w7snpoa3KZd
	yFGuGrd2EUzAGt/0WT3vdtnVAN7kX04mmPOgGoa3uCfmvSUjWgnqw3dvE2LD86VDxkJD+Ettbps
	Z2X9PwmpH5NtHiBTsflgOi3CYDtOLxcjeFHrGUHNXQPu9WPKGQnZ0XsnnTa6X/pFWqsh38LbzI=
X-Received: by 2002:a05:600c:3494:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49e619aab42mr162972575e9.9.1789161369234;
        Fri, 11 Sep 2026 14:16:09 -0700 (PDT)
Received: from tachyon.internal ([194.220.152.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6576122bsm99082465e9.2.2026.09.11.14.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:16:08 -0700 (PDT)
From: =?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
To: shawn.lin@rock-chips.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	heiko@sntech.de,
	dlemoal@kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Enrique=20Hern=C3=A1ndez=20Bello?= <ehbello@gmail.com>
Subject: [PATCH v2] PCI: rockchip: Skip the Tpvperl wait when power is already valid
Date: Fri, 11 Sep 2026 22:15:59 +0100
Message-ID: <20260911211559.207990-1-ehbello@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit c47f90be4c89 ("PCI: rockchip-host: Fix
rockchip_pcie_host_init_port() PERST# handling"), a JMicron JMB585
behind an rk3399 root port almost never becomes usable: the link trains
normally, but the endpoint's configuration space never answers, so the
device is not enumerated. On this controller a configuration read that
gets no usable completion is reported as an external abort rather than
as an all-ones response, which on arm64 brings the machine down.

The change added an unconditional 100 ms sleep so that PERST# stays
asserted for at least Tpvperl after power becomes valid. The wait is
performed while PERST# is asserted, so it also extends the reset by
100 ms, and this endpoint does not tolerate the longer assertion.

Tpvperl is counted from the supplies becoming valid (PCIe CEM r5.1,
sec 2.9.2). On boards whose PCIe supplies are always-on -- vcc3v3_pcie
on ROCK Pi 4 is regulator-always-on and regulator-boot-on -- power has
been valid since boot, seconds before the driver probes, so the
requirement is already met and the sleep only lengthens the reset.

Record whether the supplies were already enabled before the driver
enabled them, and skip the wait in that case. A supply that is already
on at probe was brought up either by the bootloader or by the regulator
core at boot, both of which precede a PCIe probe by far more than
Tpvperl. When the driver really does bring the rails up the full wait
still happens, as it does if regulator_is_enabled() cannot tell.

The same check is repeated on resume rather than assuming that power
was cycled: suspend calls regulator_disable() on the 0.9V supply, which
only drops a reference, so on a board where that rail is always-on or
shared with another consumer the power stays valid across the cycle.

Skipping the wait only when every supply is already on is strictly more
conservative than what this driver did for years: until the change cited
above there was no Tpvperl wait at all, and PERST# stayed asserted only
for as long as the register writes in between took.

Measured on a ROCK Pi 4C with a Radxa Penta SATA HAT (JMB585) by
booting repeatedly and counting how often the endpoint enumerated:

  unmodified ....................................  0 out of 84 boots
  with this patch ...............................  3 out of 3 boots
  other ways of dropping the same wait ..........  16 out of 16 boots

Fisher's exact test, pooling the last two rows against the first, gives
p = 4.1e-21. With the patch the endpoint enumerated on every boot and all
four disks behind it came up.

Each of the three PERST#-related changes that landed together in
v6.11-rc1 was also reverted individually; only removing this wait made
any difference. Moving the wait to before link training is enabled,
rather than removing it, did not help (0 out of 15 boots), which is
what identified the length of the PERST# assertion rather than any
interaction with link training as the cause.

The measurements were taken on 6.18, but the code in question is
unchanged between v6.11 and v7.2.

Fixes: c47f90be4c89 ("PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling")
Cc: stable@vger.kernel.org
Signed-off-by: Enrique Hernández Bello <ehbello@gmail.com>
---
---
v2:
 - Re-evaluate the supplies in rockchip_pcie_resume_noirq() instead of
   assuming that the 0.9V rail was really turned off. On a board where
   that rail is always-on or shared, regulator_disable() leaves it on,
   and forcing the wait there would reintroduce on resume exactly the
   failure this patch fixes. Spotted by an automated review of v1.
 - Factor the test into rockchip_pcie_supplies_enabled() now that it
   has two callers.

v1: https://lore.kernel.org/all/20260911104952.4190994-1-ehbello@gmail.com/

--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -318,6 +318,7 @@
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
 	struct	gpio_desc *perst_gpio;
+	bool	supplies_pre_enabled;
 	u32	lanes;
 	u8      lanes_map;
 	int	link_gen;
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -314,7 +314,9 @@
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	msleep(PCIE_T_PVPERL_MS);
+	if (!rockchip->supplies_pre_enabled)
+		msleep(PCIE_T_PVPERL_MS);
+
 	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
@@ -609,11 +611,33 @@
 	return 0;
 }
 
+/*
+ * Tpvperl is counted from the supplies becoming valid, and the driver waits
+ * for it with PERST# asserted, so the wait also lengthens the reset pulse.
+ * Supplies that are already enabled before this driver enables them were
+ * brought up by the bootloader or by the regulator core at boot, both of
+ * which precede this point by far more than Tpvperl, so the requirement is
+ * already met. Treat an error from regulator_is_enabled() as "not known to
+ * be on" so that the caller waits.
+ */
+static bool rockchip_pcie_supplies_enabled(struct rockchip_pcie *rockchip)
+{
+	return (IS_ERR(rockchip->vpcie12v) ||
+		regulator_is_enabled(rockchip->vpcie12v) > 0) &&
+	       (IS_ERR(rockchip->vpcie3v3) ||
+		regulator_is_enabled(rockchip->vpcie3v3) > 0) &&
+	       regulator_is_enabled(rockchip->vpcie1v8) > 0 &&
+	       regulator_is_enabled(rockchip->vpcie0v9) > 0;
+}
+
 static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 {
 	struct device *dev = rockchip->dev;
 	int err;
 
+	rockchip->supplies_pre_enabled =
+		rockchip_pcie_supplies_enabled(rockchip);
+
 	if (!IS_ERR(rockchip->vpcie12v)) {
 		err = regulator_enable(rockchip->vpcie12v);
 		if (err) {
@@ -890,6 +914,13 @@
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int err;
 
+	/*
+	 * Suspend calls regulator_disable() on the 0.9V supply, but on boards
+	 * where it is always-on or shared the rail does not actually drop, so
+	 * re-evaluate instead of assuming that power was cycled.
+	 */
+	rockchip->supplies_pre_enabled = rockchip_pcie_supplies_enabled(rockchip);
+
 	err = regulator_enable(rockchip->vpcie0v9);
 	if (err) {
 		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
