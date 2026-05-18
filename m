Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E082773F9
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123970; cv=none; b=Ay3ERpZwFLhofLDtAwMrhua2z+ldLZjy5jtuDOlNw3vhEPKHrWV4X0N/8wgmQEpuDdAb/Th07G1ESIkeqqOUlRd80ewtpvVBemtXW26oaH+F/1UBC1CVrgZinyOix5HvDoDBgIAqJs7maHYlltg6wdcH3cAvg2tABRfDB8e1V3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123970; c=relaxed/simple;
	bh=UPm8xixsQB7wQGT9Kt+uCcV3d45Inlm2+8TU1iEm38E=;
	h=Message-ID:From:Date:Subject:To:Cc; b=D8D39aJQFLdRcfssc+FEtzGrSdtGZXK0eI0ojhJd0i8favU1D7h1NFcVYkc4/6nhiWR4sOGjjdZTT+3npGCiJxSg0fxp0YPkwQaVvf6GOAm0sP/clYjVFmDlAh5Ak9sCqziCFtjPddUQuy/ThEMMQkHur1P4tbEcMBYM+/2Q57o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzzXkCv9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzzXkCv9"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso1042748a12.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123968; x=1779728768; darn=vger.kernel.org;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaA3ZM2Zqnd6U5xNasrJ5HhecqWu3+FpjPtc7vgz6NU=;
        b=rzzXkCv9aS7jLSddSxtMEp5lQ4EJ1M7FsAu5h3Md3fKWtk4ANPF2QQ2YNy6c1UGpNQ
         V71uwZa3Xet3WNvdia52rVTLYXIrVBTQdwt7MLTMBHrIotI+ecm6Q3hN5Wg9/gQ0Dst0
         MwLV3Kd66cYJdqONjgxkT6ivaQ+3YjKy+qLZbWTbU/Qi9inT4Gmsy6ycgUJti5ymYkRL
         bYaGzELpxLaTbWqqQVQpXhRpEP8V93BOydgnGy18z6omwlO4z8I59n0PYyURX9BJWSxg
         GYXjzMwX5LiV0oeqIIt2iAHEz4RmIpZKJHZrkl9J+D58EbYUXEF3n+r+L5zze04hFY89
         nmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123968; x=1779728768;
        h=cc:to:subject:date:from:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OaA3ZM2Zqnd6U5xNasrJ5HhecqWu3+FpjPtc7vgz6NU=;
        b=TkgV6QVPrvZuOq6AgWbJfd8ZWkS/eZetliuUKCwTN45ZwgFfEr8U/fiHl0C2WZcpRj
         122u5IoUK7I74gqm2FMgd4slde2skK+OpHg2nBL6y1RSkc5zpdmrkSjx6FEc83RH1uiZ
         iEjjQVMJyCual6we9FxWQKjUEHp6ayz/dV8Or/dCBHccn+zWg9BEYqWPNYKT79ftfMty
         coLRI4mXZ5WqpCSA2+x472s6H7hxn4jBm6osEloBo1gplC5y1R8If8U860K9MF7/xWiS
         V/ws/MyLOjV07MnpTrj2M5j2VzOeZUve5AyTKkBPdb85s9X/fhgjjE7qMxBnJvSFjrFF
         rTZw==
X-Forwarded-Encrypted: i=1; AFNElJ/341ojmPNkGLMQsOC9bEZ9z+Q6Ek7p9KmDAFoWKM/Kx5lw+v1PIMlhpfUi4uaHtRI+wKBeF5povkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwdFDRZs/p4shAZZ1PrvIevRTsSZ6JNf8QQxMxAH/AvkehM/9
	T4DHMLDh4P7i8pqAv8egobYJV30JnQCTdYWZy62ghqH+kVN9GKdxGDtW
X-Gm-Gg: Acq92OFVV/Fx5gHJ0EKajUrofcBGVOuhIcICIUi7Hwsnd4+WkA4+sYBwqPVn/h0L7JN
	yL59qEo2cUTcJf/PMbxBkcWSqb0DyfWkGACPbRzD1x0dbeVDPuQy52x9CZINd/9U8I/DGUP6tOz
	UuvIVonDq9AM6ORpfzGezZTsgDbnZc4sMGEDJvLK6vVDwrT/3UIIurOn+ku2QrzAVCn3i+3NeEW
	dXZyXwIpsZdNW3GvkrXsfG34GfNFHseOPumCBVCpA2IlnR3QiyD4YhR8mljBR9nCYhb/vUu37tC
	8ONVdOGKz5CMXZWWHMx+g7XX0AbtjZ9QObMtqmz/IPLldrm6Pg4qeV2PkMVxD2m5++k7xRlvfCI
	cuopJri6Y0LUzl0yu8UIJD9KegeVF1wW4VZr7fBUpyhQhYm1itS32XyixN4wfAJCUauCgfuJm/N
	Iig5Dp+iDS19estSFWiVInzKFIcJ+pgA09NcWi5plRj1G92ogbUSiKNBahb3gOQfK/SVtuzxsFJ
	qER1wRkS43wWfqR1Q==
X-Received: by 2002:a05:6a21:6d94:b0:3a2:dafd:3c02 with SMTP id adf61e73a8af0-3b22ea861a4mr18190165637.19.1779123968468;
        Mon, 18 May 2026 10:06:08 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([110.44.115.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7ed3fsm14932377b3a.45.2026.05.18.10.06.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2026 10:06:08 -0700 (PDT)
Message-ID: <0f97352506d8d813f70f441de4d63fcd5b7d1c3e.1779123847.git.shuvampandey1@gmail.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Mon, 18 May 2026 22:44:17 +0545
Subject: [PATCH 1/2] PCI: dwc: Guard RAS DES debugfs deinit
To: Jingoo Han <jingoohan1@gmail.com>,
    Manivannan Sadhasivam <mani@kernel.org>,
    Lorenzo Pieralisi <lpieralisi@kernel.org>,
    =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
    Bjorn Helgaas <bhelgaas@google.com>,
    Yue Wang <yue.wang@Amlogic.com>,
    Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>,
    Kevin Hilman <khilman@baylibre.com>,
    Jerome Brunet <jbrunet@baylibre.com>,
    Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
    Fan Ni <fan.ni@samsung.com>,
    Shradha Todi <shradha.t@samsung.com>,
    Hanjie Lin <hanjie.lin@amlogic.com>,
    linux-pci@vger.kernel.org,
    linux-amlogic@lists.infradead.org,
    linux-arm-kernel@lists.infradead.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

dwc_pcie_rasdes_debugfs_init() returns success when the controller has
no RAS DES capability, leaving pci->debugfs->rasdes_info unset. The
common debugfs teardown path still calls
dwc_pcie_rasdes_debugfs_deinit(), which dereferences rasdes_info
unconditionally.

Return early when no RAS DES state was allocated. In that case no RAS DES
mutex was initialized, so there is nothing to destroy.

Fixes: 4fbfa17f9a07 ("PCI: dwc: Add debugfs based Silicon Debug support for DWC")
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index d0884253b..c3671cb2f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -557,6 +557,9 @@ static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
 
+	if (!rinfo)
+		return;
+
 	mutex_destroy(&rinfo->reg_event_lock);
 }
 
-- 
2.50.1 (Apple Git-155)

