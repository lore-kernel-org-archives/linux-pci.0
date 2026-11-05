Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867325;
	b=ull4v/f/ucrlOCaoTO/nqS/k7LPuDSoO3e30CX+LLDLFmB3MyRIRubuuCQEXjCLhzt+f
	 FS+HxRIXj3IlE7/saIDlkQJ3sH4kGsplVdxytsnkDdmIfakNi1S/ZdG+3iQyt/jRBk3t2
	 98ua3ReeQ3HMwn7kPc9Gx2hcdNri1nTHiulC8UhN4pO9MHz+ozljjsOkASEBxA++NcfI4
	 f2tvBpRzvf7s4A8tDG44gSSUzFvTtdXIwreV7A3AW61QhzxIdryn5sIEnjZ4cjOSqO54F
	 XWhnmb0FOvalexV3csBByTvVfcLIUIErNg5V0egD+gPwpDJtFgaaZaineoqUFIo8/JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867325;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JNui4Qkn+bm95BakvVMA95vXx63ZQS1k5xaXKKrWKcE=;
	b=4dGXev+9xJSCeN/LauE1PuPSL8NfLeCZPk5mqhwlCssAel10fCu1MVY2uUXrNj+uSMSr
	 SjdngJRK3SeEZxp0pEwX9XiXiL/yA4c1iSgsydx6BsgL6Rf6V4KkudBFfCqXm4BlOA+Ib
	 VuPbFccT8jPJ0focd65hzGNzOz8DCFmCunERJZ8VQO8/uPvdwtjr+N8mAN5v7qf2Yxq6V
	 E4yQpYQmujMsn2oBqp+ULH6hzsbsga8MkWS/C07sNzt20EzxDSJLnXEzmMFpR8VGRqimR
	 RWAO0W/e6wxKMgatjvTlMu7wZFZZzZsIl6foPvLsQVSvBPtK25PhKCUCGAQvcmM9BkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="J1ofC77/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="E/TOWu2g";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837D606A331
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 08:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4837D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J1ofC77/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E/TOWu2g
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56V1qC2588144
	for <linux-pci@vger.kernel.org>; Thu, 5 Nov 2026 08:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JNui4Qkn+bm95BakvVMA95vXx63ZQS1k5xaXKKrWKcE=; b=J1ofC77/G1ZM1pEa
	+YnHtKgJT1bEpg+QNw2bedW43NVmBj0EKBU2qOvsiV4kz/v8KjUPdezb5PryL+YG
	J+SINLPqZOIRBJoc7oELWZJuyY83FIztpv94gXar3C1pTy8gqMPz6jpJeAG0/wkF
	so6E9hHtcRvCECPmZwqLceh7Wwf3onU6sJ0oU6qR1KCSLPSRtoBIBlB9URNjdlbI
	51iaPcLJLS7kaz3fW7jDspJBRcrNQiRgBdIp0CWcgN+n1B0hGcGyi7sK5NJ2/mXI
	NKl6r4LHd9rMKRX042T995nJ05KRAuZjR4uXRPoQMiSR/5ZC6K7faYHlYz63ioDe
	pynJKQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr89sugn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 08:28:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7c02e1df088so427819137.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Nov 2026 00:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793867323; x=1794472123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNui4Qkn+bm95BakvVMA95vXx63ZQS1k5xaXKKrWKcE=;
        b=E/TOWu2gcpnYdAwHn/eDVeNPYp8U6yKpWdXyvAGFap8S5RbmHLZwpaodl5p8c5C5vK
         TgFRLVnHKWdPVAKpmxiXVhtApQ7iEM9IQepBPn+Fu+NcV/cH12uZcNqPX6LYcEKzJVHa
         Uu14AQUH34MVoYlylvKoYIFzu02Q3Nooz2wJs3SNAZ6YLUTXo1cU4u6jaRbYqQd3QxN0
         0Go3x1gaij3oCHj8DMNcEf8YyQXnG6iLd4pvlhHKiplolUYE0FxitM60AbFSmJ9XPpCE
         ypzFWnb58Plra2N5JY4wlgTv7+pTg3OVRaAP+iYOy+qFJpA/3yRVejB6p/uRmgnsvnuY
         DpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867323; x=1794472123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNui4Qkn+bm95BakvVMA95vXx63ZQS1k5xaXKKrWKcE=;
        b=cJyhxYu/SSzMq+EBrhRkYZ+NQ+sa1cak+LxWosMRpYTB6dENrn+ZvAQLKja4PPTx+z
         hv6vc3c7ezS5TzET5Y55Ykwi1ImXcJGbL3ZzrqZTwwinF8PyIwunNGnoX+CLsoRtqctc
         JYvp4vkYODZdCFdFdsXG3xNcswaSTyE5LqC5krXIir3R/8OUZRUVlQEBdPHaaeIyCV0h
         rMx9zfzrbLJdVfDXkSKhfl9104wt4f1HcCKh6N2BrQLb1CW8xNpnZZHH+adPmg9WGk3M
         h0V5DTWiTxFAJ+lNJBos8/wXPf3xGrCjI4vDTp2qBSQvsvIRPFgYavoAchjh1xtM/aHP
         3p7A==
X-Forwarded-Encrypted: i=1; AKwUvBxmu0p0ILLZE/ScZvePO2Ur1iaHT0+2WhAJW/wS/h4XyKrps41/UrvMGiDSAfeBKKK3NZtfkluwkcQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+fZ9SrNm/F0wfpSwyifdxkovCk8hCLM8cRc2KMgvwtEfKq71Zx
	UcxbaxWjFpqTxFlyrRDQ39asXmRsOdUSmSToxVa0ZkosKvv0sec4Zrnvz2MLBZyeHUfRMdl58Cs
	LkGbJwdFA3lO0o8/7qEIwmxzJeJvOcuJUjWo0wuUzT1n9QBxXSYL6I7P+spbiI28=
X-Gm-Gg: AYBFou12mfQU9QmCTVcbSb9QZva/4ypnqCk8xSsZT1/TIFlLp0pihGFkg/C2vmOLToF
	U2yB63Nt8ofQlUD5psVMcwnjb9KSQrxA6huIvBb5x4PtGF9a6Vg9w6qgfLJxC3bNzdD73xQK2R5
	jO4AW1w4aQxmODI2jmZylsrZFxTXZkri6wgsXZHgs7RgAsnRraDGvCC1t7wbtTx6u8HcCdpV+My
	Gtzc/r2Narxa/3rIUeLWYJmJeVfuyC+qMe+VnikclipHM8nGfB7jOT0DaNo10MQe6mhsPYcoO3a
	d27NcNnB/yZesuUl4hwEdhAaxrN/Hlk6Lvk82bkEQlnIBHbIe/09uvjxZmZ4mKhYKb/Lu3i78ry
	OuFBhSxHtULlaqOhlh4XPul/hQmtXFhl23fdFuqfYeH6UveKwM3GE9TsLwjQaW4SDziXlSrct9J
	4Rag==
X-Received: by 2002:a05:6102:5811:b0:7c5:4da3:aefd with SMTP id ada2fe7eead31-7d072c25cf0mr8020973137.15.1793867323124;
        Thu, 05 Nov 2026 00:28:43 -0800 (PST)
X-Received: by 2002:a05:6102:5811:b0:7c5:4da3:aefd with SMTP id ada2fe7eead31-7d072c25cf0mr8020952137.15.1793867322529;
        Thu, 05 Nov 2026 00:28:42 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed55249csm7406821f8f.35.2026.11.05.00.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:28:41 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 09:28:35 +0100
Subject: [PATCH v2 1/2] power: sequencing: pcie-m2: fix use-after-free in
 pwrseq_pcie_m2_vregs_enable()
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
Message-Id: <20261105-pwrseq-pcie-m2-uaf-v2-1-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4550;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=0304nlyrASjIizIgHrxb5cCOJaky15ZUTx1KTLIrvuw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7D42+pEc3B7pwciyNHYLTgpbQlF9IfM5xDT+c
 NqXR8C9+NWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauw+NgAKCRAFnS7L/zaE
 w9e4D/4+zwkka/uRQgQc6uO4Qr8/BmxsuXdZ2Rm2gxUivZWwtg3NdF69ixJxDWUY0cQ7Wn2tCE8
 N++X9sP+r1pvpCQyZIXsl9eEWtI002l1KzEgbZzo9W3U/4BPAOm4x/V/6/tuboEQysrH+1Sz4ac
 7UoM9PI5PfHidfacZiT7Sz4Qh5EL32q9aebTlxl+1XkZxFkPAeQmQZ1zCZDjdYmf5SnifZGrj5E
 sEo5orXR+tZm624WL5x/1v5xB8S1VgBle2dxGjBNXR0TB4V/vY0Kw9o9uska/W09wk7HorsEv61
 ZzaMOCpjpsvj4ShqbY53s/O05QU0Kp10Is88JRJU81WlovRWBQfhBUJzlC/v6C+zEL1ho+XG9AS
 reC8hYRBVTtRBKIm01ES13KDD+rZUm6j4FOLnw7mR8+UoqI7KN4VgWoVBNQgnEtUq8OwBhiYOst
 MNodFCGwEde5DfVBkI5tJBXGL3xmN1CjJU7yIm2HDIHDbkB9RBbqseBoDN1oUVlnF5CAl30/z15
 2XANZJOd1RxdUdAqVcZzKsFmOuCkAbQtNT1SYVN2FJRWyc5LCm9m/V/4I6w5zawp/OHJ2CDQgq/
 MrjvmmP3UiGMIiv6ejDRzEFNnfSDQ8hiw9UYx9RSj0kD7oi+URGBKVGluD4DJSPqPX2cQhZYw9U
 sSaGqixYTUF8L1w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: ee2UBM6lxQETXBu-Qs5LJU9anHu7N88f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX3Z7z+2e4C+LQ
 CJSrySAF/X2leOo4KgAgUkxbUuIwdMofrjehw3Z0tnhKH57HZQ/6kNicmgA2LzRrVR1St46qc1t
 LM+/WuAvQrpqhPwHE+oeRyZenzOtGc9v2bWVgO1PZmA+99NBqif9mjK0La3UfLV9/aqitR1qm6n
 pv0tVIOb3da+dY9ru/GGiZfdu4M7kbP9tofXzBu3IunIqTGTpq08N2VxODT7nCjIoSSKeZjIaVw
 cLRxC6y6BYoWPFjJZbB1of1z9B2C5z2H/HTTvw2EU5/Ctez57H9s+nW5u+xIn+zAcXneUP9J5yh
 Kb0XE3qL7xKBHcWef5LYMzPl1DiSzUqOYRKckWeGpKhXgSbOty0KNgYJuvPDxN9gJmSOZP8ENB7
 gVWICyyY114J1P+297/F6+TTwJfFGWFebpe598MgmG4te5QrVy6gths+Wy/6ls8YjUZ/xYhRrsN
 lJ6ZxpivOP6zyZB4HtA==
X-Authority-Analysis: v=2.4 cv=N628hG9B c=1 sm=1 tr=0 ts=6aec3e3c cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mM_0bNS9DA9p5V46oFgA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: ee2UBM6lxQETXBu-Qs5LJU9anHu7N88f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX7n+3S/DcvWUU
 Fu70mZ1cPXOycxh5YRXoycRogBMIKzO0jOS/dn5GCggqPzMvrGuUqfo0aHn77BteLsXPvlFn/hJ
 Hnc8h/FVF3sS0ov3KEwQLl5iRpnyk6c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050033

During device teardown or on the probe error path, a concurrent consumer
access triggers a use-after-free in pwrseq_pcie_m2_vregs_enable() or
pwrseq_pcie_m2_vregs_disable() due to a lifetime inversion between
devm-managed device registration and manual resource cleanup.

The driver exposes the power sequencer using devm_pwrseq_device_register(),
meaning the device remains fully registered and accessible on the
pwrseq_bus until the driver core schedules devm_pwrseq_device_unregister()
to run after pwrseq_pcie_m2_remove() returns. However, the driver performs
manual resource teardown within pwrseq_pcie_m2_remove() and the
pwrseq_pcie_m2_probe() error path, prematurely destroying the backing
regulator array.

This creates a narrow vulnerability window where the globally visible power
sequencer is backed by freed memory. If a concurrent consumer invokes
pwrseq_enable() during this window, execution is routed to the sequencer
callback and dereferences the destroyed ctx->regs array, resulting in a
direct use-after-free and a kernel crash.

Schedule a devres action for freeing the memory used for the regulator
array to ensure it runs *after* the pwrseq provider was unregistered.

Cc: stable@vger.kernel.org
Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
Closes: https://sashiko.dev/#/bug/linux-bd17e5b1-a000-4717-b392-0ff0c2a9c376
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 56c5d51293c10faba6c978265bcd07a6980d2a52..60990760287fdd51c29ccf0e3b97a244669e4837 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -533,6 +533,14 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrseq_pcie_m2_ctx *ctx)
 	return ret;
 }
 
+static void pwrseq_pcie_m2_free_regulators(void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = data;
+
+	regulator_bulk_free(ctx->num_vregs, ctx->regs);
+	kfree(ctx->regs);
+}
+
 static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -563,19 +571,19 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 
 	ctx->num_vregs = ret;
 
+	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, ctx);
+	if (ret)
+		return ret;
+
 	ctx->w_disable1_gpio = devm_gpiod_get_optional(dev, "w-disable1", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable1_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
+	if (IS_ERR(ctx->w_disable1_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
 				     "Failed to get the W_DISABLE_1# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	ctx->w_disable2_gpio = devm_gpiod_get_optional(dev, "w-disable2", GPIOD_OUT_HIGH);
-	if (IS_ERR(ctx->w_disable2_gpio)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
+	if (IS_ERR(ctx->w_disable2_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
 				     "Failed to get the W_DISABLE_2# GPIO\n");
-		goto err_free_regulators;
-	}
 
 	config.parent = dev;
 	config.owner = THIS_MODULE;
@@ -584,11 +592,9 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	config.targets = ctx->pdata->targets;
 
 	ctx->pwrseq = devm_pwrseq_device_register(dev, &config);
-	if (IS_ERR(ctx->pwrseq)) {
-		ret = dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
+	if (IS_ERR(ctx->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
-		goto err_free_regulators;
-	}
 
 	mutex_init(&ctx->list_lock);
 	INIT_LIST_HEAD(&ctx->pci_devices);
@@ -613,9 +619,6 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 err_destroy_mutex:
 	mutex_destroy(&ctx->list_lock);
-err_free_regulators:
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 
 	return ret;
 }
@@ -627,9 +630,6 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 	mutex_destroy(&ctx->list_lock);
-
-	regulator_bulk_free(ctx->num_vregs, ctx->regs);
-	kfree(ctx->regs);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

-- 
2.47.3

