Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5512F8E93
	for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792354655; cv=none; b=YH/RZtPdr5NJNhahIycTmRDnKa5vhBclEnKMHYu1SyhAs+yK8THX2N+cR4Rijo18gD4RACMhfFIXKZaoSVnlneo1BlXIDgg61bmNlugF7bSfHrN2jrE+T6X45rwB42hGvElrAXttaZ+wc3fF6DEypnygLwioziy7ZXV4GKE3KeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792354655; c=relaxed/simple;
	bh=h0DXRm71k3vl+NtLleFRx5ikpPs0npkCZ9wKj0RSkLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZVxWmVYLxssosNSythwCwcMzX4Ee7fJxxNftLF57BJJ0OMZHGOLI8NRj04CU0693xxZM0icGcGEuO5AnVJ43Ue2USixGOd4C8Jy8n6kY/KIYoCsydsUtGgvrdrKbLT67ZLWO5Lm+WXH1748Hi2vbTGRtrzAJPlA/L8BIoOTxLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZgD2rZN; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZgD2rZN"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso3886826eec.0
        for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2026 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792354652; x=1792959452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iunLl/bLZxKCNfFKAKTG5ZUc906N+A0KdQoeUczE7Io=;
        b=gZgD2rZNtL9MNQi9nXL/lAgqp4wlksaQy77JzJ9hkVqNTo/YisnEzZBtuq16swNQxM
         P2zU5opVkAJwlmFdOzxaV/7NmoFDno7yaIbwOaUdZRyPGwL10L+7wWpSGuzm73AyAuvc
         YGRH27QXaNs5BYsho6OlSXv6edFVzGGkF+XVNs7440TSAQP56LDRt5zfQMa3bpcAhEPt
         OftTPLfHdQgHZAdjQj2IZfb6buJxrPQJeeqYC+wL29JOph30UHzJ1kSWRMEDt3zUzLR5
         21rK0HXlytQSnGSxcoBUCmEK8j8Jo77WrutvRAO0mWyw98Mwlpco52Zo2MCrpW845epl
         e3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792354652; x=1792959452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iunLl/bLZxKCNfFKAKTG5ZUc906N+A0KdQoeUczE7Io=;
        b=fEtIybLRl+yle/wIrFwa6NT7EPbA+Dgy/wc+KLjgxnIcfp9qtbKphcrctbxevxvTIM
         M/zjzFUQV44zE5O2rYBbXruWPsqPzzs2lLCKefK9pv5lvKk+41UD99kozKDIIEPOBsWJ
         aV8ebcux6Sxz6G+RfyUeKys6kYzVpTgcfMAoqVVZ8cJVSohMXtwn8vRH79ZOb17UAEQr
         zpPsg5Hi7zU/HZDz76DJKLlsCndGW3pGRqTiJXO34zxhl9cyBMI3Y+kO5Gx+dYbTZEIE
         xU01oXgACJA7JYK4uo1rGvcvborhX/n0SYqQLM+9flDhRGc3zp5gtRwxhwRMNf/SmMXY
         4sSg==
X-Forwarded-Encrypted: i=1; AKwUvBw3Rl7dnj6B+x3ZDMbWhpARY0l8SfugTaoq/FzXcXtW+IGe9MnFP2BGQLuCFgat0xq91DF8Y6MgY6c=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfmVrukzs513BJPGx5Nana8KAxe6aUnIHgvZPGwtvVzCoM0hX5
	a3dPY3xmqlEFdMnSW0/TwMFi+5Fvjz3WN71liMBI562XyR0no4z2eLLx
X-Gm-Gg: AYBFou3hdG4Sv0RI2E85OajmfoBHPSOthYTsGkFQiVbAptsvKL3mI920u/3vk1Sdj07
	dgvehuhNohlePONKx0U00vfN1g+sRPHN8RD0UdP0xC+8g053xgPlDs/q8wSl0qPbxwrbQSpK+tl
	GrhXYqSgXbHtSfV+9rHOb3wAUCZjx5qWRv9WbbHP9YFWGsQ+GQOY97m2KhUZVi9ibca8+fIIzfz
	XGWjs/VnZ6xlzYjpo7h7y+RJJU9xjN8EYCafR3xOM84w7zsJzKZZdCQ0FT+1FAYPSwu4ZkJjRSl
	H0gkChOZGJw2jTyDXmyx9OrUop5H6B9OC8CNtYkx8cmiRCJjukBU1e8xQZ6zyoHO7R1KTeI/sAu
	ne6mxC0PG/QMaBTY6MsNvt6qFdDBYqYCwGF1tCQXCiMUiNjAKOPaL6HTGt517uvmmkcrd8IM9wV
	AflE+c24NKQGUk/bPP4ecAPvTXKB3M67HFEidRzqLatHQgGD2NdiHr4Ye8Ub6l/6Xu402ZBmClS
	QBa82dVFvglICPM3z5/ZlZ7LaNIRR2j5kNlmnhNPUmIM2G5WusZrs6unXoS3esOI2is5ILt+dvG
	hIgOwVTKEe63iqSVQV0gcg==
X-Received: by 2002:a05:7022:7e88:b0:153:7a27:b7d with SMTP id a92af1059eb24-18512c381a4mr12722802c88.20.1792354651787;
        Sun, 18 Oct 2026 13:17:31 -0700 (PDT)
Received: from markbook2.internal (108-204-86-179.lightspeed.sndgca.sbcglobal.net. [108.204.86.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm20791284c88.20.2026.10.18.13.17.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 13:17:31 -0700 (PDT)
From: mark-ship-it <williamwoodstock79@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Avoid bus reset on NVIDIA GB202 and GB203 GPUs
Date: Sun, 18 Oct 2026 13:17:27 -0700
Message-ID: <20261018201727.96924-1-williamwoodstock79@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVIDIA GB202 (GeForce RTX 5090, RTX PRO 6000) and GB203 (GeForce RTX
5080/5070 Ti/5070) GPUs train their link at x16 at boot, but after a
Secondary Bus Reset the link comes back at x8 and stays there until the
next cold boot.

The GPU's HD Audio function (e.g. 10de:22e9 on GB203) has no reset method,
so when both functions are assigned to a VM, vfio-pci falls back to a bus
reset at VM start and again at release, and the GPU then runs at half
width. Assigning only function 0 avoids the bus reset because the GPU
itself supports FLR, which is why the problem is usually reported as
"passing the audio function breaks x16".

Observed on an RTX 5080 (10de:2c02) behind an AMD Root Port, kernel
7.0.14, Proxmox VE host with a Windows 11 Pro guest:

  boot:                         LnkSta: Speed 32GT/s, Width x16
  echo 1 > /sys/bus/pci/devices/<root port>/reset_subordinate
                                LnkSta: Speed 32GT/s, Width x8 (downgraded)

No VM is involved in that reproduction. Stepping the link speed through
bwctrl (Gen5 -> Gen4 -> Gen5) retrains the link and the speed follows,
but the width stays at x8. With a VM started frozen (-S), the link is
already at x8 before any guest code has run, so the guest driver is not
involved.

With this patch applied, reset_method for the GPU is "flr" only, both
functions can be assigned, and the link stays at x16 Gen5 across VM
start, shutdown and restart, with the Windows guest driver working.

The same symptom has been reported with an RTX 5090 (10de:2b85) on an
AMD X870E board, where passing only function 0 was the only thing that
kept x16.

Link: https://forum.proxmox.com/threads/asus-x870e-pcie-x8-bifurcation-bug-with-rtx-5090-vfio-passthrough.178461/

Signed-off-by: mark-ship-it <williamwoodstock79@gmail.com>
---
 drivers/pci/quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1aa87a3ef..a4adcc3e7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3769,10 +3769,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, 0x22D0, quirk_no_bus_reset);
 /*
  * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
  * prevented for those affected devices.
+ *
+ * GB202 (0x2b80-0x2bbf) and GB203 (0x2c00-0x2c7f) GPUs train at x16 at
+ * boot, but after a Secondary Bus Reset the link comes back at x8 and
+ * stays there until the next cold boot; a link retrain restores the speed
+ * but not the width.  Function Level Reset does not have this problem.
  */
 static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
 {
-	if ((dev->device & 0xffc0) == 0x2340)
+	if ((dev->device & 0xffc0) == 0x2340 ||
+	    (dev->device & 0xffc0) == 0x2b80 ||
+	    (dev->device & 0xff80) == 0x2c00)
 		quirk_no_bus_reset(dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-- 
2.55.0

