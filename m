Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC324F4759;
	Thu,  3 Sep 2026 19:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463156; cv=none; b=nTnFVSGHnZp6fJGjr0z+Z908bs8FV++RSinV0ygBDiCGE6Fl38J2/vLk0aKTDJI/t2nsejJBSFJhPJa/hgSwyX2FfMHSfipDdexmXHnrE7qWxdcdTJ5s5FXKCnMUM9ZMl8W1slV96c2Drrk/iJ3cLeMYZr7avjkfMW1z5M6ubJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463156; c=relaxed/simple;
	bh=domKXafNyy17aqWY249V2FHVU5m3asuAzOmzv5gerYU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kz4OP7hCVY16m/EKG8/2KeeRxYJzKposvP6Ia4hCivM4VbzHt3n9KCiAKWeRj+UkVmmLj6YlVouVMpiX3/JlcikA0q0C2spMIra/Nf8dE4K+Tm16U/RcFX58Hp91gj5klQr8RV3YOrtiqZXMa9opWcox0vyS+NhOq7b7MpJObRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e8CEzgqR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e8CEzgqR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683G3GtT417619;
	Thu, 3 Sep 2026 19:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DOyhAyJean9v6TArWBMXk170pLL8aIuulxfnWIj6u5I=; b=e8CEzgqRUg56oHsP
	WzN55M7sLeDY7hJdfPPyj8U7Mzb/Wx13fF07HdQhDlEL1lRhwH5DhAaqYqgaaeOe
	yGbp6BRdpKOPAL409b8gWfzophnj13aWlq5IX76riDCX3aIrT1PvdFQu7c+E+5fn
	4VxprZO2LijI7fSEw87pMeK3zqcy+i8Ifigoqjj9rUqmUsKX2BprCQzFCbiy042V
	4ZQCd7Fv0Zinxlf4J7dNIMNO2q8VJqbAz89HD73FaV/g2hbu3bURcWatIhmd/WZ+
	Qkshm4NWirswnpg5bkE25dRMQJPiViO5MM3A+dZ4J7/1RXqKftc3LATi0/KwmYUS
	7OA6fA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m319y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:36 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 683JGuLt3230275;
	Thu, 3 Sep 2026 19:18:36 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 683JIZQh3232777
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 19:18:35 +0000 (GMT)
Received: from hu-jcameron-lv.qualcomm.com (localhost [127.0.0.1])
	by hu-devc-lv-u24-a.qualcomm.com (Postfix) with ESMTP id 7314624DD1;
	Thu,  3 Sep 2026 12:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 12/13] PCI/ATS: Export pci_enable_pri() and
 pci_reset_pri()
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
        bhelgaas@google.com, praan@google.com, kevin.tian@intel.com,
        kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
        bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <8076427d234c9a4dab4ddf3da3737c61d02c1230.1788222486.git.nicolinc@nvidia.com>
References: <cover.1788222485.git.nicolinc@nvidia.com>
 <8076427d234c9a4dab4ddf3da3737c61d02c1230.1788222486.git.nicolinc@nvidia.com>
Date: Thu, 03 Sep 2026 12:18:33 -0700
Message-Id: <178846311320.1308030.14209114570392271213.b4-review@b4>
X-Mailer: b4 0.16.0
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: Z51InRXKQH3lhTF651XRHYYEq7UVM88i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfXwl4PUibcBPM0
 pBN2BpkH222dpLZq5iFabBJgdFYX05ESf7VfKsW9kYqj9OGaROGBUmeD3zGnASfIlMaFjiKTJSh
 +QqVS5KHjfWwFu90jn3JE1XJyC7dD/KtFxOUsluihElXXSv7dhu75ahRpKgQbir+/mgNvRoOosk
 Wm74W6wqj9FfmeapOmaOaC8tC9oaUA8M6LZbNy1WwZoil/3O99xr9B8IrEUl7+FQWc5bZ8WdIf3
 5CzWaylXGqi8JhVJcyGtbjH+JNAcIgRs1ZtaKUYWx2sMJU+8wSrYMqfY263tTqDrPYuYg8S9Jeb
 ug0calStgyVRfOkjKwbGGg+l46KQNfs+vhf9iJVc4IKhUMAk/qk7DnTrUVqrK7qohBwG9AjkkKd
 rAAg1X+JMhdc5P1e1/46tqc2+MdITEX8wKFr7y3eaRTgwVovcQPOxwhOzdOY25L3eWPLU8RlXCN
 HYhYExbDdrxwKigck6Q==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a99c80c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=QyXUC8HyAAAA:8 a=Ikd4Dj_1AAAA:8
 a=EUspDBNiAAAA:8 a=tXmE7SF2LxnnnbDZAYUA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2OCBTYWx0ZWRfXxoOMgcVb0Gm7
 TgHDlBTVt+NIaWmLUFZw99SRiIqKF27s7LwV8FBu+/i9bQZZoCSY+vxHjAdYh5LtJotlFiftyrL
 jZznODYOhMUaOLeIdc2ULL3Q9tqAENo=
X-Proofpoint-ORIG-GUID: Z51InRXKQH3lhTF651XRHYYEq7UVM88i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030168

> Export pci_enable_pri() and pci_reset_pri() so the SMMUv3 driver, which is
> tristate, can use them from its probe path when built as a module.
> 
> Link: https://lore.kernel.org/iommu/20201112125519.3987595-9-jean-philippe@linaro.org/
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [nicolinc: drop stale or already-exported APIs]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
