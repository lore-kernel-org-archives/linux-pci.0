Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536002F999F
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426189; cv=none; b=kA7jpjTiD3+YB0mVl2LDvbU9utl3ifxcR9hDTOL51VuF8itI/ePSFfKnd51nx/QTKrhRFCcUwefgV0Hq4VXt4+pV2UA6iV1/QVj1AYWJEGjSZfjprwVipL3N37lu7fD2xCCDlHnrmoWzwVwoDDyd3+YNK89gjrk1X4C/QypWSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426189; c=relaxed/simple;
	bh=hEBzM4Fc9u8MMgKXl+vj3ggndmfkY+7T+OgVyQFAyuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MRbxZ2GlHJuiYF08M5Gpv29S9Wt4A0WkJtPnlOjelTFrKFf0rZ5woIxPcuA7hPW98grgZqbxDPqLHP9GpEvRsmFiR3HHqU+6IlU0pMcIaePQYqeyMpQC2Rsp/zpfNeAhJ+V6bDkiCZuDCKRxLAHaK4O17KeaL/Mw6yHv9swrdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JfeydvKY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aacWYECb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JfeydvKY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aacWYECb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q7am3S3493747
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 11:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=g/gzVTzM6FtddJt39uZzR7RvFSBpRjHIRrNIymG0OGs=; b=Jf
	eydvKYmw8exrInEKodbyJ32JEK3dsAYCp+m0qO7HrPdms9E6hrgHY9nLKvs1GdhB
	8spbJR0gNM9bMCyyojKqBSyyiuyuH774n66SQ17EW1d+2UvOl9Y0HoBOCwJWp2Zu
	8JUP76n9CXnRhhdrdLX1e0d5UEGhp5hOb9GFA6p8HlgE5d8iqLJrvXwWK9RlHCfI
	jfTADBcmTVjV6yGB/nNRHfqN/Ij7LZzYHBJFTDOJZTStfOF1Z5Fo4LLJOhX5CDhz
	6Bc4DwG+tskXSAioJaTIMrr6ypa3hu7cqrQWUhwgHthArmUDgBh8IFVHlwPjk+c/
	3+iFcfePLFlEMTMdNRJQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq6xva31-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 11:16:27 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ec9a4e6cb0so5241024137.0
        for <linux-pci@vger.kernel.org>; Mon, 26 Jan 2026 03:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769426185; x=1770030985; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/gzVTzM6FtddJt39uZzR7RvFSBpRjHIRrNIymG0OGs=;
        b=aacWYECbZxhvptUd6oXZ8P0rrSOXxdOdsAvM3na9F4HjNPaBkqzAUyByKDTmMrI4pW
         2I69ruka0f9m7XhaSvTfjEZcohs833978RvhrRHT/0Wiwj3CVqbccQJW8SE8k0UBbkIn
         b833wNQ9NKmKqVRaarYer8kJK4rVdezWTEXwjHNY+dxGRY47AlbNnrfQMiy/GFLNYpaQ
         /PEUBomKPvAQNRH9MQgu+zPe6W3GN2t+vREiJisdSI+JsR4e5Qz+x1Bdiwuh3NGqbrb9
         dIO2Ad9AKpWIHvLa3uqR291e5M1SvRgoq9MPOdmEhj9T9o55SIDfFoBPdNaGdQQTLBej
         KVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426185; x=1770030985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g/gzVTzM6FtddJt39uZzR7RvFSBpRjHIRrNIymG0OGs=;
        b=AZ37kgbHGQjTFBUXEBFtYfrflrei4HbG5FO+UzJmbe/BOrUKDVqJ14XvUovPW2WSOY
         fl0H/RfZk/bEWzg8d+ywlTq13max2T00PpVb+edwRdiuNcOH8VootKIz1Rf1N8j9u4v0
         37w9LZ9sLxEdiUX+D4PWzhXKvYRSX8dn8NmF/xK0YTDTwb/2PUiwRbIJJQKIARAcctUt
         X1HjECx355NznwFNsHiTpLT+JT6wOGy2xjHNd4CIpkNmeqptlUPYsvRCCdMplRGHxx87
         N1ZT3kGd0VVdyopltMOowlhEEQfQTNBeyLDKkUw7wPFTm7yDfxhKFRPV8TNmSNuzq3EI
         8TBg==
X-Forwarded-Encrypted: i=1; AJvYcCUyvNnu0uO++vkIn15fXOesIF+m8rMVvLfq83/T8pxmbfa87/4yR5bEe/jUnr0SLf0EHmJZf3g2U8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0gkVwtahRSw80RdNupwvnOYy6BY7A9jeAL7IY7qBIK03Wx8ZQ
	Wq55Znz2Mf9nigf0EtPuCuGmemwc8hYvE6gRPklj6KV6m6yrvK8W5KsACP4Oez+yIhygvLwhEHW
	3nJFbnAyNxRsZiBv1DuVpyLFMfa9p8nFZiu5UVWGnLMWyuz7Y64Wm2hGrY9y6zMU=
X-Gm-Gg: AZuq6aJ4ngQKgRZ/IRcbmEfEp4c3ifDgp5/uy+0O5hn2XuP9gk4JnNgXgHd/DkfagJ5
	+7buE04mv4O4a/23MBfklE0PYQa1Cab3M6+tednPg6KwTamscoVmPV9aReUtW1XIdJH0SUYb/9Z
	pMIUvyKgG27nwrYogCBIwnraAjpdo9glTkPP6xA7Hzp5VGRy+tNer9l3hhfD9deZKnF4UUz77zC
	eh7SeTJCJW3WDLQndvSCAm/FcSY66nAGRV8BxMAE7KUbabCBIhKSel3g2fQXuNN8Z2loPrO5nrx
	cBbcdj/GsRO0tH351unKGKIxBf/xrI4mGxLLEIUZKzPw8z+2hg/hdmEb7ks23bav2RiOyp3gEPT
	+3BPwdmekVixnvIqZiSz2nBwXF3RhJK93uDbaOKu7eI+FbAt871B5N+r72ztW/69I+JcsvMfVCT
	dVjSN+YaxLdMAOggJmaNE10jQ=
X-Received: by 2002:a05:6102:2821:b0:5f5:773f:b1e3 with SMTP id ada2fe7eead31-5f5773fb35amr738475137.11.1769426184959;
        Mon, 26 Jan 2026 03:16:24 -0800 (PST)
X-Received: by 2002:a05:6102:2821:b0:5f5:773f:b1e3 with SMTP id ada2fe7eead31-5f5773fb35amr738463137.11.1769426184484;
        Mon, 26 Jan 2026 03:16:24 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de4918a22sm2706902e87.65.2026.01.26.03.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:16:23 -0800 (PST)
Date: Mon, 26 Jan 2026 13:16:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: PCI: pcie-qcom.c mismerge(?) in next-20260123
Message-ID: <eui7aw3ge3gmeqtlpxuamqrrldgjxluwtqwvvdxbcj7eim2glt@57hzi37e3rfp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-GUID: UBIGQ5L1xMm9fcFOLt8miHQrJCGhKcsl
X-Proofpoint-ORIG-GUID: UBIGQ5L1xMm9fcFOLt8miHQrJCGhKcsl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA5NiBTYWx0ZWRfX1kouyB9rdaFB
 ZIOr0Lwva6VBx4A9mwrGEzGz9byorRz2BAaRus9xvh/FlIynWbzaLbDlNU57Z0mN3ZunX8c8CFu
 o8X7uMl4ljAsxMVYD5hI3e2TgwUFOtQPbWea03lPcN9+LUHNOeg3AZFBjle0pXfp59Rr0o3yJKQ
 FyAIqkNOPSbwzUAdcE9uXGUsDXBNlPqVISvR3PQgP5hssBr3yrPJbywlSelj2vBlOeGxoKZjgEU
 OXAl2ec2D+F2sypCDkcgpnPTCZ4XGrFjKjWvb5QtrG7trQxgudf0rwmhSUQ7MOOEH7/6XGl9O7i
 xoe7fTNhR4glP4LTi/k8RHRpYcNwaY4QYaoSM7cqdhe+hVvOhDrFNxXkPZSjHLLHMZ4jJ00jBZD
 nCTn0ihVDMfcf5B7Gu5XN3Hxxmw1mCCZ4Xnyio1CkrjOMSgFRhA/JNwUz4zS5fX841zbg5Zwtyi
 3el7Io6ERqmRCrQAdrQ==
X-Authority-Analysis: v=2.4 cv=Htd72kTS c=1 sm=1 tr=0 ts=69774d0b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=P6JkxrBpAAAA:8 a=i2sso159dxcEbW3x330A:9
 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22 a=dwOG0T2NmQ8MtARghG3a:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260096

Hello,

It seems, there is a mismerge (?) in drivers/pci/controller/dwc/pcie-qcom.c
in next-20260123. The next tree silently reboots during the boot on
Qualcomm RB3 Gen2 board, so does commit e4cfff34b9ad ("Merge branch
'next' of https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git").
Both of its parents boot successfully.

git bisect start
# status: waiting for both good and bad commits
# bad: [ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea] Add linux-next specific files for 20260123
git bisect bad ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
# status: waiting for good commit(s), bad commit known
# good: [8f0b4cce4481fb22653697cced8d0d04027cb1e8] Linux 6.19-rc1
git bisect good 8f0b4cce4481fb22653697cced8d0d04027cb1e8
# bad: [276b0cab7e6605fb7f393375342a8f1efb2fdcaa] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect bad 276b0cab7e6605fb7f393375342a8f1efb2fdcaa
# good: [bea0cb0fcdc2f127de75b2d587fedf31af8de18e] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect good bea0cb0fcdc2f127de75b2d587fedf31af8de18e
# good: [7d8322e4859e6fcd765b7c414548b001b7ea89e9] Merge branch 'xtensa-for-next' of https://github.com/jcmvbkbc/linux-xtensa.git
git bisect good 7d8322e4859e6fcd765b7c414548b001b7ea89e9
# bad: [e4cfff34b9adba701c5f26bed4eeef18921f01b1] Merge branch 'next' of https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
git bisect bad e4cfff34b9adba701c5f26bed4eeef18921f01b1
# good: [58c8b8169ab8a5bea68e081904639fbe950b8266] Merge branch 'linux-next' of git://git.linux-nfs.org/projects/anna/linux-nfs.git
git bisect good 58c8b8169ab8a5bea68e081904639fbe950b8266
# good: [b860f2580770b1129205f140ea3e4b9dae6eb59c] Merge branch 'vfs.all' of https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
git bisect good b860f2580770b1129205f140ea3e4b9dae6eb59c
# good: [97b9a441153a59b9556de8cfa21f0e978ff4b927] Merge branch 'pci/controller/dwc-imx6'
git bisect good 97b9a441153a59b9556de8cfa21f0e978ff4b927
# good: [f770e4c1a488edb5ea96cce67f41607c259d704c] do_fchownat(): unspaghettify a bit...
git bisect good f770e4c1a488edb5ea96cce67f41607c259d704c
# good: [a8d9c82119633a741d44f4955b86caa4710a7102] Merge branch 'pci/controller/misc'
git bisect good a8d9c82119633a741d44f4955b86caa4710a7102
# good: [abb0434496c4299223f69bcb07174dee2e764bec] mqueue: switch to CLASS(filename)
git bisect good abb0434496c4299223f69bcb07174dee2e764bec
# good: [66d7b69cfc189c7e14234327398fb737bb56dea2] Merge branch 'fs-next' of linux-next
git bisect good 66d7b69cfc189c7e14234327398fb737bb56dea2
# good: [62d82b19b194120643f71281995bf12aa3f17c2b] Merge branch 'pci/misc'
git bisect good 62d82b19b194120643f71281995bf12aa3f17c2b
# good: [34793812e59224a3ba0dbe9383a5b6aea7b2fd5a] Merge branch 'rework/atomic-flush-softlockup' into for-next
git bisect good 34793812e59224a3ba0dbe9383a5b6aea7b2fd5a
# good: [4a2f8feaa278e58fd623a4dc706c3b8cc35867ad] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git
git bisect good 4a2f8feaa278e58fd623a4dc706c3b8cc35867ad
# first bad commit: [e4cfff34b9adba701c5f26bed4eeef18921f01b1] Merge branch 'next' of https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git



-- 
With best wishes
Dmitry
