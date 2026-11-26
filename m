Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795670251;
	b=v05Ffjtul2yZwoG22VSxuWare/6vpJDN8nRmy3ibWzYXLSw0LfMG/fl+D0g9aqSLMeKq
	 S12Y1P/mYE4M1CiSOWIb6TA2/y7+JIk4RzM+VRfmnMXY+hoi2I90tfdTfyjAm0T5/5NRh
	 O3ut4bsOZMpb5GUlLP+Zh5qyQEb/qUxSA4gIgr/kYPkVGu23jPTAIdGJKvv5Nbrv0pIRq
	 S23X2+7kR4+yP0ch5AbJ2U9DrNT32XeexCW8clzteUgodGz8MURaWH0yWEr8Mq9mzIhgd
	 jEaYHcwFfvZ4+mVpSUuLQgoRMh+nTAO3jOY+U8tj62u0LGubD2acBzp6xTomyv/qAhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795670251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sScIlPjGf6pwCcf1w0bGUGMbyCWhp3/IW2P+c5YbTiw=;
	b=aFs/vpDOkgh0DpAW3dfzC8mVGm0sY9h9GsoLn69CgiyywXyQKR6BRHDLTz6puQ5n6yia
	 tDAX4zATsJ02yBkaNdB2QBwOzn/9S5TuJ1YsZyhthDG/ryI3YNBTJFx/drpkResLVmxJs
	 DWD8+C8AJvX6caGMWPWtzBtbnTjqkkyUgUKLl8xDv4mCKLIvUE0vSlV42UNBo+DJVwe7M
	 YQna9jEcqszt++bM+Cs9mfhgqEJRULrL5jIsVUj/Zn487yQLV+HxNe+djK0kr+T7nyUFq
	 UapcF4CGgzmRzkWwdWoBir/rNbFU82Np5L5oJQi6+kExl3fGMZ0OEkIgs2n/SMyxZFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Rm/RtYZE";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RH2qDpw9;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894A2606A329
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 894A2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Rm/RtYZE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RH2qDpw9
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ36Yql2791304
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sScIlPjGf6pwCcf1w0bGUGMbyCWhp3/IW2P+c5YbTiw=; b=Rm/RtYZEpjvuXLUL
	2SOInYpg9jaNYYpXjpjDEjyUMmWsh5xdVqc4CdwLuMCHtiGGU6v5z74DbKbA0hg1
	e0L65yxNb1WvyCRp9o8sEBywgp6gDRY73GHcnVTSq5UojZ0cP4m8IVzTfc3MuGFR
	gmDoMwtQBfcc4ppoIENkkVDMXk9bQcTAJcQmhvlMJf4qW5Ynha0ypy6w+BsTnK1q
	IouLXzCzVD08SH/GZkAwDjVA2ctFPELMwAHbnUyV6cyH70kEQA7LULj9J0zWrcfS
	Q+0ANjtShAsIdvIi80BwKBv73pFTSNjDe8PJF77Tv3pfytFECZN4u8dIyFYdwY0E
	5UWqSw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnuyrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2026 05:17:29 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b3ae17c536so6218291c88.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 21:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795670249; x=1796275049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sScIlPjGf6pwCcf1w0bGUGMbyCWhp3/IW2P+c5YbTiw=;
        b=RH2qDpw9hWyd6vxrxKJWqypp6FgyhI3WnwetQT8EMWCfJl7aWRw4Bp+eiQNKjGIYxQ
         a7gcFPYkCKFBw8k9UJkBxj6jzDQVGF6KndMSh517Q/hb3imxPMDu+dOs7MY9V7BpxFE8
         lf2HNk19QTiwAmDgUyDyh/t2+wTBfxLiVnq3WFnIA16QE3VW+0WiS8cXdg91cBGIyXbn
         vSPUqifBfYzFdpSJ4RDuBikLCCkuF4HOrQPGa/BGfj36DsfbfrJTvO15TFE2WKc9zcua
         DsuMA1J8KX0n/Jrc/XwsUIzsR39af/Lm3wY6355MdicqHBfubxmgC7m26Uo6m+aNbEXD
         xLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795670249; x=1796275049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sScIlPjGf6pwCcf1w0bGUGMbyCWhp3/IW2P+c5YbTiw=;
        b=vlW2synD4MwBvLsDlx7kTbn5IqmC8BbC38t1mROX44JnTeC7Hzvpd8fgy7wq31WI2L
         /VjU+YZ0IRadPdG0cA0HgCp51a4UB2rfay3LLfEj3lm/DwmNvdm6wcg4r+hYqpuueFBu
         QGr9caPrKW5xXd0EYKgLMQeIp4hwE/fGkTREkAgYjlxtU5IIStQQPB5rHg37wv/nmEg4
         YZFAe7PozfHs2+s40silATgug9EWyEuvDadRv7qXRVz+9mMubMVE5Y0NkuSzcjncspee
         2qpavVVY5tqTxis3UXBjg+GR/jCvHtnRl7ux1uE0PMYR9VRvBrPB0SaWXlo2tbC9WOAU
         WUIA==
X-Forwarded-Encrypted: i=1; AL+hErGicbS5wxzhQybEXkK/PfJUMLTxNaH1hWBdHLRrO/TFaF9EiG+uPM/MC9sDzJU9xtVjWKykVfTeyH4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HTSBQW4RLyH+yfmh9Vne8KFrN35MD3JtSSFXJzDWvBOYOJZiq
	bJXTApU2zrdkc5QSUUMeorVha9kNX1QcJttIztSjs2FQ4Y9Wqxpc/4XKzkU2sxDiBkLX5MMnCfM
	jqtfg+4Qj5N+xdVk3SXHvJlkr8hEnIYZScrFu80eoEeuWz6cO94W4ttwW+jZg7p0=
X-Gm-Gg: AZFdTZcloRGp46A17ArIG5bO4jTkskijM7bfPqNDNMDKCtz9V/BCcHV1nyUsM9NX5xm
	JnoI7JQUyzfF67Apc4CNB7kOSPUOg0fclxh+ejY/IwZ844DawIbN8B1BLPcOguVms5Xc6/q64vy
	woAE1qvgAO5VHWeIG8BlXW+fUYMJapByWAnKQyc3Rj+wELOpJFLoU8xEihRD3kKgPk0HF3MUzcd
	rRs9fSpKNxok+aVS4YTTtAhcmrQHOD1kJafZH+28jJxoPvqJs10c6BuvG5WgmVKwg7m7QojmhfB
	q15o8aq0Ce+lsknLrM9HY791Bn1ta8uwu+8aTDRvwiwFAdMgXtR4fjkE+4NqAAiwi/N7iU2f712
	bG3u5jE3deHXAHdyLievG5ib0aNV5JIjGob4GZUCR8++RXfLf+eYSJG7vQMV8cWsSovPaJgFaYl
	mVbrcXNwCm
X-Received: by 2002:a05:7022:f90b:b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b5568ebfaamr18385701c88.30.1795670248420;
        Wed, 25 Nov 2026 21:17:28 -0800 (PST)
X-Received: by 2002:a05:7022:f90b:b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b5568ebfaamr18385673c88.30.1795670247778;
        Wed, 25 Nov 2026 21:17:27 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm52132934c88.13.2026.11.25.21.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:17:27 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 10:47:01 +0530
Subject: [PATCH v10 3/4] PCI: dwc: Add dw_pcie_mask_msi() to mask chained
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
Message-Id: <20261126-shutdown-v10-3-fed60d9687f2@oss.qualcomm.com>
References: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
In-Reply-To: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795670232; l=3971;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/vmyVk4dz+wXrRT6tQz+Km7L+PUDZ3c6yimuyC/uNnk=;
 b=DSp4U2tq4ELe6YeAKN/099kZfgoT4nSP8EpgbSa1lH7xnwsRV9dB+lZjvAaOBX75GJGGx8hyC
 gASrQKKPwmmBIq9m+XrMqYdU0tih5nIl0LpAsMDQ61zAk9bZtcm4sku
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfX+7e6TCBLygxk
 PVWWlHofc2L1u+q3EHonn/gBqZkhDpZYZrMYvDP8FoY7KJ8XCivPf/eZ80T+7zVzBq/smYxr/Cv
 +LQsHnletTCdFeAgaGkknvfCky3FnvKJqx7HGlBox+jV7kmtKuXThQpDpiyWu++DfSZQdKnQZfP
 kevNdy3ezSEioYRuOCqxpV4myInR5ZqxRagtYfEyZ2SvFq1vjoOWArOqnBJgkjX3uBo3OU23UfW
 eMuAgC8yxQVcwAX8vnIu0N+Yy2a5ggWh0Xpsoo5l+DZBDsDEmvRNMVAXauN76cvbA+uHeTYdXwd
 Myxb76XPH/153ueNGgg9RWtvFGnHCLE213jwRNCUc/gIHNRjyj1SGQKgc3Yt4wrk9WsXb/0ZtXj
 t18Qbbv6b4yfI8DgYN6YqLiSdRDg/BfAY84YI2kS+fkB31u82raFXODJ29q9VAxfgp90Bu4UjZb
 4AY55rO7Q8ZEnlh6deA==
X-Proofpoint-ORIG-GUID: re40ZpxEm5WoD5C0GGHgPhychixVsmwb
X-Proofpoint-GUID: re40ZpxEm5WoD5C0GGHgPhychixVsmwb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAxOSBTYWx0ZWRfX4frPcsIN+cko
 BrDA44M42jxIJtldUD2wF7yqy6z/0tN7STjAu0YdF11Pf1y7QeBvWmlz2i8NWYfWRwTUrtyXnmH
 HuzxupunHbmwJIeszq525QnvV5obWtQ=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b07c0e9 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260019

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

Add dw_pcie_mask_msi(), which clears the chained handler on the MSI
parent interrupt line(s) via irq_set_chained_handler_and_data(). That
masks the line(s) at the irqchip under desc->lock while leaving the IRQ
domain and the downstream MSI mappings intact. disable_irq() is not used
here: the parent lines are chained handlers, so the standard flow-handler
disabled-check never runs, and on irqchips without .irq_disable (e.g.
GIC) a lazy disable would leave the line unmasked and a late MSI could
still reach dw_handle_msi_irq() and touch unclocked DBI registers.

dw_pcie_free_msi() now reuses the helper, so it is exactly the shutdown
masking plus irq_domain_remove().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 17 ++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  4 ++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0837bb9e67e0..c81424e2f95c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -227,7 +227,16 @@ int dw_pcie_allocate_msi_domains(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_allocate_msi_domains);
 
-void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+/**
+ * dw_pcie_mask_msi - Detach and mask the chained MSI parent interrupt(s)
+ * @pp: DWC PCIe RP private data
+ *
+ * Detach the chained MSI handler(s), which masks the parent IRQ line(s),
+ * while leaving the MSI domain and downstream mappings intact (unlike
+ * dw_pcie_free_msi()). Safe for the shutdown() path, where PCI devices
+ * and their MSI descriptors are not removed.
+ */
+void dw_pcie_mask_msi(struct dw_pcie_rp *pp)
 {
 	u32 ctrl;
 
@@ -235,6 +244,12 @@ void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 		if (pp->msi_irq[ctrl] > 0)
 			irq_set_chained_handler_and_data(pp->msi_irq[ctrl], NULL, NULL);
 	}
+}
+EXPORT_SYMBOL_GPL(dw_pcie_mask_msi);
+
+void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+{
+	dw_pcie_mask_msi(pp);
 
 	irq_domain_remove(pp->msi_irq_domain);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f774fc6d2a24..677e5423c5e4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -908,6 +908,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp);
 void dw_pcie_msi_init(struct dw_pcie_rp *pp);
 int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_free_msi(struct dw_pcie_rp *pp);
+void dw_pcie_mask_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
@@ -938,6 +939,9 @@ static inline int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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

