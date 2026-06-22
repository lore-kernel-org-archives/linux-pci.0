Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B36358373
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108165; cv=none; b=DuzQRmPpfDiGDavNN2acsS7O2GhD4uVTklkgAFYFhZOzXhuV0fMKPgVE4R0AaA0epEGbqsx71soPmFZ7/Whj7nvydrGJ7a4K5OblK/E8EH3Y5TN2KDY9kGevvw701/aJpetVYu8DRo+WRBH6hpEAzFLGgqaeaIFHBNMlShDFzaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108165; c=relaxed/simple;
	bh=fhF1jkIK148QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p2QXm2wgjVhfqD4uoItzN+pJ2EboJne1wmoCqFepMRxjqIDefj00484kK7vUu33RKyIV+xSiUoLEyCJ1bYU+oNCs+e4kRe+skpZ4mG8XZgIpQjZ0LdX6oMhrwv+4UYBSKWjmxofgcMpYQBoktRnAeMe6Gw3pEfqEhZmrSDee6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I2zZHh19; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ktIt14/h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I2zZHh19";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ktIt14/h"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5C3oR173096
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=fhF1jkIK148
	QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=; b=I2zZHh19VpeyrTBrzHyPcXUJCoJ
	OxAwhLJSCD48w/Uiz+2nYqkMuDLIy8928uFQawDl/7ZIfOQSQXoPNzhp2GXCHmPY
	szMyEtOPdUJ8VFGIq9L1oMlwe+aCkuWS/CE4FosGmI+jiZfL+Mzyoy2z7hFWumfo
	1chvL9sOx0f/hBj2rTiS7WpVsU67Qk0bHdxFwaRpRKwO6xaPRbY3/DABOCFtMzng
	TCNqfJlWmIbkAl1KZnmYvpn8ooaw0tee9+pkQWuKTUB1iNi9QRDKGbB2yAtH3n4C
	uWWRSyrWboTz5yzPO6umYoPeckI7JWbuZxh5FK8TvTqm0mQfo/QOkKz7cRA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewjexw1th-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:02:43 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1399e7a6d05so445633c88.2
        for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 23:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782108162; x=1782712962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhF1jkIK148QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=;
        b=ktIt14/hhlZNmWYZ2mAw7hzbmRJPV4eYb2/ObDPHJwZKxJ/gE+HhQ7EtyKELhN9mu5
         0/qSibrAfcy0HtJTSmDwCkaQG5dd3mdqb6SegcF12hrrzPAto7q69ORWV+byIUQyNozj
         UT/qSEp226D5AAKHk9i6gQEYjHOcBUtCrPd1RpXt4MTL65cOBPCEMyZadGbgxUEQ3xk0
         EfVeXJ7krlNE5NUOH2lWwJZJru4tpqUyeyflrnFMhYb/J3CoDSwe+DkdihEttBYp+h04
         3Ln1PmIapeZBoWic0mAfrMbyjjwsr1DrWFrRxgV4dzzr9pmkMC4shhFWFXFI2c0OeZqU
         figA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108162; x=1782712962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhF1jkIK148QJRPMwgMFNLtsyUT0Tq6j6rDts/hWXk8=;
        b=lZZUBUCiTYXZGJMfAsMaVPciBBLhFpVd0kMJtfnEFysJLogCpEVjeAh7jP+L5pL4Nw
         6OTBx+YHa5k17mrrNvIAktMtytMVLz25cGuzH3WlM7UNHItjgmHwG+xHdrFeLz44muoD
         7hJUTC5114tIeZCJh4f1c34bWg94K5+2Ahstbhv1f2ae5cX7M1bgX2Jx2JnQ8notV/ki
         2T4XbkHsM0KPJBd2F9tSbcqS8z2slWpymmqvmby4D1Lcl2B7ICeV8P2WaOt1ICHDgQFP
         J8fj+xPwzJYT0NRho5mJNsbx5Mkk2LrxE//C58VFPMGE+alv02ITOf4RGrphnaervaXK
         ygpA==
X-Forwarded-Encrypted: i=1; AFNElJ+iBQG3wOX5sD0uhYNVWp4KJ4JWZknRAW6ozcvQfPllwGenl1creKgG0yWIMDrbSuibEnK399Lb03M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLk+/KtbSdqDiwV3hCYiocFjdZilHxB2I/n7P++wZisCC02j3
	cQC83KKVIF9PcZG4kPZl8mq5rzpwfl3dC3mmwJWgwPeTA0ndoWUDo3+gaqr2YIEuYAxhSdbdMMX
	WLwd2d0xRetBY5R9aV5zB4tBrGixDMAT2grE3NOzM/3SNAyItLO0SSZLiNR+9cEY=
X-Gm-Gg: AfdE7cna+LnBW41OL6OGJ7IfaqVqnmQObkRbtX+eHqPV5eQFI6x24eqi7G2HkwXlfY8
	bH/1p6IGZzxBPBU9Gn33GSiZ4iU23+tiSS/iRjKCuL7ZPJKdYQRSU1u1Iyosd04P1octq0d5uMV
	c1kApUArK1E9GGPWtSbLxKHTcxqaNZGrLmA86GynkTkTVdDRsUXFKMRTPCbSLB8lKKM2U+qNpKO
	CxiCrPagvzGBJViAxSlbxhbthc57dV+2Panvnu4wKutiyMlGyDWVnYng+umsXYOuqP6WWuhAssK
	k5u14JHVMvKaBsEmBm5xZoCsr2tw0/Hg+Isho8gnEJWxvCHEAIpaZad7sV7GQqCNBNmUhsjN7vr
	sKggrQ5OQzHZZu7WT+kNIYjMGm8+cohpRn2mcGDPwmWxqalS8/XH04legr4ZyPQ==
X-Received: by 2002:a05:7022:6981:b0:137:fea7:9297 with SMTP id a92af1059eb24-139a2035a3cmr3794611c88.1.1782108162055;
        Sun, 21 Jun 2026 23:02:42 -0700 (PDT)
X-Received: by 2002:a05:7022:6981:b0:137:fea7:9297 with SMTP id a92af1059eb24-139a2035a3cmr3794589c88.1.1782108161301;
        Sun, 21 Jun 2026 23:02:41 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add5bd68sm7558262c88.11.2026.06.21.23.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:02:40 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, brgl@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans-evk: Describe the PCIe M.2 Key E connector
Date: Mon, 22 Jun 2026 11:32:35 +0530
Message-Id: <20260622060235.746205-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <580db7de-321d-4f4e-99f9-3c9a1cc5a3f9@oss.qualcomm.com>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com> <20260608091702.3797437-3-wei.deng@oss.qualcomm.com> <580db7de-321d-4f4e-99f9-3c9a1cc5a3f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA1NiBTYWx0ZWRfX8yyn/o2OvtwK
 wSimFNCd8E5HZN8yytMyUaQ+Y4aKk8d8GDHPy9MEJy1O9XuAVBdtODI0nUJ/6L7JkWBVJxInWu5
 yDEN7gf+gtHLrMmXzDtw4SCl1Ik7sMKaxMMxyBrFbjytnybbUTWL5KNUH3PiX8Gzz5YpgEvifsP
 eIAS5I9TXTG+MnV3vtQMaz0GOPx2mX3sDvzDGUIwKe2/v5PO6grskorkRfT/M6D8zFBC5M6waWq
 FN5Ujw5NDq6RDkOWUspegLA3Kn9VUnWaCXwPDFQh1VQ4NTuCuwIxRaWs2qVim4OVNDJ23Uflhe8
 fnqmvi2BvBxDMMD31z3REpj0y5XXtS7N2BGfD9tm7+cjWwM+Pqi++Qexzv+HOwg3olcDIb9e+lS
 0jZhFIHBakXbcZn3/mBh1UG3gvXvw4B/gttkWFCdm/tMZxdTXsbRui6b5huy3HT/83TpAuV98GO
 CT7KvKMVjLXhpWX+Xkw==
X-Proofpoint-ORIG-GUID: 7PL2Ly2Qf8IMKCs4zGvaQrmPy_PL2LFc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA1NiBTYWx0ZWRfX8UspBm69s3Ec
 u9yre6yl1zFC7PeSyBIuCye9kL+SCxsCzdbfXnjIcno/BCVedEMQWuB3TeDpSIAG6CJBzuf5x0i
 EuzB23AFtfQoU8htD4/s8qnkCWO4L6A=
X-Authority-Analysis: v=2.4 cv=YtA/gYYX c=1 sm=1 tr=0 ts=6a38d003 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=wHO1jfwDuY-934FNkv4A:9 a=zZCYzV9kfG8A:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: 7PL2Ly2Qf8IMKCs4zGvaQrmPy_PL2LFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220056

Hi Konrad,

On Thu, Jun 18, 2026 at 11:49:05AM +0200, Konrad Dybcio wrote:
> On 6/8/26 11:17 AM, Wei Deng wrote:
> > The lemans EVK has the PCIe M.2 Mechanical Key E connector to connect
> > wireless connectivity cards over PCIe and UART interfaces. Hence,
> > describe the connector node and link it with the PCIe 0 Root Port and
> > UART17 nodes through graph port/endpoint.
> >
> > Also add 'compatible = "pciclass,0604"' to the pcieport0 node in
> > lemans.dtsi to allow the PCI subsystem to associate the DT node with
> > the PCI-to-PCI bridge device.
>
> Ideally this would be a separate change
>
> Also, b4 can't grab this patch since there's something wrong with the
> threading (multiple series in a single thread) - please switch to using
> b4 for submissions yourself to avoid such mistakes.
>
> https://b4.docs.kernel.org/en/latest/
>
> Konrad

Thanks for the review. Agreed. Posting shortly.

--
Best Regards,
Wei Deng
