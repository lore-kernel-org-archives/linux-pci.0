Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994672;
	b=S+iZBDBubLdl4BpnV6an0CIiQQ6CUv5Gw5J5NY5EPONcmKm7uo3c05IsXHxnNt3MSXkG
	 1X0Eh1413mY9XGqj5CCjqnmWH7xF12JLspiLOfjedRyv7qPcYNM4QsrG/63KWpcEgmDNh
	 Bg/2zLehZoTTkWvltGaN7CG52K6lO62idkmqDe+EjJW2NyDR1XDHlICyK6G8CY0+noYEp
	 dZRsFTSYfeG1Sg4+Uzy7Rd8CdUUehInC4/Rzh+k1jU4HjdpdFSTPWN54I3MXyeTMc0xK+
	 4nCG2hm+20vxK+eDrNGypg7abpxE5+Rl4KuO+PgOOcfO9fIVXXPR5MZA4rQtmW1quDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=A/VDrnF8rEM8ik2qBI8UieOOtJ2qpXz9Tme8jmSivy4=;
	b=s0eGU3eAiBRIzZD0nvG6ECEl8AUHK/76XOHTbVjk7V0oL/zRd7Th4iT0u8JVzA3riCWC
	 8P45Sv133TxzlMkZeGlTpRoSnv7IQTVmD71lW7gSk2Lv/lmwftk/HzcjCcjb3wXa2awFl
	 Bcf5xVbiOCs0DYhS9R3EH9FihQ3En9BL4EXexU5V09yu2nZb/+fbTHymcmxgE6jaKg6GA
	 JZFD0KRGN0D07Ty/EHwBSys2oWOgcYDX+ofKOrSBpPnVNZu49cIcvtqfY4G423sNOVzna
	 2zlnIJ3ZdNGBQUiM+gIG9Y9qCDjkiQ/Oi6pEeCLw9wHjf0VyHmukEFuwEHBd1yVFigA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sx3up4GN;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52824606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 09:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52824606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sx3up4GN
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1157881eec.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 01:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794994671; x=1795599471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/VDrnF8rEM8ik2qBI8UieOOtJ2qpXz9Tme8jmSivy4=;
        b=sx3up4GNHY4PV5rpOWK47NqZzOdor01MkE+cmqVk5CeWHjoo9GXylbdQA+Q5hFY17F
         hbtsAlxm7oNEClUH2xh3iFQevvMmES3ILQTPcUCAIxKZSxqr5i5uv0RhmRCz84MQH/Zk
         t9Y063SLDopdZ78m2xHXJmSmd73V339XkkfHqrX6ibsnOYD9ygTxqbYXzSlpar6FKniR
         9m/1y6lV9VfNeGLLVayMyJh7nxtzTcIUuJOxWOYHf8GWfhW4JAkA+VD2kx06uQs8O2a1
         GwZ1hoCqbFRIIwySi3viwLEhjRmMHYwYdJ2PNE3s02PZTTuz3juyL3ZtHLsj6qawoNWE
         +BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994671; x=1795599471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/VDrnF8rEM8ik2qBI8UieOOtJ2qpXz9Tme8jmSivy4=;
        b=11lnlXSVK1KRCt6JNNk1aFNar/oCZD8VNqP+l3zI1p9AyNm/RITk3GQpATftRk+uvn
         1aBPKPNJVPtZuhGEgWugK5F8q9nryfyf8ayXFcqXQRjB9dXwW7N1HN08VwC/3rFxBRNP
         0KRWDCJvcvbY7pY+dxvmqFfrUu/gUV0hoU1QIWtm4ss/nwWOEAGOp2N4bXyE1gIGnM5V
         sgzzpKoQFmvofwtdryblSmHYysLRNIvcd3f7br7eNA8AypGoGalBNu1KK0WFdB2r/Fcu
         LawHW2E7quwj9jOLs43xFmVC6CNMs8trxpvs8eAjkUMY/5DkzltV8DJlSgKdWVfOacQk
         aaiw==
X-Forwarded-Encrypted: i=1; AL+hErG6hhaauxozvoB3n8nzFiqhpDlDn/zzQPYkjEca7vXwryObTzdw6ia6NiL8qmn/GiEWB6jMv3x2G+E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+lJYiBXykvmoFseyuOLlHg1fuXN5CJ2ODLb3RJAd0Gt0PF7jOu
	XAqK5QLPfubZRlI24BQ1N8skVlDmlqzrUw/WHCaUH9C+L24xiv4R60iZ
X-Gm-Gg: AZFdTZd4F0ZxV6i8XU7TNNYAeet4lDDgL7Q1nvmf9SsWljXP79x6+qDBgzKCgb0NcXF
	tB2UgyFF2EIHpp6m1EX2Bd7jlUyHJ/Zz8DhHhZVyyDg/UD/5CRVwRh4r5X+sEHFLUkkvrYT+v6f
	GkHyh016ZSBoB9vCDBuvQE9ETgYmnczIXqg3HG23vRb2Uya+W9W95IN1xcabdphnvnj8usCFtwU
	RQruKC1GqLAhqNN32mzZXyvyPeg4gxdQf122Oo6Pe+QPlGJ8MDv+9K0sJIMDBLl/ljMY4hRYx6Q
	owYmYzh4qgn77407HGzYNz5iESujP9f+bZKsZdBbcVn4lYayFY54Fys1yfBakMjiR+/l0Dwl+x2
	i1ikzQmLgKphyDykXNl76UvLhcCdYnqaBvAxrm8/BMEque37t0gNKvu1oH/p5pOQ2pmA01rTQYk
	m/TmXarvYmT9zBBKPS3DT9rLKYlOGr164/Nk8p14JAmXnb+yyW+tm1R/i29b7RI94TTr74kTHGG
	yWiPzcw8TarL9zrJRTA06HUFD5pOUrVCGvC+XUN04ZXy/KqCpB8VEsI61+aGlqJq6XuK0nvbRrf
	86KZU2XEOq8Jb6tlaX5/K+z13QqNnyFEYk8A
X-Received: by 2002:a05:7300:6a90:b0:36c:dbac:705d with SMTP id 5a478bee46e88-382815247a2mr1735354eec.15.1794994671297;
        Wed, 18 Nov 2026 01:37:51 -0800 (PST)
Received: from Zoro.lan ([2409:4090:2022:b216:787d:f4f4:944d:f4ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a76d70fasm6353460eec.22.2026.11.18.01.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:37:50 -0800 (PST)
From: Vishal Satle <vishalsatleit24@gmail.com>
To: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vishal Satle <vishalsatleit24@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: mobiveil: Drop unnecessary msi-parent check in ls_g4_pcie_probe()
Date: Wed, 18 Nov 2026 15:07:31 +0530
Message-ID: <20261118093731.43980-1-vishalsatleit24@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027094427.143733-1-vishalsatleit24@gmail.com>
References: <20261027094427.143733-1-vishalsatleit24@gmail.com>
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

ls_g4_pcie_probe() calls of_parse_phandle(np, "msi-parent", 0) solely as
a boolean existence check without releasing the returned device_node via
of_node_put(), leaking a reference count on probe.

Instead of keeping the check with of_node_put(), drop the check
altogether. The driver does not use the phandle directly (the irqchip
layer handles it), other PCI controller drivers do not enforce this
check, and without "msi-parent" INTx still works even though MSIs will
not, so probing does not need to fail.

Also remove the now-unused local variable np.

Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vishal Satle <vishalsatleit24@gmail.com>
---
Changes in v2:
- Drop the msi-parent check and the now-unused np variable altogether
  instead of adding of_node_put(), as suggested by Manivannan.
- Link to v1: https://lore.kernel.org/all/20261027094427.143733-1-vishalsatleit24@gmail.com/

 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 4919b27ea..f31be6327 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -198,14 +198,8 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct mobiveil_pcie *mv_pci;
 	struct ls_g4_pcie *pcie;
-	struct device_node *np = dev->of_node;
 	int ret;
 
-	if (!of_parse_phandle(np, "msi-parent", 0)) {
-		dev_err(dev, "Failed to find msi-parent\n");
-		return -EINVAL;
-	}
-
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!bridge)
 		return -ENOMEM;
-- 
2.53.0

