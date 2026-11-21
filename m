Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795261049;
	b=uCe/26GxBBTLP9Z/yV0Z3AhnU7v/cYUje2Db5Aus0Fevdr44T2c/iX888/DqEFfpjyjZ
	 C+xeO1Hcd1D42j43+vuzlDU4laS7K0FRU8noOKF1ypGzWonmp2mOLnLIn7JtgsVflCkxe
	 11WrbhXWynr5qo0o8KuXr4psS0YK5WVN0oZERo2Largu1SIBb976pETX3GeDfPa1btR3F
	 qyqGqpFKFoUhIsIjePhgSki5g2XWmdRQ3JtGy/2CnT7iaOB5J8GVz0nJveIrVnY7akyMk
	 LBkj2zSIsktHtYKGOGLV750f/O3cj7tqvwB79as+G1S3Q0jeHMy2V23fGIVh66NfXww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:User-Agent;
	bh=Z6Fq2OUnRPwkDMt3uy74FQqaHnnZFERerJEl0pXhFq4=;
	b=zI3YfIsPSx4KQFurp/2ZHeGpN3/V3tym1A7uExwA8mzMY+Kb+BZMzKkI3t+HGLtLzJ0T
	 euIP9roXudAUZ2n6RUxtfFlH4THNyj7JHXydrpaBB93eFfZTI9W4AONoQAfA3LP20wAjr
	 p6nUfoNDjSxsWGkZRTlNSHIzXG098B9NUDf+/kq34sHEg3JhR4gg4ctYTnPzLTn/0zml7
	 j8+bpjU/YDaglZCqFbJ8JpL90OD7pQ3Qj//CUJTuRp4kwdylRuKHHX5/pP4iL3YI71F34
	 QxOxRRNwnp706SYWHuF6wHejSTnkUT29o+s0RUurpXZRaewB4SnMlC6ONhZ5CO8OJlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOFfY2C0;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA158606A32A
	for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 11:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA158606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOFfY2C0
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so2889910c88.0
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 03:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795261048; x=1795865848; darn=vger.kernel.org;
        h=user-agent:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z6Fq2OUnRPwkDMt3uy74FQqaHnnZFERerJEl0pXhFq4=;
        b=iOFfY2C0LlUvyKFJTvFPJcN4Xr9YeXIbalzQaPzIkZr72m+pI2qhhzoCdSvkI9Vk5N
         MrfXgnYBgdaM5hgm2WpobxmQXFxsK4eeEhM6WPlFxjSl3FT9bqNkd8tWAUmPV2HTf13t
         fdp3HGnjyL80p3TxPLCUooXon5JGMd3b5G58uoniv6Ux54AlcvhCmNX9iBjXPj1RJI3f
         ueq9LTqFbRPZbyMo4vl9/KuHRGK/Z7EvfG0+eUPpc5EI3rgIUohgClWWkTb/jk56aeuh
         /rUlnnsyyJ18RZOtySzvTAkOqYQc3zDZFW3igjvfG8VxE6tErT1oymKvJEWKXkwNneRc
         dKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795261048; x=1795865848;
        h=user-agent:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6Fq2OUnRPwkDMt3uy74FQqaHnnZFERerJEl0pXhFq4=;
        b=P46EL4uyL6MLx68fX+a9U/cmcEXkdmGL0kDSQxc6SgPB0utFGDFY/QaKDi35ame9nn
         cVCywquR4GyVe94UiufwmRz8WC0CNo3Tl1PcpqBzUQI0uk0VBnDXPna8peF57DP81CpI
         YHeyEvlbtjM5OWLncjO9dr9XCsrKzqoCqK7GGszdXqmldjZPIMniLdO5W7Zg6VHVPIjb
         WPpMLA0tH2FsNrlaWUXokeST3sTeBEUjE+BDk1DzDvX9lUS7TbiAuHLos23GGZzyApmE
         ymvHqy77sMRagEgAdJbn6li4GpjMpQ+O6XUSiTEL0DCB5Ot0FAlM8OOkBep+9z80kMF1
         lAug==
X-Gm-Message-State: APuU4Z8DH8vHLHMIp6JbkrpDHyRgErm/jh59SigdmeDgsHG/b1H/KYSR
	NITJqyYmkFkq/hjvt5jbaSi82At43hkqu2QSWBkzTdByfvLttXQT6xiT
X-Gm-Gg: AZFdTZdxHU0d0Z8jPn1A95bRBzAn0h/XwnrUgNbcHp1awg+Oys6mbok3v1XHkMNYTdQ
	uc/hqLwyhoH/dzZpHYyehfu5+n3J8ZXMgLjm2qyEq9V0lFZLLeOfQZbMUc36AqRPQ/MWnhp3Oqk
	6pln8Bncyc21VlbSml7ChEh09z0xsyclvmYTVAyP2T1urbiQPYFeiQs7LEYaL7PUdTw2ahq1yPU
	C3EUcFb6qUWn4VSIOdNYoU/gxLEKoYFZ549LNRFFM8UQtJ0qIRtE2sOV4V+GQvQLLAIRiPOXtaE
	H8ZVNKtTyuAtyhs4XgTVSckwzGfEQ0gTyTHE3eMETQwxnbiOfltPLwijtf0+8yFq0eyhHRi9vM6
	q5hRoIuFcLfoRwgXrOk/706OPojMVNF6hj4Ze450P2/bdN7Ofn1cE3P3Fzq12Fkk/BJAuPe6odM
	/RINOfJzj1GOUikgZ4ohOn6EJdIPMd2btRmwKfiremSLnDdTzcj2USHikopVjQc2hnY2EQVCwO/
	vhbmWFMOlL0b0TzxfBpqsz22RQ3BCZGgUth3NphtNU2E4ay2Rb7HDfp2t46Cvzv/kylTW1275KB
	M//IcpkAdB6RQOBlj2zDUYoiNGh6Htq3/kfHeXPRuzpJpTB+8InzhKQuAW+r/J9g+FrkFbfA8hm
	eJd51wml2bwkEb3c=
X-Received: by 2002:a05:7301:1501:b0:385:1e1c:9ab5 with SMTP id 5a478bee46e88-385701527f3mr5469764eec.20.1795261047398;
        Sat, 21 Nov 2026 03:37:27 -0800 (PST)
Received: from asus-ux3405ca ([140.213.140.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm17980517eec.6.2026.11.21.03.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 03:37:27 -0800 (PST)
Date: Sat, 21 Nov 2026 18:37:21 +0700
From: Muhammad Huda Nugroho <mhudan21@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: qcom: Do not power off a PHY whose power-on
 failed
Message-ID: <20261121113721.7OL6u%mhudan21@gmail.com>
User-Agent: mail v14.9.25
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

qcom_pcie_phy_power_on() unwinds a failed phy_power_on() by calling
qcom_pcie_phy_power_off(), which walks the whole port list - including
the port that just failed, and every port the loop has not reached yet.
The phy_set_mode_ext() failure path returns without unwinding at all,
leaking the ports already powered on.

The first of those is not a leak but a refcount underflow.
phy_power_off() decrements phy->power_count unconditionally and invokes
the provider's ->power_off only at a count of 1, while phy_power_on()
invokes ->power_on only at a count of 0. Releasing a reference that was
never acquired therefore drives the count to -1, and the next
phy_power_on() returns success having silently skipped powering the PHY
up: no error, no message, just a PHY that is never initialised again.

The damage outlives the failed attempt, which is what makes it worth
fixing. On a single-port controller the very first failure is enough to
reach -1. It is normally invisible because a failed host init at probe
time is fatal anyway, but it becomes reachable as soon as anything
retries host init at runtime, as system resume does - at which point the
controller comes back with a PHY the core believes is already on.

Unwind with list_for_each_entry_continue_reverse() so that only the
ports successfully powered on are powered off, and route the
phy_set_mode_ext() failure through the same unwind. The PHY core already
releases the failed acquisition itself, so the failing port must not be
released here.

Signed-off-by: Muhammad Huda Nugroho <mhudan21@gmail.com>
---
Notes for reviewers, not for the commit message:

A structurally similar unwind fix for the tegra host bridge was declined in
August 2026 ("PCI: tegra: Unwind partial PHY ...", Pengpeng Hou) on the
grounds that a phy_power_on() failure means a broken system that an unwind
will not save. That reasoning answers a leak argument, and it is fair
against one - a PHY left powered after a fatal probe failure changes
nothing. It is not the argument here. The problem in this driver is the
opposite direction: a reference released that was never taken, leaving
power_count below zero, so the next phy_power_on() succeeds without
powering the PHY. That survives the failed attempt and breaks the next
legitimate one.

The same underflow was described by Vladimir Oltean in March 2026 while
reviewing "scsi: ufs: qcom: Drop the PHY power_count check" - "If 0, the
power_count would become negative after phy_power_off(), and a subsequent
phy_power_on() would merely bump it back to 0" - and the ufs patch was
withdrawn in favour of per-driver state tracking. This patch takes the
other available route for a consumer that must not inspect power_count:
only release what it acquired.

Against mainline master as of 2026-11-21.

Found by reading the error path, not by observing it fire. The underflow
mechanism is from the PHY core's own accounting in phy_power_on() and
phy_power_off(); no hardware reproduction of the resume case is claimed.
I would rather say so than imply a bug report I do not have.

 drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1445,16 +1445,29 @@
 	list_for_each_entry(port, &pcie->ports, list) {
 		ret = phy_set_mode_ext(port->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
 		if (ret)
-			return ret;
+			goto err_power_off;
 
 		ret = phy_power_on(port->phy);
-		if (ret) {
-			qcom_pcie_phy_power_off(pcie);
-			return ret;
-		}
+		if (ret)
+			goto err_power_off;
 	}
 
 	return 0;
+
+err_power_off:
+	/*
+	 * Only release what was actually acquired. phy_power_off() decrements
+	 * phy->power_count unconditionally and invokes the provider's callback
+	 * only at 1, while phy_power_on() invokes it only at 0, so releasing a
+	 * port whose phy_power_on() failed (or was never reached) drives the
+	 * count negative - after which the next phy_power_on() silently skips
+	 * powering the PHY up at all. The PHY core already unwinds the failed
+	 * acquisition itself.
+	 */
+	list_for_each_entry_continue_reverse(port, &pcie->ports, list)
+		phy_power_off(port->phy);
+
+	return ret;
 }
 
 static void qcom_pcie_configure_ports(struct qcom_pcie *pcie)
-- 
2.51.0
