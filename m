Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831F434D3BF
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384593; cv=none; b=t7IDVXWImIHq4B3hbzN3T6PRt1ZZdHJoEZCdPVeF8N88w3rKXvjVoxV6JLi5DUVEr2SXwtN35HgtI0Dwucx0OuiaJN2FTD6u7JTdpPKzadNqU76p7kA3PeSizBGc/JpJdQn8HpyHJ0yQXuMMIMGb9NV/5/sDzu0Zz1qFoMP1W2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384593; c=relaxed/simple;
	bh=1MnAcOLx4PCMb5gcpoEh/1Z1hW023S7M6GRMHHtlKLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hz9zffNm0bwQAVRZqvauL4pGhXLAq7Ej4NUfbpmjQ9RqxRQle2kjYnJR4VZBGZ0CyCdMgdHfmfFvkI+zQiEku1n+yU45m3hjGoJR8br6iNUdvOxQ16m/12DCaj6I4hvj/OlfbFxC//wIWtJGusZ1Wp8Vy7VApavsaAaOxmAg+Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/60IyaF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CG3Tz/jK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/60IyaF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CG3Tz/jK"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5tYkw3229721
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 06:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RxmfRvfiRh5EUIJOf3+nb5lHp4eC5Rxoat19w1qMQgw=; b=B/60IyaFTEQblyBL
	IWqXfMOW93sgSJnlSuyg8UJQUHGrkISHXzwsiqxVLeyqfowDemIZguR6K5OCUk06
	yAcyBmXo9jnhy6rifmSpzLnd1SMw8PB5IzUndIT6BblqZ8QgcjD9D60qrp33TD9r
	F0bFhL19SmdQOHHywN19FycNWVG2oQWFuM75HfuYT2t9mr4LZp/m1uYM1jfRQ06j
	Tu0BmG3PElLOiz3D9jLQyd6Kqp+cQdSlIQTngs2GUGHda0/38Y/6y1+Sym+v1R+S
	ascgmSwQKDaJjKegdOYATATjrVyO/p97n4Ed+IBcOfQNmbXw+z+X3aAkfZ3m+1o9
	LOrTYA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cv8n7gwmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 06:49:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aad5fec175so85801295ad.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 23:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773384590; x=1773989390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxmfRvfiRh5EUIJOf3+nb5lHp4eC5Rxoat19w1qMQgw=;
        b=CG3Tz/jKMdelq4t5HeO5dTpyzC74l01FlHPuxFSdmgTkuvdjjSuXcMVaWdVxNkB+Y4
         atlfzItjzTMiATWke27yFoS7C1a587UiiA3N51xyYGUhhLN79qpPw1b9C2C/s/uOynu9
         8gwFw4ct4H+gbJDZeKS7AWAycCzKPsSpE5m1RFAsVjtPtQHOwqL+IwAWpk4GkkzLOc9P
         iW9NxMpUjQOrqA6I4KBRksNERvAW5YtpOpBUIZpbfCPxAeyecaMId77GlyvObuS2BMAh
         jytnN8T7mPVHTh2cutf63a6k9LoJTWO9TEobhQR+GTApWh7VAXRGYjycX/ejqqMeayVM
         XbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384590; x=1773989390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RxmfRvfiRh5EUIJOf3+nb5lHp4eC5Rxoat19w1qMQgw=;
        b=MA5Eox643Cl028QedguVYwTWcW9yqxl9+XNN1SqELAd1QPKICjypn+TrrV9Sm4nR1j
         Z6pBS4+lodH+TtglvXj6ir/wYWmdUDW78iZmD6vnzRGtrND1gMa2dsUFPQlBFNPnLtyx
         WKguh+cCgxGrkXkImif2bXNjERjUg0gNV8UeS98x1hZl41vddkOEfuzQm1M2J0wYJBOM
         cAoCFVeKl0K2e150M+/G/kS1elasxdHZpmKQxEfiYBPbVvBOdES+P6O8ree/UDJGCJW7
         KQKYFLu6p4kfcqzKjjKkvx01eWJdJ3CNRkbHye8w7wBHtLYN2E+/8MephV6mXMQ7Vung
         J+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXsUhsz86mCKypjKLaqkVmqbFGej2krt0twZr0ja2hmPfvLL++/gVaZCtr2tfKtc0KX2n4CGuRbQrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiImKKMnmE+k1lIbOxf+oOPk1++qDkc0Ah75qv+KSF8PSFuJP
	bS9/9Ey8hMk/Ha98RYn+YCxF8J94g23iDhM9HPYt4tdHENGH9QrVtczDOgOiCw4ORUH0EVTpnej
	U5Zl9A/j5SOb5OsJx+xY9p0GpHhXQw/L4Yie1ZqXGognPWUE686ML8TmbwSaspGE=
X-Gm-Gg: ATEYQzw9Usch8LdsAAyqcI5HlvdnmVEGO5bikh9D7clDdft9Ik+V6MJl4GAN8hCYfe7
	V5PqAmLwhjiePpnItqgkMcJpxGW4pglb3Y9shO6VFo/r0Dd1T1FTgUxYBwGn2RWOCDB212MNN5f
	HS1w2Q1in0V5o28akjeUm5V4AeWv+WgT4mv1Gn46aBxvfOmLwk7g8FY0YQHFPJaym46sdMWsl+K
	fF3hr71JkAUPiOngFPzc9hR44HiVfah03BsvjMJlJzyGKskH4XkkrqRqj0znsN4ef16U+EFu0b6
	24QZSDU4z0AtaYtPWC2T5Csq+5dbkpUXdfsdTVLtEZL/cgb5jwHpOVaVvCmPdqKMra1MsVPcPwh
	ZCJFPaih+xoMLSSL2Wu2b9RVYV8HwgBphkhPof1HnChHLHsg=
X-Received: by 2002:a05:6a21:7704:b0:398:c0ba:9cef with SMTP id adf61e73a8af0-398ec9bb845mr1879509637.4.1773384590113;
        Thu, 12 Mar 2026 23:49:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:7704:b0:398:c0ba:9cef with SMTP id adf61e73a8af0-398ec9bb845mr1879489637.4.1773384589622;
        Thu, 12 Mar 2026 23:49:49 -0700 (PDT)
Received: from hu-sumk-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb97b41dsm936160a12.5.2026.03.12.23.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 23:49:49 -0700 (PDT)
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 12:19:27 +0530
Subject: [PATCH 3/3] bus: mhi: ep: Use batched read for ring caching
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260313-dma_multi_sg-v1-3-8fabb0d1a759@oss.qualcomm.com>
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
In-Reply-To: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
        Subramanian Ananthanarayanan <subramanian.ananthanarayanan@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-pci@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Sumit Kumar <sumit.kumar@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773384567; l=3155;
 i=sumit.kumar@oss.qualcomm.com; s=20250409; h=from:subject:message-id;
 bh=1MnAcOLx4PCMb5gcpoEh/1Z1hW023S7M6GRMHHtlKLA=;
 b=NG0SR4yVM0HV9OxMyQEnpKZl7hPzWEPlYMzQKUu/FDNzjAOqk6TmOE7GksQxJPF6zYeVbDVTJ
 96I85imVw15Ar0TX2v3sEbYcdkfX+Awb8CRi+kd2+Xn4L5c6xARalAW
X-Developer-Key: i=sumit.kumar@oss.qualcomm.com; a=ed25519;
 pk=3cys6srXqLACgA68n7n7KjDeM9JiMK1w6VxzMxr0dnM=
X-Proofpoint-ORIG-GUID: hTmGUiWvQC8ezT4NA29s9S7j9VzyX2sI
X-Proofpoint-GUID: hTmGUiWvQC8ezT4NA29s9S7j9VzyX2sI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA1MyBTYWx0ZWRfXzosloPXG4T0g
 pjcAOTej9e+bLX/hIr09ffF16oNltmIBQzM8Qfe72oNfQiJKXsS8Uhw2JQaq0CjELUKMzGOHapC
 iTDcqGppeCfhuYnZSBY/9ZkfwuI6Fw8Gxh22ZdctGfisSo/AKJ9oaZp8mmUhQ+Pa/3wFaKm6nIJ
 5uaQb5BaVRI3DGJdnYKhyA8ybvSZxsm4MkuRKXV6CTCZdkEt4y9Bs4pdWP4mSwcSUJXJXzhCFDR
 95h8cvCa8x/YvyW7adr/CRGcFenfvdJJeFkWRifzFAPXs4dbh4NnjIHD5+NWqTwPeXkK04mnNhQ
 dM5Wxv59lvxPh1lqhWMyY4xb6Qw3kxYjI9GVetgp2TU41NUSiUQDeZBJD9hI/eyeXO4SXhuDT1w
 ryapgZnaoaYcS1+zi7UQAUiySAhUnqsEeCUrrXS7hR90XfXm/iqx8+ufg/HjoZwskUwYYLofwqc
 uJYB37fg6Jyo9uYKxyg==
X-Authority-Analysis: v=2.4 cv=CpCys34D c=1 sm=1 tr=0 ts=69b3b38e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=gm0tR4x7yrig-FKTUfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130053

Simplify ring caching logic by using the new read_batch() callback
for all ring read operations, replacing the previous approach that
used separate read_sync() calls.

Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
---
 drivers/bus/mhi/ep/ring.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index 26357ee68dee984d70ae5bf39f8f09f2cbcafe30..03c60c579e12c3bad100c7e1b6a75ae0e5646281 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -30,7 +30,7 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	struct mhi_ep_buf_info buf_info = {};
+	struct mhi_ep_buf_info buf_info[2] = {};
 	size_t start;
 	int ret;
 
@@ -44,35 +44,38 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 
 	start = ring->wr_offset;
 	if (start < end) {
-		buf_info.size = (end - start) * sizeof(struct mhi_ring_element);
-		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
-		buf_info.dev_addr = &ring->ring_cache[start];
+		/* No wraparound */
+		buf_info[0].size = (end - start) * sizeof(struct mhi_ring_element);
+		buf_info[0].host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
+		buf_info[0].dev_addr = &ring->ring_cache[start];
 
-		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
+		ret = mhi_cntrl->read_batch(mhi_cntrl, buf_info, 1);
 		if (ret < 0)
 			return ret;
+
+		dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end,
+			buf_info[0].size);
 	} else {
-		buf_info.size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
-		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
-		buf_info.dev_addr = &ring->ring_cache[start];
+		/* Wraparound */
+
+		/* Buffer 0: Tail portion (start → ring_size) */
+		buf_info[0].size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
+		buf_info[0].host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
+		buf_info[0].dev_addr = &ring->ring_cache[start];
 
-		ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
+		/* Buffer 1: Head portion (0 → end) */
+		buf_info[1].size = end * sizeof(struct mhi_ring_element);
+		buf_info[1].host_addr = ring->rbase;
+		buf_info[1].dev_addr = &ring->ring_cache[0];
+
+		ret = mhi_cntrl->read_batch(mhi_cntrl, buf_info, 2);
 		if (ret < 0)
 			return ret;
 
-		if (end) {
-			buf_info.host_addr = ring->rbase;
-			buf_info.dev_addr = &ring->ring_cache[0];
-			buf_info.size = end * sizeof(struct mhi_ring_element);
-
-			ret = mhi_cntrl->read_sync(mhi_cntrl, &buf_info);
-			if (ret < 0)
-				return ret;
-		}
+		dev_dbg(dev, "Cached ring (batched): start %zu end %zu tail_size %zu head_size %zu\n",
+			start, end, buf_info[0].size, buf_info[1].size);
 	}
 
-	dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, buf_info.size);
-
 	return 0;
 }
 

-- 
2.34.1

