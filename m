Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795811634;
	b=s6H0JPi6RmadU7SubleZQ8QTl+5M4Z2t8ffBPi7akYG0LzxfGD1Q0BVQ6ufytLfR5AS8
	 3lO7UG/LGL4pR7qJzoIAfk9lTmfAGFBKHEClxornhIOHBa0STThZHpv/ouPAGBdOKAr2M
	 M4c21Ldt1FzqDMzMr9/pVysArt+Lq7ieqide9NKuPQj7WXW+HfeXB8g/WFv26pe7k2MZ4
	 nay1mbyfhZlZv482D0yr1ND9T5Vm9og+Z5fGX5gRIZzFL2ARnBVFqcZlp8lfkdb2grm2p
	 TJQo0tAVkOU24XGLL2MHW9jIirH9fOdIpKH//hHE1BFxCGHXnioSbrdCSseroUsJPow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795811634;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=M7NWEtOCA/msVj4P3QXkAvYOuQUhm34azwePsoxk0sU=;
	b=xK0Vj7gjqr/RyUNVm0uf71ZMjoIKKbBHEq+dTw/ra/VC4m+T1pSWkuuSy16AkPPSoJ8J
	 CGD8drZn+MBjBaeG8n5Rpkq577OSevoGclreeFVZt0Ox9HF4M0kw93YCrxegLwKDRkpnj
	 2lVcI39uoOeWF2P5BK+vU++E42zMx0UHigX//DL4/HWbt04M8/kIiGB4xdTLrlsI8Zq4/
	 RrWItwnZeVjCsGxbq6yvb0Kny2IdYjyfajZOKcpR3TT7pYZ3gqvmbsh7V4hTQBYIOvayS
	 Ad3Jw4KLwNjmtjXFMiLCskw09ZaVHT2STt7ClpfmffM88c3AxnpvV8jBJtFCQvXLhmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fuuoNibx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HkteGFQg;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3413606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3413606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fuuoNibx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HkteGFQg
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARJArLQ3982228
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M7NWEtOCA/msVj4P3QXkAvYOuQUhm34azwePsoxk0sU=; b=fuuoNibxWVUUBiwo
	KKdAgXaDFx346+48fl6jf/yYRBSHxXzmSVdTRM77QYnK5yUtT6L5sZGhkVRnfaaU
	MsTtprL/SAeJqZdZV+toq/Zr6TL3I/ksjY07p1bcSYp+nGUWP6iS9bhIlwtPUwv5
	aCrVBoMVdpct8IYBopQLnsAKbFwKs7aaRWAzXEcYbngeeGZUxsVZKvVDWXcGDxCF
	Z67c9tu+wNI1T/sWNpwhb5vpWfQlA9QgF7EVEf1o+vRt2a4iNA6opwIm537GmU8F
	l1qbLoA0phvLd+n1WQZEdgfWzu3h1UDCTlBSj8SxvCngFC+vDrXDWBpsjLHzC077
	u5SHoA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7f6d895b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 20:33:53 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-55c16eb248eso134879091cf.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 12:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795811632; x=1796416432; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M7NWEtOCA/msVj4P3QXkAvYOuQUhm34azwePsoxk0sU=;
        b=HkteGFQg+XXIibWQKhGtlbgzrRb2tK3qhU0z2RENhEXYN0k216VIUOZPiR8COHPMJ2
         SPdGfgBnQL86xou0JLmmstM5uHJbFIUkdGiJR+0erO6mZs3sdIj1xwP5AD01nZxlgrZX
         G4M5ciCrsvJ4hKjHQdGvUzWa6+MXAILN2pQUqx6k069gNSs85jBCdot93nU6q1cDhEoI
         TInHhRi09c6rerQAyNFcy0Te9RIcSYtMvx5hjmXyyTnfGw8NHyZd2Zx7U47g+aOUEYtZ
         QqyL+LRaUJmIQm6Am6eXLzUtmQzJnzBGBAltFVIJWFJt2C+tpNcrEA/LhpREJrZUBffm
         VFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795811632; x=1796416432;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7NWEtOCA/msVj4P3QXkAvYOuQUhm34azwePsoxk0sU=;
        b=c4TD4YL4k/JKmiBz83q6zdC3oKKgJjP1N/6GCMLhIJJymWGHj3oZkwuB1euyXt38p9
         EN3InGIugulp6iI60AjoO56RzZ3r61ForwrIhl1ZLeqD3CwbMRC5V0jpn/2G1e3/V+YE
         IQilB0y5b9LLbs3EPY8P8lng77Lf3n4+gLhRBOOa2V4swUcWmk2O7K4GrV0bmEu4HfQ8
         nyjiDrtD4bFZH4ANe+OQJiW5JKWNgWyrsz4X65mCbHFdVtfIBeiVnSYhIrAHZxxvRqyG
         LqBESxNEmygniSNHuBQdRrCSppy18vr0BZYc3jt+RSMiREL5j+z+Yk+qwW0347w/JkPb
         6LLQ==
X-Forwarded-Encrypted: i=1; AL+hErEpsV/n06tJkvP2J8a3Sz6NtLlLWUL1gI+4WpaWnexAbhBJggJok923gd3n4Oea6DeTsxg1vQYjbzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rLp6iIZrIuPFAt0xu1/SWHFYEpTjNVjkkz2bu1TH/0vLwHs7F
	5eHGI7BixlUcLAXktBdGUI0pr1BnAodm7edTIONy+h+NbMkRqdUbstwXlfjAivBETPYbMjS1IAG
	SLNPhpsy8wji6WjO12XmA1pj44irraUwsoDXR8haMHJbHz6ZmF+KJMpFx3lf6A6g=
X-Gm-Gg: AZFdTZfo2IP7gtK40n8rMR5xzHR4FKq8oZWQoT3k4Rs7OfB6ryLwXMoURWexOatxG1Y
	HNWW9D99AKVhRZJLfS98Sfv/qEKSl1N/fadsWXg8K19A9X0tFCBkEOAv3B3nMt835qd2zP+n/b3
	MagriU2xJs6mFf1/aFXG8T1btDlcOzqb5gX3EgDEHFyvlLH9HoeZGjBlit0DpbzkB1RDCYJws8b
	b3c8PBLuKnRGOZJYVpO1PAgUCzIiB1+TEnG1/Ya5kFwqWV1yvITctbtKn6Mm2IP2xWak41H26OD
	bj1VxU59VJZFozYUU8ZD53QtGH58hm62yXOWQk+dqLsqOMQrEOJMzrULU4pm8z94IUFzGR26rTV
	IlX7pUZLPtxi4Xyzv3cgv++Tc+nzaIEjAFnwVWmGK78kakcctVg3blU75ju63Lw==
X-Received: by 2002:a05:620a:1a28:b0:93f:1936:b20a with SMTP id af79cd13be357-949bab284f6mr4399630985a.76.1795811632312;
        Fri, 27 Nov 2026 12:33:52 -0800 (PST)
X-Received: by 2002:a05:620a:1a28:b0:93f:1936:b20a with SMTP id af79cd13be357-949bab284f6mr4399625985a.76.1795811631855;
        Fri, 27 Nov 2026 12:33:51 -0800 (PST)
Received: from localhost ([2a00:23c4:e5c9:901:c496:8838:86d0:bc8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm48338546f8f.32.2026.11.27.12.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 12:33:50 -0800 (PST)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RESEND 0/2] PCI: of: Skip config reads for disabled
 bridges
From: Christopher Obbard <chris.obbard@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Chen <stephen@radxa.com>, Junhao Xie <bigfoot@radxa.com>,
        Daniele Briguglio <hello@superkali.me>, dragon@radxa.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
References: <20261127-pci-of-disabled-bridges-v1-0-3bedcbe51cda@radxa.com>
Date: Fri, 27 Nov 2026 20:33:47 +0000
Message-Id: <179581162724.3905807.13798536034754126199.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=423;
 i=chris.obbard@oss.qualcomm.com; h=from:subject:message-id;
 bh=TZkDGwJBtyA0TiNJhNB/OSVSV/aagdKBXEGWAdK0OLk=;
 b=owEBbQKS/ZANAwAKAWNNxPBocEb4AcsmYgBrCektwUucylrVH5BWh5c4Ud4McwsPdJqTGiBl9
 dnw2xSBuVWJAjMEAAEKAB0WIQTxi9yLbCX5CqI9UXRjTcTwaHBG+AUCawnpLQAKCRBjTcTwaHBG
 +DMWD/wNRZ+rlpDvMQQwnU9WtQcj8Q8Bg5b8dB2Yw8r2gPvmqD28DZeiYtjDTPWIdufB+iqgz5k
 08Oy0/zegQmPIY4RI4Chc3nJVaJXm5+Q24F1IfX1gW/g92ofustFieS4e8CsLo8YKOZMPlUBI0I
 lfXJlQqibG/hp63ZeYoNtwEJSjJOwU01etsgdsOJUeZiqcw1Q942oaLpYAK14p+Tl2CGZ5n9sNf
 kx8pY0Gk9d9JorphQkOYSN7zU09LaCTXnb506TBnvr1WQd+KjFc8a0DbVeEn7AthfMNExY/E8su
 E4apPcjKnPDstI6cL4Qa3acHbxmGaXXR5phfOaWJRaHzZQIoj7SariTGgq1VS6MSa4EGII15tZT
 HmYyMS9Ias5gBk4D3ngSRwk+y/9CIksmiyB1KhHbCo4YVwkL82U2vPd6gdqi3dsA7dtx+8gQr3X
 l/IOARrDpbLzhjrWkZrcmxHTiUcKmrq4CjZNRlSS3IXk/NznBYaR4GnSpJHDqrEkJZZp3jte6O1
 AV6n2qC+eoaN1ODqBIDCLh9wSBS1FdU+4dC6rK7WLP5rXwl8rqNohrGtM/izCvEtXEeu2fiOQfa
 BZysQQPlK6osqHi8VKGKaPdL5qkD+go0wo44qHrINp3/xdPCnDc7uwzFMu2jpePgCZtKOSGiV73
 HIIHqY3tgukda8Q==
X-Developer-Key: i=chris.obbard@oss.qualcomm.com; a=openpgp;
 fpr=F18BDC8B6C25F90AA23D5174634DC4F0687046F8
X-Proofpoint-ORIG-GUID: PYpxBZz2Z7I4apVSBZHtbGpXgoMN1jLV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfXz5gv0qr2tMOH
 D9KOiT+DjebGYxJl/ujkROfg4mmZsRfrSde67r65zKd5T0llQqXDAm4n4/q7DZJl7YswEscC7GE
 mi2LovDE6NJUGe4nonZoY0jQekmPFRQ=
X-Authority-Analysis: v=2.4 cv=IKqXmQvG c=1 sm=1 tr=0 ts=6b09e931 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=ksxQWNrZAAAA:8
 a=EUspDBNiAAAA:8 a=Rh4h1jE-l6Tb1weBNBoA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=dawVfQjAaf238kedN5IG:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-GUID: PYpxBZz2Z7I4apVSBZHtbGpXgoMN1jLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MSBTYWx0ZWRfXwrnXp3ibEeT1
 WNQzBfnnjKX3ehvQmUUSZMk97BNiFbAvdT8mgpmx61mmeOf0R+bVr7ZmI8EIaH9IKM+TO0GKhVq
 dCvgG5O1DOjmnNRSVYTjGqRUIdI8w7xcLaTKWlB0UvCVVJcnNTMrjwOF1wk4NQXMqg0I4aV8m8x
 cgyaweyalWsqex/N4eOTJu1l+sfdizLGHMEFmdgUw+njcxVCWkx+t9TsGzyV9/JkZXZPrVALnga
 gkcAGbvAKZAGInP4fuRfYZ2kBuyJL7iuyL6DEZmfNnMWzwKd133tX8WZyndLa62KjbdejzFrY08
 UgsoQvCUvcY3YzXroaQD2+KmygNa8sIswJVGASPVYb3QUdG8s40JQC4nf+HsELVPZKjbiLjhaIg
 Q7UibS7ZUaw3vDD331awhnKN0llZaXvc0Kfd1Fomogy9oG14cUtRQmnB0GUqASLvHB60HqsprWQ
 dFj90zS+61wIDLII5gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270081

On Fri, 27 Nov 2026 19:49:31 +0800, Xilin Wu <sophon@radxa.com> wrote:
> PCI: of: Skip config reads for disabled bridges
> 
> Hi,
> 
> This series extracts the PCI change from the Radxa Dragon Q8B board
> support series for review and application through the PCI tree, as
> requested by Manivannan Sadhasivam.
> 
> [...]

Tested-by: Christopher Obbard <chris.obbard@oss.qualcomm.com>

-- 
Christopher Obbard

