Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE21B3A63E7
	for <linux-pci@vger.kernel.org>; Tue,  7 Apr 2026 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571119; cv=none; b=IrsGuBKVSU+9aodoI4KlxlY7YUAu6CdyCruw6n/7A/P+21JrkLUlMLLTYNe1GhSZ27EiVP954HUgckk2MM6YLURBySwocs5iEM4ZOGlE2hcXa2eCMLWFCYz06Vau5YGUNEXTWmgVgJ7ZPfn92DU+VxCaGfU7eoStX2t7x+hpFgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571119; c=relaxed/simple;
	bh=624X6/K+kgyo0C4thZehhHav7UKWtnlQD288uj+uL6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uFPFm9yWlpJTH5SCGdg8Md8ZczoduvrWepHGVQDsbqe6bwSpSO/zbPSCCy6MoLkAsmxwGJytC8MC66p2Rki9HhMDCVD+qNzD7IRIqBZumpvKw37ecd1KpApL87uK9DUTff43LKP1Um83mU6U17Y+DppGT/Bu+OiJytQSCCV3M0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KJlEMdZ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QIrCixAn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KJlEMdZ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QIrCixAn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637Co9ZN1405862
	for <linux-pci@vger.kernel.org>; Tue, 7 Apr 2026 14:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WGcNFNedzdiEGRO8TH8xwhPWgIt8dM0Q8kkq+ED+S3I=; b=KJlEMdZ1j6dK4EeS
	GaibaZq19kvJtF8MuX5qRwAl7NhZ+ZIN2ASAuwGAzWkSImV/A5sGPD3ZnN65/O1D
	qps8kLW0SmI73H1a6DSJ/g5RJlioEfsd1SGUdYpnsVCwrFP8y841xVfsYeggz8Un
	eMoypk0BxhxW2tGeH6h4eyDL2X4TOuITBa4hiVfGiEjmmuEPI0II1vx0YFxZXVnJ
	qNsrMb+E3Y0pHWOZCAO34ScxpYfdq0AAYLDVI7LKMoe6AIyGYm5VtyXthV/sHZ+B
	PFvqSpCe+dChXGTPgzqNC8BoUqjmxyDnP8xcPvBSNuOuyKpI5T9YvPf5Yc9Vc24s
	ItAmng==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrau20m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 14:11:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b0f4e632caso76697525ad.3
        for <linux-pci@vger.kernel.org>; Tue, 07 Apr 2026 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775571116; x=1776175916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGcNFNedzdiEGRO8TH8xwhPWgIt8dM0Q8kkq+ED+S3I=;
        b=QIrCixAnyW5TDAS+EEa0CYbwM0mmBjckuvcVYz5GO0zUjnfE8+s99p2Tb9cLW2xGhf
         tWB/fBEKSm9zMhbuYN0/Y2TtfssznFyE26yW68KNMyXTlp61DLlaNvlXtnuPFRQS7rfQ
         5RZI716EehhwYOOTkKuoMSDIOVyfij7UjsOjo/zEGPL0IKP6lvwmxqeNDJXianDNKi0p
         UZdEzRB3HS5EiLC4LNJqPjs5e5UYA+Jc/3DkO9q0QLljTrJnZJW2+1AJJvdk+zJaqb7I
         /N/6w39u+MO/9nOTnkGMWnSuGygfjSw33cQ0eBX60E+XWbg2tKTkq0EWyvlYiBiEMbHF
         k/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775571116; x=1776175916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WGcNFNedzdiEGRO8TH8xwhPWgIt8dM0Q8kkq+ED+S3I=;
        b=d3uZLfI0TfmPxuvKX4jY1/cBLh27wBNhx5zRhrc1Ct5aGScqNXT6R6sLzgTDiWzCSA
         7G74pjh0RcXI+OIi3DZwALQTHspPGT9SqhLFKOBPIxOmAnVmJuCSQ1yoIdUDs7ED01JB
         7URDK8UaWDP11S7tNeIDQsYl1IAuxBLdMqMmil3DdkksIzU4Kmv2rbm/v6x2Ajp+hs/A
         wpyOLwu8miuVBu4lLrLggTl3qom6AFlknxcWpfgFC/PolN30DeY8ySUYk2uYuNg5Po/z
         idyBn5UqJL0BI5LQqMXCJD2u3VMYvonpDInFEwPn+2EOP4IodjP4BIP1TyV6E8z37PCQ
         Pa/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcUUE5SrQSW3XrAogGP75PxQRrHdhz//HcwKFx4Nw+v6l0WfCWnqYP626Cd1WqlUIbBMOMqBmfFeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXEITpW7NtrLZtoTJMvts7suj5sHzBCOdzt4hx5l7jIwqeo7e
	WFcWonj8P414JpfeK4aH+Sj7e7sFfScYvZHnUgF+Qi2Pn7f6+1kGiMg0PwK/Jen12LRM8OEJubl
	XP/QADd0G1tpH/6ae5XMXP5TEToaugBUVcmCWP6L2q0hYMcQtBLOHemLYulN6Rtg=
X-Gm-Gg: AeBDievtr4jRLigUSZgn39AhNcMQM4uLViIyrWty6TiK42tY4Fn+6x2dy5xddtcN6mx
	NK4CucZdG73ZyWpBBorZ6EmTyqk/cAWdWWVo4fpEifGCFtGptqiDq5XYA29B31jN+NUowMZPWQQ
	+cd4IjwPfa8PiwhaA6LuNvCQW8w0YjkjCz97H5Egv6+VtkU5hXpvE7/lc57ql+APR3Rub3BjLcA
	yFAD+GvswTttC0Tot1s5P+J/2fwSf4+oFU5eKFCrVgCxcW3SPRKgX9WGbH0idGao5PXE+zEvFNM
	a5pF4cx+TLZD1Kb2yfkPZM5unVUTqa/msQvglhgy2uUFcTAR0k95xq/JBcPCGjXTnNxopsmRXBP
	ooZ0XPodYMguATJVCCKem
X-Received: by 2002:a17:903:2a88:b0:2b0:6df2:8cd2 with SMTP id d9443c01a7336-2b2817a1cdemr196407405ad.19.1775571116406;
        Tue, 07 Apr 2026 07:11:56 -0700 (PDT)
X-Received: by 2002:a17:903:2a88:b0:2b0:6df2:8cd2 with SMTP id d9443c01a7336-2b2817a1cdemr196407045ad.19.1775571115807;
        Tue, 07 Apr 2026 07:11:55 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.133.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274f8867csm180026375ad.54.2026.04.07.07.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:11:55 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
        Christian Bruel <christian.bruel@foss.st.com>
Cc: fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
References: <20260407-skip-bar_subrange-tests-if-enospc-v4-0-6f2e65f2298c@foss.st.com>
Subject: Re: [PATCH v4 0/3] Skip subrange map tests on DWC iATU allocation
 failure
Message-Id: <177557111043.286575.12032515827207230571.b4-ty@b4>
Date: Tue, 07 Apr 2026 19:41:50 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: Q0ztsrTdlafw26vuJNVTWly-K3L-UzNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzMCBTYWx0ZWRfX8d/QFXpb4S2t
 jm4klDFDhNQCUIl8gBphE/NMlPq/a17Y3DnptuEx7uw69tZf4RCy0t4v63RP4QJTP0HSp2WiBEN
 3xio/KEpOWpBsPZAEzaRPQLSNdkqe8pkJd2td22wULJivXtSnZEz09Lc6xraEmc1PXgoZeDFI8c
 8Swp4ScBgSn6RAT/u378+WTdNuQ5I5TLGfxGQVcWLcPC+LveOVTiYng3XYzEwFyUq7BprBf2NZZ
 2pBm0bHZ8MWZ3Eqkz88k9vLJvVpA+CLDP4L/kBHxN4Knw2siklQB9Lv7cfGGTO6bQtBGf3W5XE/
 ln0LTVA62BSC84gIIup3pZgD4t0jD17Nok+f1BdcJToGUR/alx0XCLXH93z8Ei2yRKF99DZSjn4
 sgDa9G+TvF1dccRMdT3QlPUCmPOyiSNoJwmJlJaAMA0hfqFXev/2RLOqEHwf8fWer9IZMinJCWo
 OFfobREotW4l5+L4dFg==
X-Proofpoint-GUID: Q0ztsrTdlafw26vuJNVTWly-K3L-UzNq
X-Authority-Analysis: v=2.4 cv=D/d37PRj c=1 sm=1 tr=0 ts=69d510ad cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=yDxY/ZQAnAaCL67VaoekCQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=dxHiGLMGkjoLnCvgJk4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070130


On Tue, 07 Apr 2026 14:04:07 +0200, Christian Bruel wrote:
> For platforms with a limited iATU inbound window entries, pci_epc_set_bar()
> might fail to allocate the ATU entries for subrange maps requiring more
> than 1 slot.
> For the dwc controller, this failure is reported with -ENOSPC in
> dw_pcie_ep_set_bar(). In this case, the epf test cannot be run and needs
> to be skipped.
> 
> [...]

Applied, thanks!

[1/3] PCI: endpoint: pci-epf-test: Handle -ENOSPC in subrange_setup
      commit: dfac277624c82b361dbb3e0fc57f577a270bebbb
[2/3] misc: pci_endpoint_test: Handle -ENOSPC in subrange mapping test case
      commit: a51c75fc48c2a0d2ead2d7e8c521de0423ec8dec
[3/3] selftests: pci_endpoint: Skip BAR subrange test on -ENOSPC
      commit: 2b729b7721bd4d0640b26790ea6c360c85a4af8c

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

