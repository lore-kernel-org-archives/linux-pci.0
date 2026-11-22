Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795316200;
	b=33J81H25tguR88yXNRrg1zb9XQStwoj71/AdASPDQyszsJPM+qOkSHwLpJ/lEtTV1jyc
	 VMlbuo0pW1qvDqVkIWqZUpMHUyjDYV9+6/Vq7iMFinGXjiKIaLZfnB9gG71u8AQ5w8/8s
	 P90UzrHmgpDZ++AmPjgLb1r2rqqkMtkVyRohDKGeYxGekzhKDVPoT9vxIslEzC/GT59mU
	 0KoVUl242o2KYYVS0Mclt8NbY931E709Y3ttBKv6vqyzJpB7QrbPTYCyFgQprMqDLH9EM
	 bMOXKmXokvsvGJepEwiGLsWhM9oFmzuFxn2VS4NJ0nWYHOlWyRyXuwUkXvDAVPiC/ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795316200;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AcqIKO45VLpChEWwEL7R1Lp2+6hXNgtElEHhQVWbBZQ=;
	b=ri+45lk9c5wUTiVMYhj1oLPNgTtXiwOgzXUPq0WO73o6bKm7LR510pxUJxzuih9AKAIN
	 OGQOiuGt82Dys6he6H0JP8mQF5d4LBz9thi0X4N9Tgntak8Ps637FPZU/P7rThzRjhn16
	 jYfN2yp6fPhO1DEtj7UIg5qMLDEYMU4rdd8roE/rZusFnE74C3ONsoJZjv7JwV2hIJTWz
	 +TQFslI86iw3NUS/ggcgFLBQRCuBvFOB3s5OvK1CuNaCYW/URRu0hT4GKBmYQmB1f0ndg
	 /bQW4xybiFgx2o4FRpZTaN1EOR77JQVaaTeA4lScOZERrIUv6j7JNKrpomQJSTPp18w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RQSI7j+K;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=geHvC3Rv;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC7606A335
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BC7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RQSI7j+K;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=geHvC3Rv
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM0807k2626186
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AcqIKO45VLpChEWwEL7R1Lp2+6hXNgtElEHhQVWbBZQ=; b=RQSI7j+K5A8pmUvd
	UuJgvxgYgSLpodMd+K0ODeH3uJVk5686TTba1lHpmBjptUjPztoYxHh/rK58ULIK
	iAx21OezOkFDDMGqbL5XO/zkRy+RHF3bcOl81DWKbMlYbyy2VzYIBFKEKky6AewB
	c7D3PJbKx6Kq1piJ3THI0H8NTdXHu1AeUPBRxMSwKlkQZ5r/xriANaSj6iEE/2Ih
	1SpDdKJLHBhzP2ctCnPGMOOSgE/rocbd6qi+X3SufSgNLJBqOenijFVVICMt1Y37
	sZ7yPLZ+AxGEGqQ48yMUfzyzaLlXkqudPk6Ahxv88jIAc4SNMQB3AyUmA6qH91PR
	AVfNyQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6jmy4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 22 Nov 2026 02:56:39 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-38131260a5dso6017957eec.0
        for <linux-pci@vger.kernel.org>; Sat, 21 Nov 2026 18:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795316198; x=1795920998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AcqIKO45VLpChEWwEL7R1Lp2+6hXNgtElEHhQVWbBZQ=;
        b=geHvC3RvsPWTF2AB5CXrjmWMaiAznSvPL0zQl5JkvVrtj3sugN4gAP1djLHNaxriHc
         WtYYFSdu611iyWVT7iDcU/r55loJKX2HVJ+9CH5fwIn3/eIN7iGy0enOhCLQY1vofqkm
         Pg4ZTEFsjUtOjLlUx2jsOu0kSfIF6dwH4WGfvdDiRJ3lonu9Z7tAra5k5H5zf4wANbdX
         ccXQldKuNtCLxOjMieBQ8bWEjXxhdjG07Bohj2s5Y2cDWiN+ShNsGtfbyiBMxrWPJivl
         oU7Zh8K67UjQv9D4HAJp8H7mZy07k2fC8j6HXVuGr6kNd0J5W/G1+Cy/20/8FKjJJBC7
         zWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316198; x=1795920998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AcqIKO45VLpChEWwEL7R1Lp2+6hXNgtElEHhQVWbBZQ=;
        b=Rk5J0GrlBPoh3A6orweO19m3M2T58OPZ1Yb7AlMeTEiJ8iIxRLkzQhOy5LO80KuyUw
         OvPnIiU/qMidBOoHjUjAVtw9Fc+Zx65isPmDLNTF1CopuNK0YkodHs49ZTXdOYt9bL1k
         8SVdQ2iATyydjjK1ImzI8F2kLfBcY960vovZxgtqh9itS8Vib/w2MIzvkMqS2Fvyjvqu
         30hhMgj6F1nz1cK8aIG87poPMvUgiPTE7o0krzSaaoXC0C35OG/aXEaFr3yq9MlF07A+
         VsPX37/usOSxzS9pqxvCXz3fiCryEC88zzwTEF+yCZ3M8CUrIXSNa/6a1CnAyTMY8hyj
         Tahg==
X-Forwarded-Encrypted: i=1; AL+hErH0+cdww1e369TbPbFe0rMeyZH4HZCFBX16APOl7TE2Hr/5Z375GbXtxnqA7NurFXuNSs6zBFA9g48=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DoIKWeCtFXPRO7jkoACeUMnK3zrObBUyD6aCWa3WG2n3W7SEr
	NQDrSfcRwQfJxdzLid+ZHRhvWt5VRrI4cWNST02Eqpc1hEqp8jaZ52wPPR5zIFATFISR8F3OPtZ
	UgO+A/aqV8jAJL0ZnLSk7s/a94eNNuwVeLp0lm52WpZMFWeuWu8GwOVb/u4N4gPY=
X-Gm-Gg: AZFdTZfi+8f0SakSCUeQFOKe2E4qznSY6ckcfjmRqkuMpCE3/aU+pbyLSDOIwYiJuOH
	J6uR5lJuNl/BC7BwgW2X6qgQQEWsy7rKueqA1bt9BtiM9SPJtSWmXPT9bZyBlKbF74vWJHzCBys
	5oLRfzJi9XCZUM3+QF2T9sn2FU7dDy9+F9TrDeod1DgmD2gElr796i2WWjogGg4jHSkVkadJytd
	sA83s5OChAl0qaTJxSIOukJpjUTCAcS8N+TVe8k7dQ8BKWnzTRRDOwhBt7wWPE/GCoPl6SBTfRc
	I7NH0VYThIxICR6VMIJ+ruDRulsI3Zvg1jnOMyAc6gFWAbhkNi6XVoHBZaPo0jhehqh20w9QPX4
	a22KlIj9+prRpoaZZ2XsWrdJJWKjQleRgazMmhlS2I5M0ubz7JCxw4YuMZzmbLWam1s9doLdP7l
	a6kabu8Xl7
X-Received: by 2002:a05:7300:d788:b0:386:83e2:a8 with SMTP id 5a478bee46e88-38683e2019bmr6001426eec.40.1795316197961;
        Sat, 21 Nov 2026 18:56:37 -0800 (PST)
X-Received: by 2002:a05:7300:d788:b0:386:83e2:a8 with SMTP id 5a478bee46e88-38683e2019bmr6001400eec.40.1795316197534;
        Sat, 21 Nov 2026 18:56:37 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm312044eec.18.2026.11.21.18.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 18:56:37 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 08:26:14 +0530
Subject: [PATCH 01/11] PCI: epf-mhi: Pass the actual number of MSI vectors
 to pci_epc_set_msi()
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
Message-Id: <20261122-nord_ep-v1-1-6d8839ffa9aa@oss.qualcomm.com>
References: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
In-Reply-To: <20261122-nord_ep-v1-0-6d8839ffa9aa@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795316183; l=1340;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=6lmFv0LMj1kepMVfDNDhSTwXYq+rLdkqa0JXEDLBBAw=;
 b=tnhk8AOWx876pmrvroA7ZDRtfUiwnAUBPSnRNygL6UV6R/OUsYeZ7zAh7AZIjO3nYJCs9xbPf
 pQ7msA7ylnuBQdZX9/LqbRBB4npuNlgQ/QymPj1mWjJOZcAVYnUpaxl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: n--VPJVzAx_7xh4uaANrMIoQe9twIleZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfX1ffWLrKfpZ9X
 12g0Gvi7DVv/cgg/iTiaLJMjoCh2WY4rllxqshMrriTEHQOUm+FYvGBYFRAzTopPv8MiSogiHUM
 ggyjvPlpUDiHKJVXvfBzb7vu0QtgO1w=
X-Proofpoint-ORIG-GUID: n--VPJVzAx_7xh4uaANrMIoQe9twIleZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxMSBTYWx0ZWRfXxkBCiTOI8jWY
 toAwk7n/34nPUNNZpCStw5gCspcRwEug0zVakPGqphGV1fr7aQdiK6XKZilXZLp1bD7LtPymM8f
 XtnvXqtsNzJaF3T+4YNXWL2HBr2685zk8LF/MY3bRjbaPqi1cHr9v2CiOyQSWn/o/VS+Zc9QVKI
 JJHNTCdSeyci7VkPzn09vi5PlfJQQQWjrBdDV+LNt7nXG23P4pccwHYr2bIdphWDT5CHAA/dtM+
 yuu8uAHlLuiCZVjdQG2OMyQVe21kw58m6Z80MO/NpBZQ+7lf8O65vBr/31zRcYZFMYk30LrXryg
 iurLk9zUuj7gVfVRnI0HK8Yngsb4FciCzo8jEJ4zoiv/MnRC5+wb/6Aaf9RNau2tyQmbbuDSuVj
 qriF95VPhX8AFgGFRGFRVILNIlR9iIepyg3EkfptmWr/jTeKsoxAI84N5xRtrIuSEhZftP0pvxn
 +lLuPqHwYo9vugDmsig==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b0259e7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=-BGyM8POLA_osPWRVsoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_06,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220011

Since commit f62da6e7270c ("PCI: endpoint: Align pci_epc_set_msi(),
pci_epc_ops::set_msi() nr_irqs encoding"), pci_epc_set_msi() takes the
number of MSI interrupts directly; the controller driver encodes it into
the Multiple Message Capable field.

The MHI function driver still passes order_base_2(info->msi_count), which
is now encoded a second time: for msi_count = 32 the controller advertises
only 8 MSI vectors instead of 32.

Pass info->msi_count directly.

Fixes: f62da6e7270c ("PCI: endpoint: Align pci_epc_set_msi(), pci_epc_ops::set_msi() nr_irqs encoding")
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index a633e47edf2f..52cfffcfd5ca 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -730,7 +730,7 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
 	}
 
 	ret = pci_epc_set_msi(epc, epf->func_no, epf->vfunc_no,
-			      order_base_2(info->msi_count));
+			      info->msi_count);
 	if (ret) {
 		dev_err(dev, "Failed to set MSI configuration: %d\n", ret);
 		return ret;

-- 
2.34.1

