Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015956;
	b=LnDYLM1+FDGwiiQ1MEmHjM3uz8+dW/DN6mNhVhUKrlBRAIxBWNbmk6fvjwaO3LiUFW3H
	 FhUSkbEjxMBJk4sABoxKl3/JgUeRvsr00gLLfOeWzfoGR8etxKZyG91OcWPkmQe9uqj8I
	 6WcuK1N2FB5nKj6RLZou3nIkt2931rnPo190J+fugtO5ksT8p1eyrBWNQXW22udEUIUnJ
	 RepjzusArKIvQ3lI1myr5lMTAAOeCQKGAKd5aPC44nIf+9zMCFbx8pjAOpNLsEWM1G3SD
	 XqAO7L625u2fa2YtNPN+amKufip8Cdcfji/yeUQtguwf1Aq9J2wd+zceO9AyfhLdJeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015956;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ssnlpfixjJLNbaeprfbwwWlB/EVWQShSh5ZsICInKHE=;
	b=iezT3BjpDU4ljZGn+sOqvxY0voV4a79PUezwdR+55WV/mgfFlvxca1YjCb9DgDvJ9qtJ
	 23fy9FpSPHbJefQnkWjMf9VXll+XTpiWlrqCCbKAQpmOjN9udeQu7lq61tPPr5Mf6jMgv
	 ycdg/6o/HP20Ew4WDR5zI7CmaKcjoZw3xANv2ONbh8qhlxZKwlXbPBvn5qV6jxxphv4wK
	 ZM8V9lcErZe+160bV7NJerYwk0ejRTlTFLFTeg83d2rDSUOvi7TVvACYhqbVfKZxiVfOB
	 2RaLBAuUToNeb9JaLYedS2FXh76s95EQ7mZ82P69oYOhRTP2kUMKLMF7zOiWOr1NYPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQXH7lx9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3ChWKxG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C76082BF7
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 01:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B63C76082BF7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hQXH7lx9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3ChWKxG
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Mo8Xo3696176
	for <linux-pci@vger.kernel.org>; Sat, 7 Nov 2026 01:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ssnlpfixjJLNbaeprfbwwWlB/EVWQShSh5ZsICInKHE=; b=hQXH7lx99Cl40XTu
	3B2A/cNm1PpLD57d3EDRg6FSNyzydwIGcESMcI82Cwj1Prrqfmk/3qs+kJ1JHDi9
	rCXFpMPooJXxM1Qic/jl24TTj73I+VwukPIHFNTONDXRmup5JOatPvBjTxuQ7q93
	w7134hFgRX9wn36ZdED4FyFddxFSjpp/JkcqWdEaqtacKrhhYlyj8kj54EMWpMPG
	m48b0X/9v0Pkr2neDFu4ZnjoSMsagW1+aFPYmGEDPtHuORvGeW6q3n7mm+4El4zN
	go9nXJWl8/dJvy4S8ht7hJZ5IpqXnMofMOwVcLnlXwyHL8Qbad8toPMC6YivxxWs
	xLao3A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqs21f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 07 Nov 2026 01:45:55 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so2098404eec.1
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 17:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794015954; x=1794620754; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssnlpfixjJLNbaeprfbwwWlB/EVWQShSh5ZsICInKHE=;
        b=F3ChWKxG1OkaLDRSHC9+891S6Blf206qg3ryu5hkzcw42jdIrhJT1goQFC2bMV3Wkx
         snSPi8SM2Bqa2V3YyZ5wS9iOFfiTI1AdBz800sXS+rwZdPWtnibGChAJhGmSpVlLN2Ki
         pFudrEDcaUKV2jZ62yRzoD2X+QnQ4XwfSa1PkN0laBc3YeGzC75dtZzgiROwkvV9UyhP
         /OiSzqu/JyIla84KPFsasq41A6mZCEq2AOFibyouL4vfosUVgHU0s6TyIptSoiM9nXwq
         z0W0TXcYjVYfG+m7hbMA9QBYrF7gmIrbesZGxqTPner33wF82Ejcglv8JGQuN6u4GMPb
         HIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794015954; x=1794620754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssnlpfixjJLNbaeprfbwwWlB/EVWQShSh5ZsICInKHE=;
        b=XI++jyM8PhJNJ0gLAl7Z+CnvQ74pzwAaMwATRO8ywHGqXEN2UrHaG2QcGduvT7HC0O
         GUafN1k8xUnUbJnBEeqaXv3GEDnQY3TEqH0tnJ+8jLq/zTd2iXzO/gTDc0OMa5eyXgMx
         VOIElA1vM6aXh8nSoKN159lTxkCICDzbVMmU2NL+12QmwnCj12pg/2q8dvPOOYXRrXFm
         HFhH4ZAcg/me6UrujcA9yGIvWM3UHBNwA2sdLOkOPwhJSC6aB4tsL6ckCKTwlt0vapWj
         qoSWkFe65sCqoVTg2iq1NSHk64lIeWo5em3mY+kvZ72MM+UmEzTl6vjCdUOd1bhaPZS1
         RP/Q==
X-Forwarded-Encrypted: i=1; AL+hErHWeMyg/YBFIRyYO2/sVNxdn+NqPZpXuI8hyTNrM+PcsF7h8V6N3Nnm7xNfNUriqFkdBqf8JFN1Tcw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/z2XsRWM1IAO8z3H6yLdJnTR16nTdXe4uHSIAj3UScSiaMbQRg
	WGwr1bxWVjf/Ot+68jAqCTHqQ3Ua8xWlDt1puO7KMT3UwdOhkkawZgnc507Nn7EJ3poe8MLTv8Y
	MtQNuYwrKUUE6SzrubqvHKNwUobX9McwCxWM5O35AjRKSF7rbqe/dXcIt7AkfJj4=
X-Gm-Gg: AYBFou20OAAu4GfDgdefsQ5G1O5ubeNCvR8XOjUsuzESy4/hOXJYcaYnJhEcyplByK4
	y4/rowvKHkBX+WaYhZVZi+KgKi8U8uK7IQ0DKU6gmuCN7SOal1oRBdjWNuAcY9fSOQM5Z6IyZVO
	Y8yG9/AJFHLWd8SB/t+Ho5jVET21VlgGwxITvEk4SY/YnU4wafSkUmjfhebjfmL5xsdHgTBhUQ0
	vdOy3oEeeSXPCVxZ7k4r1aF8D3pZLhbKryEXGvIDtaUrfwo0klt0RBpbHzYRk0rolxt5Z9hVBWe
	ikpklRBH/spyTD5VucnNviRKjA3rNMMjkstJSmSVTM+8b4IGryRdMwiB/8mmdKiMFOnsf7I9uQ1
	6yMHGvIPU1u63kJS5qXi5dC6uBrsjykXofb7RuSBgk0WMDgilmWWuOgpXHP4pPgLseVZZ9XbBX5
	KQKbSxWRM=
X-Received: by 2002:a05:693c:8843:b0:36f:6d81:3fa6 with SMTP id 5a478bee46e88-36f75443270mr5970921eec.6.1794015954112;
        Fri, 06 Nov 2026 17:45:54 -0800 (PST)
X-Received: by 2002:a05:693c:8843:b0:36f:6d81:3fa6 with SMTP id 5a478bee46e88-36f75443270mr5970814eec.6.1794015952507;
        Fri, 06 Nov 2026 17:45:52 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm22861123eec.3.2026.11.06.17.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:45:51 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 07:15:21 +0530
Subject: [PATCH v8 3/4] PCI: dwc: Add dw_pcie_mask_msi() to mask chained
 MSI without freeing domain
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-shutdown-v8-3-bf607c6429b0@oss.qualcomm.com>
References: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
In-Reply-To: <20261107-shutdown-v8-0-bf607c6429b0@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794015933; l=3587;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=x0tyRGoiEXcFCBOwFALm9OeIvi8b9+PkFQQ2PP+mqWA=;
 b=iar59TBkdIYhgqQenI9gPUg1OthKYTFvz1STaSPVLQm87CmpEj8VTj/6pAbF/fYd1ru5pLt0N
 0j+5l3WtL/iBSrxZXwumJbTiZK3IEKKTgFww7zac5PiMk5/MHxYtEzY
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 8UHTk1aS4pnqPNcTAx4li5PfOtXgK42D
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee82d3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=H8WLNgnoBSHn1WVVwwcA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfX+crWL07Nf61+
 ZdhUDCMr3cXFDtk5VUm5I0R6FIyMDrFip7ANl+TH8X/NpH6TU6/K+RRSeNi2QpWgtzHhbb6PzIB
 UUeTsZsoXAJ1vU5Dy++zUi6aHE6Qolk=
X-Proofpoint-GUID: 8UHTk1aS4pnqPNcTAx4li5PfOtXgK42D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfX3R3o1yoXzunX
 LAPNGtGle6JVn8aWmrqQHA1g+REth9CMgVFiDRyffCyB53qP1/TDtFijtB+TvM6vUQykS8swdAw
 gb86U9jCno+zwJKJgvFrrrEMnWzXMtrSb+0Dm2kM+yrXUKQtVTXwnZv/MiSilEytinm5Q8QaJK5
 14HwhputUbUaJe0Mb4LftyVMtSWj4LeY7LI350VEVoHZi08vm5QUtOLMKSo9MmzBNNtBSSnblPU
 vqHGJ5FDFzxtkx+cXwyrgquv3XVntRWaGghDXMaUUGRepwL92UCGbS97P4x5Fl7r0oqSUmmBQBV
 V9ukaI9SrFJfDEadx0bgquvTYxYfT+URAIh7Ta+KkZYJqrYcDrxaeYG3xFaqYgWG6gUeLfkqbVf
 GNr6im55ipPPnviaxjLVGkOAWDNt0nwU5RmGO8vh47ibRoYsfo+/VzWRofAOFAtmoJtPDxGupir
 HSA2GdqQ0Cik18frVHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070006

dw_pcie_free_msi() detaches the chained MSI handler(s) and then removes
the MSI IRQ domain via irq_domain_remove(). That is correct for the
dw_pcie_host_deinit() teardown path, where PCI devices have already been
removed and no MSI mappings remain.

It is not safe to call from the shutdown()/reboot path. device_shutdown()
does not remove PCI devices or tear down their per-device child MSI
domains, so endpoint drivers that do not free their MSI vectors in a
shutdown callback leave live MSI descriptors parented to the domain.
Removing the domain there orphans those descriptors and leaves dangling
references to freed memory: during a subsequent kexec CPU teardown, IRQ
migration walks irq_data->parent_data and can dereference the freed
msi_irq_domain.

Add dw_pcie_mask_msi(), which only disables the controller's chained MSI
parent interrupt line(s) to stop further MSI delivery, leaving the IRQ
domain and the downstream MSI mappings intact. This gives the shutdown
path a way to silence MSIs before clocks/power are cut without the
teardown side effects of dw_pcie_free_msi().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0837bb9e67e0..7f0126c5336b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -240,6 +240,28 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
 
+/**
+ * dw_pcie_mask_msi - Mask the chained MSI parent interrupt(s)
+ * @pp: DWC PCIe RP private data
+ *
+ * Disable the controller's chained MSI interrupt line(s) to stop further
+ * MSI delivery, while leaving the MSI IRQ domain and the MSI mappings held
+ * by downstream devices intact. Unlike dw_pcie_free_msi(), this does not
+ * remove the IRQ domain, so it is safe to call from the shutdown()/reboot
+ * path where PCI devices are not removed and their MSI descriptors must not
+ * be orphaned.
+ */
+void dw_pcie_mask_msi(struct dw_pcie_rp *pp)
+{
+	u32 ctrl;
+
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		if (pp->msi_irq[ctrl] > 0)
+			disable_irq(pp->msi_irq[ctrl]);
+	}
+}
+EXPORT_SYMBOL_GPL(dw_pcie_mask_msi);
+
 void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 90e6e25fde73..16b180275aca 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -866,6 +866,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
+void dw_pcie_mask_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
@@ -896,6 +897,9 @@ static inline int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 static inline void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 { }
 
+static inline void dw_pcie_mask_msi(struct dw_pcie_rp *pp)
+{ }
+
 static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	return 0;

-- 
2.34.1

