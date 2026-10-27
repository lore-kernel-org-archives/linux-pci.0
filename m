Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094280;
	b=Jvz9LBgqtYF20TW2p7muGcTMEbX6nQwmC9qKbopdO89DOKdrQjKjjNxiteyKXFbGRqYe
	 NSueY6c+r62pV8sUrZStJ/puA+hNiYxvPJ4ytJQBzEVr1MzwfRVttvfCZoqlWrGOEyO+m
	 EZ6R5Ryo1zzDX/t/GYTy3AK6/0+OJuqwd5gDwPJGqJ3Ck31jSt2UlPZ2mvnMgmb+X1Hfk
	 BYveMlU6Wkk+dbyvehwmukhVmCyA/XSkBelJ6sCA2U1TBKxCO8tg7mE1Zje4eX8/Ecfdm
	 /yw0ZyHkKa2Uc8yv4BkTHXJHRxTxtw6LDVgqLp9srJLm77HME0nvnQxO22h0gst+U5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6hl/Nai93S8NAs/Tww+fCBXzZpo040uYm7bnamGWTrs=;
	b=PLzHhUN/UdcDruFh6etRpjbfFHqmQxE6J2I5bcCFdUZbyRfHMPHhgXzKPpk5VxfKJRBs
	 PtUKB1XMUvxqnblONG/20Y2q8r7HzqTA4h95G8qF2GfkJyYBWnDJJ7S4pNBywsXfXboJu
	 u3RDoBKG+qizTJjGWMGQ1ZkisXB4d2pPlbJcyEdrWNCnQg7FZsfhe92fVQyE+E/QjoRha
	 khsFrN7yaGqz0MH0iy5TU8yW1zB/7+4Hy7ym2gaSvs1kYPK9jkeicuDvsbkL7ZqcZg75B
	 tL6LFLdcyrb5TvZhtWTzGfmc9EQ1E0F/jphVV0XCrxfA33p+3MRTC4pc90vpdCPgMzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T566VoMV;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36F606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 09:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC36F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T566VoMV
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a1947498bso310826eec.1
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 02:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793094279; x=1793699079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hl/Nai93S8NAs/Tww+fCBXzZpo040uYm7bnamGWTrs=;
        b=T566VoMVoI8gPHc3pBnX86446rdqho7Ga58ELgz7gtGP86o8Gqxt9sSR8VUqcybwST
         +7Y2CMSLBZ1YaQzOuVYNJ2ODg0iTOhhk2/U/j9lVblNgM6du7jmTpKemVDs6qrXzRP0q
         eMbHC+bX7ZmhqOZGhdPFx9qJiMWZaQcigFsttzAmlRlvRP74wIDlk5yeEdNAd6ILDbgV
         8x+hmTHkWIbuMBgFEsFHBUyZgQ7OjjxcUrt27px/+rReaxgQQnKjD6nv9h6W8g92ziYF
         Qrq4Tzre1y2Wh4IObTkQJnRbZx2rmUOR+NiIt6FscI55phaHbi9SblZIfB+GPxydaFeU
         k0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094279; x=1793699079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hl/Nai93S8NAs/Tww+fCBXzZpo040uYm7bnamGWTrs=;
        b=zGEE8AwJge6sxcd/BGdtrx4HobcI1OxQ5VWdw+Qpx8YJS7cJIvKygjoMsB5oPu1FH/
         5Rxe4TohGekVC45sjiyGQGETWFEqW9EJA7hVRvVPBku2372yifElEMOuM+tOAY+YTvkB
         1b1Z6zZiJP3RhPsulQzFJh7VGbbNnfyHZRs4QSu3c17tBNr3RkekBcbdzL3DMvORBpYE
         pV3Z7vs0VKgfNi6cS2xotbWBylaY8zwudS3/VmelocCHRmxbKxz8+UwFZy0sS8xQlAZ+
         Xv8iBYZaTPlOAle1fRBBJFPF8rwZAd9GgvryesxaAsgWT+P4hntL+ARWgTy+O5o6oiWc
         dovA==
X-Forwarded-Encrypted: i=1; AKwUvBzIOZgRT3T6yUlbrVlRb668u9K9zvM8dbMSnB1wDhAoPHWXz99Axn6DfZ8j7yY2TWMLPY/0UsQBqKM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVQe1Zb2oYAXXKmAH48omeeNyKCQhiym5VKokMppO5NeX/1DIg
	S6Sf1FacPQSbzxCVybKsTEFH1mllW9DGRj6rP2uOjImmS+gejFbCEKXK
X-Gm-Gg: AYBFou1HRcCVzVlKmt3WYoHu8hWvrD2HnS84tmC3oKE7GhvK1auefJkviGtiWHKx4vm
	mJ9p4Mp27KopXSJjt7OS3rSV8QCxW1rKdsAth+onSCLEzZUHRzfL/+5zSsjJ5p8Q5SAB+CdmmPJ
	wG7ecH9+oyBm11aEm4tfeI0rvtEf4vNRmwN8gLwgHA4PMYcHZqomcWw6XTxfjg8N94ekcPr5jTm
	0JvoouToh7CLec/qF9lLP9/6kicaLLN+oTMXKyvZ02EYJpTUWrpCUx+Vbu6oFL4/Wiz4W+p7M/C
	PmVEP3Xrkq6TQfTZ4fqho/00FXSpPjEeP/p6Ftd0Rv2hWJhcff2Vyai1LwEyirjViLoIM7fv9j1
	Q3RBt9fz4orVeEaPkWcFvmTTVzHReM7KhvL3QGVlAlc9TW2S/fX+G7SSJNDaHDgpXPP2Tm2ee0R
	EPLSd3SMNS5BhtCXeQP11BDrW+5Ef7DqzRkzzfcnKAoVG6ysZPcjc4p2oDAI/WmEKXy49xajHAb
	SGeIOLSwnkpmWMrgP8nqEv/b5cz1Fy7foQrr/x8KOQ8gORj/htJr7ZbW/X/oxM2XZa2EAzyp0nT
	35jP0QzF9w==
X-Received: by 2002:a05:7301:7d01:b0:366:c497:610c with SMTP id 5a478bee46e88-369e8610133mr12065401eec.33.1793094278730;
        Tue, 27 Oct 2026 02:44:38 -0700 (PDT)
Received: from Zoro.lan ([2409:4090:2022:b00e:72eb:d31b:8aa6:1b54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm60252926eec.23.2026.10.27.02.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:44:38 -0700 (PDT)
From: Vishal Satle <vishalsatleit24@gmail.com>
To: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vishal Satle <vishalsatleit24@gmail.com>
Subject: [PATCH] PCI: mobiveil: Fix device_node leak in ls_g4_pcie_probe()
Date: Tue, 27 Oct 2026 15:14:27 +0530
Message-ID: <20261027094427.143733-1-vishalsatleit24@gmail.com>
X-Mailer: git-send-email 2.53.0
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

ls_g4_pcie_probe() calls of_parse_phandle() to verify the presence of
the "msi-parent" device node. of_parse_phandle() increments the reference
count of the returned device_node.

Because the return value was evaluated directly as a boolean condition,
the acquired reference was never released, leaking the MSI controller node
reference count on probe.

Assign the resolved node to a local variable and call of_node_put() once
the existence check is complete.

Cc: stable@vger.kernel.org

Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
---
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 4919b27ea..5b1862fe0 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -199,12 +199,15 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
 	struct mobiveil_pcie *mv_pci;
 	struct ls_g4_pcie *pcie;
 	struct device_node *np = dev->of_node;
+	struct device_node *msi_node;
 	int ret;
 
-	if (!of_parse_phandle(np, "msi-parent", 0)) {
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
 		dev_err(dev, "Failed to find msi-parent\n");
 		return -EINVAL;
 	}
+	of_node_put(msi_node);
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
-- 
2.53.0

