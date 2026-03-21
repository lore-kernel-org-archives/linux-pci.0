Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C830F95C
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774095910; cv=none; b=YPDRea//V0D7ZogVw0cxJ+6/nIchu9lU/qyR+N33ZZrg8kbzrPA1GpEC+UOtmQ/AQlZZ03wjh5vEPxe+ePdC2Uj2M2OrkAEcxAVB5wRLpDc2kHg+B2Ih2r9f2cAyQ89Lr0sGdHia+whsxwKhb03FO9dUw4mg+Rk3tWlrogg8GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774095910; c=relaxed/simple;
	bh=EiJRtaZTqdlEJI9BFrodq72rFyM3BJAaDkbjgaJlSkc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hL/Mvvhx4SnYACMoxxuFBJD/63w84383cQYKywx2i92me6EGw+FE/X1MBGBdUgAsqwRJo8K4nXRyer3ka0aigk0z04qbxm3Zz0J3Gog/P6wXlup4GudZ7Vey5fX0xPzx3DJ4QreI3lREDPqF4/1AcdC8LkTuvkPhdtOOIEdoC+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6R0jnJu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MliOmlJ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6R0jnJu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MliOmlJ0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L3jlYC355032
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 12:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AhRJ0xP2d1r09SQ2I1AfF4h8fEo6qUqwvCbUvSQT8Fs=; b=D6R0jnJulrKcNUt9
	VCpl327Ed1QajXuNvwWSpp8T6UA4r8peFdn0W8LAtGyzHE8U4f9Yahhwi4oqx2Zh
	Ilqy2/SrwdDWAasgihLns7D63mf3+4wE8MOQ/rG/Wr77wVnpjFfPEI3sGVAvN8Sl
	QYNgJvxkNCH7cMNU9uEM/jilVXekHlPncO8mtC43Up+TpBfnpbF4jMCtQplj/rb5
	hdYA4x8t2ndwFEkBSL3dxf5WKFngRCFEzvF8zHsZ6+smZQaBTA55esrxVhNZVGR2
	ew5+MNK9BN7JiRT3zqW9kXSY5tVsEJwpBo0CegdwwbnRRwnm6XOMmJs7NL4zT2Hl
	yCLdWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kq5rmsq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 12:25:04 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35b9333cbfbso14117083a91.2
        for <linux-pci@vger.kernel.org>; Sat, 21 Mar 2026 05:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774095902; x=1774700702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhRJ0xP2d1r09SQ2I1AfF4h8fEo6qUqwvCbUvSQT8Fs=;
        b=MliOmlJ0jSVI6ZztdlnaVs6LdoQ6wTb2iMoAiCsrqeYFa9wJo5txBYIrxiXUwqq//I
         OyOpE00lWNdR/4/WgFNyQQ1tK4gFYusyuHN4Un1YcKJpx2p1yOdxJLlnUNkeagegHL4V
         Bl0CM4keJjfGjgzodRmlAAHhjBuz8+BWKbM9anaO5jmdmXLi5XLRKRqPTL4rY4gJ04Ky
         f+dH8mxlyyB1WImdBEDpVxjbSeD+TU7204cWs4Wnp07T4xRJpRm7sYU8Mi4lJV3TAzNp
         Na2oC/6umYygZaMth1fAeHcrKYlYVqaPJ5HEBsdTZlvlppEpKwAXDg/uCwEuGQyawwjh
         NNeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774095902; x=1774700702;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AhRJ0xP2d1r09SQ2I1AfF4h8fEo6qUqwvCbUvSQT8Fs=;
        b=BGE+S4qEFkSVNp4pXzCCD25Gy7QtwSiNHc5vI3Rjfg9canIOoANemIxxmOj9hUdTXK
         U12uYbtO1nKVmOqiwMU13EjW2m38rfeX8ySwXcHClgEYdczw8VbRTkHKrNonPu21O5PX
         3lrN1DBNs3QA6m4QGaIn+Kg3AfqFAITYCnUBrQU/I2gupNHiJh1XAyijK1WKLRibcDAG
         fMaqOAgoxC+J+8PWBtibtEhUdtU66CnLc3OB4f8zrB3GI1hTtP6fcAS595WliOeabpRX
         a+xQglRzFTnryhmG/czhhv57TIwxdxt1OHPhi36I5jNpN4l/FDINhNwqZQ3Wl6rys4by
         F/CA==
X-Forwarded-Encrypted: i=1; AJvYcCUmpRf31udZO1OB9R7d3od7cc6ESCQ0XafZSDwZAj7K4RrmFCEgEzxETCLEDJOUtQrEz2md7t5pJP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8Jvz/RS+iPF0tXaBS36vqa9I0HqcFKeppj3z7pxt6WHZ+15V
	b9k8LPQbuaxsHxfc5BzKtPiudcYzqRxOCMm3MWUilrd0AF2Bub60K9XDW6GAOTWTBEbMJLnP7U0
	Ig+0ArUjPHxH8MdBuBEVQWUMHAKQe3Hp2GOy7nuh5L8bmo2mVdU0O5LzdfsP4cGU=
X-Gm-Gg: ATEYQzybQwIhCpVzhleu5Lwug91Wipq4OwNH9kwMrAF375SwvFPzKv0avTNEs1L8JoB
	dlXl2DgkQfAIdUzvzBY4OE+9MrrQ3fsiuLP4eWEnsD0zwS8V975WaGaaJtw6CfIRfzDb60JOHVc
	zbMePw3CvFBjgefr+1vq9bZgwxz2IO7h+AoHpk7d5YvrsqZ/i8H92bZUc5AfvEshtPXaqKV7KGx
	+NerZLsx3alls7j2xVSaTtmkzJUvuQGmW43+3rYJnCNWQziZ8cC1VuDTRYaWraMzW9g80ZVvuvy
	40vuzkIRhMuLZBDhjPgpxeFZ9HwStXI1uAXxmyFxhpAuipW5xO4R4LfEpIelQCdWVpm+pSoJOBr
	hSPxgL6aW/lVLZtMa
X-Received: by 2002:a05:6a20:9146:b0:398:8bd7:4f80 with SMTP id adf61e73a8af0-39bcec0692amr5686543637.46.1774095902356;
        Sat, 21 Mar 2026 05:25:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:9146:b0:398:8bd7:4f80 with SMTP id adf61e73a8af0-39bcec0692amr5686524637.46.1774095901758;
        Sat, 21 Mar 2026 05:25:01 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:624d:fb0a:8444:1ee3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74665ca206sm4391960a12.18.2026.03.21.05.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 05:25:01 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc: Jianjun Wang <jianjun.wang@mediatek.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
In-Reply-To: <b835e360b42c5e0994f9301a34dbdf140a8d3ef5.1772493898.git.ryder.lee@mediatek.com>
References: <b835e360b42c5e0994f9301a34dbdf140a8d3ef5.1772493898.git.ryder.lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: fix W=1 snpringf warnings
Message-Id: <177409589820.12459.14613770488604261704.b4-ty@kernel.org>
Date: Sat, 21 Mar 2026 17:54:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GNoF0+NK c=1 sm=1 tr=0 ts=69be8e20 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=p3aDHK_ZBxqdTpKZ4NQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDEwMSBTYWx0ZWRfXxCpOOhQJRvhz
 G6A8iRjWOWaybkB77hb+KPD8EaghFsn0W1P1DzziTdCKU383PQMZnnb3OTOvwW47c4EL6xHJ0/N
 889+WFe414S8UHDTsLkFaya6wUkJJjwx3Tu2Tud0mK0ZSkz6Wr5acJVldD7hlu+707EBxg8c1Ai
 RU0pHILoKAiq50Gsm3Ac9qjxYLR4len+BMZuErG2GlUNDTC+g0PuaUgh8zMOsAPz4OfOlphKGv9
 tgKvh/k8ognwaiXOmLX4mLb1LDp7R1Ozx6Q9YB1ZVlw1wdKrqUvIxkRdsG5tgiDq1cuvrrQ/QD9
 rFjhep67JYruNMXaGmKija6YgaJ1iWKxTH98rCBCyl23sgo4pl86Etn7NuATvxCsJIMrfkK3w91
 wA0JM2Z6sVN6K8hFrmoExFgrHvH/u90r6rmSO/h6gkpvQedx7i4jZgjICBOheDvmsY/4wgda9TI
 AWjj72bS3r0vg8O8hHw==
X-Proofpoint-ORIG-GUID: hPGiIsEpT7VwsNfkrad6k8hFQGINcCMW
X-Proofpoint-GUID: hPGiIsEpT7VwsNfkrad6k8hFQGINcCMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_04,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603210101


On Mon, 02 Mar 2026 17:46:48 -0800, Ryder Lee wrote:
> Fix the following errors in W=1 builds.
> 
>   $ make W=1 drivers/pci/controller/pcie-mediatek.o
>     CALL    scripts/checksyscalls.sh
>     DESCEND objtool
>     INSTALL libsubcmd_headers
>     CC      drivers/pci/controller/pcie-mediatek.o
>   drivers/pci/controller/pcie-mediatek.c: In function ‘mtk_pcie_parse_port’:
>   drivers/pci/controller/pcie-mediatek.c:963:43: error: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Werror=format-truncation=]
>     963 |         snprintf(name, sizeof(name), "port%d", slot);
> 	|                                           ^~
>   drivers/pci/controller/pcie-mediatek.c:963:38: note: directive argument in the range [0, 2147483647]
>     963 |         snprintf(name, sizeof(name), "port%d", slot);
> 	|                                      ^~~~~~~~
>   drivers/pci/controller/pcie-mediatek.c:963:9: note: ‘snprintf’ output between 6 and 15 bytes into a destination of size 10
>     963 |         snprintf(name, sizeof(name), "port%d", slot);
> 	|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] PCI: mediatek: fix W=1 snpringf warnings
      commit: ab4a4043db1fcc4fd4c5745c5be8caf053502e29

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

