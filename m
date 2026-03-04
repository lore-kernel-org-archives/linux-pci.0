Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14E37FF79
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612218; cv=none; b=DJqvjFbVE6OOow9E5UaEMy5LLex5nJnPc8Nfb/cc8uiyvPb0azpZYpSG+VRYqhnXSrzK2cZX+E7Tr8wW5a/jsiaWerwqb6awWpuS293SbYXDy1mhL8IlyXFUKpLswB+475hRVLIBigpG98NBhgAwEgXhj3CUs/fxVhjzECfZqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612218; c=relaxed/simple;
	bh=/opHycjzCFnLxsHbSOMeid377lF3ptlX1EQZCIflr58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBfXFKOVTp9u2z5HxIYDl+lXeK0nnc87HJe9YO/s11ly9RWfphuVGmdvEw/PnmJHC4nIrXCd9tpMvQLU8vZmrGAYEzBVMPgpAMiuUIz3ALNfNlnsYCOs9u4/0wuXHWPteNND1nYUt4CFec7KfGYg0iFZlICA9i2C63h16/O/3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nm4m1xbB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NJztzAx2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nm4m1xbB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NJztzAx2"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SwjV1678348
	for <linux-pci@vger.kernel.org>; Wed, 4 Mar 2026 08:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Job3nN6oBSFSLvd2I1gGw5nzSr+/eP+fBHqMQIMVzic=; b=nm4m1xbB27ANg9dC
	CpysdbDg2A8oldcxHtHPfGzfi1uMPgK2bRX3h8P6+Om/07V7Vo4+DDrlus5BYb4I
	59miPAMx/4RnREI18QeObRJ6TOkdgC749EIGtXcPYM8SZyuG7zyJqDW7IqcrLO9g
	iUESJ4mqs4xdT+XwOE3rlIdOlConVbNoYntRnJfndYrZML1p9kuP+HEa6YbEMLIr
	DIpwSf6k5AqT4ETNqS0o0QXulsyY6L7oNQiWYeQ+RePYRLazp1ggP8w07RXs1yYb
	QC7TApuuhcKvONxbKOYxatm85NyjxIBGW8LQSV7LwJcSkK6EuMZfCvIBreim82Ie
	zadMRQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73h9yn9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 08:16:55 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-899fa82ebb9so195932226d6.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2026 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772612215; x=1773217015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Job3nN6oBSFSLvd2I1gGw5nzSr+/eP+fBHqMQIMVzic=;
        b=NJztzAx2MFayNZJWDxF+bGWJ4YxGE+v729SwXBtCKVjHLUz6/ttc2PUXCkUj6P4Dlv
         INbJ4ljLq+mlS/BA/c3XFMcdt87iW2cpEQNEvhIvr52K1OggPm9ftLziNgyXhWB4aVlI
         5poI/F0w3glSOLnJBx1GgR2ZEPHyS1qXOO/KdMjQ7U5vt6U2ZUPhSi0Mm9SfA5tnXVi8
         iQbE361lvZJ0a7aSx1pjZTm8Ao7Ds9E4owZp53nTof2BxB0h18NDGkcV6kxT67vdckou
         7l1/phyPeSDubTjYLrx6G0kHgeLg4zLP/MpeoiYrrxDk8ftKoTRhO9woGKgAB0ltlBOD
         o7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612215; x=1773217015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Job3nN6oBSFSLvd2I1gGw5nzSr+/eP+fBHqMQIMVzic=;
        b=ee0N36Lk8u57wYU+befvorxK7SizcZFUV8KSFEWGfxszNQYqL7g9FPj4GI3sW/cqEG
         6AkP5W5NAM9XE+s25RxJdJ1QcAuuTPIvqJRjctV4OcMLsYl9b6R2hvk4t8Fz1gFl36DG
         /5Lu8sSe2G/BJ7PCooaHqCWINM0128MAU0ViJfAhvI7ilUcJqijmGKxOrAzcY+0qXugC
         RADUHFhHcZD0+0rkHTGNfnAAEyHuIBBHvd3prACG/zpmNNL1yv/4iGrefjOBsna+j7KN
         Ol2B2Xgu4nifVV79ke96egym8M+jUmt7ORmLsZRfcadb4OgdFmLeYkPYdiMzZpnDiUmj
         o8TA==
X-Forwarded-Encrypted: i=1; AJvYcCW9M6Bg7sjvqUSf+NgLtu4/Wlwo+JmUQMbWHSdkR13d4OtzWyystbJOjrdHcdIcd5IUCDMXIpx8Jac=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIM9VJE9qjpatjn2y6MtxShdZZzmZwlzzdydBmWKEsDNfsQwAH
	movudhCkQ1WddZ/RSXpPlnrDrKCruD2r/Coh/DhXsJre6mahozqUB+21XNPqOoiJ7ErlsslzhQ0
	HwFa45mgNjGuQly2sxCiYdpESb4icTd8yghlc8+tsxc2XZpRpz3rYB7ZYoc2Gasw=
X-Gm-Gg: ATEYQzxvSFwz98EZeSJCKDu/wxydz1FRzaU8loAQePWQ2ZR7y/7kvqX+RMLX7hqkr3T
	EtCOBaMooY5j11uRj17SnoZsJyXgVPzAoolwzI9HgQRMxZBpE0QRUBeOU6ioLdKYbHgZXSJKYcS
	HBwm1AJMpUnNUHMaSLC3Aw/HY6DcT4nAy1plOj5Ia5rkTk6nh6FqBtFwCAPsVa+5YY3G6ATI2Oe
	c3/E6hKIFTXWSC40VX4/CYbP58BksaGI1+rPkEIuvJI0fTC3c52GmAm8fvN3cnv+RLyBxxuHzmk
	hxJtv4E5yzd+z9ZXMtdeWtz6OLGb/kLKXkLev/fSNymkWQqqWcjVVuw8HH7eGptzK2Kn8d7rqjb
	kwYfzK/sYigf0cPQRJ8UHRqtJdp4terKK9bdMNM+CHhHQcJw3oww=
X-Received: by 2002:a05:620a:4410:b0:8cb:8251:3fe0 with SMTP id af79cd13be357-8cd5aefbb9fmr162488985a.24.1772612214746;
        Wed, 04 Mar 2026 00:16:54 -0800 (PST)
X-Received: by 2002:a05:620a:4410:b0:8cb:8251:3fe0 with SMTP id af79cd13be357-8cd5aefbb9fmr162486185a.24.1772612214248;
        Wed, 04 Mar 2026 00:16:54 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a58dasm16666429f8f.27.2026.03.04.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:16:53 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Felix Gu <ustc.gu@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Fix device node reference leak in probe
Date: Wed,  4 Mar 2026 09:16:51 +0100
Message-ID: <177261220761.4483.11760077832525432450.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302-m2-v1-1-a6533e18aa69@gmail.com>
References: <20260302-m2-v1-1-a6533e18aa69@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: CXvoGwP_4KHrKdlUys8iD9cgOZXQLjFs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2MyBTYWx0ZWRfX5CSnFeB6VoHx
 F8dQCU38G3RKev44RViMUpOeZUgsmjgCOCkpmjp5J+piN0n12NbmnJvrIOBoTiwrlkrPD9OY1BR
 CEAeHYhDDC3zbguNu3UFfekBSSO2ktyWxALj7WpbXEz59rpu640P/kbPGzzpG8AKePXE5Cea+0H
 +nAtaOMxiI/2LkQXuckpwkpjb4BobqAHG6kVJqdmp/G4pRnYGHIEj6G97fLFx56snvbb/3uN1Eq
 lkaeIAyG41DRgrOW32OIL5l0HKY1yWD+s+O4HWsJkv+MQR5sBSpVg/fpl3iXXJ0mbkv5Xp9Viwz
 lUO/Wgq7+dPeCIx6JlE4yvI/po42jT1nxPv6/G2XQrHh7lmA9Mjd1Gr59YfpKabWU/gyiAVf5HR
 AOwRByMZOYe0uSOY5IAdvxILs40XUDCg+lr/0ns0cA3UvHCjRh4fRClEvJY4zeNmaNbdHjdAYpT
 23QsQQK6DYAzpzn2JEg==
X-Proofpoint-ORIG-GUID: CXvoGwP_4KHrKdlUys8iD9cgOZXQLjFs
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7ea77 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=SUrkIAiDFwdAeyG8CjUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040063


On Mon, 02 Mar 2026 22:31:44 +0800, Felix Gu wrote:
> In pwrseq_pcie_m2_probe(), ctx->of_node acquires an explicit reference
> to the device node using of_node_get(), but there is no corresponding
> of_node_put() in the driver's error handling paths or removal.
> 
> Since the ctx is tied to the lifecycle of the platform device, there
> is no need to hold an additional reference to the device's own of_node.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Fix device node reference leak in probe
      https://git.kernel.org/brgl/c/5c3daa5301693d2e5364483a3405649a0fdaed98

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
