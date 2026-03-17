Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11D280317
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754420; cv=none; b=GyOgtFaEOjMJTXguyqG6mmguiZ0L9eBH2bTDnBBgtO/dOc/Qppf5CTz+HAvvJ/2l+V+aX085R9Rro2voIKf8t6t1U82d93nk8x/L7kjxB9g7r0waT/O+LHzvy21ctUwv+tAacJQkAPM+v65FputCjZxXTjBIjKrjfkLQACdNLXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754420; c=relaxed/simple;
	bh=9DhCCDFm896xvW9DJLZa0Xniri5OwyXWSIHDphJEFYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cowjuiJqxztlU4RdUmRmr2FVLY6AYpcB7zeuZtLFiNFc8IhljWlKlRqsMtxUtHoEUORBm+JA3v7GxE2afBfH4Rw9CYXxFi4muCdZ7lLEsbkv3SMpKFXKk69PLlLEACVbax8W4hC7kZIEWBCaLmo/5Gl531MTRku69nIH7febHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cMxosxFZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f1Ls11z3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cMxosxFZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f1Ls11z3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H7Gjaj1639206
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tXmfvTYJB8O
	fseCvx8dXYrfeCi5XnyrDEhI3+3eVAeI=; b=cMxosxFZ8lMtSuzLZd9dc1eK8NO
	RPXekCCxrh6w3zA16OeDJNRZx1hvdrq85XrvtodSEJD6cgAB+Cm169juIzbKNSQL
	8GabAcQqBSUq7BFQm4M8lWn85PuWFM/fyldaBF9SeJl7XmW70XkcjX4sGGjllwIs
	VxUxnFjd8p/5vCxY7MNtkJ0pJpVFrqj7cGrGnd7AAD5w+O/FsWezKXKmpxuV4/Gh
	4kDO+Nf/0zo9PPKaSuR4fzNonmSqaZmVBUR8DsNbdpyMg5k5DcnT0fZ/yO4tZCNd
	1iahqJxVKqH2p/wdDcDO/wB5qk/pmD8XqkfXAVHtR9LzzccGZxE5it41GDg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxke0ce0a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:38 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-509011403a7so337815091cf.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754417; x=1774359217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXmfvTYJB8OfseCvx8dXYrfeCi5XnyrDEhI3+3eVAeI=;
        b=f1Ls11z3cb9fveFJXQDj2FfkxwX6hqO5D1i1v+ub19hcY1B1xDxV4/4g4qUIMZTeT7
         YgMeCOc1lNriptFC8V5a+n4eesipQe2ufDuXesuRivAxrF6kCXrwknxs7ymlZh2kAWXT
         8wPmduK/BeBpCwfmV8F2dvB7kG388P0Vq/BWbaZVsX927FoKPb0vs5S0XeW+wNf2cKBd
         L56UfX/ZQPxmLh1XfJPvfTRDobcdZ7weLEf0Gjo7XpEHC+Mwbkocfk6IEnfeLVq+v9WF
         N2vqGBlIuTGk70ULF1q9L44Mrga9waRgaAWdI/9E7ZmU1cDr6ZBcQN9N0f30JI4M+qeO
         vrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754417; x=1774359217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXmfvTYJB8OfseCvx8dXYrfeCi5XnyrDEhI3+3eVAeI=;
        b=Hahgma5ACfLnaaT6V8a9qvQuo59ReD769tzXorfAejoZwGdWZ52Zv6F6CGU8W9sn4T
         lNEYwmdfg2qCecKpCeLFMTWtIX1m8CDHmiHMEvsEbsRvjFpomcPz3RsgyqrwCBVGqkRh
         aB2iaPqR/hulq/XDdG4flsteHBAyo9pWuk0w5R8HUuZ5yuflvZhpw56RVmxERiZrld5A
         JZaHpFdhUUOpI1aILp/iIV34z8aBIG9h/2/lUal5nC3qWSZzF6Zr4Xv6idfhrvxOlTua
         2CJm8lg62bVciuqVtvxCsLabckrK8flBTTfO6pqrmR8qggHqbzNBB8lqQymxiJBSoNfC
         mv1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcJhrsZF/L7Cp6ef4v3fhn1J5HiH1kJ59+YfPz6LoLTv6rX0nanTf80dpRxaPv2/bIxNo/a5uBPF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtkJxlAwIObf0F7X+pAQs8TA46XpJH4SJWmZO9YCAbGkwnFUm
	rcgnbIGoTV4n/tyBXp+kWqQGH2DTqqdeZa6VGRwHA5BTf/0T/422er6KN2DU2DENqG7thLTvDuZ
	d2z3TWBzrnfw23TYuEUAt/uIsY7MgChgVDfBzed0lHV6daZB+jXcugsz42MLeapk=
X-Gm-Gg: ATEYQzzwfD/EDuyMiFDPtjeuUOovT2iwKLQdU1gfkF88TrUm2XHHDkXhDoXYVWBZ+yH
	toF5kgOMudCS/jYVgPfO+XB8BCfhUiV6rt+MbjrwGWoB2b9tanZGGlBjmDWcm/39PUOQzyY1wj1
	+X+fPyDGi5sUscUdQWKGXS/KJ2X6lwSZg+QbKD3nxzeRSB3VJGbSblmiRgTvTZvi+LBy/PpliR9
	HFy7J1Wv2BxZuaiHVNEQknFOOWlc78UB8NvVJ02PH8J9CrNmH6fbzn6tIh/ol3nU7BuwDWW4rnd
	bWFkcSSmYYFmQSIagTIeKLpWuElBAPiO+PdC/tUrcbsTVLI6ZIgwinKQ/WWH7M8rUuWiHTuWmLI
	uiXtZe1RtKyN6InNTN3retsFsLHQGBYwK2Vck
X-Received: by 2002:a05:622a:22a6:b0:509:5987:f4ff with SMTP id d75a77b69052e-5095987fccbmr240504861cf.61.1773754416972;
        Tue, 17 Mar 2026 06:33:36 -0700 (PDT)
X-Received: by 2002:a05:622a:22a6:b0:509:5987:f4ff with SMTP id d75a77b69052e-5095987fccbmr240504151cf.61.1773754416323;
        Tue, 17 Mar 2026 06:33:36 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 4/4] PCI: rpaphp: Simplify with scoped for each OF child loop
Date: Tue, 17 Mar 2026 14:33:26 +0100
Message-ID: <20260317133322.266102-8-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=9DhCCDFm896xvW9DJLZa0Xniri5OwyXWSIHDphJEFYs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpuVgl+jPVUMZ1Xl2C8Qlcx/qCoESwPPQQ93fLy
 DPdpQXgiXuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCablYJQAKCRDBN2bmhouD
 18g/D/9yRaLcZiBvBPgCkpLNKJ5s3HApSEcdu8UX2CGfgGYAHuQpfm74UP1W+AY0IsIPbBm7jU7
 oC7Mt+tXTWlC9RYfv2MsR+wYkbEaYY6V0gdZtIObXmLsqYmMJvLkQkZdHCktv99zxBPp7QhsTx4
 XObU/2EkTdzr3wFJUahjdM8a2feprqGSrY6EK/+TD5pbXeOsl/1Hp8ULTWveF7H15rGznW8Ck5G
 d0FizsAFr5hbgfk7EPLq+fHBsA+UKqJ13lyXoTz1tTgGSMqZ24/47l7RrYTQucxFkMlQEiIHJHb
 GbZD4PmufA/zUmSVCXw9DgujtZz4XmWCgXftbAN2BDAOLJofujvKp4PsKtPmaiEYayUy2e5UHYr
 Wrc9YQRjW6N98OJvyHLLuOii6NX6CO85UVtZKtqNV4uehkYKxznGkvJ6bjGmPuTEnKqJr/iLx+w
 YtI4A5/mJs7rWMYKxtrH7CDDrRIYKs9IAQOpyMGrT2BCsPQHVyFClrhOAxfSOfkdsj4Gp6krEuk
 M9pAY09ONTTpqte8ntrwAUMgJ5CLjJNn9IjnYSftwB6yHb+TunyWIy/T1JmMgxwelgJmy2MwbZc
 M0fzOQScJG7f5MTk3p++jmm4ts3+qBP4MxhhTjDrfOu2moH78UvcuXv1i6MwCZvdYA6kjVZAqlJ ThqBrzVmPBpQhag==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: i0Ngp3KUP-7tIS5nMgrS8rssSp3rQQXf
X-Authority-Analysis: v=2.4 cv=aue/yCZV c=1 sm=1 tr=0 ts=69b95832 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=i0EeH86SAAAA:8
 a=EUspDBNiAAAA:8 a=d5zWgTKZ4CwGW_Y1MEAA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfX8A2Q3lRK9EUz
 6r84/I0HBhKUOaioNeIE/6vUYw4sF0TlJZRtyUeiqLQTg6jgaXRA0fiieokuyPtliYX5utjCLJt
 EpldvW/w4vYHXfoJ1hwjpCRPaLe6rFQ9/prOYIsoeojR17NkjJ3iwuNdHTGWP2E3L/etQkQO+B3
 tVunyzhIXsYz79B7a31/EuwrPxaN3o5by7IBUPvOPDDytJpVR0+51aigHCfw1cEgsyjoYvuEO2V
 ronIUq7bJcwMyUSVsHuKUobTG1qlhsNtUKnUvd0aVnXWjNFhU9KgWR/90nk77hOeRz/+FZsk2Gu
 LZw8/koWJJgGdMZT6Fb4cALITw4NKn3rUukPErCuY83MDDXeYPNiv939gYf4/u02psphWw6tX+R
 DonB2UDcR7wSHIUlWRmAQqy8EUU7ZX6sWpuDRaNJBBx6JDIJ6Adu8hJunHnQyX+ag0DguS2AAZF
 9WwNRahlxcacBJnfaaA==
X-Proofpoint-GUID: i0Ngp3KUP-7tIS5nMgrS8rssSp3rQQXf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170119

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
Tags
---
 drivers/pci/hotplug/rpaphp_slot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 33ca19200c1b..67362e5b9971 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -82,7 +82,6 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 int rpaphp_register_slot(struct slot *slot)
 {
 	struct hotplug_slot *php_slot = &slot->hotplug_slot;
-	struct device_node *child;
 	u32 my_index;
 	int retval;
 	int slotno = -1;
@@ -97,11 +96,10 @@ int rpaphp_register_slot(struct slot *slot)
 		return -EAGAIN;
 	}
 
-	for_each_child_of_node(slot->dn, child) {
+	for_each_child_of_node_scoped(slot->dn, child) {
 		retval = of_property_read_u32(child, "ibm,my-drc-index", &my_index);
 		if (my_index == slot->index) {
 			slotno = PCI_SLOT(PCI_DN(child)->devfn);
-			of_node_put(child);
 			break;
 		}
 	}
-- 
2.51.0

