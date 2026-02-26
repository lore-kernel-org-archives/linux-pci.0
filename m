Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7B1B394F
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772085660; cv=none; b=hLyJUfjn21svwHf0gq4RP0752+PctKwnbyH1TWhEPWpBDtPN3p2+Oy28fLvWiFGUt6gpbdNTt8149eoN+JC8ABx6gRsjTb/J8FaeufZD87XeJEF98OpiXz5hgd2/qwjW1FzBB48hh5TI2CTYleWhQgxegq9UlDogoRc9zNSfzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772085660; c=relaxed/simple;
	bh=5aaHAsfy34UQJRjhiZnUsb2N9wbOG+7Ix/IBTsZqtFQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G8wCCRGCd46nToeWE29iA42b56mAqY4AQWgMRT8tSEi3lqtXUptoKpl2KJ5uZRvvWA8J9yaw77mbCQwMSpA2B1zx6SjNwWHQaTxEoaikOfNUvNJ7YFwaVPAZCDeBc8KUvcr7gY3nYT2cOAJzmcmCn9BceiKNptdHNnbkq22rK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ocBF10Xz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AD9p0Pil; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ocBF10Xz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AD9p0Pil"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q4V1PF2617838
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AK82dyoaOlJYYB3XgfMezSdjoVMW1MkhV/j1P7eEsUA=; b=ocBF10XzLa9iVu3m
	vIGW1bDTzOYl33pk+99NMGqLwVbaYZ+S8QVn1XDTEBsj+eeQvpxL7n39a1lXZXlT
	K9++sC2X14kwbdkZuEdFQqBvuDqtRh3QfoidUFjoxYGjfYdKgNtmPLuQE9ykQh8l
	WX4VDyAbn3otnJag8z0rRMF9dtSyAdO/xQQ+4UJCVIo+WrpVlaOx7nC+7u/AVKGl
	F7j0VyWw52vce3acBWFxuReNyDTBCWyFGSDQ0INe5SqMWag1NlC4LTt65PHzugEg
	mS7nYg6aS3XiXQj91mY4cQEZWqxyEDnV8exG0kTVSaAEBYXfrX02IIGl1UH7lIrS
	UOAWLQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj559hxeb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 06:00:59 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3562692068aso1234672a91.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 22:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772085658; x=1772690458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK82dyoaOlJYYB3XgfMezSdjoVMW1MkhV/j1P7eEsUA=;
        b=AD9p0PilRO++uQKh0ODswLbuj/f5gE47m3ohNRRB5KnOFY2mOFOF3G95sKSVVCVUCI
         idcwJxM9gALgF8TivelZmTOeuKgb1JQnn7XzJQ0M5GNjOKZ6bQTt5QDlNbxw3PqCIIqa
         JZrc3ia+6HIBljteZ6dUq2fjO9mUpV73yRIwf1o3UxaN7MxOaST4z2wOR7NDNA93i1uX
         ofv/y1+H+7fxYhepSeLI1UaMHfRicebLkcYpIbyrBbS20Dmt3ctrOcw4SSNegTAfZzoc
         NhWVuZS7bOMzN1HFCvrPrPNEpCj0S9HPcpXGqR8VF1vU0bha38RzcHtG4acqoqbBhaOY
         +XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772085658; x=1772690458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AK82dyoaOlJYYB3XgfMezSdjoVMW1MkhV/j1P7eEsUA=;
        b=LIYS1BNRdQwp/zLQdmIsZNyiyvRINBLAV8Cr1vW/njmbwy6OnimfWrxnoW/jzupJxN
         tldsD+c7FGfnnQQhQLHu8+8bf8aswpurcvZsOwE7AqFL0K7kYf56tLlfzFI0YwiQxO0j
         EDJgP1zg7d0G+6lxthrVz8BoTAHB5w+lmgJaeaJ5JxVYgXjUCQezUs5h9I3MYq8EouUO
         0BHi/Li3jbnDFRxB/bF9BYRnrU5GUfCe0DphDubgJGMmr70w9xlczzvHgk5b7d3PjcHA
         K8kydy7ODUI/1pBk3pLejICH7c640YvJv/6w4Ipzmcb3KFtVh3gnrsDOvk/Uu9ohbzfL
         s43Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqtWOCx6hps4rSo8GnEljFzc+pS9Q9TKxEMveZAcfcpF1vLh/2w80lPCHOHlBwR07fiQyXVCRRFbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vbqBGv4wdWmEjTgYer2RQuusRlDbNJRPp5kIC9xUPf+Phr15
	Um1deGSAD0HODCIekrWXcXNUKv5yS8l2ygMqbV+7uDigLGe3W6Z3vkT1UvI/4dnTgZ4+zLny/6L
	VrlYhFgNCJUgEW2CLo+rbr0+u9ldK5GnqHrKk23xKrZz2r5UYTsFc0R4WPiC0djc=
X-Gm-Gg: ATEYQzz0DrFNm3KXlDyM79qSZP9HHSqM4kNtRWCEcPQSMj/tIMSMTD01iunKRhIfMGV
	mTfCq+FCb3IZcmQhyL+ZquPMced6lON/dz9jZ0d43Wz+ATahfcwHxVOTAEiDDuBoO9hl9Dy3sM9
	kCIKF3H8lRigcU7hczmczE5TqaZFbg13UJoNHIZ3R1mkqrSTJ6aQCTB75ELi9hqs9hyHTQeokYG
	yEomqkLvfR3eGEUe0FqE12xDozKYwqhTqkHlEApO/YEKyH5HrQFJpjANrM2B2vU6VtONvbrZMmm
	lhhugVpE7qQtN2aM0otQTLUqOnDyqdx6r4UwqejVg3j9jkt2DCZEKeLR4xQ4lOYg4Wx9OpoXhT3
	t47Mdf9MQGpo9fzbwgyC4v20=
X-Received: by 2002:a17:90a:e7cf:b0:358:e911:b209 with SMTP id 98e67ed59e1d1-359387046a1mr1420236a91.14.1772085658157;
        Wed, 25 Feb 2026 22:00:58 -0800 (PST)
X-Received: by 2002:a17:90a:e7cf:b0:358:e911:b209 with SMTP id 98e67ed59e1d1-359387046a1mr1420196a91.14.1772085657518;
        Wed, 25 Feb 2026 22:00:57 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:8fe5:3076:521d:50c0:367d:1d7b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593db82627sm854861a91.0.2026.02.25.22.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 22:00:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: lkp@intel.com, error27@gmail.com, sai.krishna.musham@amd.com,
        jirislaby@kernel.org, thippeswamy.havalige@amd.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20251223184003.32950-1-rakuram.e96@gmail.com>
References: <20251223184003.32950-1-rakuram.e96@gmail.com>
Subject: Re: [PATCH] PCI: amd-mdb: fix incorrect IRQ number in INTx error
 message
Message-Id: <177208565247.10273.12316821554253981104.b4-ty@kernel.org>
Date: Thu, 26 Feb 2026 11:30:52 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: hOSBw6tprHmTbac6aFs_D52L0_M9Tn4R
X-Proofpoint-GUID: hOSBw6tprHmTbac6aFs_D52L0_M9Tn4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA1MSBTYWx0ZWRfX9/Pt0giggIo/
 lT3O+zMmy944q0G1slayRFI4GN+OjGwkylwdK9P+OX7D5r2flcWtOwyyE/y9IjLs3c8MoGlGZq8
 zjPhfq3m8yxJIq+uSCqE3D8GjJra+XnETiDsc7k2yayY5SEf72qqqU3cGOE13F7Dw3c0hckUBsS
 pedArZp1epu8s1B6ZvwuUIxehpPXDohuODy/RVSCLY/d39hw+t8XyYye5a3dvS/ZyBnTwZC/b0m
 m7DtRT/G1x/VHTsBigSGAJG+2rSEP0joFUs8dVnZGA4nfDkDmQZ+hfpu8FBGKooDIT5vm1ADbu4
 jnBr/Acmt8SnlugvACT9M+4jxJrue3r5aRk66UM78WWlaYWsQ4IrzSLOhLuXwrykivbiO5zjz/Y
 pv45Elc5wISQLXr8t858Ln7VcVD6ZeXlNev/k4jfGFpEn2dDMSCtTBWPb67IU0DNd8vYGjF/neV
 ex6bwEzSg3jy4ozoT2g==
X-Authority-Analysis: v=2.4 cv=TcybdBQh c=1 sm=1 tr=0 ts=699fe19b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=JwQivNi1bCCBtT2mgXwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260051


On Wed, 24 Dec 2025 00:10:03 +0530, Rakuram Eswaran wrote:
> The INTx devm_request_irq() failure path logs an incorrect IRQ
> number. The printed 'irq' variable refers to a previous MDB
> interrupt mapping and does not correspond to the INTx IRQ being
> requested.
> 
> Fix the error message to report pcie->intx_irq, which is the IRQ
> associated with the failing request.
> 
> [...]

Applied, thanks!

[1/1] PCI: amd-mdb: fix incorrect IRQ number in INTx error message
      commit: 821578559ef68583dc3f1fcaaf9dfa00147348b7

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

