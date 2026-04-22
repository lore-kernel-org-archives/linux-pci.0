Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0683876A7
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776881771; cv=none; b=Zl/ZzX6KGSUe44bwaxtYcSfubPQtyXdvzCat6Rfij0Fk+BbnXEs8+u3gt6EGTF71+tmVJxHaASFFn6ygrlLFgJotfO4ElA/bAbigEfQYAL7sKYPSw9650ZPJ8OxCQbf0FBT/CvdWe/FDv2rJ+eW14sYihq5ZI6MpFTcoJwMEIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776881771; c=relaxed/simple;
	bh=mf/wiGIJo7w2d/nZI+wHpViVNnpSzdppqqCqUoYg03o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNTLkwDVJW/EtYnqpkRlWDo//iAnQnUmA3U5/+y/xxY6KiyJ7OufPXr0VqUEYW55aM4yIetYxuXp4eK0HHqVM/ruU8Z3yIUiPez6q56NPP0LHmBpVqe3bY7HjghmI+zL/b/cb+ZY6oxCShRPWc+rYolCUj5SgJqxXPiv2iye4Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NFCWpEu5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3Lc6rKZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NFCWpEu5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3Lc6rKZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG3gKg1230220
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 18:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hmf2rPquk5TMbSfIW3+r6rwe
	dWNLP+19dSQv3vyH8d0=; b=NFCWpEu5Ahuf72qjLUAhRj4l6vSUmuYay65p7+iv
	ptcVKpVKo6/dhTqnDIil3vTIvVYesJBaO3FVNS3wPF376xSOwRlIMmRSFrDkPE91
	lzaKrc2wnM9kaOIUtj1ev8nazVEA+dYCk6konbnNGQXL8o1Se37ChIDR+Dx8m+0b
	ZZv5/M62/L9mQ9o0nA625voIcQMhdaMkKuF+x79tHyMUEJW2IeVac7bjcj6Dj+qZ
	yAJoY1+qRk6EJhP/+r7uG9zfGS4II0DAhS/8ftmnFfn67pPjC1Z97x4lWxn6ntLM
	x+CcYKYu4wgbgX8Q4GeaL5OzR2MgiI2hF/2yv52c4hJ4Fg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h68fbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 18:16:09 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-479d4674399so2575196b6e.2
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2026 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776881768; x=1777486568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hmf2rPquk5TMbSfIW3+r6rwedWNLP+19dSQv3vyH8d0=;
        b=J3Lc6rKZWkEYsOP0Ju9K6iuYShEQ5eesNP+6LXb9HAUb9lcLMjnE8AD5URfjkp4wSP
         UHkHThfiyCVz0JZOMw3bz0WeNGg0KyNs2QMlXjSBXbmsGJuugToAvCrAqTcvV+K5Imcs
         vtKB5j2ThhlrD0aTpvLJVnIKmAn2Cy2UR/jGLkZ6lRbA7Z2cghRCK6TqNPFaY9O9TcGA
         p+LzbMUrqgzrcofLj98uxtwNXwXkWrap0zXj+byXDcbNmX5HhCShz6r6gpLBJa1yuHcj
         ktPxQ2v8BMkIU85Sr/qxmc4W/ZBoB0pPSfSrsBCOiWnMbDYtQ0QQ62+XwS7K8JsP7+RM
         UfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776881768; x=1777486568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmf2rPquk5TMbSfIW3+r6rwedWNLP+19dSQv3vyH8d0=;
        b=iRywXPJ2jla019Qhgmjv/kV/ZGs9CBtV2IA62fZLJjIqc0uWdoe8fObZojHun81/nO
         oesuC9L8J+U/9mRZCO2uNbtVtfhVpSXlOAsc+Y02XrNDNVWFU8biWsXkvdjUUEESKPws
         1+x0vmt7LOgKFmf8ZDKRmaRE2tr/BQbDx2/6kviSVeT3qS+HqZIWYoINsryXTR895f9y
         9DZpB8E1lOIygq3P+M+m4w3xG13GklypNuSXroQoz9UPqRVxz9NWw1t9//peg6D4lDrR
         G38FpKVTu8hw+YWpjdYFMnOe2v5e7JaFu6wnD2eDCBMGJoiMXw1NfOpvvo6LdAEsOOkv
         FCfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+CX4/muGbLapfA7Oz/nxByHoxE0yisXlUfqVWzhyQuZUIA3VqZ+VDewkPPBednapmK5U6A01G2NJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytIfV80j9cFiP75TPgoI1D0Qk8Ta+edTKAYeagCT9DLT8/XXGm
	BDnLXJY16V+XFOKBo61HTHS6G+FVO9cA1B4vRljgHCUpo5g614bTBRUi9RJrxIirhc6XhokHXN3
	wgvrCOylr/cO3n/oPt69EiMIYNqfxOMyYc8vbZ4O5xTChI2hUImbNbdCEWCexPOE=
X-Gm-Gg: AeBDieublY0Wy87HeaTarlGKBtzvDB7xFIQqIgpTgAhDlSUW10/YalwBEiQqRGr5u8G
	vj9PS/p1Y/WFOQQ3QL9ekW0hTMwfd1+mWDq5oZgeYV6hlmKm5wtjFgYDaXE3te2jHcfTZkVKaCX
	25oIACxIvmVn1e/+nJFonJi7oiwxlnaF9fQpz6j0JKH7+a9C7JnSBicHLqIukjROZDB9YRsodI5
	Ka1JQ4e19xNKaBQVllT+tIokqWxKUAYOVS8DOkuBvQjE3RC1Clq99LgYmLhKIQLnNYwcjLQgc0L
	lwP/NMXMcerrUXFWyu+TI9ie+oXz4kbZdeknvqFRQDwmzl4ks4BXzaAa2RgFfcKds+i/ynG869p
	aqOGfejOPURdBhHOsrTXJok2KkKSaPBWUfVkE279ctjjGGGg5j5reBdjiRQDNCtu9/nuZgSN9YQ
	HkBl+W5eny9N+2F6Tz2Yg12ZJMglNKqTZ3BzL52gZt6OdcBQ==
X-Received: by 2002:a05:6808:6f8f:b0:44d:bcb0:1409 with SMTP id 5614622812f47-4799ca08539mr11775110b6e.22.1776881768359;
        Wed, 22 Apr 2026 11:16:08 -0700 (PDT)
X-Received: by 2002:a05:6808:6f8f:b0:44d:bcb0:1409 with SMTP id 5614622812f47-4799ca08539mr11775082b6e.22.1776881767903;
        Wed, 22 Apr 2026 11:16:07 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6b20sm40071291fa.18.2026.04.22.11.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 11:16:06 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:16:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Wei Deng <wei.deng@oss.qualcomm.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 10/12] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
 'bt_en_available'
Message-ID: <cmeufrfrpongh77x4leqbxugc5mrrtryjbn7talpxnnxgjd6ho@fcif27twuizh>
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com>
 <20260422-pwrseq-m2-bt-v1-10-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422-pwrseq-m2-bt-v1-10-720d02545a64@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69e91069 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=yI0fE1SOOqVeyhB3FMIA:9 a=CjuIK1q_8ugA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3NyBTYWx0ZWRfX9EvwazQ0No//
 RuAEXGklk8HEY68xWBS7Mo6iSSRVAQgXfdX45w+TRZmqgGyxTLgBTq9SX2QUeitXQsvMCrLEtGa
 WQg7jDLoXFoWr9BZ3Vy91j4pm/RPCT0yY99cAFgpg/0ZzP5MzRTivhmfN8WQ2Y1HYosFEECK+sR
 ZlOfYZhf3aYVPHHkQJOxQApFsxBiEmbqp1Mgo2qEvH6+j9R0Sskc1nJS1K937Vki3CbW5Klg/Oz
 zvtDpzz5fJQjluTK4kcy18hXzPNGEbI2xi7KKgFM4EOdpdCLcCdMk7MBZt3aZApCTyYu20tPEnj
 YII2yBf8XDfgfV6UI4KNQUoWHwMRIFzC9bobte4PIe92GcScgcFgB8raqVmrNHaYBiWuY8VBAbE
 /sHoyH3B1u/Y7YWypSHZpQ1hsKuVy4rfMnSUAzNzRT7hUxH5Ln9bkmB+PnLOhl4iOOrd1NUCGRM
 Pb+6RqVtHdit8OmNk7A==
X-Proofpoint-GUID: 8unwkl1-lctE-SoUL_m30lUhhZpokEbD
X-Proofpoint-ORIG-GUID: 8unwkl1-lctE-SoUL_m30lUhhZpokEbD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220177

On Wed, Apr 22, 2026 at 04:54:51PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
> GPIO in devicetree. But the naming causes confusion with the new pwrctrl
> framework.
> 
> So rename it to 'bt_en_available' to make it clear and explicit.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
