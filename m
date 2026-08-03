Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC37385D89
	for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785753141; cv=none; b=mwjeGd7FQVsoNqYdF2gXAu0oCCd1zh/kKHxPeJkabDpvfkHeBnnJvu0EzQreJMTrD+RUj/sR48mldCB8C/uLjsrLtYgw0UiJrscaUbUOdUfau2tWyVxIBSnR/NRXmas/Hc2+SsFW049sypdLn635Jckk3aHMpB45mEvXYdsYdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785753141; c=relaxed/simple;
	bh=kXJQnle2iy213AQWQj46cMV6D4x1j/TtR9P5Qzd56rA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdW3dF+lmlPerXumZ90zVzSh1MjWrbj4aP+snur2RvOp2wGeRB6VNh5gYY55K2t56iug8Wat+0pvMyMdTT1R4ueDCWD8GN5NN7dVZdjmrIigQh8h3gFowgsY1vNUEXgKpohzVY7XIvVTXrh09CFT/EIUcjOYqX/X8WB2mI1Z5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TiU7BJpN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=b1kuUadB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TiU7BJpN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b1kuUadB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6736DB6f3654729
	for <linux-pci@vger.kernel.org>; Mon, 3 Aug 2026 10:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SsOg8BzHaZPjVzLWezCKuNFn2YJ6/+JPUNTdZcJCf2U=; b=TiU7BJpNpXEsU/y2
	mhQjK4BU5En47PTImCEEAkJNY22Im2WfBGZQX8fxXy60Ey+O/ZD1BpvzsVcvRrG4
	hCfA2aGDHQ11mL4FdQ3PXjLLka7SpyRcFoz1c6bcgKkvqGC0AplSCkIaajpvnAXk
	6XIVevQZHrXA9y0NNqaBO3OYcC3MkleBsH9grp/jKVbpHuyd1St5mQ4CDJi8fZpy
	UdrpOccwOt+cQ6UVcH7ngtf7ldpNOzcfLDNUnnOnt3oCFyxJGXQcLXByDxSTsMgN
	9pPRSm5YE3IBIw+Hgwitij1zsFEMaSnusV4rIjCE+K13nv6viAIX+d3d0uJyRwnM
	1q5jDQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhb14cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 10:32:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so5273148a91.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2026 03:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785753138; x=1786357938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SsOg8BzHaZPjVzLWezCKuNFn2YJ6/+JPUNTdZcJCf2U=;
        b=b1kuUadBN3He0pAkStNvDTt5dvOPCxDKWPIL7QkWFQGNGHR+RBWGmkwwypI2+XuLEL
         L7g4apLsAWKJl31Sva64Cq8zCHUkA/Wwn5Y6nckeLYB0+MdpQ8dt7sNbwQxhpG9fHx1c
         DsqQH9Z0yGvkLexyDngSrxmsfArnVv75uqsoiiFKva4D+TKUs1f+3NitzD81lUmmuVfs
         NvLF/4a/v17de5LiRln0wnj1hUVFsNretVACYwCmqnBJBKFIOhMzyebgYGIrxKRlael6
         g7BhEgptI3m4h1UFgVj4dakCOe+5VteNRrKqUQsmf0yDaj2+OshLoBK0jdzckN5/LMaW
         ZyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785753138; x=1786357938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsOg8BzHaZPjVzLWezCKuNFn2YJ6/+JPUNTdZcJCf2U=;
        b=AcNBbezIbuQy3Uu+isVQoHbgePKji8Hp4VdmxGskuPq+UywgDzZtSa3ZTe7JgfZxjb
         nfzr3a0PH3bqrNcWHbD3qckY/toyc9V2bYU4HTxYKZhTxkmHkMRJXOzm08yuT6R7jVqL
         oRbJyupnbDTZY6S1+blR4dOv3HskUmiWY1HyFKTnh+RSN6YiiuhvpaJcEzqGWaI68NfQ
         h0N2orVub5TvHMo2tesRJ/+hLqiyXiSl4SB38s30aHTViyQ++EnkY7xFELxyhKuHKpSZ
         p65t2i3EESidyUV2X4LUE7+RTj3CH91ZHypmLiXOQFP+8bug7ajC2dILjpZxNPH/Q/Ph
         UIPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqJuT2wvhqXMGzKGmv85pAADvN6jWvXfi2pwlGEA7Xxermj+yLxLPfWqk+mE3RV0DHOwGaZTH+QTIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8wmd1tP/Swq/Zb2sr6mybyfKbwzRb0VcYyS46EM3nz2q2rpT
	MuAFC8K5WBzCjW6fMe9RHxYuhlWy2rif862R35e7wOPrNliXDRrYe07UzbPCIxRxvrDJ1H1x0eH
	eT4Bpdks7Pwx8P5Wjudbx6DyXBF0Dnjsjf7Gs9MSkAliWP1jX7hWIvovhjZQEEnU=
X-Gm-Gg: AR+sD112YfuoKtPO5i/EltTyoAvgNJdhwSK0XQOU2DfBmqHw4F/7BPy5cwouBYD2Ycf
	lRgufnd+ZtrvUWi7VAsRZ8zCC1s/GaFfKB0jZzIDLvvXzjYJMu14aQzxDIF5FZCaCVQ0wFX6+YA
	vKb07ehzrK0UHo0QsLlL1vCLuuG1iMoccUOSe6X9ls17RJU0vrdq7rs+E4Ex7UNZia2mN0iteMo
	gYmbyE4efwhhFyQkBCKoOefWR265aURpiRkq1c5x16Kb24nU9T5lF6zFmsndvdjz9gnXZ4PDNz/
	V4R5ByeMG+aRDzDnMjYqvp3c+mGPSj32JQaDWzolI39RAVF5qUwgC66IThcA/QpDwtNA2fE73DG
	erIwChHhlaakRCd4wgtCtAcPd3g==
X-Received: by 2002:a17:90b:2588:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38fbc530fe4mr8942870a91.24.1785753138508;
        Mon, 03 Aug 2026 03:32:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2588:b0:38e:712a:bb38 with SMTP id 98e67ed59e1d1-38fbc530fe4mr8942831a91.24.1785753138002;
        Mon, 03 Aug 2026 03:32:18 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2b1244bsm3693427a91.0.2026.08.03.03.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:32:17 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:01:47 +0530
Subject: [PATCH v2 5/5] bus: mhi: ep: Use batched read for ring caching
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-dma_multi_sg-v2-5-c12bb05e42d6@oss.qualcomm.com>
References: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
In-Reply-To: <20260803-dma_multi_sg-v2-0-c12bb05e42d6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785753106; l=3180;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=kXJQnle2iy213AQWQj46cMV6D4x1j/TtR9P5Qzd56rA=;
 b=+8Fy0NjdzuFsiqbwvScTz4Xn76n/ysFSpxfGLANQlTO8kqhW/k29GAcN9IKv825+jmOn97fT4
 OmfYqMfaJTzBIo5STgSVXs09zHTAA7nUzj1rknHfloExXKfrqI72JgI
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-ORIG-GUID: 3HjvvyzBJ4bYU7QKT13MJqwEDOX8wKbX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA5NCBTYWx0ZWRfXzFaHiVUs/1n8
 M6pK1p5qLCQ76E4O4KXgMX5FEXd/bl7vk6xu52YTeXtjnj4fX4uZ1ihOW+PzCn7pOJs85c7viFo
 ZCUZZ1h63XEeXMUj6BKlpTNJiIsCS0A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA5NCBTYWx0ZWRfX6AmB1nhQxHsF
 Dq0+9lhN5RJPk6Yht514DxSrx2XE9eEicbCWTGPj/ufJD0y7s399NggKCXWJsyFyrQ5XvjxLwT+
 28XZJPutDKf+BgjVpzRbW6UzbpeYVBuC1SEgJwDGmnLAgIoYD7OjpGE8xrw2yWpaCPmtakROieA
 pWMaoCFBfqG4ysvblMq8Hb4ZWr9etMRqr1PJOTTN7dcLiyQlrySl0n3WvdtxzOpDWR3YPtvaooo
 szMRet7N93twPZ6QC1X9x1Rv41WgnRdSTz9gg5KJwUvwQSIGx5SZz20KeB4yPnCGpWrGmZOx7If
 3wHy8NeJB06mRYimlDm61AaqJ4HN8lyVi+4riET4JBHzkCeU3BIOhdoZrjXCZTggU9fn/jDLchC
 rLMpIKqNZ89hZ/+a8EX5j8+KQ2LMmBwqffWagwDZCRO9IC/f1QqyzB01lA/BuLu5nr54SQge35I
 yRGt0bj8zQtc9iR/K3Q==
X-Proofpoint-GUID: 3HjvvyzBJ4bYU7QKT13MJqwEDOX8wKbX
X-Authority-Analysis: v=2.4 cv=bKEm5v+Z c=1 sm=1 tr=0 ts=6a706e33 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=O-L2LWsoD7DDJCLd4zEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030094

Optimise ring caching in __mhi_ep_cache_ring().
For the non-wraparound case, use read_sync(); for the wraparound case
where ring data spans two non-contiguous host memory regions, both the
tail portion (start -> ring_size) and head portion (0 -> end) are
submitted using the new read_batch() API in a single operation.
On DMA-capable platforms this transfers both segments in one DMA
transaction.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/bus/mhi/ep/ring.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index 405ce16c02a89ea2268ea1033ff5c1c26b1c81bd..a369c1eb0c0b849d7ced01b99898ca461cf680b9 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -30,7 +30,6 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct mhi_ep_buf_info buf_info = {};
 	size_t start;
 	int ret;
 
@@ -44,6 +43,8 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 
 	start = ring->wr_offset;
 	if (start < end) {
+		struct mhi_ep_buf_info buf_info = {};
+
 		buf_info.size = (end - start) * sizeof(struct mhi_ring_element);
 		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
 		buf_info.dev_addr = &ring->ring_cache[start];
@@ -51,27 +52,30 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
 		if (ret)
 			return ret;
+
+		dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end,
+			buf_info.size);
 	} else {
-		buf_info.size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
-		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
-		buf_info.dev_addr = &ring->ring_cache[start];
+		struct mhi_ep_buf_info buf_info[2] = {};
+		u32 count = 1;
 
-		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
-		if (ret)
-			return ret;
+		buf_info[0].size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
+		buf_info[0].host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
+		buf_info[0].dev_addr = &ring->ring_cache[start];
 
 		if (end) {
-			buf_info.host_addr = ring->rbase;
-			buf_info.dev_addr = &ring->ring_cache[0];
-			buf_info.size = end * sizeof(struct mhi_ring_element);
-
-			ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
-			if (ret)
-				return ret;
+			buf_info[1].size = end * sizeof(struct mhi_ring_element);
+			buf_info[1].host_addr = ring->rbase;
+			buf_info[1].dev_addr = &ring->ring_cache[0];
+			count = 2;
 		}
-	}
+		ret = mhi_cntrl->read_batch(mhi_cntrl, buf_info, count);
+		if (ret)
+			return ret;
 
-	dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, buf_info.size);
+		dev_dbg(dev, "Cached ring (batched): start %zu end %zu tail_size %zu head_size %zu count %u\n",
+			start, end, buf_info[0].size, end ? buf_info[1].size : 0, count);
+	}
 
 	return 0;
 }

-- 
2.34.1

