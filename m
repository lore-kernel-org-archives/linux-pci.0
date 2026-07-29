Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B13B0581
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337854; cv=none; b=KfLo2jfPF4cLrLQ0mSB4DLy6aj3rOaSBGaMJoyrPVg+xqFvNnn2ddQJZ7YNMTbK7wD3HOC9xI3iudgYDlDOH4dB1sj61wN6V6Yy2Vq68almL4KwNnzl4Jev8VdtW67wC1hPdOec1FsxsuopNaPefD8ndmoOI2zYC7cyY7XIVIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337854; c=relaxed/simple;
	bh=T28LwLud2iEzbbgwesgevDXa8dhLYQcfSwjwDOvg/gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC2TViXragOrpeXMVvtdWSFNr+c2yDJ5WodSg6Y5jmKC8JcZw2/rTyov0VAaNX+gl89K1HzBmZdUX2Xdo02GFRQU7AXj5tq6AkH7/sNEcVkBkI0rHDM6QEIxi0SR7ed2qnyvJ9GDeeqWprY2OeL5bxnzZPOenN38Fh5t+3BfaBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXntxlLP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dolS7ubN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXntxlLP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dolS7ubN"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3Qev2593356
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 15:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3kDVR16cPwPN/H4xAF5SCh3q
	n7cgx706CeAbqHCaGCY=; b=nXntxlLPp3xOVSis7uv47cgc/ZazyDy4yvqndDrg
	kWFCf8BtIYRZ1xRYbqKytEul0UF+4zJDmfVJwS34s0s3iA0u/sLQmbCMlhZMWn3e
	R9wQ29CVB6Cu36a4nY4mHNnaubrVb7jBwA5iVuLxkDpw/9qHOl/zixNLTu0/S4H4
	kHmmDV5gp5a7AhM6/9+vEjjE72avo05qxg2meYQnGcnMDJcRbywyZHfv1rLoe1qr
	4V+234SvpZZx1HenpYDqOCOAJ5/Apl8tDiS0zqhLkyDa6NY92CbGRf7Hj9mJ1Ms2
	fHrICKT4ov0Hqiv4opOC7yBnHV1+AXqP0ZuUT/jCdxFl3w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqke086rb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 15:10:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c20762d21so13614571cf.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785337851; x=1785942651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3kDVR16cPwPN/H4xAF5SCh3qn7cgx706CeAbqHCaGCY=;
        b=dolS7ubNHK9C0nRD+i997wUXp0qidBpYE8MyBR6wYgvXL4oPAdVEx1WZ5aiTyo2JHx
         c8hLOFA5H16AcL7k6sTJflrZq87++hljHdLjIS8fDDH3mHMLomxctKEcIa3DrSYTqkQJ
         wWmcZ5bh+5KGntmU8jq/cBRF9Vj0frLDk0I516ktWXkYo1gEw23PCRmWrqGn708PWPQi
         Elc9piRjH+JOJZL02PlsrA+nzQLpDGdRfikElduXmCZO92A4a+iGBm86dMmQH1C36YaJ
         6YhoOzstrC43HTSkRPRaMIrQLYBgpo648/d8mKlpMN3uZ93NM0dSgsAFSUR5VDxXUKY3
         D1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337851; x=1785942651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3kDVR16cPwPN/H4xAF5SCh3qn7cgx706CeAbqHCaGCY=;
        b=QdvYtQ/tRVvLEP7q2y6VfLdN/GLZr0zex3kbRzCHnuuRzu2gvoipJNqILOzHd+xHtd
         4FTGmDDXw37N0mLgHLTboayfto/rJZ4A4upBYxeMLvb6RB+D+lxkAXcIUgdkyGZMH3CF
         5+tcqeYOWQQURzpMWixwiBfqdkQI8mjX7xeOHm+qqdDYMtVag9ZCI/WXhAzTXAFJHode
         04AsNYYrEJclKWcY99r4p8HZKldHzrcmG9c7j2eZm4uiIHoCjx4kUdnJ/U0Rz8PaancQ
         ucrBIBXhqdd2etH5u1PFzU4TfBAC35fq04EKus56jLmt+VvCpSG5eZFqdQ5j9wAKBR8k
         sWhw==
X-Forwarded-Encrypted: i=1; AHgh+RpiL/Vo4COC2MJuhLm0D/xIeZ9r9/L+6PFqc8LjGTGasxDF9xTZatjXhwNvn0vtjTQk5JyW2qrhSUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqIDqi8eI63BzVvVO8eux5xwpNWOmTJLJq+C/KzBAuj9GKk49
	mlBVRTUhXrBz2Wta+9bCQ6c275rwLxmro1xoDESKBVPEVwhR56ef5M2RxImDdSUI7DPZGehKYWC
	eWeuSZiQBd5U8Qr72uoowJGpMxjse8D95GxQ4ZyEEP/iGhLBEDATk07aegjCFLPY=
X-Gm-Gg: AR+sD11fEZs9GO8YLCuQHVTIM1Hye970ZlqvcsCe8KNDqdOU12VjVxLnCTbFvThZrU6
	S1Nt0frUa9bej22M8EvOrB6omE0bebHrUHpPZmurju7p4ebi3L9IZL+UOvGAZYfv2/aoVTNnbK0
	qEu0qKQs80K1pnDgmLncERm3CGRaZ95H1iInp8uSEUyzFvbtsorQ55IwO9nJ0+B7zEa4HwuqF1C
	9mCLoKhJS+ANkf/raGCWnasR1J9tOHXj999LLW8//W+/dNcH4A07epPyPRHhnUvw2jL7lIfNx+P
	8vI8kxH+hqyHvLVit8AxQsREpMxCKoOL14XPzSraxG+sxgVQkbhqvczXrB9zh3OvoCmmcQN7yVo
	affLawZOfWxAXFn8=
X-Received: by 2002:ac8:5acd:0:b0:528:3c2c:5c72 with SMTP id d75a77b69052e-529d7115a62mr61467751cf.32.1785337850909;
        Wed, 29 Jul 2026 08:10:50 -0700 (PDT)
X-Received: by 2002:ac8:5acd:0:b0:528:3c2c:5c72 with SMTP id d75a77b69052e-529d7115a62mr61467081cf.32.1785337850054;
        Wed, 29 Jul 2026 08:10:50 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bff4784sm362740695e9.4.2026.07.29.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:10:49 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:10:46 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: eliza: Add PCIe PHY and
 controller nodes
Message-ID: <bfqbdommlswjz3hji65hg54g6eiqtufpljpa3jdvqxkhsu5uso@dfc35pmlcngg>
References: <20260729-eliza_evk-v5-0-41790a5a24de@oss.qualcomm.com>
 <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729-eliza_evk-v5-1-41790a5a24de@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX+O+zdXu3rIU5
 0LH6pGT1R31/KHrIirOJ2TR02DhbThrsfnURqbxq4F6Wl47N6YzibK3G1pgCUvDorsBTewAwiFZ
 uLx/MUsmoak08/1/mR4SHg1INyZNZTboHQItjJBb+ju+pBEEEeiCiTd16QecEdk+a11bgy1RUI0
 UihiBJg+Fj793SsdbsOhB1BHcXKudoIecXASAGvA+3uzhX3hezv3iJxRC54UiEwUPxUYOuiwkKc
 43ynJ6/nC+oB2mImxlyMiB6+wD0GBSKCI6ABYmXIqm9t8DgRtu/xF0+uR5sBS4TsVrMeixpODfj
 pBShOsEGWzkWGlOiKGLFNXcpRX8cf0uydrAUOBia9Upjb6Wh6DTtI4EjrY4MzdjpEN6g28uvllA
 RymhLYUKvN5QfL9Ssvj6zq6IcqrKk9+dishLQaez8UimV8VXC16nLiBJDWi8okfVehfCusV+mKP
 oSzOt3bjTXyl1TM9xZg==
X-Proofpoint-GUID: 03aXiHi2TLreEV2iYFBC9Cyjz0Qw6ucN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX9z8j/TbFj772
 zwJ1kGSWhJ92hW88YwxR/dSvDyKwPfMvLHR9WaX8lke6C6mbs9BBG8b9OkUKJAbac3PFpTgr/6V
 Zp3JLNY+jhGftK3CZi+PBWpaW1FZbrg=
X-Authority-Analysis: v=2.4 cv=ONYXGyaB c=1 sm=1 tr=0 ts=6a6a17fc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=adJbRHicXYsKkr84VsUA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 03aXiHi2TLreEV2iYFBC9Cyjz0Qw6ucN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290121

On 26-07-29 20:18:36, Krishna Chaitanya Chundru wrote:
> Eliza supports two PCIe instances: one 8GT/s x1 (PCIe0) and one 8GT/s x2
> (PCIe1). Add PCIe controller and PHY nodes for both instances, and update
> the GCC clock references to use the newly added PHY nodes instead of
> placeholder zeros.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
