Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B9F35FF50
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773209539; cv=none; b=JIBeRtHG5GVvaLYRPr+hQxPpe2uQSnLkGs5CgPBjNmd39a8qBUf7Zr/uzIduPqpx+ctNgM1dS92oA0MCZ/km7uKbmeGZMJSKDL8VdbxQ1Z+9prMyXVqY9Rm/sA9YB7BLckIuJ29iuBUGPUoNMSY6MzrCfADNkzjZfNDnDdArNRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773209539; c=relaxed/simple;
	bh=bajqm9cxsG4pHZt9QuT3Z4rBHvPRxwuJFhr+WIMKRj8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FAxb8FsL94DKZdSCcSnfHx10EP15htbLZx0j0kBjsd8+CyJ63T9B6C50VtPMezvh5VBztojP/jtbg3iIBEaTf85GFPer7VaSUj87YjxBP4akcRw4ezlgIsa1Did0pNQucZHhM+ePLJBjKYnJ+/h9eYOhrZAyJyzfDoqlKFZTeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZQmLpKbV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OE/ugLtf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZQmLpKbV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OE/ugLtf"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B3ZDFO3893450
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 06:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uxZRhY5iRDyirvCDrXWUcHCMIwWAOHum4sDVKV6ieUA=; b=ZQmLpKbVVliL2suQ
	I0eRF1Yb6zx5y4zfJSYbDaSoGfyu2hgjKnCG2SVvxgStfK6tBQqKjM6cwovo/i4X
	U1TWJLZXBRbH+feoRbspATLsZbZgIYu3EpP+KgT7Aj2j2pPKowk18gBeCTSRB26v
	3p2klsylMKkrNv4GtgUw8BpHTjIg3cTSJX1KxN0h1aIIyxpPC81UEejq6WIQtAsh
	FammvwWGgYy/BEwbBAmQ9YHPnBaC7FE92OoAT7bKFRKAYXE7v07CYQmzokqRjkJL
	f0O5j2s+zad+yficev01b7Vv8Bpahe1SwvcIhHvyb68Xqk1lStBJlKsAIrnStD5W
	wsO/ig==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctkmyuc4p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 06:12:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3595485abbbso13164300a91.2
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 23:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773209536; x=1773814336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxZRhY5iRDyirvCDrXWUcHCMIwWAOHum4sDVKV6ieUA=;
        b=OE/ugLtf7ZWUafSWZeGemzk9jvfbx8xbmgxF0aL+RdmoSLTk6Wth0uEUHeXeKWW257
         Y/OhY5b+oENyuzDx6fSTuK3EqKCTLrE2W2qtMjJKBIK+MersHlx1z7QoI5jPQlv0Rd/K
         DzdJ/OwvmUrWrrY5pwTqywHpjf0iXgU9n8fHDNVoGZ0FHw+OzBItrXs1Nn/Xk/a5KUSn
         N49cu3LIUg+n7wZXK2tH5kF9AOv6rvYa/v3qc+lVxF4vAhQwa2D6gox3TGwLGKJyGFrS
         bbiWdmmg2HSpFnggLyKz1iO+bCO3LGtoSFroqFY1OagZFdRXINij0S+fCwSCXvTXD5/D
         hH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773209536; x=1773814336;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uxZRhY5iRDyirvCDrXWUcHCMIwWAOHum4sDVKV6ieUA=;
        b=qieEnj9Ixb6qIh5X7+jA2n9bdT7Zm/A8orlj4Bq1TA8q8t+CtXBwAcnl9MPoP/5jfz
         PgcLYg/67GlyjYaRIpOqpOTQ/MnX5qcBGOmrhYo7Xs9h0X26fj1RwdYp3/ETduShjNE4
         jgWIzIIxhNdLFIQqQP549m7LEPlu1mzhiqcG3ba8Uw8GCUusEF8k2TIKHyy4CzFeOb9M
         mq9+IPEyF527BZ4AscHnCxJXUYefiHWbdZXI8SEERIU7GB1k/21OM2uDh5StDdKiM397
         bUGRZXIi+MJy8xjYFarvO8nveQx1Hslhp47O+oCvCTQBpNshB9AAiHZLf1eNNHsYXfZg
         zxeA==
X-Forwarded-Encrypted: i=1; AJvYcCWTwAtzELtOYHyBCFNsSX0FZfG6VCIKOz+YybwfkiJszM8gAJPl5Q+BIRQaQFe4z0SdYqgyTmrmZqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KuMAppsVJkwCJbCin7kKGo0xc4GebrGq6svlWu7BAMrIGQbX
	UltBrA4jOaf6/4o/UiRj/ejvPA8YLDCX9dScvlzzwCz4P4uRoDifm8zBxrQ6Go3yMO6uuIMijZj
	8Zi6QGJxljCGSK4XI6j8Es2xSLVSkDRw9s9KnJCaAWn6VDmmeAEQPUQQtXTlj1L4=
X-Gm-Gg: ATEYQzyoCcI6MAD0V21KXRIx7Ewsyv/AAxbgBvc8SGCBRA8Acg7mco70Djlx7AGa9kw
	OJgqYLPDHrwHc7AzpYmgrWNejnT/Nj1s3CDeSZYXbOz7L6cnbW8aZMSjbhrazMTWpZ5uJK6psP6
	XC4yrhosxNriisycqMuj4uOOfXMYUU2FP/zhY6SP4n7Nm5EFEpvHtGtUjVhHnJq3QfXZC73mNKy
	7T1BACJAG+2RJ1s5kR6tYbKCVIhdQpV817nP3iy40JZYORhR64P4icPISUEfR4lQgTvJDME97/w
	YlWr5vLzPG1lZG3U0SB/K2QGSFGNHNM35grwQDUuvUR8aQGe0vuUkORqNf/eAp4Dzh0Ujc1T59R
	lP8q0/GV9s2hX1ZmW/SI=
X-Received: by 2002:a17:90b:3d01:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-35a012868eamr1331653a91.4.1773209536244;
        Tue, 10 Mar 2026 23:12:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3d01:b0:356:35a5:4a64 with SMTP id 98e67ed59e1d1-35a012868eamr1331622a91.4.1773209535691;
        Tue, 10 Mar 2026 23:12:15 -0700 (PDT)
Received: from [192.168.1.2] ([2401:4900:88df:edd0:a836:2d6:92a6:a5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm1175287a91.14.2026.03.10.23.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:12:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
        lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.bruel@foss.st.com, shradha.t@samsung.com,
        krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
        inochiama@gmail.com, Frank.li@nxp.com,
        zhangsenchuan@eswincomputing.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
        pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
In-Reply-To: <20260227111536.1940-1-zhangsenchuan@eswincomputing.com>
References: <20260227111536.1940-1-zhangsenchuan@eswincomputing.com>
Subject: Re: [PATCH v11 0/2] Add driver support for Eswin EIC7700 SoC PCIe
 controller
Message-Id: <177320952799.15366.7679761469929073093.b4-ty@kernel.org>
Date: Wed, 11 Mar 2026 11:42:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=RYudyltv c=1 sm=1 tr=0 ts=69b107c1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=h4SL0BZ7AAAA:8 a=GM8G9jC1lcraCpjxISAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Cfupvnr7wbb3QRzVG_cV:22
X-Proofpoint-GUID: 71RqIr4zD6UHf380WYUcek-lYNwuwYAV
X-Proofpoint-ORIG-GUID: 71RqIr4zD6UHf380WYUcek-lYNwuwYAV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1MSBTYWx0ZWRfX0SgCjyRutT8I
 ilXG1BRcdbuJs6qszJAVtSKYtp8HVNWxYitvM0MWErrwoCAmcSO0H4BV1eHjFvTumUwhrIDmI+p
 z8Q1efo/rnQwsU0IE6xR8EN0rkKearE7dAy4I/cEsb0mpIJovD00ZnebrTSwOtmEBP1nAS1flHQ
 r42naP6Nf/0nvQuKTkApBhOywzy13NnYesA9Dt4VrcVNs4xUO1AxzJokR7JYLfeUPXTNlwYvYIj
 D5b9Gx46ncs5l/Os1KhWb+2kC6u6Evt5wTH4NJuKxCPzWvPYGH0+rb2FVeFoRnRqMj2rjRRk9wr
 uzEnySoH8uEKkbAlWxTtvUHbjES9cFSy7IjZICPLYddf87Q5FsrmpJf8j0qeJKwiEuSbFMeMdE7
 4YkBaeW6Pwk8uvp0l1uwei0iKIB95rM+Mh4fLRWgwElm/MczOZa3nBMIi9E8d1kpxtqcPO2gBsS
 WweLko0tiiYmlYGBBOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110051


On Fri, 27 Feb 2026 19:15:36 +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Changes in v11:
> - Updates: eswin,eic7700-pcie.yaml
>   - None
> 
> - Updates: pcie-eic7700.c
>   - Add ".data = &eic7700_data" and ".pme_turn_off" callback, set
>     skip_l23_ready in eic7700_pcie_pme_turn_off API, because the EIC7700
>     SoC lacks hardware support for the L2/L3 low-power link states.
>   - Reuse the dw_pcie_{suspend/resume}_noirq APIs, depend on commit [1].
> - Link to V10: https://lore.kernel.org/all/20260129092629.1866-1-zhangsenchuan@eswincomputing.com/
> - Link to: https://lore.kernel.org/linux-pci/20260226133951.296743-1-mani@kernel.org/ [1]
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: PCI: eic7700: Add Eswin PCIe host controller
      commit: 7e8d4b3d0b1b05c3c09f54a14c8da6f21bf2c852
[2/2] PCI: eic7700: Add Eswin PCIe host controller driver
      commit: 7a129ac6e31bc0c6d7149fd9c7c78bba7d0e9e42

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

