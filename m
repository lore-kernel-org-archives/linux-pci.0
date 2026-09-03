Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E9A3EFFCC
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437589; cv=pass; b=tqTSbETEPbrxKfViAkZcmEem+uio3ZXnWAUh2sYNy5DNhInKUbQwMjGVuvopJvyFBqwH7i/SSC1PlzMLRCkqMllDngYSaEiXyQaZfDEl2J9GLb9/A+wD9c33NP823LhRb5KcBMIk3AlqG7mWn7kjbpFbGKF3ZTBmmJGKHPpIEQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437589; c=relaxed/simple;
	bh=rCAsFqPyObwtdPuK7mooJ6bECLcZM9KoaNHChmdp/NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buiHOkQrnV0+I3bdIuiD1yFwKOGB8yTuVjAE4ZBccWiQxRcJkS0WAc+rsyKYtefpW3cs/W9uTOiwXgCTqBXjMYAvSBafAxw5EHWY7oYHfS7+vjJcGhLWm1hnxQQBsylLV84oHqu34snzC6T0qM9n15U3sqT4l8NqvtWn0a22YH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SiPv4OR+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W6pURTlZ; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SiPv4OR+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W6pURTlZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AHA7V212400
	for <linux-pci@vger.kernel.org>; Thu, 3 Sep 2026 12:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rCAsFqPyObwtdPuK7mooJ6bECLcZM9KoaNHChmdp/NQ=; b=SiPv4OR+84hEgH6l
	RPDmsXUNwVS4Vz7tInAaqyOFtAWWmW/Mq53+MMoW+ppSEyHti73UEj+894ftwZTL
	ZQdL2iCEsYxQ3wfF5+F4ZNAQfJ38Qp3rlb7p5uSzige/fReEKt9tMyc4ICm8s80M
	GOXJ0gUS9XtKZpZ0JYlmIc90m7k+5RoS5AE2lZ8hUPRTnU339LhruDV2SCfAuURo
	QhX3fLJjP+DifKMlYSPEWu4gfqkcPsGf6QESbpJD1vLRl03dphAR8fUY8TGBqvdC
	JwZZRlXUo4mdUzcBS8cwxEU4pwTtxspFVkB6Ay9QpG1UlyOhTOsJqnxfWXjluawH
	3hW3kQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyht1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 12:13:06 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6a313ec13ceso2388479eaf.2
        for <linux-pci@vger.kernel.org>; Thu, 03 Sep 2026 05:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788437586; cv=none;
        d=google.com; s=arc-20260327;
        b=lGw7UGZQStlyfYId/hQ5xppCZAnaSSOTjvCujQc24I9IZIj+C4tq6cIEF17DdScK3q
         4Lgj/ZN1bmzmjOVd+Nx2BMlguijA/blhxZNJGudpe6IP5igRTzIkx8R/ZuImXQnk5Ww/
         R2ESOX7vysFFzUA+PHRcvOnTwKk/3dBeL1fldiiMKLR3GdAnmSjWB/2OEuvKyvyIaA4N
         xNsuZuMEeY+6Oxc1MZm5x1CrO7zJKhyJsRnUKbTJ24kLkbqcqAYFhHGsGMaStGJjUuF1
         aWs7AwqbBbYPDSqYBfttPQTa7mWzNMaYhjBkYPj65Qxg+Qg0dmnxJJ9QcDnDdstvP7LW
         Ho9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rCAsFqPyObwtdPuK7mooJ6bECLcZM9KoaNHChmdp/NQ=;
        fh=uSJ9uhFtSuSzZz+N0BI2guj+mxdqXyCPBME36Ee8ABM=;
        b=Sk2F+53I4VjdB08XeR+DT37ha1MI7uGlxWzg/ZvU16BZ9R1vnzTXNemCbdqpsR+PW3
         5EO4eFCihRM7JyGIkanrUzoHQsBq87sBhv/l+3MSfooZOm8qx7luubaQu2X58cJ+lyEx
         ifHyGwI/3vwIdFhmp3Jy+wc2ZWGLKq+/Pfo7XHARQFbSS/+2XVMSuEupXcRVlb6gGwhA
         TlqFbYOHjEFEQ+jGDReCGtpFEtUHMFdnTANfExYbSNJfS8bJ8F2hPkRlCm5DwUCMjjBF
         ZIwNbVgnlUPLqDeHRjcwW/DomTsHvTHZsXnKaxK/G/jHoen70sdhBtKuBW6ryPKLvTUT
         iidQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788437586; x=1789042386; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rCAsFqPyObwtdPuK7mooJ6bECLcZM9KoaNHChmdp/NQ=;
        b=W6pURTlZf3b3uJnaOP/MUFdsMve15giipOaMoCfjg1O6lzZJQ/YCeKojhv9QxjL41I
         9gM06nDWiZQx3xgTlpSbqmGDdq6GOvE070ckMjfg2Tfrh1JnNVKH1mmkw7vr/wgOhiGz
         aIRCyiBPFWkKsZlCJBNCa1bYXcPq2ECdJMSO2A5IpXovtdwxLq/2bDdFl7YpxRi/XOJc
         PZuFYdI4pAM6eY9k4SQ330CJeGTKse3scqH8B8S7eJr+OvPdm2HNfYKwjLOHmX/F8dZM
         WjG/8kG2Va3rNCnKHTnQh6gV69+K4VIEEfqvBq0I17Q9ciXjgOqlIKGReJfssqnknWr3
         qc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788437586; x=1789042386;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rCAsFqPyObwtdPuK7mooJ6bECLcZM9KoaNHChmdp/NQ=;
        b=KfxmYVmAEu3BOp0VsYwtM38vHrFPU3YCZhnUAru1oZunEsNKGwxcxoPNLIExwYVKtY
         PVw3tI1q3eE07OZuAG2n5H3ENh2g5hPDrHUgY6H5CONhSaREIUt0GzWQc2B+IdSQZBP1
         9D5fjjGBlR1Gylw82B3FTZCcOfgM37ah7Hd2BfFop+U4VBFHiCi6A3/tszzxngX2y89j
         juUvrwaPVO5MnXcvExmzmgXbPTRmFSCXIFH3kNlbB+AJ2j9qFBKDFhShv/TuFwRHoreZ
         N0L4gmUCrofDicsaNWH0wb8gE796bu/soFOiqgTHUlgq2lrjzr/w0NSjNHHO37c/6g2g
         XGSw==
X-Forwarded-Encrypted: i=1; AKwUvBx2fRsr0jNnO3Pm36bim3xspgiAgw4q8wthYBpDwtMWun44jA7zOh/cBdwnjDi7i8kk/Ua8hb1N2FU=@vger.kernel.org
X-Gm-Message-State: AFuF++mI1f3RAjrjIQ3xTt/reGRCxLYcEq4fSP58Nrhoi1Lw+FbnM2T4
	a8Vh4ZE3XEgVKorDkLHoD37qxXO503AJ9aeuOBNSLm9uhOegj9fBgnsvxkIrFIczEi9+sNPebAx
	mDpDcQKsddRcLPbaZ0lfN3LGY+f1ZR0VxnFTz/tsSG7q750775pFm9GWMWeL5idrKDnTVQBKqd3
	9WH99zSuBKF5bOmoj2wAypu+hMN0hxJsY57qWD3w==
X-Gm-Gg: AYBFou3FWfEF2pQYcUZIaMWAv17E8kt6miIw5vNcWkdj+pl0afg76+dPPDb8xWAnyB+
	9n9sDW1OIxTytNyASwDHY/lOzmaUoYRnKsjYrkWpd20ZCw6eow1WMX8ZBUiv+j+HOhsELz5/kFO
	Z5nzbwpEhnp54JVRbA52VTqJLxN6wOc/AQPPzeoaRz3ro5a2Il9bQwNb0vAQ==
X-Received: by 2002:a05:6820:2d08:b0:6a3:92f8:96ab with SMTP id 006d021491bc7-6b47ecce067mr9305162eaf.1.1788437586033;
        Thu, 03 Sep 2026 05:13:06 -0700 (PDT)
X-Received: by 2002:a05:6820:2d08:b0:6a3:92f8:96ab with SMTP id
 006d021491bc7-6b47ecce067mr9305119eaf.1.1788437585657; Thu, 03 Sep 2026
 05:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-skip_suspend-v1-1-ba2d877e22b1@oss.qualcomm.com> <5bsz2arpufrnbglizghlr3ztkjeqhvsc5pr2qmgmkhj3n6l6ia@atgkmc2igd7r>
In-Reply-To: <5bsz2arpufrnbglizghlr3ztkjeqhvsc5pr2qmgmkhj3n6l6ia@atgkmc2igd7r>
From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 17:42:53 +0530
X-Gm-Features: AcwNN1Xjdf69rGqtBAINnrwGBccYKfXH5cndtne3yrRdPJSmPRATyngrRU3ToFs
Message-ID: <CAMyL0qOSUzMjqMgVuhbHAT3oCfAQ_n2mtq+9iU=ZDC=y_n438w@mail.gmail.com>
Subject: Re: [PATCH] PCI: qcom: Skip system suspend/resume for
 firmware-managed PCIe
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Rama Krishna <rama.krishna@oss.qualcomm.com>,
        Rashmi A N <ayiluri.rashmi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfX0qG6+F1EvudF
 FM6uDq/08rii/1yiqhqQBKzaEd/JtyqvnyJzeXLvmMl6/p4L98Ee8XVcqPXjCkrjdjINrbMXEen
 Y4nD6N1GYPLRufVyPnjMBLMtj21yGZHz9PDw5B3qr4/+jg0ImvQZFCj+QFPBI4NaMQ+C3pMUASf
 AWGG/mdE0Fix5e+Ddy6G/d1zN3iz6SeNd2g6xAuNFChdphTm3QZ2hzDSFsRNXxD81rMprysvuJq
 KFMzssNWOgIDKnUQZeiXFw4/LbMPOveY4VFS5UGoBTRSFbZt7E2AvB5jDQnzAAy0ewZrViSXiig
 J8//K3Po5uHDfOWAACzOhuXLDdfNOOAvq51Y6TXmxZgAoKKfcIIFEBh69f/3P+5c4D4bwkxeWO6
 1JcS95YHVgkjmm2MziCse0CvhUDcop26TeQOZiP99dTJFkeEAN6cP9dsUI/b4kjP0jVex8YQmc4
 IXNDdSV/WgXfReeEcyw==
X-Proofpoint-ORIG-GUID: SGiMOvC_Q0cwffXBFU9TYRF3VyrLncSr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEwNiBTYWx0ZWRfX2XbuHiJ/WfRN
 /XwxTPWGKqmZuohnKDgbDXzLqpuNjG8+h6qVBopWTDuid3dRveGCd/wqjBsmiIly/sV+/yHfK6x
 L5QWTxDK8QlmMqgERTXTdSdIt7liDdw=
X-Proofpoint-GUID: SGiMOvC_Q0cwffXBFU9TYRF3VyrLncSr
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a996452 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=Nm-cwpUMS-KaPtIAedgA:9
 a=QEXdDO2ut3YA:10 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030106

On Thu, Sep 3, 2026 at 5:05=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Mon, Aug 31, 2026 at 07:07:02PM +0530, Mrinmay Sarkar wrote:
> > For firmware-managed PCIe controllers, all resources, including clocks,
> > regulators, resets, PHYs and link state, are owned and managed by
> > firmware. The host driver must not attempt to manage these resources
> > during system suspend or resume.
> >
> > Skip the suspend and resume operations for firmware-managed controllers=
.
> > The associated power domain transitions are handled independently by th=
e
> > genpd framework through its own system suspend/resume callbacks, so no
> > explicit action is required by the PCIe driver.
> >
>
> What about the D3Cold sequence like broadcasting PME_Turn_Off? Is it also
> handled by the fw?
>
> - Mani

Thanks, Mani for the review.
Yes. The firmware sends PME_Turn_Off as part of its port
deinitialization flow and
waits for the link to enter L2/L3 Ready before powering down the controller=
.

-Mrinmay
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
