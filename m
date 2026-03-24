Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF03563F6
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774338575; cv=none; b=YSsRKGX0xyDqfTF4x0Y9Rta0/pv4JXqGbry4qLRCderKkBnqyeXVEbAZfjw+z189EHDGohMXSnyjY7o4W7MhK7o2tuPGHYR/dSHmiweviVRWhYshqaJWCIXFPmLnlJPHRJYmZpdMV1SWQKg/1zAU3dxTK5TOIoo+dm0HVVzzTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774338575; c=relaxed/simple;
	bh=W2oLhAEL17w3es0YuJ0OK7GjWfVlwSZ9xozpBpnvASY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TA5XvRB/I7SICRkDWngKlHO3W7NUIjHj/0b/oo/wU+Oq0gtZVigvqIlqmD+jBzcrqZa+qxPV0f/Yl/sI6A9QvEoY3LIxPftkOsLHS9JMOOs4KpdZCFg3UYhrPZlSazR7PSiFeg+GJBaX4e4zGtVr9iGnsRsMFb8jF/Pc+ddwJPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bQ7/gJ65; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ftpzT7Bt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQ7/gJ65";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ftpzT7Bt"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3dDIW362500
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cyJ+xo5J5uXO5RSDiJtrPj/qdCmHyoKNI/w9qldPyo=; b=bQ7/gJ65rZpY/3zQ
	bm4iOWvzXNgKPrvlm5mlRzozCdqYJ989reLMknoDBwQBvVb+RYl0RQm0EbiOZVg+
	EQf/mHoFAOx0A9DJREHr6A9q96N5AGUtSRseLwqwwwuNSb5XxBJeroxTGI9g9DSd
	3i4JhIcgoc8aazFcPyfc4P3M//AKR+r8VnS2HdQ2xvoOdVSjlcNWQmQYbf0fSKkS
	VlPS/89tuzsHevKKQptthWtupN3moOB2wYADRexohxFkm7yhfZL85QtPtMbTWSpJ
	r84SlYLdAemxzz8N36Q3K/J1K6OvgPlwHyNr5jKxYv5QHBnMC/gRVwaDp0pe88EI
	8P3BVg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d33k34577-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 07:49:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35641c14663so6589386a91.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774338564; x=1774943364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cyJ+xo5J5uXO5RSDiJtrPj/qdCmHyoKNI/w9qldPyo=;
        b=ftpzT7BtvqL5hQBXHOZYQBEG5RO4n0fit8Q0tK70T9jfEnxDiz7m1yO0XbrPL6BEHl
         IercNPRYuwhMyESSUtXhodbyMth8VzD2jFljkNbtF3/yuIHjULsPK8+9vhjwef1HKpqM
         I1jKFhTR6dyQaCSF9eud5UCvFI+bqiZeYzriU2lhZ87RlgsD05oS5/FXbLVPhdxe6V9z
         8wIyhuOe3DMnzP5Guhsm7vezntTX8zm4tw+fwLi7/c09eCZKvovS4PU9HLkmYMPJ5Ptj
         acagPhVUFRsGxZY/J2p9ZsnQrkHBCjAMdacOUS9mhQLK7RMZVoY0iNBoGiyYK43Ol1bl
         b7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774338564; x=1774943364;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2cyJ+xo5J5uXO5RSDiJtrPj/qdCmHyoKNI/w9qldPyo=;
        b=g2dbY9Ip8eCGYuarCJiw2/TPA3/cG/8zzSOFJqdbt+sSFxaXbZBINO+pd9pnSaBrSB
         8BhmRq2OORdfORpqU2b0aFnszhQ4rMlMVaR4A2edtWbTUKqlC8ZQ7b3XCHNmzE35HlCN
         77KVZkOLZjdlsVYW2yyL5z6XjfShkT82506K4Jg3jZTpeFh2hCQbj98cu/mjO09SBBo7
         rlGqhL7iNaHpq5mySYfq4ia/JDB02iaArz2UxUgyvM1HTukvBkHb+BLr9QNSL+MEeVI8
         MzyQhjh1XYVXCNkEJn8EQMveGtzzkbrd6IBzuxTn4Mzw5j7MV5rIk437xpbibBDoe+JK
         jfCg==
X-Forwarded-Encrypted: i=1; AJvYcCU00d1Rgq8mDAoV2+EHd/I1mvIpKdaAqPyF/p5X4FBElpOz3Jw8R7qY6+0FXorCc4U2QfwkR4AIlks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4tSLnkO0ThxBbuVThY0mQzvNsC6GmCkBejcebi1eMG2hK1Jt
	Igs4Kr39Rf4FtHzDF/j7DZpiABQuGl2v2oP+ZyaGQYeTv9Hg5V5dSHgt3JEKQubC86gEIR8aYTf
	i7uSgaeVXHbHe0+0utkGxO60kuOVurDZHHW6hjAYjnIIAV0Gsq6RDBWFOU6JHSgk=
X-Gm-Gg: ATEYQzz4XgLK79R5cpJk1NT075FTjQgGYt1bKxKyXR5SugSfDEhZa9oA7+l1/cIMioo
	Uk+2iRN5T2qstdOXsbDs59ONqYgAhMUE1Tv3OIQm/Vjj5CJlf5tQLoDVAHMoKE9CRwA7SCWwT0Z
	OXiFhO59IybrX3JRnmhqqqK5VyZWBUnl5t7AITwQCUIxliGMqY98j+UIK167yVoBrv8Lg0xjJnD
	0B3Oko6+khea47Q/VoYMEUCGDzOnHoJ6WLUHhc9ZMsAjzqpBs2+uk5vt3lOiXvqwL/IZ0L92vvm
	kxLDzYCMshziCU6fj8w+XAQ1uPqnNxmWDyXVjgLOMxXeHayk5j+28fgVbhFwrgptDJe2S/4z0E0
	YqkLtvznrP+O782qNWppuimU=
X-Received: by 2002:a17:90a:6c82:b0:35b:e51b:1936 with SMTP id 98e67ed59e1d1-35be51b1952mr5318992a91.16.1774338564259;
        Tue, 24 Mar 2026 00:49:24 -0700 (PDT)
X-Received: by 2002:a17:90a:6c82:b0:35b:e51b:1936 with SMTP id 98e67ed59e1d1-35be51b1952mr5318965a91.16.1774338563741;
        Tue, 24 Mar 2026 00:49:23 -0700 (PDT)
Received: from [192.168.1.102] ([117.193.214.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03206dcfsm1441552a91.13.2026.03.24.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:49:23 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260324052002.4072430-1-wenst@chromium.org>
References: <20260324052002.4072430-1-wenst@chromium.org>
Subject: Re: [PATCH v6 0/7] PCI: mediatek-gen3: add power control support
Message-Id: <177433855940.26248.5285712170276296674.b4-ty@b4>
Date: Tue, 24 Mar 2026 13:19:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=CYYFJbrl c=1 sm=1 tr=0 ts=69c24205 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=13ILl30Z8QjaXWZz8Pan+w==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=kFJ3RX7tyYxcrSALf5wA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA2MiBTYWx0ZWRfXw0CyR6xHDoYO
 6BCtHapSrd4RjBoYjXubRf0SG0TOkyy/vcdVpUk90zxRhE9iyTmNIDi8jx4bUCBmQjycwfxFy9h
 eZT9D1lYBoF9+ZPDDco8OX4gu+kk3hDPtK/UyBJB04tanghmA0gsKq2041rdQxTvTsgkPkNSgzS
 Osvsi1yQP+zrVjrvtU0urUqrV+NyGHqOPMq5yulUrLDGZ/3VH8Xm2vPFCKLGxYicS6mevcp/X9J
 fKusMueMYOsxZESbqXhGwfFP3nrdWvXCvLXIwhVXbIlnTF82wBlWbhoBq9cHMDyab9jZXl2E4Xx
 AKmb/BwIjOsIK/CWlRg72ecnToy34EZbODqjsn3imEGq5h2hNepZr4vWBF8rse/v1KGYg1urRlj
 3QAv7f/m1cY1q6WLMH7IZXIeu08j/fAWmOTF614B1ikHpMX+p4LSxv0zpaJ203q6nwmvYcpgPRJ
 aJQNhD7SYalHYAJxuUQ==
X-Proofpoint-GUID: -BVOh3V0JUxzeNqt7R_sJ-m_ACAatV_w
X-Proofpoint-ORIG-GUID: -BVOh3V0JUxzeNqt7R_sJ-m_ACAatV_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240062


On Tue, 24 Mar 2026 13:19:52 +0800, Chen-Yu Tsai wrote:
> This is v6 of my MediaTek PCIe gen3 controller driver power control
> support series. This series is based on next-20260323, with the
> commit a2b2ca0c2477 ("Merge branch 'pci/controller/mediatek-gen3'")
> reverted to drop the older version.
> 
> This series is ready to be merged. Please drop the older version and use
> this one instead.
> 
> [...]

Applied, thanks!

[1/7] PCI: mediatek-gen3: Clean up mtk_pcie_parse_port() with dev_err_probe()
      commit: 71f526831e9d7db53a7b01717bfb725759b1d06f
[2/7] PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out of mtk_pcie_setup()
      commit: 0c7398cbd5d0c0d9952b6bcf1fb738e252ea0f50
[3/7] PCI: mediatek-gen3: Move controller setup steps before PERST# control
      commit: 67b1ff043b0ddd88e0a6af6c4c3590a54b60eb93
[4/7] PCI: mediatek-gen3: Add error path for resume driver callbacks
      commit: 76190e45623aefd6a84450af5c84e793f4f6a796
[5/7] PCI: mediatek-gen3: Split out device power helpers
      commit: b8cbed2f4d783f4d9f3edc5dc6d2aac848de3709
[6/7] PCI: mediatek-gen3: Disable device if further setup fails
      commit: fded9d718161f1c8da7a8464b87a028292ad5573
[7/7] PCI: mediatek-gen3: Integrate new pwrctrl API
      commit: edb2f4b495fbf1b148df0deee147ea5c320f56a3

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

