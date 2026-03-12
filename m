Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D193947A2
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315733; cv=none; b=K3Rlx3CS9qvObFhhaZxaU/6EQbBMKtfKHmfpiGMyTRYRQ+L+OZs+qjYA1U1vTIuk8YcIFymKPsqMsbSUfzCqJ2QT0Mx7lA3hBQsDZPQnlmyurxFhH6UHXBhw78+RrWR9o8Fr0v9kVpZr6zN4qBMkIorQXTIBI4bg8AMMl+Rrlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315733; c=relaxed/simple;
	bh=K+Lls85tI06zAStnQt2JpIDd94kGRPBAjQ4m5phRPV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmPHh51IRzwrg/ZKMKCuJWFMjfireNpHEX7poE/3X+sC1qgz3QAsEUvqQFmeHCGx9jVqXd8+Rzt1WMULAmvvCzHV6OQitk4HWRGReDpdKObPE3SB1sRSAolL6dv0NQ+3notWBiUH5iYilbHaseWfNEjxHmoiGe5dF5NyiCyApfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P5phZrdj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J7RSODjH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P5phZrdj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J7RSODjH"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C7drDO509557
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LE+t+QqJAI+/mgc7W1OIUYrBRVzqbLNj9RJHGrZKK9Q=; b=P5phZrdji2XNB1A7
	dTTi/RsItP2yc1RU394FYJtIegEYWxTNyrkQb0nAwMYAKmSD8GZ0IhcKP0iEn39T
	gPpRZjfwGbi1uO32Yfl3TFFBlGMioBr9HyrKxTKT8kBqhEkU2yEOd8CFcf6t9eyv
	CqE9kdZD7mCqzR8uNPVT4RBKJOpmu73ReHRA/EkhWeGpxE2vkNMzto6iDdQJgujY
	LOGl+LoKIbBfmjlUgTd3w3s3q1mw3x1d3hdxAvi6MWs7VO5s+YYappVus92gUf+M
	U2peZk8AIN/AUUgB+VjEDiVd6wpnW54pw9QdSIRCsBJQQnWWpQcwYQoQm+ZwhEgs
	wMOK5g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cus9w0m7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 11:42:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae405e95f5so10896115ad.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Mar 2026 04:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773315730; x=1773920530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LE+t+QqJAI+/mgc7W1OIUYrBRVzqbLNj9RJHGrZKK9Q=;
        b=J7RSODjHfWdCER63RtLjQWiaIahcMkD0FXqsS8JTXK52x7WELXSJBUFQLlWG2u4uXZ
         /e75MGX/mehM1TbAMQhnf5rTK4l0EBbWoaTDCHVYAXF14cNMa+AqIqQwwgVtHjyYuRd6
         2Bw453lcyzt/gfJ7vJGMQm99VTPfCyhrGFG3LEajJvBG6cfn8TkrlkD7vOrESinzFoIB
         kOKIt0+ML5yX/u6QbiWk7qckm6gw4BkIK4AAGMlSmDc+F1o1rMRtD7u6wD0yMKD8aX9o
         64/16qnc3Wmdqw45DiqAwAvFEfUJXDpwwzBQpAO3ks6vih02KrgmxgNTxZhxmEjQTBEo
         qZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315730; x=1773920530;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LE+t+QqJAI+/mgc7W1OIUYrBRVzqbLNj9RJHGrZKK9Q=;
        b=B6+FQeRrpE0RRUgn/CyC4kABr4YiYlTcaAB7ebDNDnlbOlc3vU+paCtoxim3F7jX9z
         Sc7eKl61thlWpgoC58gMnWF+k7W7tKU+BUlerxhR73jBS1SfLAX9zx5Rzrqoh+DT37aP
         9SlrmfuNMIk85w7BNKvLuxSmW5YRKzK411AU64i6P1mdCA9ojjRtoBHZVvZDk5UgiKgZ
         DfsIVnYKV0d/GNnZQ4wj2OrmUUYGWJihEaGnP6fOSFadXcTycI5ct11OEn9HZcyns40y
         xAZqqxfpSASmcLA+hi62jqlUDw6y5RMwSeNHqfPUJiBb2fG0wlHPGZBC5u3TtYI+8WUk
         az5g==
X-Forwarded-Encrypted: i=1; AJvYcCUJF3FpqIIzbNdjPU0fltGnjF0p8HsR2fhiEx8o4GclSm3oIPCMRFFba4Oiwhevm/JLxJDDVkOrGig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyzXE3gdbOvsw30YxS8+RIRsGlwI6ysW8X305HdbGExsp8Lya
	RbCvTEtjzC6Oc4PpgM4bWLcU7ndECq4EgnrvIrCeVd0+TfmHL746Equ41om1URlXTbJd3aFk12S
	dVBXWWIRezkSE/uXOmnOfpqzxDI4eb79xVPPECeXV/R55UGUG2APQ862GvEspgvE=
X-Gm-Gg: ATEYQzwrNKuW7SbtVMeiMqMNAZ2sw+yGnqAS70cUB7MPEDLsp7hi8yBXvfMtCF7p0Nx
	IfQcaEQ5+4i0tjbfdHKj1SjFvOq0i0ldjr4RCI1EZlej4GE8CvfJ18mVbTUo8xBYAxpgpTJqvvT
	EU77QGaFcwoRNlsYhlejx1CUgl89xdHHV5dvr6PuTo9C0xkHNMK/aPFMxFcbY2g23AkEvKWtE58
	GgsPUpuT0nXR3DgHk52Mt8mnu3liTY9sX7uS06Yc62/AqB3MWYZMv0uGfAAuVLkuDPdRhgHYCag
	7VRZpO3jxQUxecY8ZFFwT6dn+kgpOl7nldiREdkHaTz9UWuEyw727MIsxs0LQfaZfN9kQDe+1LW
	ZS+95v8RrKwRUM4soQXC4N2qV0PRdTasl2p9WoPJ3OyIcAEGMeLzfzpIyJg==
X-Received: by 2002:a17:902:d4ce:b0:2ae:47af:3b29 with SMTP id d9443c01a7336-2aeae92124bmr54674205ad.57.1773315730438;
        Thu, 12 Mar 2026 04:42:10 -0700 (PDT)
X-Received: by 2002:a17:902:d4ce:b0:2ae:47af:3b29 with SMTP id d9443c01a7336-2aeae92124bmr54673835ad.57.1773315729939;
        Thu, 12 Mar 2026 04:42:09 -0700 (PDT)
Received: from [192.168.1.10] ([38.254.186.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae22217dsm53886225ad.4.2026.03.12.04.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 04:42:09 -0700 (PDT)
Message-ID: <ce25b963-0e8e-4411-a406-7b466eadb1f9@oss.qualcomm.com>
Date: Thu, 12 Mar 2026 17:11:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/3] of: parsing of multi #{iommu,msi}-cells in maps
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal
 <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
References: <20260309210506.GA589665@bhelgaas>
Content-Language: en-US
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
In-Reply-To: <20260309210506.GA589665@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SuzyTPUw1UO64zP5yihwuyKRjeas_6uu
X-Authority-Analysis: v=2.4 cv=IIIPywvG c=1 sm=1 tr=0 ts=69b2a693 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=FuYIH7Xx0xzBSkYrynBYgw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Iq-Xo7JqGUrbNy38CdcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDA5MiBTYWx0ZWRfX5H7P7NP/0ofv
 NBgShxYowtuFC7qGjYeDmBB8PHvEcr2aOpjaGtZHxMXNqvPS/tVcsOe53ys0dQ7Gn5NJOzvjS6T
 W+fI6mZ5umkDrzIa5R18Mm+9v9jmewlTpb+hi1jJ0zx0esvU+JEdu8P/iK7Y0NbDU/KLP20acR4
 AVAWtDZfxI6n9HECnQ33z9GZrfEX4MjRpNNAl+U1FAIOeM9zkboMnCvYAFiMGM0xV9HbmURee7c
 GYOX+ijs35Fo3IO6NgIZ3s+5jySQEjk94xKQeaQqKomA2Czhqwk98iEp8rrbeLKqhyEBWLctPAS
 lQhLiL5Tg1dhi9/jzQiNOoKB0KwZs7rF5+4DHhy7J9Vk0pPXl3/yXBqCPlr0mjiseEf/4f30b2v
 c3o2jfqbY2UUCRbkCbgsIyokhrchpT958eHQiPq5jf6MX5aJGGOVfmPHlMXH36yRBaMc3zJmo7f
 8R9k+ClRKvgLZ3QmWZg==
X-Proofpoint-ORIG-GUID: SuzyTPUw1UO64zP5yihwuyKRjeas_6uu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603120092



On 3/10/2026 2:35 AM, Bjorn Helgaas wrote:
> On Mon, Mar 09, 2026 at 01:03:36AM +0530, Vijayanand Jitta wrote:
>> ...
> 
>> Charan Teja Kalla (1):
>>       of: factor arguments passed to of_map_id() into a struct
> 
> Please make this subject line match the capitalization of those below,
> i.e., "of: Factor arguments ..."
> 

Sure, I'll update it.

Thanks,
Vijay

>> Robin Murphy (2):
>>       of: Add convenience wrappers for of_map_id()
>>       of: Respect #{iommu,msi}-cells in maps

