Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2939B978
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587663; cv=none; b=ImwfQ9jc53JYtekdZPGzmvWSYFSFMQXBsch103U+9Ir1Zf2TFtpkKs1cicm9K7/YeFofTahma4Czx6EdnGaeaNomUaj8z9CF0qosbkopHcZrbCLTIF3KluX718TqODZatF110lyBQrp198oGBIM7Xl14kjzqlQZH3vLI+0BIVzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587663; c=relaxed/simple;
	bh=K0hlM0lN30Bc68DtvvfoVqrg+eMKbU1QUkPAArNR96o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jT26+U8Mi3x6DKE2ardp8jQjYI3UPwF44kVWsWK+sVZS36bptngmxGcrnVOu8cIkddvcRdCkp/H31aHCdE4ua5BCceWank7CZFeEAEOTKw/yoMytaZQBBv+9veyTwESZFiEinwoiC/48RDnKwTY40b2lXlH+b2mkxLpqNmXTuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZvoiO5aK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NJgvy0CC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZvoiO5aK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NJgvy0CC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CB2F6a3385878
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 12:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	euXmck1ELzC/OgIo6WW7EsF+WFVXfWU0hYGpGH6Jnlg=; b=ZvoiO5aKQTfe8/J8
	6fLvirWkWOFT/yzkXH1Fteey3X/qgO8vTUfz4/oKPFSZcZIyWXErDwkALjM4AVah
	RYp5ResAk71U04zrfqNf8s3UkRDQ36WCyu4qGXH+Zim4YxwcQ5KyU3ytqcJ4URiM
	zpIM3cZWPKD6lsLPv/gxgw26oOeZNV4ouJdY69qKRronIBvKPRezqUdN1XyqeaDy
	HNzJaKtKu76EV7HhcM2FEJ55xpLhDAJf8MXmk9AXmGC5YrJroBQmMnQnPmNpJ2Fw
	XSZm4keSRDbrPT17ey+8pB64TalWouYPdWqQo73X14ojEAM5mZZhjcKjKxTTQdgg
	FmLEHA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv4k4ue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 12:07:41 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8271fb4407so3259435a12.2
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778587660; x=1779192460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euXmck1ELzC/OgIo6WW7EsF+WFVXfWU0hYGpGH6Jnlg=;
        b=NJgvy0CChAKt1cAN7MGWPrZtokGZAQjLeh6JYWBYBBmjN6X8YwKahl6AQfzpBJkrle
         0auvK0QNedxWoNeVBto0O5Z+grgxUanYifTuW1TSA1D3DneGOelTyeebxXWCjSlEmx4a
         MUa6GGoeNzmCILH36Xx+hTTXCqAqRA9LVlzK3+snjJb++HMbAKZ8w+e6UtXzqw+mQJlk
         AQLMrdzAIGVKE54TvE3eIBwnXUn+llUo/CFY0twbQ7jhoQRvatMnIaZopfG+uHpuQpjA
         MQvgiCykA7U1HaSwbJGTke/oOIYnLsQiUxFj6WIgufPPnjuDiNV7gKlUYRQHgUKlZJIj
         gnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778587660; x=1779192460;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=euXmck1ELzC/OgIo6WW7EsF+WFVXfWU0hYGpGH6Jnlg=;
        b=RqRAd9Q36D1H907Eb1Uft4QOAMb0uApZnetaLe/DLzS4hevDmkT7KkLR9ipIRJUqgA
         RFg/ux5OkV31UycHAwM2krz0UFaznBbi3ksz1T8SaPvKTAkwo4Y2ntT8+oo0nIbdoR6g
         PUglDD22bQYNZxV3rih8LWOvmy1F1TB6hsSCrQOEZDp9xYf99kEN6a4jj4mxraZDCkA0
         aPZk8C5F7sFWmHjtgUso4o05/6FMNtrE1ziD3tJ056mJX0G5q5U29FsfAmWqxSK3b16U
         yumB9yzBJoUTC6MpKos6QTOv64tZdLDZgWVFuo6idcJDAwiIqnLwKuJrySUdpWOlKxIQ
         vmpw==
X-Forwarded-Encrypted: i=1; AFNElJ901nHfJ27Ow0M7Fc5+Wtq133FObaYMb0EMjgmcOicSLv1ioGeB4gL1VhdsJaRt9OhkLN2dyNN2sQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUsxFjizfZicYzaKYDemMI2CeGXe3gashzF/W6iDThZTgXKa1
	JjvZZ6veA8QV95vAyO7+juHbwhsG52J32RVwG4T2EbP043p/8tMiqPZHio3v+a0Z7KfDcBfpzrq
	btI/jn+XYS0yAsCwa1/VeLjjl4IJ8zMOMV4f/f57fuf6owr9Ol51/TE8Z7w4nIrI=
X-Gm-Gg: Acq92OEtBd1BOsPOyt8FCy/mUUmv3E3w5QpdhlghFKargatl4JBm/jgNsQm6CCjnwit
	/gg5Rr0e9SwM2392pLBRgfQIvckyXXfGyD1VQymj8EuA2iI4P29tojbCcrpHWrFlsozra2G0xq4
	8NrmjB/vA7DyOjZZgnUbtbh67JevWKuiQaMMdqhff3rKPoQxcUzy+kOBTEO9FD03Edu+APmJ9L8
	4Iiar7QEX8o6ZIn1OlrjQN37Ue49X9ItJs5SQXZJ2JvVcqzXtkmuTdFeCL1yg2a44+77+2D4jOJ
	URhUIEzIFIbdHywCPqwSU2xPymWdxwc4Dqlkv+s53Ll07ReT0oS0gwAtXsYHq+a7H1zBJeORvlS
	aC9bkAo8psojJiOLWkF0DTQmzVYe5IG25p8Y+BzUo5+lU4j8gucI=
X-Received: by 2002:a05:6a20:9149:b0:3a1:f82e:b009 with SMTP id adf61e73a8af0-3aad42e2dc0mr14670215637.18.1778587660270;
        Tue, 12 May 2026 05:07:40 -0700 (PDT)
X-Received: by 2002:a05:6a20:9149:b0:3a1:f82e:b009 with SMTP id adf61e73a8af0-3aad42e2dc0mr14670162637.18.1778587659759;
        Tue, 12 May 2026 05:07:39 -0700 (PDT)
Received: from [192.168.1.102] ([120.56.206.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267711513sm11822554a12.16.2026.05.12.05.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:07:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260416-setmaxopp-v1-1-6a74e2d945a0@oss.qualcomm.com>
References: <20260416-setmaxopp-v1-1-6a74e2d945a0@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Set max OPP before DBI access during resume
Message-Id: <177858765602.22216.18380104786326008908.b4-ty@b4>
Date: Tue, 12 May 2026 17:37:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=ZrTd7d7G c=1 sm=1 tr=0 ts=6a03180d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=QuRtzvr4xB5J0le8HPcEzQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=0YoNalqRbkP_kE0cSA0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEyNSBTYWx0ZWRfXz+kGrzkjlcYV
 GgnWF949zZz2a0qvNWz+LOcmEYNwSEkh/gsbOdn7j/mc5p06eJT+EVSrJs7WFTsCgvLP6JcI8X+
 szTVI8usOb1MPTaTBZfJKEi1U3S3iqGamwowq4OlburXzrms9xrvc4aVQ4hnQ9BnqOzIn7k8U8h
 GP/B181O6gyQ/9ad/oQIh53bVzmlxW/JP/ni+ElSfZjyjGIrmvn/vPOxxMQ2MklfDwQ8AuhFsgf
 Bixr7aWvY4V0Q9s4KX5h2Q+szHT53uOC2OOurUYNGQgDPvYrJ1yVnkQNDfbApTbvFMMuqUjiran
 t3Y9gduCA2Op2t8LDmaIYQ0qG7O6pvP2jVFRUTGf2evyOazhYIO6u3MbKDIWzUe+b2l7S5MBb/W
 FK4axeeJNkIDEmUmMEaiBtkU7PQr21mTIcOolnSq6yuNfFUDvf/33sYcxwt+pTzXxiI0CXcY2rP
 ZmryDVl+LOwzD1d42YA==
X-Proofpoint-ORIG-GUID: 0G5XeECN1lNfNySLxiFYTsifGVNWyMhv
X-Proofpoint-GUID: 0G5XeECN1lNfNySLxiFYTsifGVNWyMhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120125


On Thu, 16 Apr 2026 21:16:25 -0700, Qiang Yu wrote:
> During resume, qcom_pcie_icc_opp_update() may access DBI registers before
> the OPP votes are restored, which can trigger NoC errors.
> 
> Set the PCIe controller to the maximum OPP first in resume_noirq(), then
> proceed with link/DBI accesses. The OPP is later updated again based on
> the actual link bandwidth requirements.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Set max OPP before DBI access during resume
      commit: 44ec2e81ab3758718105b62cb8623060c0aca7bb

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

