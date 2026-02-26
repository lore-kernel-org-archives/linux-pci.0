Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12813876A5
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088223; cv=none; b=nVuwjHYYUvJWzivmjiijH3Dkhg6FNwE1VGMt57J+bN6vEkB1j/0TbSSprJKNi1DI935OgrUNwf4jLAtUyZ6SQD0IoHw/hVfJwQ7HCV99p6vFmo6j/SZtKaJAtKeMlUTd/nXQD/9dXJS2U9Wp8KA+vHrFitLa+GCsGXReCYDAgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088223; c=relaxed/simple;
	bh=FufQji+7Ewrr7vcq8PkZtbwA3C6p0/81Ayvn998N2Fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JN6HzXUi5WF2fGL//HfUGf9yVM00XqpzcFwQvSgZQGjrqbIZNrIgMw7ZhY0+fcxZfmRJyDgTLfNe/ao9VV0Y10PO9wBceegn4wgpQ1Rd8tiqI7/WGtqlewypHS2lbyRfNdUQYPkTJ2SJkfuugyV3PdRlHwOfr3KwqBtLqs+Ocus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35851eadc17so256889a91.2
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772088221; x=1772693021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+gS9rzm17IOsOjXDE1pbAIlvnilZzxzhAM4Cjn+O+I=;
        b=jPCxb0K+qJ6EM5qjwRj2XGTaS5z07i1LYDf6dLg9KZfmgGRTXn3bsQDR+0edZyqWP8
         9bJNElj5rDQcwOHqmFNf7An40PocPytPxDrUJzDOfu/nfuHAEQwT7LJDnlZG5d6LfdRJ
         XWGKhvF6odrKCflrrtO5Fxoglbyhe/44icY6nEWpIvRjYhBLA87l8DqIY1JlP/sU1sQX
         GmYNHyUOSBPDqSLbt5Gwmy8iEzUpsCqv82obnj3JW9hUZk4eLau/6uAUfAi0kDFcNTXX
         oqBu90GWehpSVXjnTBmyGCARbAPlGW4ukde4tKLKPZ1DWKYGcrVMoRajt7i4U/k0s/Fq
         k9ig==
X-Gm-Message-State: AOJu0Yz1W+Gy2XNeW70ltBOx+6bIJcm/P1jVqFRd3fn1iKgNBp1HMQRN
	PuxxAq2WITasbD1AXT4wQv9CaAY+ovHBgeAzylZG6ims+3MEwCGqooRy
X-Gm-Gg: ATEYQzyR0yT+73SD71yMP9mohAUZQsu+cyg7ik9E9xMfPFLrESBTSpf/TUeg4lkLirc
	mi18V/gE3NU84i4zR2e08zuI8PIulXG+rtDEVTmlG/LEDqfigaN6Cu9xt+bUqmrvKr/SlpSoS6J
	yaQmYq/p/qbMVPl6GlXrT+dLzcnURyGYrhvhu3eCl3KXUQmQ+fcxhnLfWI58rX5bHtJJ0aomNLP
	7oYdDQzJi/NBwt28raT14FuyYGzTM8BInck+DyAULDeUNI83tQ1JOeqKu7o/AfWFnWRWrRo/KH+
	Yd3mmKSsekljK63U+0cEScAzMgHZYOmlvOXs5TEvMHPvZaCIQbfpZREedKJSPN0LbfBJUhG/9W6
	7za1DXZBqjIPkU1v3xl01M0Eb2UcKCWz5XG0jiZQi0J76ddnkkB00mn4+JFCL2aSlp3vT4djn+a
	ImuqtoTkwrAqXgr8c8OsLHC3Y/N28+zruk1fewE4OQe6RMpS1Ljg==
X-Received: by 2002:a17:90b:1dc8:b0:354:a608:30a2 with SMTP id 98e67ed59e1d1-358aea0818bmr15837823a91.35.1772088221270;
        Wed, 25 Feb 2026 22:43:41 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcad6ddsm1040973a91.1.2026.02.25.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:43:40 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	Hongyu Xie <xiehongyu1@kylinos.cn>
Subject: [PATCH v2] PCI: replace msleep to save waiting time
Date: Thu, 26 Feb 2026 14:43:33 +0800
Message-Id: <20260226064333.538857-1-xiehongyu1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a arm64 platform, there is a 10~11ms gap during PCI bus scan(last two
line below, between 0000:01:00.0 and 0000:02:00.0):
[    0.078871] pci_bus 0000:00: root bus resource [mem 0x58000000-0x7fffffff window]
[    0.078873] pci_bus 0000:00: root bus resource [mem 0x1000000000-0x1fffffffff window]
[    0.078875] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    0.078877] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.078888] pci 0000:00:00.0: [1db7:dc01] type 01 class 0x060400
[    0.078895] pci 0000:00:00.0: reg 0x38: [mem 0xfff00000-0xffffffff pref]
[    0.078914] pci 0000:00:00.0: supports D1
[    0.078916] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    0.078979] pci 0000:00:01.0: [1db7:dc01] type 01 class 0x060400
[    0.078984] pci 0000:00:01.0: reg 0x10: [mem 0x1000000000-0x10000fffff 64bit pref]
[    0.079001] pci 0000:00:01.0: supports D1 D2
[    0.079003] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.079073] pci 0000:01:00.0: [1e49:1101] type 00 class 0x010802
[    0.079086] pci 0000:01:00.0: reg 0x10: [mem 0x58100000-0x58103fff 64bit]
[    0.079201] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:00.0 (capable ojjf 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    0.091501] pci 0000:02:00.0: [10ec:b852] type 00 class 0x028000

In pcie_wait_for_link_status(), using msleep(1) to wait for link status
change.
But msleep(1) can sleep for nearly 5ms.

ftrace shows:
 0)               |                pcie_wait_for_link_status() {
 0)   0.500 us    |                  pcie_capability_read_word();
 0)   0.580 us    |                  pcie_capability_read_word();
 0) * 10292.26 us |                }

 after changing to usleep_range().
 ftrace shows:

 0)               |                pcie_wait_for_link_status() {
 0)   0.320 us    |                  pcie_capability_read_word();
 0)   0.480 us    |                  pcie_capability_read_word();
 0) # 2483.980 us |                }

 After changing to usleep_range(), the time gap is gone:
 ...
[    0.076763] PCI host bridge to bus 0000:00
[    0.076766] pci_bus 0000:00: root bus resource [mem 0x58000000-0x7fffffff window]
[    0.076768] pci_bus 0000:00: root bus resource [mem 0x1000000000-0x1fffffffff window]
[    0.076770] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    0.076772] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.076783] pci 0000:00:00.0: [1db7:dc01] type 01 class 0x060400
[    0.076791] pci 0000:00:00.0: reg 0x38: [mem 0xfff00000-0xffffffff pref]
[    0.076811] pci 0000:00:00.0: supports D1
[    0.076813] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    0.076874] pci 0000:00:01.0: [1db7:dc01] type 01 class 0x060400
[    0.076880] pci 0000:00:01.0: reg 0x10: [mem 0x1000000000-0x10000fffff 64bit pref]
[    0.076897] pci 0000:00:01.0: supports D1 D2
[    0.076898] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.076969] pci 0000:01:00.0: [1e49:1101] type 00 class 0x010802
[    0.076982] pci 0000:01:00.0: reg 0x10: [mem 0x58100000-0x58103fff 64bit]
[    0.077098] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x4 link at 0000:00:00.0 (capable of 63.012 Gb/s with 16.0 GT/s PCIe x4 link)
[    0.078281] pci 0000:02:00.0: [10ec:b852] type 00 class 0x028000

To speed up booting, replace msleep() by using fsleep() (more generic
then usleep_range()).

Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
---

v2->v1:
1, add booting log
2, change usleep_range to fsleep

 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f3244630bfd0..15fd15f24df3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4519,7 +4519,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
-		msleep(1);
+		fsleep(1000);
 	} while (time_before(jiffies, end_jiffies));
 
 	return -ETIMEDOUT;
-- 
2.25.1

