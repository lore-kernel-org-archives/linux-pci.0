Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794812741;
	b=k8NsWSfj8NKyDrwDe/1FmH7FUARlaRdb6NO7kq3KL71J39EyDmeD5gzPW5QuIt3GSPlf
	 Ks6qcJFrFDZr5M/3ZkyiKfRzO5IFslaxzYYJULZtjkN69E194bhyDdiegsDhi2sPwyrxJ
	 wlpjbpEG9vwuA6EKf8GXH+UMkzX6NPZc/vD6WuIEYj4jN7h3SPg5+dakRSHkX8P72s/2E
	 i/vcRWyI3ksdc5Rln6qM2cumluFGwNTPyl+Y1QK0BYRSzIS7n+riczrHdq/6dV5im8Lrl
	 augFWBM//FUf8WeGsiVQh8MrLMYAVx6XtoN0SceEzPBxrRewgLthG/lJeCexuzOkOmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812741;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rBoc9Az+eYLYApOQ5Nq0UwLguS2L7Y5c89wC992tlqw=;
	b=RF1Dq+vBIGMLOlwrmcolukGXaZPoRD3OeSftF6gCKXAuKGfFKydT3cIW1mIRxU5oj6Cs
	 JKRdx7lqit0cll0Pvesl+Lul3tWAG2keCT30xemiX/fCJRS9+kt07nvPzeav1lxIlpC8L
	 R5qHQ98c2JUtctPZ8jvApv5lrzI2bEitK2C2rwPdRmd/+wufWyxcQLwy/48FEUuuRWYGk
	 mSvt4I2g3PUmZUzGYMYTJFBIoPIntYbtvK8fCcJUV2EUxkiBwV3pjYEb5LdyZ/4Jauvk6
	 4cl2jgPR4mPcImM/SvtsnzrPdH+XVj+LMmpokfME+3bjiH2CpoAOEcM+d67TMcXdh8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SJ5S0Ys/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBD606A323;
	Mon, 16 Nov 2026 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJ5S0Ys/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794812741;
	b=Tm08GaosT3F35/goGlMpFlAHYY8sLzjJNGvB2jqci8Egx3nCjpORUUuS9fVMDo6XwQoN
	 DPssXd3At6lRwQ/hIvzabaRCIshsObTR+CyiAhvWOjVP1aue6BEBmK6zpBbJDTx4qILLE
	 WlmEMvlY1xqQHtT9AHyHexNb4IPqdiP+y1NEqSb7uk6ThH7Htz7Z6snG8PBc7IBguMJx/
	 4gJ0qtqff1jAupMkl/UUFJtNhhPrzlz1Xtnrlxb8nO99eZ73OJ0/rIdGyw/d8uCkniLG7
	 OuOemv1LZGKvXpDYzjdbXQcIPXWN/XbroGWhw8SP8+slhV/GiG2rFo9E6J8eTNNrAaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794812741;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=rBoc9Az+eYLYApOQ5Nq0UwLguS2L7Y5c89wC992tlqw=;
	b=BHqtVSLUaiK8Zkq8jw1Nbze/XQz3JyfdkU1SWd8xpkVdZy0fSjd5c6v1MWKolC+k43Al
	 BRsdpm8HiWnYyMTOEHMQIG7jDCXEA1aR+a4DlepRTRQwGlJqvL/HFcF1BFhnK+i9MEmED
	 RSszyqxrmhl9uN+gwEhawRCE3kKNekfgyFtxXjpoW0rDUS9xjghvQGH8blXKi0hD9pBbQ
	 x7bPXOIdIs/ThgoEpyIg6s6iLnuPRZYQFb7hvisQg+2BEtR9ntJi411fIP5Tvje8d/r+O
	 /MSZdNwJCjPBuRK3iPlmLmj4EUUuBFKersQJV5SFs5MoY92TJZQDtFzs3XVVowPXMxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BEF1C1F000C5;
	Mon, 16 Nov 2026 07:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794812741;
	bh=rBoc9Az+eYLYApOQ5Nq0UwLguS2L7Y5c89wC992tlqw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=SJ5S0Ys/PDkerFAQXDztg4mxwvUqQaWJAKat33wC7U99JQi3bEsDGm+TLR+0tGr2H
	 zQvr9sBZZkRn588EZzdtU1LK+X0dauYc2+dcZ9wSVpGtzMOeVyB3/FDUBXeM7fKk7Y
	 eDlRewvqT2LIM5XdLV4M6Mw8m1iavIspbHY17i4r/yX/ilbjRYZKl49Qyiat08/u2B
	 XXR6llGwZU2LJ1MNnAb6HKQnCwo6CGzJ24ymTLlCkN9Tq8eGCpgNLN8Zia+FDH09Zc
	 dKeMtZ/BSJUVkGll2RYyQ29QotRYOnGuZ36MkGq35y6Ue5NFRSCeG1uHdwXDSBr5WZ
	 GwDOq25TgQeBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4F66B4A368;
	Mon, 16 Nov 2026 07:05:40 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Mon, 16 Nov 2026 09:05:39 +0200
Subject: [PATCH v2] PCI: rockchip-host: Retry link bring-up on repeated
 Recovery
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-rockchip-pcie-resume-v2-1-a633e279be97@iav.lv>
X-B4-Tracking: v=1; b=H4sIAEKr+moC/22NQQ7CIBBFr9LM2jFAwTSuvIfpgtBBJmppQImm4
 e5i49Lle8l/f4VMiSnDsVshUeHMcW6gdh24YOcLIU+NQQl1kEIOmKK7usALLo4JE+XnnVA5PXl
 Sfa8lQZsuiTy/tux5bBw4P2J6by9Ffu0vqPT/YJEo0AxktDXOGy9PbMv+VmCstX4AwyDy0bUAA
 AA=
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Matt Thompson <matt@boondocker.io>, linux-pci@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7808; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=Cps1/uQ5Lnu2PNKM6vu/z1g7FA1bXqg0a2gSZkGUYzE=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFm/VjufXCMedXRF1s3YKRz8VQrzCiaVx98o7BBOVCreF
 sBle+ZaRykLgxgXg6yYIsuEQxq3MpZc/evvYf4AZg4rE8gQBi5OAZgITynDP43jLLzXq0//a/xd
 JMa//0BQ2KdX6z4XPVA4u6FnqUXw9HyG/w6tAgwiIXGes+Xu68078sU99PeGRIlznw/WrcucYJC
 6hh0A
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv
Content-Transfer-Encoding: 7bit

From: Igor Velkov <iav@iav.lv>

On Kobol Helios64 (RK3399 with a JMB585 at x2) about 3% of link
bring-ups go bad. The LTSSM reaches L0 and then re-enters Recovery about
every 200 us; the RC sees DLLPs about 300 times as often as on a good
link, with no DLLP or CRC errors. The first config read behind the port
gets no completion and aborts the CPU, or link training times out. The
state survives Recovery, and a new bring-up of the port clears it.

After the link comes up, poll the LTSSM for 5 ms and treat more than two
entries into Recovery as a bad bring-up. The RC runs at 2.5 GT/s only,
so no speed change goes through Recovery, and good bring-ups on the
boards we tested showed no Recovery entries after L0. Bring the port up
again, up to five tries in all with 500 ms between them, for this and
for a training timeout. An empty slot stays in Detect, so a timeout
there fails on the first try. If no try gives a usable link, probe and
resume fail as they do on a training timeout today.

Every link bring-up takes 5 ms longer. A link that stays bad delays the
failure by 3 to 5 s.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on Helios64 with unbind/bind cycles; every bad bring-up was fixed
by the first retry:
- earlier builds with the same poll and retry loop, 7.3: no abort in 600
  cycles (5 in 150 without the patch), 10/10 cold boots, 60/60 s2idle;
- 7.4-rc2 with Matt Thompson's RFC v2 [1]: 4 bad bring-ups in 150
  cycles; with the RFC alone the JMB585 was lost in 5 of 150;
- this patch, 7.4-rc2: 5 bad bring-ups in 150 cycles (one of them a
  training timeout), no abort; 20/20 s2idle.
An NVMe drive on a ROCK Pi 4A with the patch: 60 cycles, none rejected.

[1] https://lore.kernel.org/r/20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io
---
Changes in v2:
- Drop the hot reset of patch 2: it did not stop the aborts.
- Also retry when the link keeps entering Recovery in the first 5 ms
  after link-up; up to five tries, 500 ms apart.
- Do not retry a training timeout in Detect.
- Rebase onto pci/next.
- Link to v1: https://lore.kernel.org/r/20261024-rockchip-pcie-resume-v1-0-58e54a5cf5f1@iav.lv
---
 drivers/pci/controller/pcie-rockchip-host.c | 80 +++++++++++++++++++++++++++--
 drivers/pci/controller/pcie-rockchip.h      |  3 ++
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 1e1556e436b8..7c43e5bcccd3 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -13,12 +13,14 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitrev.h>
+#include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
+#include <linux/ktime.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_pci.h>
@@ -29,6 +31,11 @@
 #include "../pci.h"
 #include "pcie-rockchip.h"
 
+#define ROCKCHIP_PCIE_LINK_CHECK_US		5000
+#define ROCKCHIP_PCIE_LINK_CHECK_MAX_RECOVERIES	2
+#define ROCKCHIP_PCIE_LINK_BRING_UP_TRIES	5
+#define ROCKCHIP_PCIE_LINK_RETRY_WAIT_MS	500
+
 static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
@@ -277,9 +284,40 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
 }
 
+/*
+ * A bad bring-up re-enters Recovery about every 200 us, and config requests
+ * through it get no completion. A good link settles in L0. Each visit to
+ * Recovery lasts about 5 us, so we busy-poll; the limit of two entries leaves
+ * margin for an occasional retrain of a good link.
+ */
+static bool rockchip_pcie_link_is_stable(struct rockchip_pcie *rockchip)
+{
+	ktime_t end = ktime_add_us(ktime_get(), ROCKCHIP_PCIE_LINK_CHECK_US);
+	bool was_recovery = false, is_recovery;
+	int recoveries = 0;
+	u32 state;
+
+	while (ktime_before(ktime_get(), end)) {
+		state = rockchip_pcie_read(rockchip, PCIE_CLIENT_DEBUG_OUT_0);
+		state &= PCIE_CLIENT_DEBUG_LTSSM_MASK;
+		is_recovery = state >= PCIE_CLIENT_DEBUG_LTSSM_RCVR_LOCK &&
+			      state <= PCIE_CLIENT_DEBUG_LTSSM_RCVR_IDLE;
+
+		if (is_recovery && !was_recovery)
+			recoveries++;
+		was_recovery = is_recovery;
+		udelay(2);
+	}
+
+	return recoveries <= ROCKCHIP_PCIE_LINK_CHECK_MAX_RECOVERIES;
+}
+
 /**
  * rockchip_pcie_host_init_port - Initialize hardware
  * @rockchip: PCIe port information
+ *
+ * Return: 0 on success, -EAGAIN if another bring-up of the link may help, or
+ * another negative error code
  */
 static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 {
@@ -325,7 +363,19 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 				 status, PCIE_LINK_UP(status), 20,
 				 500 * USEC_PER_MSEC);
 	if (err) {
-		dev_err(dev, "PCIe link training gen1 timeout!\n");
+		status = rockchip_pcie_read(rockchip, PCIE_CLIENT_DEBUG_OUT_0) &
+			 PCIE_CLIENT_DEBUG_LTSSM_MASK;
+		dev_warn(dev, "PCIe link training gen1 timeout, LTSSM %#x\n",
+			 status);
+		/* An empty slot stays in Detect; another try cannot help. */
+		if (status > PCIE_CLIENT_DEBUG_LTSSM_DETECT_ACTIVE)
+			err = -EAGAIN;
+		goto err_power_off_phy;
+	}
+
+	if (!rockchip_pcie_link_is_stable(rockchip)) {
+		dev_warn(dev, "PCIe link up but keeps entering Recovery\n");
+		err = -EAGAIN;
 		goto err_power_off_phy;
 	}
 
@@ -377,6 +427,30 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	return err;
 }
 
+static int rockchip_pcie_bring_up_port(struct rockchip_pcie *rockchip)
+{
+	struct device *dev = rockchip->dev;
+	int i, err;
+
+	for (i = 0; i < ROCKCHIP_PCIE_LINK_BRING_UP_TRIES; i++) {
+		if (i) {
+			dev_info(dev, "retrying the link bring-up (%d/%d)\n", i,
+				 ROCKCHIP_PCIE_LINK_BRING_UP_TRIES - 1);
+			msleep(ROCKCHIP_PCIE_LINK_RETRY_WAIT_MS);
+		}
+		err = rockchip_pcie_host_init_port(rockchip);
+		if (err != -EAGAIN)
+			break;
+	}
+
+	if (err == -EAGAIN)
+		err = -ETIMEDOUT;
+	if (err)
+		dev_err(dev, "no usable link: %pe\n", ERR_PTR(err));
+
+	return err;
+}
+
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
@@ -881,7 +955,7 @@ static int rockchip_pcie_resume_noirq(struct device *dev)
 	if (err)
 		goto err_disable_0v9;
 
-	err = rockchip_pcie_host_init_port(rockchip);
+	err = rockchip_pcie_bring_up_port(rockchip);
 	if (err)
 		goto err_pcie_resume;
 
@@ -938,7 +1012,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_set_vpcie;
 	}
 
-	err = rockchip_pcie_host_init_port(rockchip);
+	err = rockchip_pcie_bring_up_port(rockchip);
 	if (err)
 		goto err_vpcie;
 
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index b5da15601b58..fcdc3783b3fd 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -51,6 +51,9 @@
 #define   PCIE_CLIENT_PHY_ST			BIT(12)
 #define PCIE_CLIENT_DEBUG_OUT_0		(PCIE_CLIENT_BASE + 0x3c)
 #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
+#define   PCIE_CLIENT_DEBUG_LTSSM_DETECT_ACTIVE	0x01
+#define   PCIE_CLIENT_DEBUG_LTSSM_RCVR_LOCK	0x0b
+#define   PCIE_CLIENT_DEBUG_LTSSM_RCVR_IDLE	0x0e
 #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
 #define   PCIE_CLIENT_DEBUG_LTSSM_L2		0x19
 #define PCIE_CLIENT_BASIC_STATUS0	(PCIE_CLIENT_BASE + 0x44)

---
base-commit: 35f800669ce835aa77364a2ab5b61be19b778d3c
change-id: 20261018-rockchip-pcie-resume-2c4dfe23341e

Best regards,
-- 
Igor Velkov <iav@iav.lv>


