Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A6C2F5337
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022814; cv=none; b=SBIFcTltLEQJEhy93wWAe4jZ65u50PVHsRQdnNkpiM2GUv6/yxGXASrsiTadFyOtIep76D4rK1QdkGLmYmyYxYuLjJZtQ6WrgadbkImH77okXWptIYnb+vWnzm/q7gB9+ctb/2HgbISwR/gJoU/1jNEI3gioksGDchOsxfQ0vVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022814; c=relaxed/simple;
	bh=ss1rHh64uIjuyYcs9EexckevxsdC3EsWu9JrzTfWz+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+Al+r0Nsem7j54EWntoozV5A9R2cKkAToiDpuHQuPYMc069IYMKh9dwU6uRTbajOnR5Udd9deV6AACerlVJKpkX8Jf0fyzUKy9UYp5ineaPq9Ub4b5vZmxxQzj0bwVuRASoMbHZ17p3wWfj4TBI0wWFjRKazvBZsdrVP49hkDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EHPun7Og; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B4ax5egJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EHPun7Og";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B4ax5egJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Gp3N3655253
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=OtlYq/p9g/l09HGFRWH07O7/
	FCUFDmortwofpkkwn8g=; b=EHPun7OgTpKkjm7XCc9fqZFI35/d1VhTL/UrZABy
	J//NaE2LfK9ir7wtviM2sbxE2Sj3QmSdrk818QhCtXB+omj4aFUtqMr1yDdAeNMU
	17zHwRGR4WG3HLl3etSi4FioXZKF0XM6PKkrbMz2n1zfiTEYB7gtL4UCpQl8VprA
	lghXZuLkYCnAiPHSzutXEcgc1QXEcNre5MW8bdQpWYqjATYiePvFIu5cxnWPdnXO
	GAZzSQYLt/jDnOccVQjHLWlzDh18s+cTf3Vb/zxGE0oqJvZzuImA29HSunv4diTR
	uidPFnY+lbaLhOggssE0qz3kyU9N8yYJ1U10um3XPhrLHA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydtfc0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 06:46:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc4216aee8fso9097072a12.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Sep 2026 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789022811; x=1789627611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OtlYq/p9g/l09HGFRWH07O7/FCUFDmortwofpkkwn8g=;
        b=B4ax5egJbjEBnuV7H58U8ZU9stpVLTmKNMoh2GhZnGnZYNqLPeQqUbToYqy8tG+Q4a
         OVyL0zJduDSexdqcqOMv8F3YzNlq+tYWJL0VLills3EWgZ+3GJS4Twt2Z7NU70IHq0BX
         g7fmGDOVlrUakSyOKEEdRqpaxNWDXhssukvBl8brbHK/EervIeslbHoeG3E+4bBJwlpu
         emW0Ejjb9/2b+/jDyLojlcipBRt/6fDPvW5sPBOtiM+VT/k/hdu3b04LH13kcrvg2lrI
         yYgUkGLmhckAwTY102jO+LfSuWo3r65nE/1GVKDfAWyq4zanvTSdFlJTvWdeedIBmotA
         roaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789022811; x=1789627611;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OtlYq/p9g/l09HGFRWH07O7/FCUFDmortwofpkkwn8g=;
        b=AypFCc+23p+3gYgkoS/OHeJDmctc1eI4/HS+kqRd+45RlhB4cLPwAnrLxseuR0bJtK
         uOlNncXerk7rlb3mIC5P0XwOzMcTXL4TV2xnv9p0auyFJoiIWZmeElgS4/O4o60IvbO9
         3YqlEKoh798Ql6DwOH5eStkXpPGHWOkdZsyjHE7UUGM655VD0rukgpyomcr5ye/IkCia
         RAKxwZG9LMhOAJziN2isTEOZN6HaoFDa4tFlvfYdIf845Hn1szIM6Mc6BDNYRJxeYXho
         P1fPuEbDUbyvNUJ6EHZ0kfKz+AoxYnwnPA8xTwwvSCKccH1jBWS7Y4UYmjEahnsouKL6
         is8A==
X-Forwarded-Encrypted: i=1; AKwUvByfte8m4v3MrTfb95nVtFYcmDnXde1W94z17T5EHU93AvnBlBmhTxfu9sSwsELZpSZrIKDst9Sf5X0=@vger.kernel.org
X-Gm-Message-State: AFuF++k8K4mcsRpYLCyVrJcJWA9X0dvCsqsIBQe2ozB7p5IoL9srEo5A
	caRGlfH8PIg+kFKu557VXYXnt+hgxLttuFAifFwoFakjr4Q0u3U9XEryaMRNQ7vcdkoEBhqUPei
	pCEdGyVXmKfXaf1/pAxyLvFM0uDP6WCBksPdH4RlJ+FUjOZG4LxBMzyuEXIeew2M=
X-Gm-Gg: AYBFou15V4qGo+hjG/Pc8Mj4eWdImKEjIHqbAj6Qadpo91GX+OXDqkkY9nmJ31Vn31i
	ozkmabcbz/oUo3spsP2uBRbeM7tWUjwrjZCai+NVAlsPn3rB1JnxTJAAvTCUT+zshClU/tM9H2S
	JWe04qs/Z+9adTJvsJPMc2bXM25rcWr3Sp4buK7oAPqHy42MIe7FABLFmONOPUO0DQgy5ViEehp
	YldbXl9xOu1NGukysczq2YQg+FzEA5jpTre0hpa9A0zxkBi1pMr59d3cVSB/EMy4AdLc7VOJ1v9
	FFqsQ93oko2EyqLUzHM59FTDkROoGKgCYwwL8t30ErC6Q7VKutur5hEVAYr3FzdHyUgjug5CheH
	ahdb3fj1OmHuf4+gv56GmLbqslb+NYrmsgxiE67t/ok0=
X-Received: by 2002:a05:6a20:914a:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-3dacbf56563mr8135482637.25.1789022811483;
        Wed, 09 Sep 2026 23:46:51 -0700 (PDT)
X-Received: by 2002:a05:6a20:914a:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-3dacbf56563mr8135436637.25.1789022811020;
        Wed, 09 Sep 2026 23:46:51 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm77169144eec.16.2026.09.09.23.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:46:50 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:46:43 +0800
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: pci: qcom: add Nord PCIe controller
 compatible
Message-ID: <aqJSU8y-ZAQjnRJf@QCOM-aGQu4IUr3Y>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-2-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-nord-v3-2-b0a82721c547@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa2525c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Y4sVft1UDeOkrP7wHAgA:9 a=CjuIK1q_8ugA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: i1393R5ESwQ64isd3BVhcq0bfszD9O6I
X-Proofpoint-ORIG-GUID: i1393R5ESwQ64isd3BVhcq0bfszD9O6I
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA3MSBTYWx0ZWRfX0QZ0nzZk7kao
 d1o5Sv+8qYJN7vxWZ2wJw4XGkgsjcwPg5fCMEdDLPz1fo+D829Gye/m6TV1vfGJHf0WUuWIrUVk
 Ai6tJZyqkyNYzklPkhKZL7B4EyxADXg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA3MSBTYWx0ZWRfXygoyi6MGclcT
 mc4ug8K63PiASMvj6FbMql+FogZZLDeXik+201L1nJ+PYupyhH2kn4YhSEXGlH0P29Z/zGjN0GS
 t87J5UZ+mf1qiK+Kgl6Ki03KFVbTbLryGPnBN0xVVtrzrqaZLA1SIX+4/0jVKbNlljFID8FNd+R
 59sd1Z5rrLVvnqDyuotYYx9BVlGp1YdoKGQkOI3o7rO4u9keDDEaQO/EJ7DPAfTslrsICm0iDQp
 FcZ7jcTUhNBzyIBQWHZVEYZpyNE3xpsLhspzpYqnA8ljzSr7d4js+0EiMcbjAueAFJv5MP57bW0
 eLm81XQCNr8nhstvjWp1xOS2+jIhV8AXb/A02PA1rRR6DuA/2eaWhFJsYluDboEEYrIAi4ikCYY
 FSbQdvhNozGK3IhCMvdCGtfENYjW2G7Eni090y65NtlEFBnLP5i9WaTPRrhFjVRCFwh23dQVPfK
 oY/alSaXbiFEIFe7IrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100071

On Wed, Sep 09, 2026 at 05:18:17PM +0530, Krishna Chaitanya Chundru wrote:
> Add the qcom,nord-pcie compatible string to the Qualcomm PCIe
> controller binding.
> 
> The Nord PCIe controller is compatible with the SA8775P PCIe
> controller implementation and reuses the same binding definition.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
