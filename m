Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794905722;
	b=okPMsaZI+o9IJwvzvpLzdV2hKRy6mHXDuxgjqf+YveyZxCBFVFVvpez/NiaDi/DPqH9T
	 cveWHNu780L2JO9vKsVjSLyvtDUyQP+3Qiz0NgGZz6ra4FjheWmz5LNNlDZNO+IEEW+0W
	 2J9z4MOvIdHGiiW6J41oapG50pJXl2b2rkxQ/ePLoRJXilccROaUe2kO85I9w9/JQ8Abq
	 EwgezyCdHwHgSWjkYbwA0qUg3Harg5OVwLIT7lgOJUKUnkDTYlDzPxYt4vDzIV2nbbI6t
	 lQ1YOZFTAhkp5dQCrTgwinAIuUcRHfGDknK3LAP5vh5JmkU7Lt9lzPjUltu8yLaaa+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794905722;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YoSUKncv+j8yWkI1ZDcElbOhTKMX3MU43KfQwivUqRI=;
	b=Ab1wWS+HZXjgk3sqhmyk5an+PhxdUxJEsUT3SK4MoWDErTEzl3tEPFSQgRbMIekjwunX
	 o1/h2up5Mj2t4Cu6oGfaLP7lKl92qZPXht9bQsVhJQkwKTshEp0ifEa9ewAOXYy0FrUuJ
	 DYtDyaXTJqD7lnaco56NlkxwzquCKEBTREZUbs208ZpKZuCtHBhbdF0uKruU66CZjepZg
	 EB6/6ZQKpuQWTV2A/FRU0UvLngeo9Heuia+UttckHKhMdugea2fqQHAKGIsPHV7uBmE2j
	 MUzLRdEBhieG6nvVWiqHci2LJ0tnEHTO5TF71QivOiwXGz1wV0Ki2cCd+k3s7I8grpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=idZG3t6H;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57509606A31C;
	Tue, 17 Nov 2026 08:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57509606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=idZG3t6H
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 2F44220DC83D;
	Tue, 17 Nov 2026 09:55:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id 02A2A20DC645;
	Tue, 17 Nov 2026 09:55:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr 02A2A20DC645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1794905720;
	bh=YoSUKncv+j8yWkI1ZDcElbOhTKMX3MU43KfQwivUqRI=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=idZG3t6H6xRGsVi2TLW5bezCYq3xy1oVFURyzryQ9GXpQhy69wkKSzq48Cz/RSZr7
	 7NQgoF+E6TIVPLrpq+iXLd3fgVhhZiAYA76YlzIikzYy1LxUWSSSteUlz+cTCnCJdo
	 duOaFo+2r5cKXMliOMzbXzhfnjpxJ0oD0lDOUZawsGu/moRheKWm/F0Hc+MMyCCy/s
	 MjNJrep/oM3R0LapuvuEZl371t/y3u9o4xTnI0B+wCuScVMulsx+14Ai6wbqJg4Cab
	 9IJlaf8WOQv3EG7Il0I1fk+80TKSqtYUo9J1r3NVTNxooOJMvG5T0W/1Z3S2zfMlMR
	 rWPfP6aURMzmA==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id KP3hYXsr1wK7; Tue, 17 Nov 2026 09:55:19 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 33F1520DC83D;
	Tue, 17 Nov 2026 09:55:19 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
	Rob Herring <robh@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Alex Elder <elder@riscstar.com>,
	Encrow Thorne <encrow.thorne@linux.spacemit.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: spacemit-k1: Request the Gen2 speed change once the link is up
Date: Tue, 17 Nov 2026 09:55:06 +0100
Message-ID: <20261117085508.83388-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On a Banana Pi BPI-F3, an NVMe SSD in the M.2 slot (pcie1) always comes
up at 2.5 GT/s, although the root port and the drive both support
5 GT/s. The Directed Speed Change that dw_pcie_setup_rc() requests
before the LTSSM is enabled has no effect on K1. Setting Retrain Link
in the root port's Link Control from userspace brings the link to
5 GT/s, so the link itself is fine.

Once the link is up, request the speed change again, wait for the
controller to clear SPEED_CHANGE (as pci-imx6 does), then briefly for
Link Status to report the new speed. A port with nothing behind it is
skipped after 100 ms.

With an SK hynix BC511, the link now trains at 5 GT/s x2 and fio
sequential read goes from 397 to 575-640 MB/s. Data verified with fio
crc32c. The empty pcie2 port behaves as before.

This change was developed with the help of Claude (Anthropic); I
reviewed and tested it on hardware.

Signed-off-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr>
---
The K1 PCIe cover letter says all ports run at 5 GT/s, so maybe this
depends on the drive or the firmware; on this board the link always came
up at 2.5 GT/s before this patch. Tested on top of v7.4-rc1 with "PCI:
spacemit: Ignore PERST# input in RC mode on K1" (applies cleanly without
it too).

 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
index 92a71ea90..4acc14efa 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
+#include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
@@ -209,6 +210,51 @@ static bool k1_pcie_link_up(struct dw_pcie *pci)
 	return (val & RDLH_LINK_UP) && (val & SMLH_LINK_UP);
 }
=20
+/*
+ * The Directed Speed Change requested by dw_pcie_setup_rc() before the
+ * link is started does not take effect on K1, and the link stays at
+ * 2.5 GT/s.  Request it again once the link is up.
+ */
+static void k1_pcie_speed_change(struct dw_pcie *pci)
+{
+	u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	bool up;
+	u16 sta;
+	u32 val;
+	int ret;
+
+	if (pci->max_link_speed < 2)
+		return;
+
+	/* Nothing to do if there is no device behind the port */
+	ret =3D read_poll_timeout(k1_pcie_link_up, up, up, 1000,
+				100 * USEC_PER_MSEC, false, pci);
+	if (ret)
+		return;
+
+	val =3D dw_pcie_readl_dbi(pci, LINK_WIDTH_SPEED_CTRL);
+	dw_pcie_writel_dbi(pci, LINK_WIDTH_SPEED_CTRL, val & ~SPEED_CHANGE);
+	dw_pcie_writel_dbi(pci, LINK_WIDTH_SPEED_CTRL, val | SPEED_CHANGE);
+
+	/* The controller clears SPEED_CHANGE when the speed change is done */
+	ret =3D read_poll_timeout(dw_pcie_readl_dbi, val, !(val & SPEED_CHANGE)=
,
+				1000, 100 * USEC_PER_MSEC, false,
+				pci, LINK_WIDTH_SPEED_CTRL);
+	if (ret) {
+		dev_warn(pci->dev, "link speed change timed out\n");
+		return;
+	}
+
+	/*
+	 * LnkSta lags behind SPEED_CHANGE; wait a little for the new speed
+	 * (stays at 2.5 GT/s if the device is Gen1 only).
+	 */
+	read_poll_timeout(dw_pcie_readw_dbi, sta,
+			  FIELD_GET(PCI_EXP_LNKSTA_CLS, sta) > 1,
+			  1000, 20 * USEC_PER_MSEC, false,
+			  pci, offset + PCI_EXP_LNKSTA);
+}
+
 static int k1_pcie_start_link(struct dw_pcie *pci)
 {
 	struct k1_pcie *k1 =3D to_k1_pcie(pci);
@@ -226,6 +272,8 @@ static int k1_pcie_start_link(struct dw_pcie *pci)
 	val |=3D PCIE_INTERRUPT_EN;
 	writel_relaxed(val, k1->link + K1_PHY_AHB_IRQ_EN);
=20
+	k1_pcie_speed_change(pci);
+
 	return 0;
 }
=20

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--=20
2.47.3

