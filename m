Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462182;
	b=MV7bbsY1CHtfHh8fLlAeoC5PAG/uuJ0O3Z09e4JeFp8q/qRE5/yMo00eWJ6RsAV47ACH
	 ER3tnxmu46KbHF/ClSnf8qXGuL7d7Z5Vjh7m9nJVTmxBkLs1KQ0WV3/EdMctdpMfAa7FX
	 VPzNzQWya8yA8oFN6KyhvFVIzsaNkJgh40EirMpDc8Bf8MQ46bIUrhJZWg0nAEHo4JdLv
	 /gkS1770VSCWSLJb72ZiciX1Gtsst6mmHx2OsbKdPKeeeoA3fat7Uem3nTU1ZkmQ8o5/Y
	 MHASuNzqIULw25W8MwKAKE9Ggwj7qvrLcNFWPz+568MgEbw2AxRckOClmAcd5g7fOyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462182;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3bfBPCAxzD1ewqDDXxdBbPCkJzOW0WWiLOKX18fykp8=;
	b=TwOIn0KAJrhn6fShxMUSffu4F24XtZMQonTRSLVwFZ8OIyao+BvaOUEWPVB648nSvkiw
	 6qvd7BdH2xaczXkfsapV/5MZYTIxJGdXCSLWABZhv9Ix/kL/llIAOO9n6owYd6IjEWQ3i
	 UXOPbxj6FD4uNoo+GJAd57TJ8njnCJ6RzGjyEJdzUee2/UCjzSgPjPa8rAh2GZ0tbkFXB
	 bVmBEzGnX4w+r/V4lx2uoMHnR6AMK9mb2T2/JfbYAigbi8WCcuI8n+upqT1I7Rovs/2no
	 pluSXALsQlyY3UbvYuSNfre9kOxL3W97SIvSH+/n4k/J0y6wsTyMnjvgtxT4sTnBXXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q+vuZHg/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8DC606A332
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q+vuZHg/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462181;
	b=kfr4t+c6XWQ3Trzqy4ZZz511TIgjKReLg705T1Mn/gG15N2JnjUuDVTqLpWoRUP70ryT
	 raZLfNIaLX0jAXpH8ML1GobRxOWuPTZvwMokeTCBykl8OlpDmrfAopU+sqgvDuQ5KubuG
	 UxTzbknKFIIl4gapdiQaP/JGqBGFzJobbkAG6WMVhEDL4Jy8+CgzOmA1ttrYN37R6aWi6
	 vm6KpCNzHDOezSt0EvKce1XelKGZrgBH3XvmIo4xgFV0n6EskO/PxABsVN3J6UXnZL/7L
	 SSQNYot8Z3YI60OjArTzPQ4OZtngLLs5sd5qUohEEx6Ew0l9s16sBoIOE4PSZhE2PgA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462181;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=3bfBPCAxzD1ewqDDXxdBbPCkJzOW0WWiLOKX18fykp8=;
	b=G60vGzKJ8vKcj80L3xDKgGy9PvsQC6XxOMLYt+768WJRNeaz5C8QA38fFw28Fo0aVX87
	 tVGrVSFb92Opj66wzTfdcOHubtfX6dInQdv8zVoaT497ebSEmjBJe77VPd+gP8/lVllaE
	 Zl8OHDch9gYYkGzEbDwLeCOvx6gWz/8/wAqvKizTkb5ltPZb1Nfmx5oAPgbqgvGpQR7Ot
	 FLSTF0Sd+Wvw6A18+z0KOmSkRLjS2vhpWpN5zoEsxcxpJ2kwbqqv7VplA4hCcDw9OggQB
	 aRoDu4mUuXLmEAikW/5q4RPoVRzNYQcItdKnCUavEtqm8wPAb/4KhWyJT+0SHUjSOHQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A6A321F000D0;
	Mon, 23 Nov 2026 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462181;
	bh=3bfBPCAxzD1ewqDDXxdBbPCkJzOW0WWiLOKX18fykp8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Q+vuZHg/Ffp0lCfNVTh48kzzCUKZJsclxURsCGDD3ZCAU/IjgLvWRgRcq9cBlmGvr
	 ii3HZimnMzFwLUyAsRRgDBpOWPf+1V8eUHmt+xOH9sgnhWVV6YAU2C7Cr8Pnlkyng0
	 n+AW5sH/b/NuNhkBPynOd02Cb1BMIDDEEymfyXraxGe+UK4j+pbcR6AmamLbyy1JAx
	 EWQX/qWv7GT0vtUZzA9lb+XTanaVrikjbJFCK8XGNrSbLUDgVqab0lyR9STQXaMDwb
	 WFweZ8pLY4A+ehG8FyvbmRQk+a/F8axSmrxQ7jr0VYfa0dQjGYA+/0lI5FhKxBXJMi
	 IrzPduIRqpLKg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 092534C63D;
	Mon, 23 Nov 2026 19:29:30 +0000 (UTC)
From: Han Gao via B4 Relay <devnull+gaohan.iscas.ac.cn@kernel.org>
Date: Tue, 24 Nov 2026 03:29:24 +0800
Subject: [PATCH] PCI: dwc: Split iATU windows at region limit boundaries
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
Message-Id: <20261124-dwc-iatu-boundary-v1-1-03c8e58514e1@iscas.ac.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMPQqEMBBA4avI1Dtggqh4lWWLOBl1LKIkxh/Eu
 xvX8iveOyGwFw7QZCd4XiXI5BLUJwMajOsZxSaDznWplC7QboRilojtFJ01/kDSXFYV1aYmBam
 bPXey/5/f3+sQ25FpeUZwXTfl4h0hdQAAAA==
X-Change-ID: 20261124-dwc-iatu-boundary-c2e677c8a8c1
To: Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Charles Mirabile <cmirabil@redhat.com>, 
 Randolph Lin <randolph@andestech.com>, Frank Li <Frank.Li@nxp.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, Han Gao <rabenda.cn@gmail.com>, 
 Han Gao <gaohan@iscas.ac.cn>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795462168; l=2144;
 i=gaohan@iscas.ac.cn; s=20261021; h=from:subject:message-id;
 bh=LWq4t/W7/8Yh8qXqKLllSLq5ntvJqq5EalVbOE1tRmA=;
 b=ues/A1ukD7yttv0kwYfT+pgX19+/wfooG488bmDtAKIbV4ss0drz8BXLUvRxFBtBrd0wuawkF
 3+ex+aQO1QXCWXE3O33Y01xP/EKixtnNnzg6UTzm1OiLcEHy6n2tlxx
X-Developer-Key: i=gaohan@iscas.ac.cn; a=ed25519;
 pk=J8WHEK3filS86QaCaIHDGafqhxKyQ4K7+vFgRirTIiY=
X-Endpoint-Received: by B4 Relay for gaohan@iscas.ac.cn/20261021 with
 auth_id=1262
X-Original-From: Han Gao <gaohan@iscas.ac.cn>
Reply-To: gaohan@iscas.ac.cn
Content-Transfer-Encoding: 7bit

From: Han Gao <gaohan@iscas.ac.cn>

dw_pcie_iatu_setup() splits a large window into region_limit + 1 sized
chunks starting at the window base. If the window doesn't start on a
region_limit boundary, the first chunk crosses one, the iATU programming
helpers reject it and the host fails to probe.

Stop each chunk at the next boundary instead. Inbound windows have the
same problem.

Fixes: e9a5415adb20 ("PCI: dwc: Use multiple iATU windows for mapping large bridge windows and DMA ranges")
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
---
I hit this on a Zhihe A210, where the config and I/O windows sit at the
start of a 4 GiB aligned aperture and the memory window follows them.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index bbb02458af58..37f7a48bf4f6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -952,7 +952,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 			}
 
 			atu.index = ob_iatu_index;
-			atu.size = MIN(pci->region_limit + 1, res_size);
+			/* Don't cross a region_limit boundary */
+			atu.size = MIN(pci->region_limit + 1 -
+				       (atu.parent_bus_addr & pci->region_limit),
+				       res_size);
 
 			ret = dw_pcie_prog_outbound_atu(pci, &atu);
 			if (ret) {
@@ -1030,7 +1033,11 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 				return -ENOMEM;
 			}
 
-			window_size = MIN(pci->region_limit + 1, res_size);
+			/* Don't cross a region_limit boundary */
+			window_size = MIN(pci->region_limit + 1 -
+					  ((res_start - entry->offset) &
+					   pci->region_limit),
+					  res_size);
 			ret = dw_pcie_prog_inbound_atu(pci, ib_iatu_index,
 						       PCIE_TLP_TYPE_MEM_RDWR, res_start,
 						       res_start - entry->offset, window_size);

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261124-dwc-iatu-boundary-c2e677c8a8c1

Best regards,
--  
Han Gao <gaohan@iscas.ac.cn>


