Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D938B7A1
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774104009; cv=none; b=atSwiEa8TaL48qqsljCu/Q/4UgVbBkqMMjfl6PycGGYvL7Wfetn2M7/8ymje3nOO33GK5071g5C0coD1HTtxXV8gfVTXsb5vYPomKpgm6e3lffGt6ThustlYXtPRNu9lIJDxlHsb6/Xn5szkkURb3L81jzKOfr7a0BTexT28KfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774104009; c=relaxed/simple;
	bh=16Q85NJkL80Z81gFXtlKfNUW7k8w6fob7p4bVRzqHIw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F69yz3nA+N1keu1k9D26Dhf01FUSpbB9SgDWc674EvPdVFxUCm6TXyJlN6W78L20ZZlM+TL8pPcivcFBSFkInREuIJV7LkXdxwOf1yN3Lk+/CCoOwbuiLxlZXurQUf9y9Tm39XjS2bOTNawcXnmyE1I2Jp2tUx5+9uIy1nIpcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dvgK1IUO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EhhvkVpb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dvgK1IUO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EhhvkVpb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L4nCdN3549669
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	088YGn3nYbjUKQ2G5hkNpceivsXtytVja5O0dDOJnBQ=; b=dvgK1IUONy0gKCLQ
	YjXS/iT/vdxUyUO6/yLjvCvDP5TKX11PQvCOvMKSjev8wDsiGSILfWguMjFJBHl1
	rDVXbkdN2ttlqfmKoxm1qzs6DViQ8c4FHcOXSln2CKO845mXz/pAPIMOjnyMb6D8
	XgKnGyDheGO8lyhcUHQOcsrg2OqYwRX+wzjv44hSBl6ZXYfoLyH8zUbQ6+k8jkxM
	AwadmXK6HC7Tos6GEmBkB6FXMH0b6r+vRy92oM7/9T8FFvZ6dquF0qhAviu56oEx
	NaqlF1MFO/9EnbvaXiCkp9GUIjh0Z1A6vyVdPC60PszXUCcDb3DVFJYBNrexcAZJ
	iTbOPA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1gpk12cp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 14:40:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso1549564a91.2
        for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774104007; x=1774708807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=088YGn3nYbjUKQ2G5hkNpceivsXtytVja5O0dDOJnBQ=;
        b=EhhvkVpbOa7gBH+n/CVmvmoUr9pr+Q1BtUDK5J8L9PW2fZag+NsZwud5dCQP3XEDed
         xdxDDtdDZjJo6cHzubz0uSjGeF0Tn2JlFwFnlnZhYvSuetyN7oYEezTlsWX+SNYPAo04
         l9ouYANi9jmDP2pdkbU+G/mkEEwtZ4glQcgD3Hgn9qVhCycmNeQHWqRWXjJwtlfNiygK
         /eXG8/Rs9OR2+C2nDJ482E/s23/nD3tTNDa5HDwOZPkPzF99ZLpY/gFMdrg1uUbYxHfK
         PrmIzVM+lDAligJru+bWgYENPDPksGf6lcoePlsZ6HI2ED5kQ5RGp9ip8G1e3w9BjTkl
         DqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774104007; x=1774708807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=088YGn3nYbjUKQ2G5hkNpceivsXtytVja5O0dDOJnBQ=;
        b=d9p6787ooOixa3V0li8rxVoNY9NGKgNXq6gc5qy8v0NvHhtrtLCd+s4py96AJj6hZY
         M7MY49/8tIJ4NxR2BDdWQyuancL+F9uIav9MS9V9l82ceYjLd9C1yzH+WcBguWxX1Vg7
         Zpa3WZZf5SK5G+GQhmFgPBvtVpiS2Br3cS3R6kqHGCMyBLMac3RGs8d2Mhmf1ke034+Q
         p2RP7IVL0RlIGtxO8dYs3P/ZGw1eWL84PvwfPIs6tAm8vtwXMmgP/6545qjCTpyH6iSY
         4wmFkEqUnZSyIX2xRs1zlj9ztZ6a6KdQzUNL+JZ2kag/8RPRWhYYS3g1KA/hKR7KAJTf
         Zx/A==
X-Gm-Message-State: AOJu0YyHudHUUyxPE/GuV/8AGvaC0hrH7uq0Oli0fB3NWSYDEaP8+gBb
	4aMDTGqq2FE9Fc6rv5JR/wjNCG1+BQdXqcwFrlIhyuCNctRkK0rJKjyE92pJxsIyXFYp1mxcNGg
	k0klsVdlhoPEx3TpjCTt9CyREC4ytY08z+COSZ2Fx0gsUDm1TdEAFvYICBdeVuZbyfrjwf+Q=
X-Gm-Gg: ATEYQzzNbhOSyRGhBbs64NHAo19qcp2bMye7GhE3D+K2vEzF1EvV/ASsiEG4nONKrXO
	5dgAVCA+3ZaDjYy5a1zmBudPuXhixYtvdGIo3ZSpCN3zU4hTHtjronmx1qqgw/TGtfCfPOfDHOo
	6VcMdxil/iq2qGtrG+ZclLDKjwOpunX6x7uvbumaBkA0fQn3YD18RptYsDWYlEE7JiKCkhm/D0I
	5chcJs4wl9HX2NsV4IwZUSfak2KbNBjuZ9kY/j5N1NcUWCvLq93bjHraglBZR6eFJ9Nu0N1K4tq
	TWs/4Ce8J11prfdqvmzyYD3u1jXEhxbSMXOYYdQkGv4vVLSOuh/CnGKPdcxvYDt3fxTT6I8VSo1
	Y4flcQGk84EB275It
X-Received: by 2002:a05:6a20:7d8a:b0:398:b95c:51ed with SMTP id adf61e73a8af0-39bceb482ffmr6054080637.35.1774104006598;
        Sat, 21 Mar 2026 07:40:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d8a:b0:398:b95c:51ed with SMTP id adf61e73a8af0-39bceb482ffmr6054060637.35.1774104006085;
        Sat, 21 Mar 2026 07:40:06 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:94da:c4b9:51d5:d888])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc2a8sm3941657a12.27.2026.03.21.07.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:40:05 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Niklas Cassel <cassel@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260305151050.1834007-1-den@valinux.co.jp>
References: <20260305151050.1834007-1-den@valinux.co.jp>
Subject: Re: [PATCH v2] PCI: dwc: rcar-gen4: Use 4K EPC BAR alignment
Message-Id: <177410400094.17067.12979287248097257456.b4-ty@kernel.org>
Date: Sat, 21 Mar 2026 20:10:00 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: rBhmLxFnN1rh01LYY2Dl_VF4R0xPc87u
X-Proofpoint-GUID: rBhmLxFnN1rh01LYY2Dl_VF4R0xPc87u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEyMiBTYWx0ZWRfX05+8Nn/JsTe3
 6x5w2lPzVSff9Szk83riWxuB1YozuRXktFuvEe/bIyEi0mDtDsUalbHLM8YUs6jc/qxBKMSTWS6
 WURBHLAFJrqwcA+xb/EAYHfTHlkXw1mPTe4yeQbIiFPv7VNDWv0cO/5MVt0q3EbtcziRX8ZLJ1c
 0Qre8JAR58M/voKWMbm4qDqCeMD35S0+OS6uVWErNA+19K4CdlKknLxQ9ijFie6mBw9hq8GYKf2
 8r8SKQafxLeRiNWDLPlAa1pjM/galhTEoRCZZ2Uk9q9GnTI36Ecb471KeEdN13pNWbTnjfrLSUL
 co/GshRyxpw2MjN5xqS/+ZQdDOoLG+NRkpyyc4rss7wfjW1ovGJ0Fr6NsGH5stbmTLavNoLHl3f
 gKH4wXy7p7XTTUiyUlEDyH0V+4WlwnMq0YufryefBvnH5Sjp6vCtpioE8Zw3xRGOjn6albG9a8N
 jl2tkRkEx4rYJQnpYNA==
X-Authority-Analysis: v=2.4 cv=QKhlhwLL c=1 sm=1 tr=0 ts=69beadc7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=YQ2wzFUj4MmMy6G3m4IA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210122


On Fri, 06 Mar 2026 00:10:50 +0900, Koichiro Den wrote:
> R-Car S4 Series (R8A779F[4-7]*) uses a 4K minimum iATU region size
> (CX_ATU_MIN_REGION_SIZE = 4K) as per R19UH0161EJ0130 Rev.1.30. The
> DesignWare parameter itself can only be configured in the range 4 kB to
> 64 kB, so the current 1 MB alignment requirement is incorrect.
> 
> Update the advertised EPC BAR alignment to 4K, as described in
> commit 2a9a801620ef ("PCI: endpoint: Add support to specify alignment
> for buffers allocated to BARs").
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: rcar-gen4: Use 4K EPC BAR alignment
      commit: 380627b3a5ec51a7fdfa156c14af5022980d6333

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

