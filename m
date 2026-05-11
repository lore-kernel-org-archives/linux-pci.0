Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942D3FBEBB
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508987; cv=none; b=YsG5R8ps+8+gUPIgeiH5VRK02PysRucvEdb/XBeG4ciheAlLRnA5ZXiygHvrkjKfjWqNQNKmnBaw+F+utGB4xaRoMyabCXeKzw2GOh+Qg3aIePfMOU3eUaslLcTHrmw/dqg5oquiV3cADkJcHJNT0R+mDz4tEs0oA+ELxa03fmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508987; c=relaxed/simple;
	bh=GOIgHaYHVEr+D4jT/lbQ9M4pWI6vXaYERO1WNoWFViU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Co0Jorfi1R87FWKuAHWVCbgJaNDBBVX/UAWxBRRVLUbDz+gTwsiwrXdVfbvPPZztei8APforqlmmLEfErHnVw+kPwtOo7QFjy917WDEZl3AYN2NYJcYMwsT+ylF0UfZ+d7eGGt2F6QB4Ue35A1HokqxGy+GrLgO38BVu9t1mPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AL68GNis; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M+NzXxP8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AL68GNis";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+NzXxP8"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64BCambk775035
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 14:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cYnHT9BekgKDF9vPnYRkY/ldH6SS2M4Hi6O/HEwZY14=; b=AL68GNishQetgwW2
	jDn4sqkYLeSfvDU/H1UsB02gHgG63kfHzJN9KX/Tk8ecNdsibXNFpIwy31JIBx8r
	PIYFWGbUZ2q0D1otJ3KQMvkiZX2j6wF9fz7ANM1zp3VB8LR68xlfWt7y87U5ZR9v
	9+rlNI5cK6seWvc89r8z19UPvtDMVT2yt1DZsyErgGzBH85oQHAylx7AsaJ0hi19
	9HYXpyoHmtgp1vGRqZUkAoYnLhCE6eTn6ecAg/kIjS+oKGIye0Ve7KkRqGjKncNH
	vT2kUVAAJzastn42/g8bC31Rk9n2GU35z/tKo9gr9HLPzV3FTQlMUx5RwUJBetwQ
	aII0Xw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32hmrr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 14:16:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso3138995b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778508985; x=1779113785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYnHT9BekgKDF9vPnYRkY/ldH6SS2M4Hi6O/HEwZY14=;
        b=M+NzXxP8TuOmq1EMSF4txcS5rmS894Cjz/Jbxx3b7eIktFGs2bd31SylGXeQm+8bjo
         bW4DHrlzfJfDXqsfruCJxyfIn0K7AXo8G8ypWWbSpB/WuLuvAr0Ina1YGYA6q2AOdy0h
         lEHvDP1e0L9U45mGmMXSQx0m1vxR46InGp7mPgr16t1ZO9njS3xI9BL2Chj6iibQGGhZ
         wfB07Jhnb3llP50Gfx302vFsyyqZBP1rTmzVMyq2w5/IuK0NyZt4NtbZsb3i/9pBrxVh
         CsFsuaJR54B7mUu761pSVedss/YTzQBRfKM93P7Jogmr7F/0is5Ru0QrNCA/Iy3OQx+d
         EOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508985; x=1779113785;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYnHT9BekgKDF9vPnYRkY/ldH6SS2M4Hi6O/HEwZY14=;
        b=Lj4aYnNZNXkKbLDY6CjoT/k4kDNkvNAADs1lJwkeRwgL2bYPzuqWHcvi9oTUv0UUjA
         FJUeRl0DDSDIcAPxkLUueM9FI1a947RQNMVtRV331FjsUu2OvNKHf2+a6UcAYP3dhfbH
         3QxAVNFzMhC2gX6xkg1LJOz+2TAJA7GVvjrgQZrO8V4iYh2ZAzoiOwLp4cv4QjkcN3r2
         ejmoj2/7c/Vl5qhrmSdNkjwBI22tPID1ewln8aHet3zDIB4DF20Y55cWXkhtYbHQpu4d
         mZPaYFEoVPZ/ZxcMtrOT/oe7p1aROR/vTQBVOW30vkEX3NRDimqG8fbxrStIiIfijLHL
         plBw==
X-Gm-Message-State: AOJu0YxwHRhR55YVDHqlqGUFjdLmv2VxDZVAzjO8bgyEVImHwsuf4VCt
	sFAv0rk59y3HnaLMxeY5DrVQmTjEBVCgiRGg7Tpqi+MsSw1sOWB75B02x3m4GzhHi1jheE5bQKt
	uCHFYQrMB+YiqcOS0Aepj4zw5sioN/W3c6WlDQlhJusFEUa+FbOtooFeUtN8NGos=
X-Gm-Gg: Acq92OGF94Tgl5p8zd86w4/kP2fDX6K/YwSAc7YDMtPgCZyxfBXnjsr/1gORI2bG67w
	kygtixq2bdrI+MkpGVqrMnrkICuu8P7IzzxgXIcv3fQKUI1iDzKmaDykTg0mGoJrv2etMa7Y55m
	8dzzCFVB3gHvk/p2o4yCna7pHqcHwzSijxvA1gL/XTonYTV21sg6betwheIaGWbxSR9gKVvMw5h
	j4FV9YYZ9wImQ8XYMYYzC6xbg3tXksCwvtskawmnI+wE4/HCJnQ47jBzRwOxhJjj6xjS22va9sv
	bQrrQg3nOhXq2GtaD84sBpUYOYfw80ryTBUnziPm38iYbVovBm4v2vveAzQTeCGa8tx73wEyiIw
	9xLaqLz92dpeJ40J0at8U
X-Received: by 2002:a05:6a00:28c3:b0:839:dd77:34fb with SMTP id d2e1a72fcca58-83cf5c4294amr14905295b3a.22.1778508985010;
        Mon, 11 May 2026 07:16:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:28c3:b0:839:dd77:34fb with SMTP id d2e1a72fcca58-83cf5c4294amr14905200b3a.22.1778508983911;
        Mon, 11 May 2026 07:16:23 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.54.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682abd39sm21100027b3a.52.2026.05.11.07.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:16:23 -0700 (PDT)
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
In-Reply-To: <20260410062507.657453-1-mmaddireddy@nvidia.com>
References: <20260410062507.657453-1-mmaddireddy@nvidia.com>
Subject: Re: [PATCH 1/1] PCI: dwc: Apply ECRC workaround for DesignWare
 cores prior to 5.10A
Message-Id: <177850897704.187882.878362162947134934.b4-ty@b4>
Date: Mon, 11 May 2026 19:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: xs_0xj6Rqt4HjRBL1FckRO2cuzA7hDAL
X-Proofpoint-GUID: xs_0xj6Rqt4HjRBL1FckRO2cuzA7hDAL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1OCBTYWx0ZWRfX7T/euB9E60xS
 DUbiDOdzvM6wmEyxk1rNaVSnmMLS1aw/mQcHKvZyCU7q+3VjMN8Vs9bE9wpebGjHsdzuHPm+kcr
 TgY6AR3vFTWvHf5YssHm3mn7jynuFOkjXfCkq0FabFb5L//U+bVxdZVNnRxtL3WkwzPRSg6XWEh
 gpGXKgopu9dr1qeXXEeY/LGPmgIiGlTFbNtcgdMT6Ggd+p8KPBeAKdn/tMBgZmFWwvCn4H/VydK
 Ome4ZBLJKKhvEHiAAQ6l4EuA3QjsAQWuTt6LD1xT8e2WDNn76IfQZptzmDDuPH/lSfx41TpRcdk
 qxu0UxX+igNIuxctI6ZpIzTo5sd+a3eZYTxwz16ue1n5nBe+qmfU1LBLQN48BYr6qfBXWXA5BTr
 MJ8SZgesZ+/HjAhI64rqwHXUeBpFHSPIRA6GEuL35G1iRkzOpCKMdb0/fbgrjS+jxOsC3tA3g5O
 pDAPkvpRonfm82F7gwQ==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a01e4b9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9aueHI4LIkvGXWIRyVK05Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=yd0uEEa4BFbhJQzLfZAA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110158


On Fri, 10 Apr 2026 11:55:07 +0530, Manikanta Maddireddy wrote:
> The ECRC (TLP digest) workaround was originally applied only for DesignWare
> core version 4.90a. Per discussion in Synopsys case, the dependency of the
> iATU TD bit on ECRC generation was removed in 5.10a, so apply the
> workaround for all DWC versions below that release.
> 
> Replace the misleading comment that referred to raw version constants
> with readable DesignWare release name aligned with the implementation.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Apply ECRC workaround for DesignWare cores prior to 5.10A
      commit: ea72929526dfe6fb1a4c20afc0f2bff3dd0eb6f1

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

