Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015944;
	b=fKG9UWTRmP2uGcV5+JALRJfPT9r8348j+KpMlJtBMHAR4GLXeqg4f+dCdznek7f6Fzsy
	 rJyocAzu6tWPHcY/biH137piyGRpjjcOKTIqGlE5cTcCMsdH46is/DyiOfUKiIfPL33mB
	 1GR0Nl8TKEe7dGu16HQ/80drP4gs7J3YbhM7Q98eqxdkCXZ3+3K412GPEpLHT/04I6td/
	 z/tSeU8S6Wrys3LJntY+U4KzjWJQAJRaGVfA4y9jCUnNvEYqBNjLorjVj3pWDpL6PYHID
	 5CYloX6ZckcZK0hMsI463dl14pJEZUxhXj4jnJGr5sAugQuX5oTG1w5y3tgbcQF9a1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015944;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
	b=ma6ncfKm2asvD6JLLCrBqUiUaWPhteFOuc4x6GbgrneIbIZUyVEppk9DYIy4VR+7zy/c
	 QOHJnK17JXEugBRcZH6ErwpFQPISHz3pTxkfVNqCP8xQYlaEhem9gL37kHyJHu8kK/TnW
	 bAMWAdHCs+zB6Ly9Sm1YZ7MQhZMzesP+Qdx97gdxfIgcbgRyLV3/7m2eI8WmthkNtLBnG
	 9smzWXDpkkkpk+DyN80CdhwVslDQCDsil6iD4d0HX885z9w3Js2k0eSfAixexB1Vcr1Xc
	 OU0hvXvggTEjHMQykMo3f4HWUI0ik+HLmAPHqg8IvebBjHkGGSRxkfr4Ojrpu76Y51w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gW0PHRyk;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FArbB7Dd;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58344606EEAF
	for <linux-pci@vger.kernel.org>; Sat,  7 Nov 2026 01:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58344606EEAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gW0PHRyk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FArbB7Dd
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Mo5iQ3696096
	for <linux-pci@vger.kernel.org>; Sat, 7 Nov 2026 01:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=; b=gW0PHRykNFc1GvF1
	S6oBgQZRiZtJ2sVkCStuUhJDwuBD2ZWjRyWIZEFPvNO/jMgt+PeqRiVqM8+otFDs
	k9wVUGTNSJe1iXUzb34pSOJFlgdBdo+eYGy7Q6067/y4D0baObT3qiTAvNUjYFLm
	VNTdiucv3MgbchmG1y03xJmfzwWJTNkSmM34Yqz8dNL/ghcNs53aAfH5jkEEg8Vg
	JfF1jwnJXnJoaVkuVr6mdxHDT8dfaIy3hcRn6L2Xfgpsej7egXDW4D1eQD9+6Xkh
	Cz0FoRC2i07E/r7abA1Ugb5JbZmrpDXvcCJSYC1Di7JmK9jJlPcVjyduhxMY8Ttt
	XqQMcg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqs212-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 07 Nov 2026 01:45:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36cec75d8caso313611eec.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2026 17:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794015943; x=1794620743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=FArbB7DdSvR6LFBUR8oQXy7Zvbxgzod+0PH7pfm+Au64dmO+tRsr6+e3lO/42cZ5kC
         VSVcP7W7gDrdf+SqhBNenPDL0aoN+ZZPZJqx/DYnkMLcbNATWOe0QrVbvT7xlvtwuO/Z
         oIROVi+J7ZnNlJ7QvGemOEBlrIfcj/EhGlEVzPsWEbRv0EQdzVmJEFXVwmAtKGsVRCMG
         qeCyzIZ46ioolLF3WGz/FDjmoCfiX6LbYafu60R3lHGpyT93mLsvggMgSjYCn31n8bUd
         TIE+IM7jJ+/RKStUWA/1a5bgMgRDHiHmdVZwf6w6S7VyLyTFz1v02Mh6GIapXy1Qqi7J
         yoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794015943; x=1794620743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sz+6Kcub7kDVCrdSqvP71/UKnkp6RLiDhWqxwmv1ciI=;
        b=kE3Bs5yzSw+W4nyY+SwNj5FGyeYtDJrFZJHiuCUeUlFxgu+M7ik+nlzUDgXTHQLcTS
         jphtTJA6rr8fTRcmdLQcRkzu8I2eNPH7QDxz/h1o0JrZX5wrg8ppI2Wl1Nkff5Qmr0Yl
         +DQ7yzzQcL2sdRAoZi1N9RolFKXFxISTPAPq6pKJHUJ6xO3ip46EqVU44Fh+ihbhkGVy
         RBE2nE/9DJDdx5RZwaWEeIDu4ucMVindr0tZFW1sYHsayxax4R5UT7b0YxYe21uGZ5FQ
         dLt64y/CiCiij/wsaCIcS3tT5I66eWGtI5NJnnhsQwoQogzAuKub12ZDhvrQ8yBNW8o7
         zpvQ==
X-Forwarded-Encrypted: i=1; AL+hErGJDeGpJi6XM38LsLHan4pgFLApC0rPYFQ27MnRIuBSwITYYOdLVXBFTZeysfaMUqFBHCMLxXu7KYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YD0c85fSyzm3Bt8upg8mrXSDbozkIAnbUNu6O2G8QO6Mt3bKU
	XLehmVbq+gm936RpdRcR0b+ofzXzWfbucl7GUJIdmfHV+2wK2DMy6ZcT9IWNnq8MXcRsNTx5oeh
	9F2Ug9wATtuDaC9F9FEoR+4LWDIWaOSKORE3qsMtlV3FqL9FdryqoEP/8tDumVgI=
X-Gm-Gg: AYBFou0mH+C/e8L+BXSRFjXP3kmlkihzFxL9K2TDcKtsmkze49exmrJwZ5qy+R4bMdz
	6oKYWR9Q7yuSCkbOxARhjeroOktpVghhmE8pFOVpGd0YX0DE97j1nm4yYCA+AdrZBtJjG0mitFO
	EjbiNTVMotbC9dH87IG3uHuXHUOJ2wRT+PbI+BBQYd226/xgVc+t/FU2DF62FAPAUeR7T7k3Iqn
	qA+49Wx6hOqTnu401wZoX8iH845uTZMHoonQdz3W/LFHfEbqv3tI08tzDgX11xSGr8ST1TM5Z3M
	ZGcq3zDnb3RzwRlDUxifRhulc5k2yCfFgOmTAH6IUM3SgOgXlIGxkgZTvHPCCR3zvClPZtzyY1C
	JCOvCL8JAPdfuqfwFub5+324zD3EAZG18+WpPcpi2DcOi/cWPucvOjNBCBkoGPZYURrVaFRjT9g
	Reo4MYLLg=
X-Received: by 2002:a05:693c:88d0:10b0:361:2a55:b94e with SMTP id 5a478bee46e88-370f71bacabmr947887eec.15.1794015942869;
        Fri, 06 Nov 2026 17:45:42 -0800 (PST)
X-Received: by 2002:a05:693c:88d0:10b0:361:2a55:b94e with SMTP id 5a478bee46e88-370f71bacabmr947855eec.15.1794015942316;
        Fri, 06 Nov 2026 17:45:42 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm22861123eec.3.2026.11.06.17.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:45:41 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 07:15:19 +0530
Subject: [PATCH v8 1/4] PCI: host-common: Fix early bus-walk exit in
 d3cold_possible()
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
Message-Id: <20261107-shutdown-v8-1-bf607c6429b0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794015933; l=2329;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Z62C1KjgkUfHo1yhmxjksV4K46Bz6P+GsVAjd37UQdg=;
 b=wYcaAkfQWy2rWkm7ilCCTWzQFh1Rmc1QaTAfbEZEw3bciOtcbL14NfGk/6vh5x9ZF6DDyfJXw
 IXBLCa+0QtKAXwKrtJoYcXO8SmE0SdmbaapVi7ZYdE0O9nGpbii//Xx
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: dHPu0owQHNAX2ixVlK-Ph_ZWfmPwByeW
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee82c7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RIIKlrP-v3AzcS8hWasA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfX8Knxwd3JwGj2
 ZG0pSuJ8wtCbs/OMDoiIGLqHJ+pfvdBMbGD3K+MyGlewMHspyfm0I3jQukPqDMh/UL5WS9wfzK7
 n22k5BwPxl2EcY+6eWiz7lFlJPif/uU=
X-Proofpoint-GUID: dHPu0owQHNAX2ixVlK-Ph_ZWfmPwByeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNiBTYWx0ZWRfX7bbsgacBfJ2Y
 h9+58oaAd14mOtqG8ZQyUo2cUfzaQWKhQhzOFAhtrXAsJ1Qj8drwttBr/iTy/hmuO8Bb8O2AhkQ
 qpQHMJ80OBE5xmJgNwtzNVbOosiTyHTQWoZe60llhM7fIxxdNnWGSaRCeuLN/+NlY2GUxrbYYHE
 mZucjy9LxCYzh4Hyozj07arzNO/pdrO69Nu/MFoRHHCBevgs60+hq2j7FadiIoyAxjM91uszok+
 V5DwpAxET26kOm3R263v6U6aco8qy6pii8EUpEN/6NBT4JO615DQrud9+RNR+H+q2AJtk9ELgmv
 kZIf0mt+4pEt7GotGrmRPmX2nv3Opq4IFKn7Bb6wcaDBl4lTTvFCxMFVerX/hQFxvV1ucO8F5Lm
 Fm0RajWyuCtbwnfekbky3lPzeZa/1R3xEQsi3x1TAoRDDvhLxd5B+KlN6vuUOu6XopLXK/hm6x5
 6lb7+6//j69WvEKwUKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070006

__pci_host_common_d3cold_possible() returns -EOPNOTSUPP for the first
downstream device it finds outside PCI_D3hot, and pci_walk_bus() aborts
the walk as soon as its callback returns nonzero. Any device enumerated
after the disqualifying one -- including a wakeup-enabled, PME-from-D3cold
capable endpoint -- is then never visited, so pme_capable can come back
false even though such a device exists on the bus.

Since pci_host_common_d3cold_possible() already returns false whenever
any device disqualifies D3cold, aborting the walk buys nothing for the
plain suspend path: the overall bool result is unaffected. But it
silently drops pme_capable detection for any device ordered after the
disqualifying one.

This matters for the upcoming shutdown path in particular: unlike plain
suspend, shutdown forces the link into L2/D3cold regardless of whether
pci_host_common_d3cold_possible() itself allows it (see the following
"force_d3cold" changes), so at shutdown time it's common for an
endpoint to still be in D0 and disqualify D3cold while a later,
PME-capable device is never visited. dw_pcie_suspend_noirq() still
uses "pme_capable" to set pci->pp.skip_pwrctrl_off, so an inaccurate
result here can cause Vaux/wakeup support to be dropped for a device
that actually supports PME from D3cold.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index a23907a875e5..c2c852c64aa8 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -275,21 +275,16 @@ static int __pci_host_common_d3cold_possible(struct pci_dev *pdev,
 		return 0;
 
 	if (pdev->current_state != PCI_D3hot)
-		goto exit;
+		*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 
 	if (device_may_wakeup(&pdev->dev)) {
-		if (!pci_pme_capable(pdev, PCI_D3cold))
-			goto exit;
-		else
+		if (pci_pme_capable(pdev, PCI_D3cold))
 			*flags |= PCI_HOST_PME_D3COLD_CAPABLE;
+		else
+			*flags &= ~PCI_HOST_D3COLD_ALLOWED;
 	}
 
 	return 0;
-
-exit:
-	*flags &= ~PCI_HOST_D3COLD_ALLOWED;
-
-	return -EOPNOTSUPP;
 }
 
 /**

-- 
2.34.1

