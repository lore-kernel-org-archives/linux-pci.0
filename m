Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1523A59B1
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599600; cv=none; b=n4cPK0byPknfnggIfBn7wFCGzN4WOCAYW9QPsbim47Vbktz650jcg1b5zaUCURdbH+BCSppY1JXPplfbUUdYCwWRg1EaN8wJXpc5vi1SqyryFq7kyQ2Je+h+iyf93Zdo2TUdkPFX1VECyEVBB/dTsbJhyJkyN32pgAuGlrPkN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599600; c=relaxed/simple;
	bh=h+ptx8C/cbQHJsE3+Kk3U3Vtl4JYBPi0lsNxAoa1VMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U/LiB+MS/NNIfA1dFkm6WJAU7N/IS/9tL1i8wvKU6OSQeT+r7BWoFktP6Jv6WiN5VVYPZMVTOA8X8ZF6h3RrZMkPFFN3lb06iduC+C1xquav/qwcddr4/tTstsDnyXFlZ/z1q8wSN8bA35hnvkHky3qVT4f/NEjTOcFaJbUj3ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhB3yNfH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhB3yNfH"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec449cf976so147687466b.2
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780599597; x=1781204397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdDPcFn45o8eOdopqzCXPMjHN3/Cvgt3UFvkr3Oo5TI=;
        b=MhB3yNfHQQI/wXHLWUaW20PTQn2acuPo6ARpEy7Eux1pXxpyLKZ5NigRzdcOm4zlRH
         sM7w4wJEYTSrwrEPw1Afw/WNfbCWwyupGQSGOUw9jbwZUuYvLg2gxypPBxgX10xTY0a+
         YULwSEJ4IdAx+iEEz/i+871NbBBVPpkKfyE3wUlfSkkclktRsWMGRRgpkpzLCxd6Xxyk
         Ht3bKgdquSbUAwhaMx3cdvhAI7Gn0G1P42wQ1P3MYT0vMx0WhyYruuRXA7CbqhHDzQvo
         Km/J8LvrbIH3rMQI3KREPcZNM0HexaaHyyDfQixaHVkOKnoyI5KvWBZHpbjD7WKHMQ/o
         8/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780599597; x=1781204397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdDPcFn45o8eOdopqzCXPMjHN3/Cvgt3UFvkr3Oo5TI=;
        b=YZ3K1sz9xzEmY7IQRIWhS4GQLfoH15HTX2MgWMQ5rnqEhhwZwg62qh86lYijHOQQWv
         A8ZPytTVrL0V8X6L4oMzq/4h1vR+ozZx2fPK609e0EF1TeA98ovclIokQ+h4LeXnnrw0
         6LJUsb0/IL/arQYPbIHyhZ633578X7mHYmjmpzDu2Mx8uKV0UU5HihqrthEgH9ju1q53
         CYAIhHU1PE3ayZ0qmNG6G1aOVsOocFZFOjiAsu30Ud+wvB0wZ4UjK04bnru2F/3yBxnH
         Ybz/nfzvLvdApkrhXzWcLM23IV5zoPx6ZKCtqFyjWo8MC+bzjPPnP0Je+kovCPvW8Qgt
         ZCtQ==
X-Gm-Message-State: AOJu0YyPD1/E/FwPdSi+Z/h32iMuQuj2XKuIaui0PgfVE/+Y7J+15xr4
	W5sD3MiXOq787kDHzoFjivYdnQa4oJX1KSxSRzM1OZwRDp5dKVNAzRWw/R6EYNYQfM0=
X-Gm-Gg: Acq92OGxOVxkQNZyN/9YF0YsBw9r3zlPd1tYxCFSL4qMENNHJYH0nwTl6zpW8aVj3ZN
	/jc4HXybyYyRSonR4ofUDk5TDNQJCO9qHwOqIQnC2MNWshaEsHIjChjN4M9pHs/M//pzSJkSMJj
	HdGude+UnJROP0OsHrtnkrYaLIZhXK1lg46T8HHifA4CKTJSdjaEWFApY4Poh+uoNx1Dt83Wosh
	4ICFc1J3Afn7v31LEduPw93+0Ue8lLcPpHhjw2zljhKUPTg8IUViETzPKrIybzbTlPEk78I1iQH
	M/Q+We+7JffmiQgDi6Xa5o03DzWT9ZnWbzxcUj9tXbQuUW0nyQ/rTxHHvdGxQWWIG8J14GbX+VM
	xxcfKat+aJxN5jEDEmLfLN+76iiQc9lrXBVafzm0wuB52dJJiChL/5HxWLkY1yM17/SPCbFfNYV
	qmfpA55dqqDBEkwbEqYazkHeguWmYk9sZKBSHMre8Ra8uEG7YtKfcAKIDqslp0vGTp+es=
X-Received: by 2002:a17:907:60d3:b0:bdc:bb72:7bc7 with SMTP id a640c23a62f3a-bf0aab1b72dmr528603466b.31.1780599597207;
        Thu, 04 Jun 2026 11:59:57 -0700 (PDT)
Received: from ali-monster-pc.localdomain ([45.92.224.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05228a16csm339673466b.28.2026.06.04.11.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:59:56 -0700 (PDT)
From: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	lpieralisi@kernel.org,
	Ali Alaei <ali.alaei.tabatabaei@gmail.com>
Subject: [PATCH] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX
Date: Thu,  4 Jun 2026 20:59:53 +0200
Message-ID: <20260604185953.17177-1-ali.alaei.tabatabaei@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel Arrow Lake-HX platforms (e.g., Core Ultra 9 275HX) use VMD device
8086:ad0b, which is already in the driver's ID table. However, on these
platforms the VMCONFIG register's BUS_RESTRICT_CFG field returns 3 during
probe. vmd_get_bus_number_start() only handles values 0-2 and returns
-ENODEV for anything else, causing VMD probe to fail and leaving NVMe
drives behind the VMD controller invisible to the OS.

Handle cfg=3 the same as cfg=2 (busn_start=224).

Tested on: Acer Predator PH16-73 with Intel Core Ultra 9 275HX
           (VMD controller 0000:00:0e.0, 8086:ad0b).

Signed-off-by: Ali Alaei <ali.alaei.tabatabaei@gmail.com>
---
 drivers/pci/controller/vmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index XXXXXXX..YYYYYYY 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -649,6 +649,7 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 		case 1:
 			vmd->busn_start = 128;
 			break;
+		case 3:
 		case 2:
 			vmd->busn_start = 224;
 			break;
--
2.49.0
