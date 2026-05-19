Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E44028FC
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200281; cv=none; b=UBiSipp5c+VfiCXy3lOR4KRdh16pjM8O8ZsWw9yMCySC5e3KjlH0Jjl/lzoET5g6qUbEEjyh2fSg0PqWev7Rg30PJayL6f0nMxyJB6yxvp3mpbcmVX84Xfimhoh8QChAHzu0lix4c/JJ5b3H4INXnUW2cCeslM4fQOkykUd4I/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200281; c=relaxed/simple;
	bh=w6rSSlUOOGgtp4odPIHdwSXP8pS6aA3ms6bNL7gsjTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=POcZ4v+CkjC2jrhvoki4oUOiwC+UuEi4m3u3XD0rmxXvIacBMeS74rvrqkEDt+zc1/w4Ft3ZhoaxENfMa1S7JTR7kUY3F5r31wtLPKVOeNhUtGUNxVXnOjJ4+b0h0v0nHxAAFRqVQRufCuw9UpbGP9njTDEErgltzB9ltOPq1mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gt8dQOtt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cne0H4tu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gt8dQOtt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cne0H4tu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JC8ZWd1737098
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U71qA0iV9F2TViQIPnVEbXelxIjlGXakpmN89ILGecw=; b=gt8dQOttusADyHJr
	LHps4pivmlMFGUsi2B4VClx3EBGGkQInwF68BysVyZPriJiloyryje96//KXdWEe
	mg6b6Y/chf+r6sTFrCeFgRU0GHaUk+pn8NBzu+QQji3uZlW0ACusV4VKYBnjTlzL
	oug7YW+FDJrMWCa8RYHbL0f98xY1fkyhiXgHrdcErIUKCa+Gw46coqNAD8zzvLtK
	9GGv1EJIKynulKsLTwVySgJYAfYKi6nvAvCFtxb1YMLkwraqac+Eb23XlZSwGmtd
	WWei5JVCH2U98hf/1KTAWNxJ8ruXwJgMQC0+MfaECDAt3I4dyLhz3CJNwXQb5+ed
	CLImZA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju91ubc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:17:59 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba838d3fa4so36118915ad.3
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779200278; x=1779805078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U71qA0iV9F2TViQIPnVEbXelxIjlGXakpmN89ILGecw=;
        b=cne0H4tuP4vA4qb6C1h5dX44QWoPxFggm01wYtuHaMqYgXaEuAf2syBeLgIby7+iqH
         BoPmlWwlRnTiqSnJPhY2CLT/28xythI3YsnjUcQc0ppyhMulaF631033ifv94jocUQ4Z
         tzMsrkuMRqnlepk2gxaXjvkPD563NlRlF0XPnuxbtUcGvd2kqtJtrOvYCr2z8PYYMOhV
         fhSTTwubdjrd5rXXz+0+h3/tx24wTxRQIb5zTvKt2CcjWr9uvKSgyS9TKxgjdDznS03g
         Mn65OYLC2nnsYCEx19Sn+wnIVQ5MeM1vkUUodM6NP8Hv4mM/LFTRZh1Chf5/ev+nVyux
         W2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200278; x=1779805078;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U71qA0iV9F2TViQIPnVEbXelxIjlGXakpmN89ILGecw=;
        b=ouuTr0eCqD/k2APYt6qYZxouZExDLc51V6Uv5ZPbGGNgUZFmGqBxIM0l1s12ug7Gkv
         PXGslRRqNS2s2ohkAAyYBBzgm4ry1/6CbfKMb8mPINcTA/7+K3jquYLE9w9ExOEGFKvX
         ivPT+Ph6cZcxjERV4zMNxvgJE1G8C2IurT0zDyZDGo7il65NGoPcXPa/XNYttW39UV4C
         GqVFyjgJJDXaEGLvFQoW9zNLscxJR33TXVQrTs7QTrkXMwgwh2SF38LjxBND2xScxCZj
         LkfsHaFxgzG3PoUhGA/XG1//xPoLyGWFR0WepmMl9CBwxq5q4v3PtA8hUrq7IqJ426WY
         nOFw==
X-Gm-Message-State: AOJu0YzSmDxlGxRyUtF2RDd2bz1ldLy6eUP4mp07C5ZlfasG/DCflouM
	VIVUqH46I33kPWI8HvMc/vPF5yUTunJuA+XgzZsrEW91xL0Fzh+fPe3pVyBV0wVdsi/HZsHzdCn
	l4ciTdmx8FYbkzRdaAQdUI+iv74eCp4Hz6+Plkm8Fs01yJU04GvuocZsS+C0gM8U=
X-Gm-Gg: Acq92OGGviGCr43GJpe6yKcqkQkFTcBv9QXGj20LYcGfLyOR9bIpHFURqCDUTMEAEeW
	IRt2siygeFuj+jjajRyoRpGZBX5DTIFiJpKqZUAp40KRJH/GF6fyeX2/dLehoUcX183eFonN8Tz
	4u4HIO9uIRMmTdsAAQ3NH+W+ZdN3HD8VvSxS4FeocOEOb4lEDL6zQMLZVP4dOfA7b04wAqF53pX
	1lG6ZQYZn78Sb/o8epk8Uc15jCf997cG+bfcXixUDMu+5kg2o3m0sDAWOBuKkIhswG9J2OjZ6iN
	iN/eI7C0Q2ecmrGfD+soDZ5kCnj2KN29UgJNHyyvr4pdBXptk9Mi4ZL7uG9eAlKIP+Jd7mrAJ42
	MFWKRFZ2IV7h+gj5Yfs9c
X-Received: by 2002:a17:903:3508:b0:2bc:f202:54d7 with SMTP id d9443c01a7336-2bd7e9c575cmr210481085ad.38.1779200278383;
        Tue, 19 May 2026 07:17:58 -0700 (PDT)
X-Received: by 2002:a17:903:3508:b0:2bc:f202:54d7 with SMTP id d9443c01a7336-2bd7e9c575cmr210480525ad.38.1779200277830;
        Tue, 19 May 2026 07:17:57 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.207.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe492asm194269575ad.48.2026.05.19.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:17:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, kishon@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, Frank.Li@nxp.com,
        den@valinux.co.jp, hongxing.zhu@nxp.com, jingoohan1@gmail.com,
        vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260515070753.3852840-1-mmaddireddy@nvidia.com>
References: <20260515070753.3852840-1-mmaddireddy@nvidia.com>
Subject: Re: (subset) [PATCH v3 0/2] PCI: tegra194: ASPM L1 entrance
 latency from device tree
Message-Id: <177920027083.95581.15850589651650964424.b4-ty@kernel.org>
Date: Tue, 19 May 2026 19:47:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 05CNe3mTt4pZ5SJCrhoBu6bri5f7Vt1H
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c7117 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=1gRTTRxgmbTSdBvl+srOOw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=H5kH8eP05ZJGUFTVoxsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MiBTYWx0ZWRfX20k/jVOFC7v1
 QaZn010A+2uhR2NZptSB97ldUiXDD98LY/4ddntqfJThSIiX+yZYSzDR8ZhvGmkrQFyhoQ5+H6G
 G6p3FMYH60ezEvkg+wHnymejGH4XR3ppkrdym8x5sODPhmiW4RCJNrqCqTnNAvvuTNjyea7DuLv
 a83ZL6W1TMn1J2otSTkYwEZmMnfLY9ApRfQJumUB4tsJzJ39mV/NxM5FN8duFzl2FBMpW28dTsH
 MBDK0z1TqtFCEXVnJZLylbve/Xt8lSXV0FeXl4oriUmszplrSW9EL2PCMHvPOh/pGTs+BMCOJhU
 UqtU+RIPqesAZLdttwFncOb0evp3HpDjoXmFgSWfnxO3hFqN9Uu5KyuYm/K/KMqzHdzj12/CXVJ
 5v/IVljfpMz5LpUd2WzHhDt29IY1n7CgeaBE/D8G7D7Q4zNUZdnCO/9mSD9+R1qP6kfz+FqVKXb
 l0WGkc7e9DQnhUHTLkQ==
X-Proofpoint-ORIG-GUID: 05CNe3mTt4pZ5SJCrhoBu6bri5f7Vt1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190142


On Fri, 15 May 2026 12:37:51 +0530, Manikanta Maddireddy wrote:
> This series programs Synopsys DesignWare ASPM L1 entrance latency on NVIDIA
> Tegra194/234 PCIe controllers from an optional device tree property and
> corrects the default nanosecond cells so the PORT_AFR field advertises the
> intended latency buckets.
> 
> Background
> ----------
> The controller exposes L1 entrance latency in PCI Express PORT_AFR (DW DBI),
> bits 27:29.  Software must select a 3-bit code for the maximum L1 entry delay
> the platform can tolerate.  Patch 1 reads aspm-l1-entry-delay-ns (nanoseconds),
> converts to whole microseconds with ceiling division (DIV_ROUND_UP), and
> programs min(order_base_2(us), 7) into PORT_AFR during ASPM init.  If the
> property is absent, the driver keeps the existing default (code 7).
> 
> [...]

Applied, thanks!

[1/2] PCI: tegra194: Use aspm-l1-entry-delay-ns DT property for L1 entrance latency
      commit: 87f493041e20759ffc27262cc0490c41628a5ee2

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

