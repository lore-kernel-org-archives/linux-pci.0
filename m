Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635E83E8C65
	for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2026 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841131; cv=none; b=udMVM7tNK3JJP5H0xLAr1SUGE22rTIIR/9yxcsDqvmHuA8Z4jDAaY/DMBnWldYvI4kWKSDjYr4EiCFbhP73maENTXNR2YV6T6TVQkC0ZL40lfE2fcGwGhEu4NiDElju3lPAoXygsQR1/jze4M3L57VGWvuoKpffNI0TT5wbv/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841131; c=relaxed/simple;
	bh=E7FlCPW99o64hLROxUlikKTNWxVAx7oj4/lwKHXZSQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNYHazPmA9BnF1dkh3HLCVVF3Pok9H8EX+jyyRsYesaxUq7XFcVH2SZPls4JEdL5635H5TGsNn1dI9uTF2MeKKyGkWuOublU4YcNqJJvGZR2TC4WjFeBJB5lbkbIR2y2n4PKH6Wghysu18mtOGIpc8faztpmPJuqWEaqzaqjnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JYRgZ13V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V9xLokL+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JYRgZ13V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V9xLokL+"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xgZt2337560
	for <linux-pci@vger.kernel.org>; Thu, 1 Oct 2026 07:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hY32ZWWXiIoRL6HqBUNIr2rx8z+fyQfuBXw005hbeb4=; b=JYRgZ13VyVmbwDrX
	AG6zA1wKAbuGJAJkyka85eqfX33Amquk2woYcoQL4w3dWTcWtuX0PyTPfYnVv+YD
	ajUQmExbX7NlZF/puxKb3X+iudHwVddaD52CHiZueoqerXK49mv12zBmYkVR4EU9
	daten3a5sr43hqaKBrLsIZEtaV2NnS4wWgOpQY2wJaYoVf94D+5dOVuhaoB4mLnY
	QWZGNcCWtOB85A4qkK/1x7zA4gpaZpZo/UmlTATjrbWLCcWO7WQy1IYpo1vv6bto
	3kZ+wDvviwu5hSvCFBbxSdyGXxWVfFLe9Ip4CeOLUT2RDBzK2A6LVEWk1QkBXwga
	oQa/lg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h14n23me3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2026 07:52:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf6c528aso197192585a.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2026 00:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790841129; x=1791445929; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hY32ZWWXiIoRL6HqBUNIr2rx8z+fyQfuBXw005hbeb4=;
        b=V9xLokL+apg/VIN8thTgPkmFMoq3s2DE0Kn8EH88Xt1DHeOx1t6YEV28GSk2XOyHfP
         vyB010cgZ6Xezw32cKverEExJAemRouudbHKCDdT1rbYyihUUhl+0+/oS8/zjSI/3/Fb
         cc+OhovoiIiftaL+t2xCEflTnha2l7smHJbLRkURm2ZdQxwwyhIwEyJLcydCfcoi69MU
         LgYtiIgOVMbtie4EM/fGiwauE28PZZrVAbjIEW+Xzqd/tfQhEv0JlfjDLSI2EUM+e8k4
         7UBgPQgP0cwe3dDdCvihvR4gz2ecbOr70tHoFu1ehcFDr5zzhAmZdz5CJSUWT1OWgig3
         V8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790841129; x=1791445929;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hY32ZWWXiIoRL6HqBUNIr2rx8z+fyQfuBXw005hbeb4=;
        b=NewgBkZqTRb4/nKRTu/ppNYOCmdEsbdGG15/eo7cGqNjo3i9X3KuZr3ty7mi5GtaOp
         scSbFi06eRb1oTNQzCFf6BlJF2kxHNRMZW2BoqQsK2YwK0inxMQV606WQwJi+GO7S2jc
         aDBI5uAJ3XZE3hjN/kBHDiNwpNEzEP8F4nEOFm1BtFpyw1S0jUPO/ZGbKEN7KYXaBJvT
         TmQlaUE+7zX5FBOOV6U2DD/S2OEXpW7E8gp5zkMm8bJx8x1LY9rJRmugUaGDKl2BrKZv
         QlVNPf9k6rn9HuQ8pdDBWvXU0f8uIe4H8+YtIH/hfJ1vgKmUew0kt6DZ2gRsviBph82u
         JSQg==
X-Forwarded-Encrypted: i=1; AKwUvByl9oeezX2ALMNmOqg6LRCaoVHBux7EbL+eF/5Lyzn1Q9A8RHQEQCBWSKi04e0bQgPUhk8TsvoM48M=@vger.kernel.org
X-Gm-Message-State: AFuF++kQwEZgR5lRbsNNkz5pZ2nmGsUbnaCSJwGKLpmQqivP8pUK6FE3
	rsBD8V30pUCIZM6x89VF7A4NtkQY1CB6/IDH04h8AAA+vex+8NpV7AmuTIDS0Y3ar9jdXCD0br/
	S0eHzwEjdueQioLN6IvVgrR+7qZmsQaeGeA1LYtfoh1f0yEflPayqAf/j4Dtfq7M=
X-Gm-Gg: AYBFou34Uja2LM6i7+V5Fk/U5tfCDBuPQgLU7436BXwsrFnMosWfaYsI7rvGlXWKUi5
	ZIp+rSed9wiOEBWqvnQ5Pmbac3QorBV06OquRsFNW2J38NGdgJihLrgGb2GQxL0IcpBfqrxcXiM
	PyWWqLGPIrlqlMIscB/McghIB/Fi8d9Oj3bRXfxyMxjV7iQtgjvCc1XlsZ82KSOKcuRnf/GhbHI
	zxuA77D+7Jhh+T0pvOPTmoiSO6c/jGfF3SJO/ztvBCpw4P4KO7bonpAjzAhB0riOhqbUe2m4pw+
	Y1WjSCQKjn/LRclulB2KWYU3tQyDcarSJAQz3ysttZMbCiv0rc0N5orFfignYK31kpU9dk9lKdK
	vAqP//gW9Sp3GdQL5YQBMlpACqjg=
X-Received: by 2002:a05:620a:294d:b0:93c:61e0:81fb with SMTP id af79cd13be357-93ca97359c2mr745199285a.46.1790841128623;
        Thu, 01 Oct 2026 00:52:08 -0700 (PDT)
X-Received: by 2002:a05:620a:294d:b0:93c:61e0:81fb with SMTP id af79cd13be357-93ca97359c2mr745196185a.46.1790841128192;
        Thu, 01 Oct 2026 00:52:08 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a020f7f220sm48915035e9.5.2026.10.01.00.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 00:52:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Alexey Charkov <alchark@flipper.net>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Fix leaking array from of_regulator_bulk_get_all()
Date: Thu,  1 Oct 2026 09:52:04 +0200
Message-ID: <179084112209.5187.16060198876692455319.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
References: <20260930-m2-pwrseq-kfree-v1-1-82678b02c126@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gr3XaU1C c=1 sm=1 tr=0 ts=6abe1129 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0LJTc_hIYTHMuy4QETIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX/JsvgYYGFIwx
 NZB+JSMH8eYVFFel1fqneo8x6l6Qpv6g/m+KwKCVWvyLJMZ3bM0rGGIVewNWoGGiBi9WavxyUxN
 Nx0gzXtsz/LTC4V7zrM+2kE630MqrPs=
X-Proofpoint-GUID: MdUUVcpyT0Zp_mjTO2xKRqVyURs8GZuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzMSBTYWx0ZWRfX/3acLsRdR3p4
 UdfUvUpi7+SWMHJ+IwpTjD+yGcREmyo66rjCkj1gFwNDr/g2ObQVr2huqVRLTkYa9xCu4lL50Dh
 YgmToVbQiK1DSX6DXEl5ovRDttq/iMmXOlBUh0hWHyKQMG8Sv1cB0RlqPGaADg4UMHeGdAfk1dg
 3J0v8Kcky3FAc3fCJkjBz1se/bz1Hir50i/0/cNH4kG3/RnrVEplH52+xJTOQfUopu7G+f/H4gk
 41vtIr+9PpUwWpkfadBMN2FmJM8zjtTt2I8nkddJv4drjxyx4byTXK9gPdl+mb6vOElu+jIFYSw
 QDID6KUEma4dPpwB8gEJuxwFIvhuDYnS3ZYs5sQ7bogPU7e2BQhebL3nVo/pnjwodMKJNoWS93j
 xCI52Bw209kf+8tlTXrJecpi0Z03ERnPGNG5OGV7Z+siT/6KucNQs+gw669L6gCzwRUnrRdoyds
 1v+OGA2KNRr82NN/axQ==
X-Proofpoint-ORIG-GUID: MdUUVcpyT0Zp_mjTO2xKRqVyURs8GZuK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010031


On Wed, 30 Sep 2026 20:10:21 +0400, Alexey Charkov wrote:
> of_regulator_bulk_get_all() allocates the consumers array and hands it to
> the caller, who is expected to free it at an appropriate time.
> pwrseq-pcie-m2.c never did, leading to a memory leak.
> 
> Add an explicit kfree() for the consumers array.
> 
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Fix leaking array from of_regulator_bulk_get_all()
      https://git.kernel.org/brgl/c/0d6c5794fd633427f0d4ad8b51d94061295649da

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
