Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23DF37C108
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 03:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579044; cv=none; b=Uq7ZzyEm1637Zqg+vBwca/br0wOMmGXTPmtmGAhQUc1Rb6Y8JWFF+9Aq9oe3/fz8iCpDSsl2/06KbVhnuP5KZ0AwDHqa7FxyTJH0XTyv0uHsEOqKBiGIAZDcU+KocclWgk4imJk8MxRjnG5YlvHdWoIbLlP7Rr7jEjukNU4Ermo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579044; c=relaxed/simple;
	bh=aY+9+MdKna9M5CJAz5t8sHyWsdgO1hXtr9iBaOmS6fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGumGAhfoN8qEPqC6EMUYNn1psGl0I1dMpH56qpWpy6QeBlkLdx8l1FTmYLlQAl1cSZeZ9KI+waRbSripb56LuRbO/nFZxIgPnQfEvGOG8Mq1V7xVi0b5Wr64EQGCPyZ5CyVSdvl/eTn8AximYZSzcasb4D9eptZXcTGGi2p/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9ig1rOA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AR0R6J1Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9ig1rOA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AR0R6J1Y"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G1xf2v2361722
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 03:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8zG4ij+zNAg
	8aexT5VC3GGKsuDLynsOlxhclh16ESQM=; b=F9ig1rOARCjw9E4BR+5c9yfyysI
	lxrAFpSYJS5wom0+ojGT4qh02JoP/y/CI/G//RMQdNc54tlx+jxu8m8gChbVtjKa
	YT6T0piam3WwXCwuebSq2vVc3r7lDHE6Qw/3eUiI6tJwra7CjfdqN6EwVl03uCiI
	BRZyibEmowjki+dWb0fl3FUhM0srPOPOe5GAXFWJO8/XmYX19i8JYJVCEYERsgbL
	jbpLpCOlgRYJzlwmT4chtqR2dpZG4s/4sRlc32WmekEFOOlDZTyKGLllnpsARfiN
	7nfWbe4Trr2kuxw9R2Dzj9Whc6zAguUPFcYpvz5uh66wCBA1/qIM4pgHcVw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2ccxhw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 03:04:01 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137daa666a6so388042c88.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781579041; x=1782183841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zG4ij+zNAg8aexT5VC3GGKsuDLynsOlxhclh16ESQM=;
        b=AR0R6J1Y7dndSLCoj3smWfIsuVuiK0P4/EJyCB0xlkCIysudldPwJmY/cqhjlojFrP
         JzjqmTSBuCPYNxeiQrMJyP+stqAfLr+HQB7G5GTKPz1lNdVVEsIO/7dTjQzbclLuIyTU
         4/dgk/2BT82fEUn+7GHwVXWiYG362lZ/+o0zs2ITRn+FZ5ShhJaZAUltWS0Bnt81/QRr
         AGR2/uOXV6YkuRafRsBQGKQJwfbeO3aBosW3iX2vA8ZInklYQA6SKeuSN99UsGW0r7fb
         8GEgz3kDzvgjl61tekDU9Ztnyapz2nx18FQEYKbAXSlmLL0bxNZxTHzeg/i4GeIdE29R
         pxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781579041; x=1782183841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8zG4ij+zNAg8aexT5VC3GGKsuDLynsOlxhclh16ESQM=;
        b=ccBKUnCO94rvUv+73ahJGjxDA7WCR8K5eE0hYoxP+ThAuBuRfl4T5ip5wQh/NngUzz
         NQ5k/WJSTlDZCno4iveyv9P/+ndG1Bip3eCKg0XX1NuzDZHbm7zcmhrRltEAEBGB8l0x
         QTJZuzONgvNxNUuHxv21pyr80u3lxWHqvxg74JPExYhzSrgDIckOV7XtVdES0MS92CQA
         aeT21ym0S+hLd4BFfDSQsgG5wKhkMAtGxZjMaiJXuSVobjQuO8gogT385rd39sEwKQbu
         mmYskq06Bj+fKfJuw5cZlqJQ4ZgOazriSdIUMedIq1PnQOvciVCl3iCQuw1RAPMylK5u
         Louw==
X-Forwarded-Encrypted: i=1; AFNElJ9kYoUAzzX2E1+bnMmqA2oIXdlYyf3rwR63uQ3lovKUq5iKeXe7XfmOX11UBohqxqnO72ZRN1d+Qps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6sgste0vD38vHFviLSBKmKYLGa8ab8IIjHwvOkZBBUZyJsb++
	0NiyRonlqfOO71bj44jR0AYoZcKPc6+pnGiosTYJUuWQOj9pimUPTrRAzd0MTzVXoudu5LFLR8k
	7vcZPZ3AN5OgsQN2SIj3M7SFUNnLCR5qjTK8jx4LvUyWWIWkPJf89fd6n/gSoMr8=
X-Gm-Gg: Acq92OGYFtn+ewucaZL3IVJUVJlSSubp8TxDDkcfgZ5RPR/jHKibTv5YNWC+ykylQmL
	+70XG61sv6YxsXtTYpIh8fJDlEBj6iSHRy03uiTUjWeItOwfz2FEHL+3Mo3uaZrBDtzIkUxgbEf
	vOXfUwjmA1RyNRvP2SpnTuCWA+j90zT7t7wYliUmjDdnzGXm87ob6z576T/iyW0vofLkcUm/FkO
	WYoe0Ihs4ALpributrJ2PTAOCdxKq+crseYRiK2MLhIkPlUzTD/ZuSPAL904/QYkjwT2LBf2fns
	PlKx3wCUis8Kg19CFoof0FoCfzijfTXpSI0vIBvWGtY/72X5zq24cL2lvKD+hHKKUvjzNN7Odq3
	OVzA78i+ohYGGl85dyDbIHwxWTPLT3F+0EVnBXCEitnMbHQ6nHrirBnMU5E/m+vxXPr6iABQn
X-Received: by 2002:a05:7300:4306:b0:304:3c33:7afd with SMTP id 5a478bee46e88-3081ff5d099mr4747143eec.1.1781579040741;
        Mon, 15 Jun 2026 20:04:00 -0700 (PDT)
X-Received: by 2002:a05:7300:4306:b0:304:3c33:7afd with SMTP id 5a478bee46e88-3081ff5d099mr4747139eec.1.1781579040209;
        Mon, 15 Jun 2026 20:04:00 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm18012843eec.0.2026.06.15.20.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 20:03:59 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH 1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
Date: Tue, 16 Jun 2026 08:33:53 +0530
Message-Id: <20260616030353.3701326-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
References: <hndyeomouu754rwevoigc2ai4ywtz5lhodizj4amjuyn4azjhq@f6ixgilydtg2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAyNyBTYWx0ZWRfX3EqksDpJrJtW
 esSc8scgVw27mDW0LcWMjhvdYYKGaAUo2diWk6kWG6JutsLqLT6a09skRITNwI6sGQm8xbewwD3
 bw8cy0QcxQ2IcbNElviKoKfSCWskGlm3Y84sFvMkA1TGS5WQGbEj4FoTxwNJlc02UQNi3NR1c7a
 7JaSs4NXWQRO2KWp9DUjip5TZtFQG6aeCgWz4w71MA6EzRNAGHqvCCfv4MsYL4X5DiCPeEI4fkB
 snTxH6irfIxLUGPV39+WMZ+zKiEEMU4iQA535PxwkAJkaIFhjTH5r/rbF0z8Hfb5BQBgMatRLwL
 yRJbDuM0qCVIxcBtoCaV0V2jGgwZKfhVmcBwUYfos8uMzxcKSxqh2GeHYXOtUNz7TqsN5e6yWgZ
 xB8frfJrMFI62+hnJKawPHSth0ZcNOl4Ym8f7bPmPWymbWwNPuRMT4mPaI5PL/LOeGgRqdgpBfV
 HJriik2wbWHmrs5kORw==
X-Proofpoint-ORIG-GUID: __asRd2NnF-4iq90SxqTTAUgRZikC48L
X-Proofpoint-GUID: __asRd2NnF-4iq90SxqTTAUgRZikC48L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAyNyBTYWx0ZWRfX2lPucZrcicpZ
 9fyzsj9ayK2p0T+Mm/QAPE3BDZMoF2kpczt2xFYMMlJQt3wobpaPf+cCaav+N3ztzTtkGUjeWNq
 SqCBlXzIAsjneopSC2Qjj8WJK0Wu7Q8=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a30bd22 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=qxZblbheq-ph8u31yYUA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160027

Hi Dmitry,

On Tue, Jun 16, 2026 at 03:26:40AM +0300, Dmitry Baryshkov wrote:
> On Mon, Jun 08, 2026 at 02:47:01PM +0530, Wei Deng wrote:
>> WCN6855 is a Qualcomm Wi-Fi/BT combo chip that uses PCI device ID
>> 0x1103. Add it to pwrseq_m2_pci_ids[] alongside the existing 0x1107
>> (WCN7850) entry, so that the pwrseq-pcie-m2 driver creates a Bluetooth
>> serdev device for WCN6855 cards inserted into PCIe M.2 Key E connectors.
>>
>> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
>> ---
>>  drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> index efeb25ba9c79..b3af14464314 100644
>> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
>> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
>> @@ -188,6 +188,8 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
>>  static const struct pci_device_id pwrseq_m2_pci_ids[] = {
>>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
>>  	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1103),
>> +	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
>>  	{ } /* Sentinel */
>
> Please keep the list sorted. I saw that Bartosz has applied the patch.
> Would you please send a followup?

Thanks for the feedback. I have sent a followup patch to sort the list:

  <20260616025632.3697863-1-wei.deng@oss.qualcomm.com>

>>  };
>>
>> --
>> 2.34.1
>>

--
Best Regards,
Wei Deng
