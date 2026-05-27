Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02A3D3490
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869904; cv=none; b=KUZxJIgPLy4xpJ+QWZv3tx/UZ7Ac6Y9MxKL6B9qs9sjYqyQpof/KI6QVgagk/mlhZ+TWNRuDdu67pDtxQNOKL29Scz9AFsag8kafsTV0lEF5H83YDqdliFjvJinkVgDf6naznXz9oUEuJpWQ+2ZIoinHi40nlsl7gy83KCyTtKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869904; c=relaxed/simple;
	bh=k0eYI/tcoPetwLHY3ErdffSYDhxyUrEIeQsBj7DcntY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lWSqke7dCpECQGu7XuCQhU0IaotxczmXno9WSseW6x2Bv/iuIsyk4NZQlbvLOWB7374k6kQ0EMh4xwZX3px09yR/LoUlkQn8hEjt0UHEFi6SC4DlNnCg1CGgFR0OmDAp2Pd7uJjk1JAhGSCw+MdQm4m8P+ElgJbpHK46XUwnfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KM1/7Czx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g/KXONgB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KM1/7Czx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g/KXONgB"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R2WhpQ2983856
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 08:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOANBoJGkhQTTtDkuoGE3NtKeQCxPUUpR+rdobnCBi8=; b=KM1/7CzxFiiGQQ0M
	MH6U23dOsfeKlHhc+t7VfbCHxjmpTUsEbFWTQadTUiPEO9BxiFLcCryd7sA4WRvX
	AInnGBcqyljcilciU2UJ5JYYaF1D+HZBkAN+9qfBjobwyPSqM6gt+lSsDPeW23vr
	V8XEFEonKZwWLdqdWGXhbzyk5722RoJkYuds3JrSfAjUPv9mLt17FO2KDQuGeBZn
	rsQtXyrjFDR2xVcTa0+XEGFjx9omJQgwX1sMBc8Xb8EGDyob6u8ET91s20AblJu4
	5n63g4qz16ycslD84192y3NvgZhHltRuDJPeXqd/+zYrxG0hodgGLqwCPIioCQVy
	QlRyHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edn17hjmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 08:18:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-514b673c8f1so95013641cf.3
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2026 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779869900; x=1780474700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOANBoJGkhQTTtDkuoGE3NtKeQCxPUUpR+rdobnCBi8=;
        b=g/KXONgBGYFJsvu0d/N739Nxq0dx44e8tlgfsIV+VocrR62ykUslaVOTBXbJWgpNnp
         ytGiIJr7MK5AxWkeNkhX2kV/StYwLgs/HPGQllACi/NKVIi3qEQYCvDn1VsC2nTtZDdW
         zjtbU38QAa+GiHgB99w2BhnvhuCtkbjNCKykU42gfj0inkGG2N6KmVpJH9k3gzLShHH8
         i2Zjuwr3cWO74lbLwAXGOzRu1FrSS8gxUewH3qjzI+tiSBHsnxq8smmNvAJ3CVXtLS0f
         aKJ4AXc9DSzoORRMzkkhOFUgdVEtT/2Vg30BvPM6ewz2rnFLZZOnAV2LpMqAdL3wFckt
         fYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869900; x=1780474700;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rOANBoJGkhQTTtDkuoGE3NtKeQCxPUUpR+rdobnCBi8=;
        b=cBdMs9QClF5E3s9ZubLshmdBQnISHcjMwuQuxv9eZlHTtxKpELncQA21jE7hfEIAM2
         ZwLBHEx1bUdw9ZC5s3X3L5qdIIgvyIXoiWhYazgv8yw49TsgvUhS4YSSvhGh/KXFO9xA
         qdTrWCHZfQBN+zEJPlb16rHuSMZMX8KSuZVwJRRCvYrMPYpCT7Yxxn/NT6banoU56arM
         wBi0EAMFEeb8pui6Lvrul8D3M03/17e+WmG3OPoFQtZ9VPrj5yZ6p+LHSg2m7aRJa5bl
         6YLrJfd8OzYOgbux5dyF4go0IZe4jDN836JHLt7MpgHQFMsAzkaUD65JBcLDkEjwDqgf
         kVsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t6YfPlu5tjcwtYqFPJpDLhvhsT9+MFiPHA9MIWFuDEmDWuBlRK5rNlxEEU06YnTSZLE+L6OVCqVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHjfuF0BG7iY9Jg66DC7FKj2e2tFsgWbSxSZpTh1AethvJNUiJ
	sBagB/RrPADr8YpQ1S412zZzp7ccuf5/rh2U6s8GbAzmr65U5Tag8EgGwQj5XXhBWJ0y6oGPuIL
	PcYgIYpZjCdTBaxkaFNnJjEJsEFLLvv3vsbroEYiVxP4XenZS11fX99fHDulAy9Q=
X-Gm-Gg: Acq92OHP82lvrtL9Yagfowhd1+rpqwdcujrhdLdp3LL6QFkHhudhH4KZUn+ZvlAAzsQ
	bT2hS3oUb3hSlgeo+kt3qGUiN4u48rIoL6j2SeU5oPRESWdutuJHeETRZSLHX/m7HJ5NLF+edMc
	Ep+uHmzQFRFI29/A1bityyPpmiWpi7BqC4PQV2qL032Eu/WoVyi/WCMYYdNhYO7epWIB7p22FHo
	qpUybhWX6r2RyQcvdKN01PkJ4TfO+uEzwmmwqoGwXxA8mNLFTAjKEzWqgDRVEWDXze+7zkvBQcb
	9XDjlyi6lzuCsjrsztGCX17ndWJYL7GV3pl41RVkuz5P2Espw8wL5s2Ct+Jtss6ISlcYcq/84kb
	djxwmNtJ9wZPmHER77RHWF+IvmIFVv+iWM2E91fD9B21t7p4w+jnjC5O/Ocke25BoD5w=
X-Received: by 2002:a05:622a:6119:b0:509:965f:888f with SMTP id d75a77b69052e-516d431d5efmr284072481cf.0.1779869899944;
        Wed, 27 May 2026 01:18:19 -0700 (PDT)
X-Received: by 2002:a05:622a:6119:b0:509:965f:888f with SMTP id d75a77b69052e-516d431d5efmr284072081cf.0.1779869899245;
        Wed, 27 May 2026 01:18:19 -0700 (PDT)
Received: from work.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b1a28sm4329959f8f.26.2026.05.27.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:18:17 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        ntb@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, den@valinux.co.jp, Frank.li@nxp.com
In-Reply-To: <20260407124421.282766-1-mani@kernel.org>
References: <20260407124421.282766-1-mani@kernel.org>
Subject: Re: [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
Message-Id: <177986989704.12139.6324839457205446816.b4-ty@b4>
Date: Wed, 27 May 2026 10:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA3OSBTYWx0ZWRfX7adPBUf8E3Hc
 L6Gvzf/E+RB1CDAT8jBllkvYfpE/sGt/QA2cVlLBohoOk/mydYpWXqN2mMLcPfuSzRQ9JLfVyz2
 9ycVEosCwEuulvqi9R1GRfLyH0KOYS8jRueUma9KhsgDlgiprvkJ242V5Zp5piNvGu7dRswG8gF
 oMxM2iJzl/bsEb+n5+HbDcCKLJV8bs+rgJvMVUrJKv434004v7YK5qh+OgFvt6nhOialKdCelC/
 4P1QKTt2o9RzhgCpXVzPtbKVrQo5w/UXu0ydEeSKSRsomWbBLSUxP77TrZe3F6I+rHVBzt503Yo
 YNLs5/yxvgsmOHouV+J/58vhbnVpTAXp1tD8yhUBlhfE7keroNE1UoY4uZiZu5SysCz1C5ipIGZ
 gkjaQu+4cWc0s7dqhtwzao3sS1CIlJtvYiJMGFK3k6J0floEZGBx8EqQ/o95rJ+//n4/5gJubIj
 1NrEYN22OfWz2b2l0pg==
X-Authority-Analysis: v=2.4 cv=R6Uz39RX c=1 sm=1 tr=0 ts=6a16a8cc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=nDlXaIEONj1azYL8NVcA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: z9EBLYLEBiIy5jGYouEzTImCNZS6Iagk
X-Proofpoint-ORIG-GUID: z9EBLYLEBiIy5jGYouEzTImCNZS6Iagk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270079


On Tue, 07 Apr 2026 18:14:19 +0530, Manivannan Sadhasivam wrote:
> These two fixes are flagged by Sashiko during the review of doorbell series:
> https://sashiko.dev/#/patchset/20260406155717.880246-1-den%40valinux.co.jp
> 
> Manivannan Sadhasivam (2):
>   PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
>   PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
> 
> [...]

Applied, thanks!

[1/2] PCI: endpoint: pci-epf-vntb: Add check to detect 'db_count' value of 0
      commit: dfd986796037ce31af73d8be416d98944ec84551
[2/2] PCI: endpoint: pci-epf-ntb: Add check to detect 'db_count' value of 0
      commit: d2942f5fc787c5e327ede76e0aea2cf41949e500

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

