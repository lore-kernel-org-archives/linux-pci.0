Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575B92868B2
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754417; cv=none; b=TL+uqHjtCgQc7vY/XAfxekZGyaewWLsFmJf7m4SCs3DzRea0G3ypTQE7kOClZ7ZiNsNM+eh8kjmfBqRalIjAQiWPhhXjjCGSvXR3tmrhrTc77G+hq0BMhFukJ0+Y3w+xqsxqL6u48SVhyqGwDTY6CNAAXCyQDqUr/lQEqbOKLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754417; c=relaxed/simple;
	bh=eFMulhlJa2czqc6PcJ/mERCRbh2LOh0022dwe4uJYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzlR1voe9H2FipinLwATU6aa0mlGh8fkilZmiJGqHAKVFo2oTBYavx91S6GgFWDKZp9KHBc1hsm0PIITKB/PpVAnGsS7sF70W1sZVwIbCTLdc5mHRcKZojf7E56auWT48f4KLqSTVl7ukUY8LlfgrhVFuwc8LS/8GoM8iqQqbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lWIHho7D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RDCnLiX4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lWIHho7D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RDCnLiX4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HD4wi7668927
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=88mM0UwfW55
	9Ea9keKdGQ5zcGppNDqvuOWAU7Ac1YoM=; b=lWIHho7DytD+zQIa3BaWdOoOeKU
	ZVC60QGQrjqvpRt82HkwH3Z2k+DnTKuabw9v3vog7BL2AVmZ4CMfUXMlEUKLw7Sm
	0yRshPkXidtbOuJmZVe1Se30cQvIuNrsJk4tIsx8YbRPXoWzyXAKp1bwwbjAsTJg
	1hAtH2qYebTCI67LeOgVUPjOleZHAp6nr9cYZrOv1lclF7tFF8Gz07c/Dag0UUYq
	azLlmX6jdDX5pZU3OO7flD+WkIIHt25OJk1OpKBN+BOZ3M12hW+csxY5nvsxbEcy
	w2K5XtcEd3YXUmT4wsg+f1bKJ+MfsrH0SJbSAO5Va/jC9STJ1jVzU80joEA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he03h3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 13:33:35 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ffaa85b95bso47604037137.1
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754415; x=1774359215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88mM0UwfW559Ea9keKdGQ5zcGppNDqvuOWAU7Ac1YoM=;
        b=RDCnLiX4ve0+YIz/NHxrLDi6PWxIZLNZtBinX9YEqfXzETtm16kXBfIwGCs0luab4t
         n7VvW5vERIfNop2Zs4ivnc+jwM+OuKmpaQm5xstgooTg6rAumXtgWyQPT+G+v2z3hOvC
         +Wh7sBWaoI7l5ydlCxuabwMH4ATXGuZ8sNt+Lap7lNN7zxb1q+88RJSNmkdrAJtO6roE
         05W8zlzFz2qeEs1G06kWVnyib9rA4Qp0YIEnRch+pEHWmBeb1RDwfrK0SIa92o8sknm1
         vq1JXyX7glQ6n6s8EKaJCW1FOI0IxgW1rJC617T4BAU82iI0sh4BUQi7dmhaPgFZowUZ
         35JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754415; x=1774359215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88mM0UwfW559Ea9keKdGQ5zcGppNDqvuOWAU7Ac1YoM=;
        b=eVPgwOyZ0Yt5ulbyYsYLHXcJbc6a3nZLIr8OyRk6Rs33Ghsg2rQYBMrD+U+T1xwZ3S
         LG6TEhs7HAvEt6pmipda41MYDgZtdF6cBrCgl8lbZDupfb7oZu5RMUEm4slUiWwd1bue
         kyapnBITwMJ5JfUjLYy9wgV1LMfyr8fePZKCvpv3+1OEj3kgCl99qqzEBg8JfD37v09k
         mpDGsdzSRaPZyPgVYNbNI3RFj7jh5CYVjtXhim8jb5j6d4sGrSyuu7v0q5phnAN8TCCT
         +aKF/kowoHBMCxJlO7eqmVX7BINyh07YcMUCaUT4gNq9gIdQpuh/6QkZjMlBdtVCBpJZ
         /Mug==
X-Forwarded-Encrypted: i=1; AJvYcCW6M1r6dpt8/Y9oObwDZ9ZzwwZhjDCIvQYmeYJK1H10rr1QVFltk98njdpjy9aFqQaGeIAgIj51EsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy8bUMKQt8J8SyNLVHb2HeRpUmLSpoRpFdIEROtwv8W1UNuXIz
	JYKzIgJM28Tg5aUbmv+7Q1S1ZnD4/Lm9RgYj9gFKDbbHEuEh5MYtMb14qR8CjfwuIuNjLdfnuab
	kSE2jSojm2roUgOPEsJaxU5sfq+wbTNPon5iUtlm8r2LZoHEhCyojzoRozp6z9Vg=
X-Gm-Gg: ATEYQzx9MHfl2NdI7ixEJWggl3c3uhtdG7JvP8VobvMPJMh+hTHp8AsZgupxBc/X/1z
	sMNEfsXpGClq6Fr7CG3plxea5o/Of8kavqiSJiV/eU9T9rUXJoTtv6/LRFUaB6Y7DLRzN5QGdjL
	HubJ4GvhKqz2ILzNvfg1jtHMUV9djJ+ntir7MQMNxLxyfYWvIhryMAKDsJS2tZmBSFuxLNL9ieK
	7HjYD3BSGDRnch2iWpMhrH1JHf/ytRpSvaJXk+bn8rAEgSGoZ8TPLEW2s4ssqJzIT8fRR7Gjppo
	PaLgpEriEHn8ahnfFmpbPgotlRliLTttgIq2mdiaSCSrgqvGkjH+ZhvgKbvnmHCpr1Ad8kN2gr+
	dTSPpoEp884bshwZEduvXpgeaAS/vGhVTjueB
X-Received: by 2002:a05:6102:5489:b0:5ff:ca6e:c897 with SMTP id ada2fe7eead31-6020e8b0a82mr7765963137.25.1773754414601;
        Tue, 17 Mar 2026 06:33:34 -0700 (PDT)
X-Received: by 2002:a05:6102:5489:b0:5ff:ca6e:c897 with SMTP id ada2fe7eead31-6020e8b0a82mr7765939137.25.1773754414189;
        Tue, 17 Mar 2026 06:33:34 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19aec5sm51358613f8f.4.2026.03.17.06.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:33:33 -0700 (PDT)
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
Subject: [PATCH v2 3/4] PCI: pnv_php: Simplify with scoped for each OF child loop
Date: Tue, 17 Mar 2026 14:33:25 +0100
Message-ID: <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=eFMulhlJa2czqc6PcJ/mERCRbh2LOh0022dwe4uJYpY=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGm5WCSgUBvQt0JDHdii3jWXC/hFw2j0Bpx4Q0CacjgyAikrz
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpuVgkAAoJEME3ZuaGi4PXiJoP/1M+
 O2IBPigfQbnSPLXMO9PGtKAtkLFrr7UH0xdJmfKyTWqwr4f3bd+NnDFEcCQTTDOhi5q1/DfvHPz
 oSBfYhhtTib8d11CyFDvJhXi2uNWole466n4geS1ah+G7H+6A1/ePH2BhShkYKmK9ozKw4cKtkM
 mMke2eJG46E7FGMuYTlpg3b8yukEIogxlAfO04ei4vC99ESxVP5y9v5QSaCI9+D0PItGjnF+yF/
 kxbvMfDh1o5QoMrzLmqFxFoA6N9C6k84W8YzmXMQnU4YmPGIvyaoCGqbwG35nx704jx/Xgc0E0t
 8lzHD2+FupqcBNTmXnxErH8qjjmQJOsB29727VBE18vBGad132yrTnqBnHYeZe2vx8cjpms7UVe
 7dp3+ZkvMliHKiMYahouDtGP56kJ6qm20WyA45cbNVH7sr4y6aWhWgN0zeuwwGkW28jkQLdMwhf
 PE9wOYSgDBeyNHdIvJNPex0m6JeyE6C92+lPFxTukWnhD5bozbd9tscptfBxfKV6WXUHhCRKJxA
 wva1nWjijOc2Kpj1oS3HZr/MJLirzIeOmBGuze0V2BfOeupdrfAkwDOHQUUvnUqJ6DTPNHt7fcl
 Kyv1Gu+cL6uYme8xPcMPRJ5zjciewwFwqROmx5+3iTnKKjB9MEpbLow/iEtIktUpUDeR6IQ1Iqv MDVb0
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L2Y5s8C65ApdR65uKK4xQWrSOpJECRxQ
X-Proofpoint-ORIG-GUID: L2Y5s8C65ApdR65uKK4xQWrSOpJECRxQ
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69b9582f cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=i0EeH86SAAAA:8
 a=EUspDBNiAAAA:8 a=WsY6cfW8n5MRYgmDw1UA:9 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfX5cYlaIajqxFR
 UCcvb2th2PzL4zJ/UKUpZxvN0NVZdEogVVSingYxHJgD5Sppnpd2LIui35XJKIg3nZxatcaTL6q
 ktpTeHUtWr8kbz+jn+Y3fV48KayY8EF9flgyMpfdIDiQmXZGH0Lf/CDlFthQQetMlaEp6zvZhVJ
 oikqvDn0MzxqHcK3LKt0qhy2QQhn1EZO3emoUvbfwPDfGkfL8yjkcZvQTiRG4YwbBKGEuCUhTtP
 8oxiSxMcKyspkl27JJgIEIgN1fE5SLmzXr/VK0NBZ+RK9vr4aYrMSuXZqyQdza2kfgFeH1nWWei
 QXakSdWdc58iv++s1X304D5hgmlxIs0I4U8lrLKSiEi1eEoRMmJgoEzI+VlTBb5Qn+ILHVBYPsc
 0rEFLfiP+NNgMGXZwmuVEAF+lqaJwoO7AQWdSB45pMblXkiXJkm7OEVCEmY5j20oN0rS6SvxgBk
 iuNra+F5kxjIAXzb9OA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
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
 drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 5c020831e318..ff92a5c301b8 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_node *parent)
 static int pnv_php_populate_changeset(struct of_changeset *ocs,
 				      struct device_node *dn)
 {
-	struct device_node *child;
-	int ret = 0;
+	int ret;
 
-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		ret = of_changeset_attach_node(ocs, child);
-		if (ret) {
-			of_node_put(child);
-			break;
-		}
+		if (ret)
+			return ret;
 
 		ret = pnv_php_populate_changeset(ocs, child);
-		if (ret) {
-			of_node_put(child);
-			break;
-		}
+		if (ret)
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
-- 
2.51.0

