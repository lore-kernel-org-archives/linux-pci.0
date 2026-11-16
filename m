Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794862191;
	b=HOUwvJa4E4P/N2cnTnaI71/fzuKfMxsHPH0G50QVlS+T8qgl7RWEiXkSMhuuNtphBwl5
	 g3eY44gtzc8yQ7paX9mqpq2P5N1j8wC++Hq0u6i37mQsTUDbQWYGg4nZ/GZ+q593r4AfF
	 zN6JntBFeOa1xMfQblQmQJS7FoBGQZyQbtyLlIX70GrfDGkvhW8+lY4bufqcDNTsuhRq4
	 MVtEd94eJyr5WRHZ+uGeCNl9Be1KeVewdH4kJTocgOdSPrsKDrAkPtktOqbZmcnnYVIC8
	 G6POX3VahuiFVUTvTYGUXP2ER4cSFwSIyFcGMJM1ltEAnLihWqqWOPvCbQ7ilHFk/pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794862191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iuEt++c/hh8n+6PRCKFVagfSRp6hOAJBlPen/z85MFY=;
	b=wRZ7HHQx7hgtsDr5vBjIPp/HfAcpHC+HJG8hXvWC68eslTRmwFIl3gFnR+83/ETGj6cU
	 8225/SDBBcElcWax7zzKKKAoWB9nPokiTpXjerJL4xnXs2jCKo3B9vutUkHwBi6Yu4JIg
	 OuyzF6TVK3DM0Ot8t+grXE42r1sg1gnenA4lpwwrzyInV6t7AASIRjQ9q9Cz+HahSWgxR
	 iK6fEad43r2HUyi/Bs2+7s3vAcdQ6oyH5TpKMPJEUxLORrySbj/7w99mU8nVeqwiulk1u
	 o0ErASbvzqaK76V0eyeIF+Bf7jhPtH0UTLCgz4YzRJ9DHLxsVv5gClMImZDhFmicuqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPtBHnYS;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2273606A322
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 20:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2273606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YPtBHnYS
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1a8cc11ac42so3915275c88.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 12:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794862190; x=1795466990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iuEt++c/hh8n+6PRCKFVagfSRp6hOAJBlPen/z85MFY=;
        b=YPtBHnYSuugUYdqNM4KEYh0qU+k9Wb5l+wT4VLqWZ+Pt7TPkmDl0bYJLRJ841uzfYg
         /25dFJjIbSxQQCp9SUDmx+LeMNwpMSTnpDExjhtg4IxlsBqD5Qf4h+/CE4E1rbq7/42T
         mmzBbtDMzJWc3PKYgNh+EZtl8W1wskf8vw2OW+xWQyhPS0QycyT7iO0nSHxTnkx8Stz/
         o2UPVJwHrDIdIrcBPkQIXc3qWmIjcmY1Cydv/X8RwPgbbfgXerDN3xFA59yNJSsECC+8
         JDEiUKY5zVbQURHtDLGpBY9gQMAbZDRJpN0UtiO70e4utj+DfVTpzW4MpUy2Zox7occb
         BeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794862190; x=1795466990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iuEt++c/hh8n+6PRCKFVagfSRp6hOAJBlPen/z85MFY=;
        b=eiXO59aW6wxrVxmTUO61fEipTCBAhbCIRNQQ3MB87prQCOxNFBRGRtFrh3/ECqq9gV
         Xp9PV1UJiaoYLq1h3d+Rl3GdKI23SfC8RJYu3ruOe+jd0cVVnsgPhkTqZxCvTYVR/5jN
         wbafSyAUy4kCLLTv6MNKoZaEGViwId0/RpBQDHyPwNDWumhLLdJLe7JlOvcqSysMAJaH
         P0dxa+JEssKpvZf0GyshigXdt5/n31AOYFjJHNfT/rbNVDbg3/vZ4Iy1qyWjmv0seL5i
         9QH0RAEiRDa9IB4H3Jsb8PeSMpQnttTCOBO0RhpuztEhDMXmPXDlishaEOjcgyqkHv7z
         0mZA==
X-Forwarded-Encrypted: i=1; AL+hErGrRjMixu6JvtkTn3qqfXuLgyBQ6ZHLom1T4Uhu/Wv9Ea7zR+9CF4uV+26xECwzITDQ2zHcHjRcCNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eu2cJ4t3FPJQ3vf7k1gbbg4RBq8+L7Av1rb7Y6HtNRw67OCMP
	A8iXjY9hqR8JjRPwj4/f2RoXGHyPMiIujJq4eXsu40/NLpCTJ8OJyI0j
X-Gm-Gg: AYBFou1oq8ka0pVS8tN3HgEfILMS2ZKZpwYkZ82QZFwfI7WHJ/IUEnbHdsFSYw8oS9t
	l8fAAdVZIt8B5aMp58kByuXyXwt1g2+UFvBZ5UVUJQYmwoSz4eY+O+Dzs9t515AYsjRQ4r6yP40
	lVJzGi4DHqyVXw4V4zcoL9fTFgnQSwUGbjUjJFBHh2491KO+DCx/jnYpGFQhkc1/uP/X3SggwTm
	VKw8IwkatJivo5gzcCoatISdr/MlnKJPdTzrNPPETdDGYZnflG7fIwADc741E+yPuilNXJ85hZP
	mr8KrubHVRtDWG/c1es3zwor0+Fgc7S1O3HQeKq0TXmLXlCY2nMPdjofWpqps9VIcWKZLP8wORT
	OiFYXMt3DNsodu3iP4iDPlTGL5R/dYxRCZyh5ZtEbBGeIn9UeXEsVH3WK/kVFbOCcchSBZUolG8
	LDoPUk6Uvjq3EHTLqjJn92wGJENNvcFak86/npSf0c8XAUUZ/jP6+eyH9uTAaw+rEEiDo15/tJa
	I+NHEwCeQMTRunhuDc9li17yTW9t+Z4If2OyrgMok3DtXhyCNR2J/EwGEJY5h8ANoC1GI5O+YLl
	DSbyRIP+dExcETe4OS6YQmBi10zM/HzsaUOVW7WsArOMUXJA7X43D0avPgl7nRyYBqi9b/A=
X-Received: by 2002:a05:7022:b886:b0:1b3:b67e:9fcf with SMTP id a92af1059eb24-1b5030f29damr10878006c88.17.1794862189687;
        Mon, 16 Nov 2026 12:49:49 -0800 (PST)
Received: from hp-OMEN-Laptop-15-en0xxx.tailcef561.ts.net ([122.172.81.184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379553316f2sm38153829eec.9.2026.11.16.12.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:49:49 -0800 (PST)
From: Jayaraj Devaraj <jayarajdmit@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Paul Walmsley <pjw@kernel.org>,
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jayaraj Devaraj <jayarajdmit@gmail.com>
Subject: [PATCH] PCI: fu740: Check return value of clk_prepare_enable()
Date: Tue, 17 Nov 2026 02:19:22 +0530
Message-Id: <20261116204922.159384-1-jayarajdmit@gmail.com>
X-Mailer: git-send-email 2.34.1
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

fu740_pcie_host_init() ignores the return value of the second
clk_prepare_enable() call on pcie_aux, so a failure to enable the
clock is silently ignored and the controller is programmed anyway.

Check the return value and propagate the error.

Signed-off-by: Jayaraj Devaraj <jayarajdmit@gmail.com>
---
 drivers/pci/controller/dwc/pcie-fu740.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-fu740.c b/drivers/pci/controller/dwc/pcie-fu740.c
index 00ec69a09164..b2eded23b52c 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -270,7 +270,11 @@ static int fu740_pcie_host_init(struct dw_pcie_rp *pp)
 	/* Clear hold_phy_rst */
 	writel_relaxed(0x0, afp->mgmt_base + PCIEX8MGMT_APP_HOLD_PHY_RST);
 	/* Enable pcieauxclk */
-	clk_prepare_enable(afp->pcie_aux);
+	ret = clk_prepare_enable(afp->pcie_aux);
+	if (ret) {
+		dev_err(dev, "unable to re-enable pcie_aux clock\n");
+		return ret;
+	}
 	/* Set RC mode */
 	writel_relaxed(0x4, afp->mgmt_base + PCIEX8MGMT_DEVICE_TYPE);
 
-- 
2.34.1

