Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226241D4606
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022898; cv=none; b=Y3D0D9d/5jdPqlLfbBEyPfQvaCS8XIOvDqA8vKG6hpTiuHKn18Bt6r26s5efcToepw3x3sh+FVx5d6NuXZ7NxoqvqShD/K2RSHWE00OQsjDGJs3EbafQHlsG/l6SGdOcemhEwv+Ze4szspc5XJ9vT4EdNz3qn6wj2vBduI/67/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022898; c=relaxed/simple;
	bh=3L2b69RJJnuw4lcVLlXhAoSaQwGiXuIlqO+HnG/X7Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okm1u0PwowQ3Ci6lzC0vdSdCQ8WlqDE6xDWT4/z+JQ1oVQNSF/bDcg8xBt7L8JclJAp5+wFZdkCKoVX785r6xwmE/daOPCmIPER5YAI1OfZ2xrgaNKSZBJz2usMxRtHBKXXAw2eys4IKbMrpNI1XH2vqDPPVx129EXHLAFkRfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R2abuqHU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hmgy4cct; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2abuqHU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hmgy4cct"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GrT83520292
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mvvRWLQy9D9Ms1FXD+eDgTSA
	ed6FXm3bAYuAa8sMroM=; b=R2abuqHUbLMV3Wno4oDzY4fc54qu8N2STmCSvSG5
	nFInWaQ9NXOAUCB/53zkPYwe/su6S2FrpvRki969Qei5sFOnGAH6u8rnQ/NS9nF7
	8tPrMD/5WKwRK0iXZebxquaEiXeKIFawu8Lgu1m62PiV1DxuuN5mWkc1WusrcG3N
	sMhJSxwHPwQA1NE8ebA5+iefmYGAvnrTdVCcAonY115HL5VxxVKbMyfqqa0d8n7e
	kQVly/qbV4xrEyAJSlIjlJ6DGkUemT6OOHD8/Vrmlf+yozrJ8TS3pbdTL8WNReEq
	4RQ7US2Ib7RllZ1+9kcW90wvFasTl0pNKECp2rLVQYFuJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfjj7e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:48:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so4583461a91.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 23:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789022895; x=1789627695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mvvRWLQy9D9Ms1FXD+eDgTSAed6FXm3bAYuAa8sMroM=;
        b=Hmgy4cctXnBrxY8Nvcva6lk8NZ5GfqVVkrwo4fQsLz3fzHS2z+Cvf8XKCkWxIwmosp
         wGq8KmCbPBQxha61NG//ZMt3Pze4B+U6wGlmEXaaZk+n+8cDqFJUp5K+bs0XahUblZWO
         GI06J3bm8ArJe8j9lOC3k+7HTKXSlbH6ZtAj49uGkSH0CY6g2NOGUK7v+UyLX9aLyNiC
         NsoYix70UYNrsgo7OncOqceodMaVt+wOJsEZpanPA2YSMGycwGKac6arzFQ1RPVpdpJW
         Yi4Vvab+V7qodArrTPKwnWFKfixYJ5Z/ISjweQruoTUu7KdlAIeVfVTp7SqN98WRvWS+
         lkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022895; x=1789627695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvvRWLQy9D9Ms1FXD+eDgTSAed6FXm3bAYuAa8sMroM=;
        b=cS4yVNhrbZANdwcXK2r8YdqiUEX01Bte+QWBLLkxLRENvDgbh7DSehdHOODrDtRjWF
         esd0Te5no/uDQUBLXSVHgTYAjVUdqJWFq5QxnDxI8mFfcrTXnzJGVm/myGOEihg/WRjC
         DiGmw0BTN5MPeY6uIjLRnfSDhh8uk9Ec2vUs01cBQk9oiHDwwvCbj3Mxo4whPPrC0Ky4
         SkwQgH6mqPgJKHRIMHhEjfUQ9mZ3cXCFUT/27s/bE7pNrLzDIaPsgbvQ6iqQzSv9P2mZ
         Nekd8H2Bg91WO7PVQdsNohuPoh2X0PbRSDDGUYcV04F3qBz9CEecC76BDj07juwH4mh8
         jpdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZg/pZ0VLoWo/h3ZLLlSI70Cbu2NcbmUheZuJhFYKJNCSuoqjZIsKHMjB34bg3UL22osbfP52yxi4=@vger.kernel.org
X-Gm-Message-State: AFuF++nk2/0yH7etX8EpMwKJwVD1zj1+6tlzRG7NVY8M/KBimDMKMy4p
	WePzR8F4W+Iiv6laNWqWIqdHnMIkaysQZ1nizCVL6C1H2CO04uF7kDDReyw4MFBgaj/wuep/KOa
	owLJhaBGgfemHukqFl/mm7IWRWLBvgjCDcgDgEiEVdnkiXFXtQSkBUG67NxuiRcc=
X-Gm-Gg: AYBFou0ko6hvpLQUc7O36Vi0TsnjLtYexsJqnwWuLMFgmBjDLFSy2BXaYWjCcoq6o3G
	1rd3GnyeZQl1G4l+EHkwDjksbi+R1/Vo98RxS4EQZ8Q4IUzzLhojZcj7iVpif4EnEgGHXwKPag6
	wSHbJsqfQP8lU0IyLcNHQFhmPKgUoTcWjBBgQXIFopx5+WOGKHWaDpDCYkAxDyB6xUPD8fY1sCT
	aUu83jDVveVEv08fBfGLm0M+o29iGteulXoTRqi8AtvRZ/zHOhCi9ijGhbM16ec1QUu5KsC2irt
	s8GH31lNsoS5fnocS/ARx5h9qUW1MrQtXYOKEH7wk/lyqslH620oyxf6zLm9e9w6B1IWnGcxEgj
	ivmIdI56CCv4ms0kg7gXOLMNW097WW1ySrrzKCVA6ivw=
X-Received: by 2002:a17:90b:580e:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39b261cfd97mr56212307a91.14.1789022894635;
        Wed, 09 Sep 2026 23:48:14 -0700 (PDT)
X-Received: by 2002:a17:90b:580e:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39b261cfd97mr56212222a91.14.1789022894101;
        Wed, 09 Sep 2026 23:48:14 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339ac24d7esm77812195eec.15.2026.09.09.23.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:48:13 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:48:06 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/5] phy: qcom: qmp: Move
 qphy_setbits/clrbits/checkbits to common header
Message-ID: <aqJSpqRmq5721Unb@QCOM-aGQu4IUr3Y>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-4-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-nord-v3-4-b0a82721c547@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA3MSBTYWx0ZWRfXyv803ctluY5t
 i9sxUFzy+MYJjVrCFbJOk5/ALAO+FjSpV202jW46ooFBRr8LIuIuiDr+wV7YGo3kJKnrnzCJKZS
 ZnBsh6Z0I8C90e+jLQIaBJmiOcZMCQ0=
X-Proofpoint-ORIG-GUID: 803egwiKEdcC7r_t8zUe02cUi1wCSqth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA3MSBTYWx0ZWRfXxNWoTF3Y17Ys
 ctm8/7pqAtA9CVuhbfP90lsT5zKxKYZfQ73Rbc6mMX+EKWDfOaWa8OGdeoauW1GflG0fhHK4vA3
 ZEsW3mmQpLuCncd7K8iR39wx8KdzHNUUDDWMVuXR/I9BWk/jiQwjzfSZ+beklXhdOYIizIZSehr
 1YCDbc7B96CymgRpoXdBXYAlFi8Igj++WJB+QCc6MFvAhxmQ/k6dy5BqNjcXOWwq/a32piMMisx
 DYdRSrGoamqH1nl45uDFrL6avg5uYmC2gnHxlNBJxLuehS7MjOtZTO+F1bDtWwuPPKTyahUAq3I
 2DKrYIj2BGNQt6OAZY5czNuISWajJHXYI7RM7nlkbBYTW7OI8DyzJc6zFkcwF0dc1uVtzU3InpQ
 zkrSZL0f0PgvB8F82Xwu+lv37bOEazA2NfTtbG+Dc9/0B/xmr1CPonvnT3+bEA+lYP6vhVLZuy+
 Guy+PbgirPBbFQINCgA==
X-Authority-Analysis: v=2.4 cv=H5pOUOYi c=1 sm=1 tr=0 ts=6aa252af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Y4sVft1UDeOkrP7wHAgA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 803egwiKEdcC7r_t8zUe02cUi1wCSqth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100071

On Wed, Sep 09, 2026 at 05:18:19PM +0530, Krishna Chaitanya Chundru wrote:
> qphy_setbits(), qphy_clrbits() and qphy_checkbits() were duplicated
> verbatim across phy-qcom-qmp-pcie.c, phy-qcom-qmp-pcie-msm8996.c,
> phy-qcom-qmp-ufs.c, phy-qcom-qmp-usb.c, phy-qcom-qmp-usbc.c and
> phy-qcom-qmp-combo.c. Move them to the shared phy-qcom-qmp-common.h,
> which all of these drivers already include, and drop the local copies.
> 
> This also makes the helpers available to phy-qcom-qmp-pcie-multiphy.c
> without introducing yet another copy.
> 
> Suggested-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
