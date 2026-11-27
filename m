Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778926;
	b=iM3A6KeaPEHVqRp8bKvbk6FTZDqeGP08Qn8uLGyVCmQ+VoaT1jldkgtK8+SPEyBsG7xP
	 kbavHGwIgD6qacRPf6LFAZRWrdc/1mCh0S8IP429ZJXtHR7W3htXXm1ZUYtItWIruon3b
	 ztXfVIyQNhpvqf6M5qj6XouaLFiGP2jH4IEydMNRemBnt2yJN7jKxuG2stCil9hib8d7q
	 wTNLXl/z6AJUKkEqEzcOm+OC5aAuxtZFXfYsY+y+rZt0duGchEmoXnp1IA3aJ6wteFnOU
	 Ddif6i4sBsu/M3WdndNFzpShblw5USvGI/LPuIfpY+7DjBDV8CLD40Eydtt6PZISjBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3QcMFLkVoOVQbwwuwu7BQKszQucYPXEBAdfvcVBv04Q=;
	b=J9kQ+C4+JNdgnc1xzNUA06NlaXrskqd48zj/N3+Cgumj0duW0FZNIq6MiXC6ECym8nMj
	 bWnnOI61KX5YEE+nNHQqpvzlluUXlmxuESENSsn3wR+9lz3lVpdETTvOVBQTa5QWhbU3i
	 jmhV+qIkj3M56W9HvrFqZcTU3Uve4at44wsrn3xaPPThmUlPq+mHaTbCPad96KIcVNmfA
	 ZzJTucfrKG50pnVDuicNqlTj0lnH0GsgnRgjLD0XlbeaEnjstMbtllyx8Cd9jzphE1uyL
	 f2kXiThHR5dFLhY1v9hoD0rU4d+ZmblXohnsVuuNHRXgflcv9TJenNVpuvPQ7+S2xYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cffWaVwq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eoXRxvyC;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908CC606A31E
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 908CC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cffWaVwq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eoXRxvyC
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApAwx2906428
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3QcMFLkVoOVQbwwuwu7BQKszQucYPXEBAdfvcVBv04Q=; b=cffWaVwqTRC4Xmkk
	q7CQKO27Qf+HBe7JXDPh3qS8EMBx76rrdczz6lIFAV0VPeOdqyVEZAGMh6+6g/cS
	NhmmwRw/QQGVUnYqkKcASyknzWEx8xdLsykuJh6v51+e8LVyVmAWq6bZeznxHcy2
	NWBaJzTR2kyRyrN0zSw5Tw7Xf1ApAJdCvdfTX64c9LAEms1IbghLnVzOLWcxoVZL
	IR966B1kRxA+GorI5u9NVn9IjJ6sd10Dqvp2/ov9FOe00Y3qfTk8RuqFdmVN9lrj
	Cxx07gW8c8NrPAdBpFJk9OsG/Hv6FlQGtoT7csVFMlUVcfWeyCXKIek2fN3flL0f
	Lk6hpA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6rf939ag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 11:28:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53630cded29so24148231cf.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795778924; x=1796383724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3QcMFLkVoOVQbwwuwu7BQKszQucYPXEBAdfvcVBv04Q=;
        b=eoXRxvyCcG0GcIcguIYGwmHfNh5pI+biCVzVc7biSCICitb+H0DkMW9ywsUKxDWDlw
         2eI0Anexx22OtjIOu0K5DCmfLe6jVButs+1LotzkN+9fotpvLNvpiw/wJ6klowLu+Tyh
         h/A2TavREPeDBa1RzIQZEKE+iFxFSWE66fDcm3LN7qMjOKej5/WDKqxOe1CNPTrGo6UT
         rEWLhvNoR2sYPnPcHxW9m1DAHY/kOlM4EJEQ4DViiYFuzhmMSgK5t9aXW7Bd4p7uiGMr
         efU2fBE2rcwTrQw3sThmco0QB/6a4LSVdj7A2UIpQVRsut7szxdycng9s9TldFdCeTi1
         awXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795778924; x=1796383724;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3QcMFLkVoOVQbwwuwu7BQKszQucYPXEBAdfvcVBv04Q=;
        b=HE4BZpdeANsHQNDyU3qhUtnvHl2hAbGI7N1342upqVxXH/e129IjGlwqP+DdAE6XsN
         bEENSogTMe/1REUgBTqACF+FEbKEZEXfRYeYyEtydzF7cCtBh5mzBTtYgcuQCqVwGdyR
         q8QTPamzZKyy9ewtBDE+Sp4btKYqECJfhXnb/ON/9t+v+nU2JeF33KesqjbnBQLXwXK+
         gMaPLN6d7H8I7apuYVybvYoeFpVVIQm7aT3SRON4LauxkSqA8HVMOCjFtBU+HAIE2jmG
         jBZslCzH1x3kcRLAfz1U54s7nCjv/7NrlzcAqbafwqOb17CXFzW/usE9IOAOLOXmUsXV
         K8Kg==
X-Gm-Message-State: APuU4Z+o80B/Bl3xcbsmAokMLnUZHYSm0y0MU9pDifPIlF5JOG8e5XSg
	5cQvmKwJ87L2jMGJUEFwbbF+9U7M4vl5N/ioerfOmMKPk5PyFFH2AmGcmFscRlYRoF9PWcp5CAX
	9KkUNyP8JFLgGfY07NbbB4NoE0cZVUMRPMsg8nXeBJU1EmidpdZ9KDLOCn5PhTtY=
X-Gm-Gg: AZFdTZf8wJk3tyGufc6O+BwBsMitlyYECPMNDplTR6/Xgre/VN+CcuuvnN3Ej33cYoe
	a7qReOJd4ecb/kexynyrWzCOq8haaWQSwYXqJFhWZRqZ5II3UeyR/4GBpZXs/JsI5QBaX9y+lXo
	JshsFHXS3SWJqLOoc297JigR4Xsylbkn8Ndw5eSurJ0/4VfzIz6w2QVKfJTJjHeA1iT6g1wQsGP
	rYDSEDa+VcaKKMAZ9GcUyXdT560agQ/+8GFPK5bBfy3CekUnzMs4appxjMn5z/B4Pdxw8KuDj3I
	b5rkYAk/wEb6fhJTo2UuUxKX2sQYAlbEHY9bunNO3fU8biS27su4x/CvcdyV2lGUnusNeWxZ2Ws
	rI8E9D3lal5fKEqFdXf9HAlQkzcvwSUXSekHjbtGBzzulDpkNH+tWXvi+fKuHzHKT1BpaVNA=
X-Received: by 2002:a05:620a:a801:b0:949:a385:d30e with SMTP id af79cd13be357-949baa12795mr4352517785a.4.1795778923804;
        Fri, 27 Nov 2026 03:28:43 -0800 (PST)
X-Received: by 2002:a05:620a:a801:b0:949:a385:d30e with SMTP id af79cd13be357-949baa12795mr4352512185a.4.1795778923280;
        Fri, 27 Nov 2026 03:28:43 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b00117dsm853935966b.80.2026.11.27.03.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 03:28:42 -0800 (PST)
Message-ID: <a049f292-848e-46cb-a2b6-0c4a82e9a7e1@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:28:40 +0100
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20261126-shutdown-v10-0-fed60d9687f2@oss.qualcomm.com>
 <20261126-shutdown-v10-2-fed60d9687f2@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261126-shutdown-v10-2-fed60d9687f2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WRyHb5Xmt--2NQIKXX532aKLEROg5Ym4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX7LPX6RLbp88O
 WI6UVv/sTEXIjIyoP5lCPdRpySvZjL153eUX0iWWZvQrsbe3E3o1tnHicFmF1zfK21CwGjHen6V
 gHf2NbOpD9tf0xBPt6NHG9n2AH1Du4ibUiRxEur/Cb8+qT7AqXi3x6CJ3Mq21NIBMA5qVfNg2Q/
 +1LQH1FQuZtNKCrojLThyJ6LTK53YVN8mXRwz6TP0ghtwZgGLbaqo7lAsnvtM9aplBJxVonlEcW
 HMjO8E/N8qpbCtMn/l2UFlFgCn1J7jIaVafwceb0tqnsgW35aGFz19WHgFogutAHW8f/+6wIzvw
 7PNR+mLst/9r1+cwMM29J0Lyau9so8carOIcXknYwuqMZPflZNKq5JyfzoPq3QU/G3vsIcHzXRC
 Cej7sa8J/T2w0WKzDo8uWCUCBIpykrw3xlB5odPJ0J+Ukc6/X17UuJ6bTCUR9h79YKvTrTmADhX
 R4tvxlPb8z4xhc8865Q==
X-Authority-Analysis: v=2.4 cv=cpkOAF4i c=1 sm=1 tr=0 ts=6b09696c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=6YwwngTh1o4zImgwx78A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX8SHC1ghmj0qC
 wYD2zmiAU6bmjbkNzCynOL5JWxgVdOvsapLhXFJchCjNZwmFe3ExnndF8wtTqFtqhDc2VoK1Nsy
 QnT9axTMNBIpNVHHoNSKmmzjAkK5Qfw=
X-Proofpoint-GUID: WRyHb5Xmt--2NQIKXX532aKLEROg5Ym4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270045

On 11/26/26 6:17 AM, Krishna Chaitanya Chundru wrote:
> dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
> to check whether every downstream endpoint can be put into D3cold before
> bothering to move the link to L2. If no endpoint supports it, the
> function returns early and leaves the link up.
> 
> Querying D3cold support during shutdown is actively harmful, not just
> slow: pci_host_common_d3cold_possible() requires every active endpoint
> to already be in PCI_D3hot, and returns false otherwise. If any endpoint
> is still in D0 -- which is common, since endpoint drivers aren't
> guaranteed to have suspended by the time the host's shutdown path runs
> the check fails and dw_pcie_suspend_noirq() returns early without ever
> moving the link to L2, leaving it up right up to the point where the
> system cuts power/clocks to the controller.
> 
> Add a force parameter to dw_pcie_suspend_noirq() that callers set
> explicitly to force this behavior, still call
> pci_host_common_d3cold_possible() unconditionally, since it's also how
> pme_capable gets set, but ignore its return value and force L2 entry
> regardless when force is set.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
