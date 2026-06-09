Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99337206F
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022324; cv=none; b=T3eGrqcSCJWLzWhhvUwk/6xA565GReNlaovqekqbWXtferZD3HVmCOMZK+YQWQsK1BJrgdua/O6dT+9cOnXMWsdXdlSeI74qbPCwwM7f9x0xbfiFnhfDcGGmgPn7auQdM3avt5ekTMYCh+gZgy9ozBMMFn7DJ1nFrlJ9gejBhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022324; c=relaxed/simple;
	bh=Jh1ZE5uq78gnZxkFGh13lMr8+RRPEWEpeWd+HMx066U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dInbsKka0e67hbe1GEBkUfaZfAffrlSTl9i5eSSRam8XYw5adyiwVF5vCJ0Mu7Qod4FP40l+FhFstiEPufNDN1Opy2JbNCyvotCfQVQrEAV8di0dmQgugGrGYBiqB9Icqc6LE7ZDLZbNBvMVALVxG4i2YpbCA7NayfuRZgzEn7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TAWczO2a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HU7J/tt6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TAWczO2a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HU7J/tt6"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659GOivo2750385
	for <linux-pci@vger.kernel.org>; Tue, 9 Jun 2026 16:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gZ0RRpoiTcyO43kD7baXaPj3wcmkJLLGJPD4QWeYn7c=; b=TAWczO2aidQaIoXM
	CC2ktMv8IynppxZsasLjjfJ52g3otyjQyn/MsteSYkqsWxvFBXVnBolc+LeiPa4g
	OZLGof7YuybsJVv8LAqENi9JSGzTdn0d+eDbOCuDOZPN0yMtyJ0S+1SEySIjJxBM
	lstghTt3DsUuQfhoaijNrGd/X5SQjQ3TgGA/wzwYX1J9zaWDoBafp3gHiyjH+Ufw
	jxmkuF3jXWwr5BMmU41FH/oHi7d0Oq5LLIYWvEDmKOisU2IWMHYd5/M0ZLjaPxcE
	lncCTIWfn2KQq0U80eAQNVczYw2UFVSmYdK1fwqdklgHGtswSh3FgTaR+d9NbjAL
	IQ3mVw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgjg10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 16:25:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bd4146cb2so6742153a91.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jun 2026 09:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781022322; x=1781627122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZ0RRpoiTcyO43kD7baXaPj3wcmkJLLGJPD4QWeYn7c=;
        b=HU7J/tt6UYgC4HUH/M7oHcZs5yD/K6wGoJzepNVVgGPyzEwO69mb99OJbHYm6C94Jc
         b2KBZSPr0PfjotsYNOqK7klf1fOMX+w+vjYP2280kj6CZcrMXrDT+O7LznMN4owMX730
         Di/oA/aDZTaSOgeDlcSfKY/S7cGj9a3kprBVYuxRAP+Tob8PK1QnyyMCJ+zuR5tWi8dQ
         rrXSlII417Hxy7T90bvGfql3plPv3f3iXtJ31nndR++HTy6Jf5EXNUpSp1ASptVA1sHc
         1YwjVE6w9qjvCVTfnxhMmqni/MyxTrWNbXLxTHDkPzouq6scGyGDDdhF1ue17tcdBOR5
         5R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022322; x=1781627122;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gZ0RRpoiTcyO43kD7baXaPj3wcmkJLLGJPD4QWeYn7c=;
        b=JCgqVEAgXF9MawMAcpTe5VkteyPMueVDHUqjyZ2jHSeAutAsXsxcTqzUQtmYuDVtm3
         v/FU8fOjfjq8cT0/E8wz2kB30MGXEvl8E576iAjzpydozJgCWU46BlqzoSfQ1P/sqI0c
         4kK0OOeEmKmzR7r8RuO7jsbc70dWNn+9KidE2KMbCdDxRIb0gvXmsWQOolSy0uQQLQj+
         VcM0rJI6YuGKAol9+YBBhNicp7/rTRQyWRFF9l/+lKeUQZXyu7qfq84iShejmiRig1Kw
         Z3P8ILGjGRCoZAsZoVb684HAbIq/hvUFr+nYeeeyFcFqe3QgG07iB/nxC4AfXrOKHlXy
         RNag==
X-Gm-Message-State: AOJu0YxbKImoEd9g5oe40eaoHGBThboYg8u8wozI26QJiLd0RmP1ysaj
	/haw7+9VNPM5SkLNiohJ0J1IIzUmt+cT7CVTCqGrm9fmgVMl6sjlTR1WByusbk4hdGfLmha96yd
	bEYlLC6aeWN10mbJz/nn5atY3l/IQlG/gJmcUtKXnKJWP+l4uBQuOOC1KVwobe9c=
X-Gm-Gg: Acq92OG5YXoNDdu/f+yKvg0vNcjVRgDyq4Z3IbSPz/CWeP/MWtRrd5jBA+IlnJbvCan
	UnUx9RdqCWzx+F5039jXHvOnrYA7vQBLyuPZYuRbug8cIrtKTgvkb4wWveyBtEwLQcsX8u15BzN
	DI5SfLzqPeFWg1iCLoboAQHEt0Ug6VftrnSLtpvTKY51oqzCCZ7BRm2fxCupXuHSKzwrFujuIEx
	6l0QgiauuC2ykkfywB4WHuIDiR9J2Kh9AIPxG5/IG2rNUCEonEbMr9LAZ2CIG2qFmVurx86XJsA
	bnDcm8KkcXymEanV3Pr+DYztImr3N/NhKBv7aze10Qrr8bI1Q92ntUAoPXsZEQ87OkmFzb76oZP
	lUw9CmT1P4QlaSA6B615yU69KBJI8fOQ=
X-Received: by 2002:a17:90b:3903:b0:36b:4d63:4a93 with SMTP id 98e67ed59e1d1-371328ae3c0mr17914263a91.13.1781022321820;
        Tue, 09 Jun 2026 09:25:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3903:b0:36b:4d63:4a93 with SMTP id 98e67ed59e1d1-371328ae3c0mr17914221a91.13.1781022321282;
        Tue, 09 Jun 2026 09:25:21 -0700 (PDT)
Received: from [192.168.1.11] ([120.56.203.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm24900815a91.1.2026.06.09.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:25:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Yue Wang <yue.wang@Amlogic.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuvam Pandey <shuvampandey1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <177909148011.9588.6639767953842842291@gmail.com>
References: <177909148011.9588.6639767953842842291@gmail.com>
Subject: Re: [PATCH] PCI: meson: Propagate devm_add_action_or_reset()
 failure
Message-Id: <178102231651.11622.14383228802721431855.b4-ty@kernel.org>
Date: Tue, 09 Jun 2026 21:55:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE1NSBTYWx0ZWRfX3JoHZuNEm/O3
 ffjt7z3ouebHZatxCJ8dq3X53iri0ZBaw1rjaOQNdOcpVzhBjenPeVBs5uX7hhxlUzkddAZalm+
 OsJFdltXU0jUmcy1WWmro7hiAlRvnC1AbaF4pd89iE0/TYyHNjzFTsyvVk5qYWPRqhHMksD/LbR
 4onqwpIBiNbhvrnXadjnNa8U2MH/TXO1l8OzB2idGwpZ7HCSsH/mxB669ByKsbhicsKU4OAuIt0
 4bJg7i2Fqj76y9+MBxl7DZp1Lf94G5S/iM4mM0kt5qS7CU4HNJ/qPX72LW/ChD4oxaYAhKbDxtj
 u/pWQmXC7iGBYTpiCQo0c0qCEeNE2Y2D7SdrsYQJZLikI3W85XNLDqD1n7NjmteMmjK7x3RlDTD
 aSEv8d1Z/dldutSlzbWKYVsYUWjcqPICgwRwPmwlGnbtx4Ahb3eLFbLx5/qkZtFw1e5e/Zj/cPf
 LjbPezKQmJQP1DqT0vg==
X-Proofpoint-ORIG-GUID: wZAhnMgINg3M7q0dh8gZlyp4UUNq0lts
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a283e72 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=eDurORsI8St+1bJHqsJewQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=YIal6LhKh1zn__LXBV8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: wZAhnMgINg3M7q0dh8gZlyp4UUNq0lts
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090155


On Mon, 18 May 2026 13:49:40 +0545, Shuvam Pandey wrote:
> meson_pcie_probe_clock() enables a clock and then registers a devres
> action to disable it during teardown. If devm_add_action_or_reset()
> fails, it runs the action immediately, disabling the clock.
> 
> The return value is currently ignored, so on that failure path
> meson_pcie_probe_clock() returns the disabled clock and probe continues.
> Return the error so the existing probe error path unwinds normally.
> 
> [...]

Applied, thanks!

[1/1] PCI: meson: Propagate devm_add_action_or_reset() failure
      commit: b12341b98d5ac52f48ca1390e1e371aed81346c8

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>

