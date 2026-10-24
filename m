Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792862686;
	b=wySSon3XLzkPkQ0Yz7KXg1eepDzCEK3rG/TIiQLhpuPH6RhWtskn0xi8esMIYdmvtdyX
	 /Q6XH9QQMHKEcbqnGOB1see+NKOZ8CBeHfcLorFb9pjqP5dgtKQL0bVOQ5h1ifFKzb3o0
	 rLo5wt3tSc3KRJPlDnp2KVMGDM/uHFGeut/9nvWr/xNauGMb06FFdkoLOQQQ5VCHdkiKo
	 JkLHBB7FJRq4cYsyOLiPDITTO4scn3ydyAwDMmIxTF51INKF1TOkcK/CIx709GG1yt5rI
	 6y8e/nQ+3KpJNesrpR75xqOG2crprHdgDvh2ia19Gg3JXiVIkDSyT/K72tDE4jJ15nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792862686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x7nrxvqw7BIVjKxlluiLcYREpgrFvqJvaHMxfNmrkLM=;
	b=rbrNdMdjGjeo+R5pWKed2S2M1j5TUuXoWHNoGmpeRJWgGKFkKYn7Fc8lUjHBV93CM4+V
	 CcTG1U9OnkFlAop0Im9sSg5N9Qz7pc9FuNBUrrqhm4AbYbe05cZS16lLAhOnkLd2atbmg
	 cKhDQI54qziMcvPWrCORYzPIjsnTXk2RAxy8NhG3H8ZBfht29ec8zkTxPmB7dA+apCpeY
	 j3dajwzGyfLI4XaEG0PuGoKThNplj8XfQzfr3ddcd/DvlDVUkjos6NOdgwTReqVKGeLgx
	 zXZXBWk1vpCyQTSV4qeK1TrBuGT4DyVzXagMgFlfYDFXxH+uOXoH2fWB/iTaT6nHU2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B0IOMheK;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A253606A31B
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A253606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B0IOMheK
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a208d93758so19527285e9.3
        for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792862684; x=1793467484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x7nrxvqw7BIVjKxlluiLcYREpgrFvqJvaHMxfNmrkLM=;
        b=B0IOMheKeJThOLJjE9YVnNnLE4knkhDF1KSxEAHHEFIPyfIrux6NO1XXW7Ycphaywn
         vicXEK/ohXujqc+LrTcilWa7mpUFujtikDK+oehOcYJ55ZOvxaNfKum7wrhC0CwHPubq
         FQ1V9FuQwey4q14tKOtgojzlIVpniG92Exk0//ROLd9vsNlXx4lpvlMjvQda5ybOdVq/
         U9cwslKcgVHh5rgOkgRkkSggIghMJEsZl61nmeBL/Rmoj0VlQtaRBgKueH9UAjex5886
         +4Fb1T02IPSBtRp1WCpr7y4FOELCG/3aylWnE1wsqgpuVFEFgM8yg0E+mb5+0N1LEI06
         CWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792862684; x=1793467484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x7nrxvqw7BIVjKxlluiLcYREpgrFvqJvaHMxfNmrkLM=;
        b=BT4VpPBvPfwszsCvkvNqaxzxOHXV5OzdrVowiWZRkTP7WsFC9fgOfen/CS2j6hvIpp
         4PvvLHBUPtH5EXENhIf1Ddo0gYcPRVeekSRoQtdFzz207pXnHXp5m7Q67WSHfBn2ADHG
         OlUwVmmUtKJNTrDJDkgs+BeVME0ymtf+Ba0cjOCyocs+mncQAfh1kMOdpaM6n97fKERC
         AuX3hNDfryP/10ggyoryCX3cHbSdRjHqzt4u3YbQel1sbFSgsTbtqqncoVRDXATIqfSu
         ZzKmpnFzuNmOneEIf2FYvfd9fP1/gm6wP30uVcWkGN2MZI+TqQ4ax+HCsQ00UQzD7Lfd
         x1tA==
X-Forwarded-Encrypted: i=1; AKwUvByncS2XIXgOA4HmP13kXboTjL0wfy1ztYFKL16854mRHKSzdroBmMgNtwl0DAdTGIoOG8JgbY7EqWA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLvPerB90kjoQJTWNXnWPygzuwJgHfZ+DA2CZHGZ3HiC6SDHmd
	yX5lsFMQUGOD5WyUMU1NcB9n/z9qVEdwQRpHYRMSoU2w0EBVnQrpHu4Mw2WAQw==
X-Gm-Gg: AYBFou3OBFf3XR+dgpSbl6hZal0gxBcNKhJe7wSuRHus2ZQIVz3iwDrJhVzElfP16wg
	yq9bXE3KYAD3osETtBZ3x+tar5ukZDV1xv7Xy0nhLrFKavqVTQoULCTHa/KCs24yOu7m7yRPy4h
	haPFKNIkNAg5/upJwKB2kpf0VgYOg3/v88Ku1BcF6FrhoEa8yGkMJSi7VaOU5trMDShF2mKQQga
	JzGFYRj2kCiamsPofr5/9FlCzgdkisdhf2FcvVdmRu+ABLxdwPFPQLD7Bisr9CssFccX6iRrGYO
	D5PV7RsT5knJzVVjVJfsKkOE7pgTDZp3ZWQ/OesMXq+Mb8fD0/0sFgJVxfXkUQQ2XO0b/bIyjWj
	vdyrRPNtG3onoasOc84czoQa5qjB+9gjAreTODkWHGHxClaDUItrqTW+vWUp79y090WlDTkhgu2
	4zQVKifTkFF3Mp00VdY+hj5P3f+dBg/DFKeHx9Y49vZvpnCfnz/OBKOYjJ5W9HYR3ETJBkfUCnF
	BIBCnwnxvmbmrX8wWPW1+FyJqrY5qlwgQJNPzTteWx9+wz6va520PPmZW1quKPUI60vK2enAhCj
	Sy2AhDWX7J+nwcrvyh8nYrVtwG4XEF/Yw3ejRctRXSvcBuzy3R9whJfvfKW35PdZetUBZB93dZ7
	1BsuQZLWQRXLZ4odW8bcw764QYh5VP3HuiZ9+BVgg9iDiXHl7AMMT2VQmLcMhrSw9sjsI0pFTEt
	SiS/5a
X-Received: by 2002:a05:600c:19d4:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4a35ac9114dmr35075715e9.10.1792862684213;
        Sat, 24 Oct 2026 10:24:44 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9da9-5f01-d5f0-7ecf-afa4-4bc6.310.pool.telefonica.de. [2a02:3100:9da9:5f01:d5f0:7ecf:afa4:4bc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm80685955e9.1.2026.10.24.10.24.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 10:24:43 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: quirks: Skip nv_msi_ht_cap_quirk when host bridge 00:00.0 is absent
Date: Sat, 24 Oct 2026 19:24:26 +0200
Message-Id: <20261024172426.85842-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

__nv_msi_ht_cap_quirk() runs on all PCI_VENDOR_ID_NVIDIA devices to
enable or disable HyperTransport MSI mapping relative to a host bridge
at bus 0, slot 0, function 0.

On NVIDIA Tegra SoCs (such as Tegra210 on Jetson Nano), the PCIe
controller exposes root ports at 00:01.0 and 00:02.0 with no device at
00:00.0, and the root port's HT MSI mapping capability is already
disabled (found == 1). Looking up 00:00.0 returns NULL and logs a
false-positive warning on every boot:

  pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge

Return silently when no 00:00.0 device exists on the domain, matching
nv_ht_enable_msi_mapping().

Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Observed on a Jetson Nano 4GB (Tegra210, p3450-0000) booting v7.3
(c03c1a14507d), where the Tegra PCIe controller (1003000.pcie)
enumerates the active root port at 0000:00:02.0 ([10de:0faf]) with no
0000:00:00.0 device on bus 00:

  pci 0000:00:02.0: [10de:0faf] type 01 class 0x060400 PCIe Root Port
  pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge

 drivers/pci/quirks.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1aa87a3..47778c1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3115,10 +3115,8 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
 	 */
 	host_bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
 						  PCI_DEVFN(0, 0));
-	if (host_bridge == NULL) {
-		pci_warn(dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
+	if (!host_bridge)
 		return;
-	}
 
 	pos = pci_find_ht_capability(host_bridge, HT_CAPTYPE_SLAVE);
 	if (pos != 0) {

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.39.5 (Apple Git-154)

