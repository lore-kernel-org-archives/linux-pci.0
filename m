Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF003559D3
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545559; cv=none; b=JNVSTf795jEZpu8nlTnFVIC1o/NJq8QdOKMy4VcJ+BBN99PcHzDUyaWqEgzJdCfG+masSCgl5jr53SmhCPTRjaOfrjDxyuSRLPzH5ViG20ktyngC1Vug49ztYIsCPe/PeXB4kyC5XvsDRICJZ/dDHx4NKNM0dssfVc233uw21Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545559; c=relaxed/simple;
	bh=euLHU9LJSjnuVv3KVwXZVLQKkTH5tfAXTjDgcT3R8+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V/xX8dRXmW9PMop8N9YxkrSlGbEJYbeuab8yBH+05LdZ8K2ierYTou7li4mGZSkP/CCreE74aiCutUdagHvA35WscrI/mWbq/cNfBKC/KihE0LPY+xDpQooLTVJRZMeNtVCRgOFtMv7byiNDa0i1FWCk6ByHjV//fN7oAsLFLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h6Vu8yoq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IFxYN5nn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h6Vu8yoq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IFxYN5nn"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFAuIl792859
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:19:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ww9RyXfzw3HcfsJFywuqNamT6krJul8stvWokNyJt1U=; b=h6Vu8yoqbBzY3uPy
	50M/5YiGSx1F4dSdXrMRCDR77IF5jUuhNVp6CE+C4dT3LghVZDN663ByPszboVm9
	nnXDbFt7wRXl1XNFsOO5h+xPdQ+k/oZloLDpJ1qxvxZu/oILt8GSYMPnBvUDbbpS
	AKuaFHVHypfIEjxCvnufAKuCtoq/z/bQc+iCKOsSkbLZg03hmJBq/DQp426HP6A4
	F7fWtb+3OXSKaGeD+Y2hvB3gEnU1qHObnamSkkqTSkCxK0mJ8tWQuczZX0Q0ADWF
	qqgXI6PkH6S3mfXXbx78yusMFPJbVa5PGrtfXynn4wE8vjBet38Y9rwZMOcu78A5
	6bVzoQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d53eqhayv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 17:19:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c629a3276e9so2302371a12.2
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774545556; x=1775150356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww9RyXfzw3HcfsJFywuqNamT6krJul8stvWokNyJt1U=;
        b=IFxYN5nn34sKC26nyflIK4Prfi85CDiaTQYG8B0+nOQlNoXU4yBoUBNcBhXt51lZQv
         LykkWp42wjHb3pWeaBcKQOPBCXbaUUeMYulN6D7m3cY/okEKBBdOMnkBYpHmVq08HlFF
         YWIXwJiCF30X8niusYUbhicVTb2rEsEOlQTICx6gW1nIY1vKdupFqX/omj6k3weW9m+R
         DmeC6NovQt93K+UzeJTux2WAYlTqGWbONW9X0DDo+zwpJf8PvBbsqfbNYcLQcg6Tqu9r
         avUpQOelKSSUHVEB7o5kmKJztmFBWuYyjnG25EuCgptmqKUdi5nPK9Q8nL55VKCnqzVt
         +ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774545556; x=1775150356;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ww9RyXfzw3HcfsJFywuqNamT6krJul8stvWokNyJt1U=;
        b=lYR0mVLle7JxL/aJVVNOCsvNZzXcGmfWvTz1AFx4knKfyMYGSWg1/nimTJBWCaR79j
         r2R8dQUDDk/RY2sZK+w8P93zBiCU93Ry2vid2TM7N1ehL/sM3LPKu/4r9TXQfAIrb9RL
         aQc7AIV2SkDC+RzoWpwZtc4A/j9wHf4zNUGpiPjBjSGkBw2XUt/XljupxX3eF6wYtZHF
         vo6kY9gmPVRyMu55E707JkHgdEzQZIb3LIkYvAnjCs4s4q4pdXuU4gEdPcQv+mSw2ARL
         OWUPbT2Vg54yUiFX8v8ok4I4pjGTqSANJDsDhD26jwiv/TuEfyO5slk6VYyHAb4MznpB
         Gwtg==
X-Forwarded-Encrypted: i=1; AJvYcCWgf8d8RnvCcdsG01ePa5sfTU7sgrlOe+saEmC1zjEnclVBTw/8m3UU2oYHMJjzEVYpRUNPqNpDYYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL031QLQpxvPO8APcUvCdafgZtLai+N526zCTx/n66fdMi88XQ
	SKNTNPcLK6uCufhBBvOFCh1cRfPTuEuPh8JEOcBsWYvNT2U2cDU8Q+os4X2KVD6g9g9f2nDCvgS
	Uhf7/WG1b3Rl/Bnk1B42f8OZOIoG+apbS2U3AfoQ3DNxFtuMh5Ss7wU2D0ltPD+9t65MDcWk=
X-Gm-Gg: ATEYQzzA+Zwusor/3G6+sZPExn/+mGMdwvyA9wQtHeGrWPf8sRUDxlv4C4Xri1q1WHS
	P90yOZUECEkUp/gIjQ3C22H57TGhh5J/b07DLNR99ZVO2oYQgAF33BAZWfZl8kXfVlR1egT0u6Y
	Dislh1t0wyO+MgCxsPAZJyQIIM2Udiy/QSAeBlXSwyFXbTB5U14N7wFThCNw5WQb1foEsEBl4X5
	kYzrPPHgrBqmSXCSwcagR05pq39qqy7iZ/dlY/9KfgorNPsFyktTBBprlpPj2pbLC0yIurzLDgP
	yYu8J9jylx/siRVV4Zd2/joZkNNrNgwnkLwKQ7iy0yEkB7TxdrjfX31LV6TZg6Xx4jzKq98WQe1
	0izme5PQYsf45ZuBYVXDdHoA=
X-Received: by 2002:a05:6a20:2e82:b0:39b:da83:91ab with SMTP id adf61e73a8af0-39c4ae2ea72mr6809521637.63.1774545556303;
        Thu, 26 Mar 2026 10:19:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:2e82:b0:39b:da83:91ab with SMTP id adf61e73a8af0-39c4ae2ea72mr6809488637.63.1774545555717;
        Thu, 26 Mar 2026 10:19:15 -0700 (PDT)
Received: from [192.168.1.102] ([117.213.101.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76739334e6sm2661617a12.18.2026.03.26.10.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 10:19:15 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
In-Reply-To: <20260306031443.1911860-1-den@valinux.co.jp>
References: <20260306031443.1911860-1-den@valinux.co.jp>
Subject: Re: [PATCH v2 0/3] NTB: Allow drivers to provide DMA mapping
 device
Message-Id: <177454555116.460009.16357964565477922352.b4-ty@b4>
Date: Thu, 26 Mar 2026 22:49:11 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyMyBTYWx0ZWRfXxbnrdb7faMJ9
 kfMVBKUDFaBFxQ1g8o/172d+a9PPCp5xheDvSX0I459ISdNESJ3hMer2TYySXOlg6y+dl93LaIy
 UZHcxqWjTbr+glXm09ADmqFpOFraRud+sD+V7TnySq4d5ADnQAaxE6JjLwIVGMJNMBR1Nt5U+05
 xmOmKkNhKuoQM5x47cOE1QwLZfY6fv2LQq4nKuXo7SeLcg6tUJL5RiAORM+/dDNuwcrLvUNzglD
 z7q4JLzoEqDvIvEki8krRZZpAMKB73pE56LOgod2cDgJmit1mRQvNsIUUNMX8Zn7pubU43DYENY
 Yjugz40TmnJYVoYWC3T8gEWHPQPEOAai9TxZgznUeYRrt1LPbghYkehabdRd8k0lum2Fgu2I5Xx
 50BgKGkG8rCItrLzXyX2ulxmRThEw0X/2Re6vEHwedKkPhF07QuMetPZqadx3bzTKT8ydfdAjWo
 26tkjdMLQzv1ahhBBSA==
X-Proofpoint-GUID: qTPvKUBtlMn9Y4a_-DLx9iICT2PbA4tB
X-Authority-Analysis: v=2.4 cv=S4bUAYsP c=1 sm=1 tr=0 ts=69c56a95 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=pjPfvbXasfe8cMZvnaMi6g==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=l7Ugaa1-BWrJxlqRz38A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: qTPvKUBtlMn9Y4a_-DLx9iICT2PbA4tB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260123


On Fri, 06 Mar 2026 12:14:40 +0900, Koichiro Den wrote:
> Some NTB implementations are backed by a "virtual" PCI device, while the
> actual DMA mapping context (IOMMU domain) belongs to a different device.
> 
> One example is vNTB, where the NTB device is represented as a virtual
> PCI endpoint function, but DMA operations must be performed against the
> EPC parent device, which owns the IOMMU context.
> 
> [...]

Applied, thanks!

[1/3] NTB: core: Add .get_dma_dev() callback to ntb_dev_ops
      commit: af43a3a0c0ad524a69a7921efd0a04d50c03090b
[2/3] NTB: ntb_transport: Use ntb_get_dma_dev() for DMA buffers
      commit: c2fbbb8b341c58d24c7b114fae4cadd55a4660f1
[3/3] PCI: endpoint: pci-epf-vntb: Implement .get_dma_dev()
      commit: 185596ad93f545bcab2fea0dad6420c0c3cb386f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

