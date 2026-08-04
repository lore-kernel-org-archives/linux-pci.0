Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4068B4908A8
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785871727; cv=none; b=emR15dp1LiZZQLZ+DgFdQbsuPirA5AIJo5FIXSoeCE3p4sr7gqXxejhguqSk4lL86IqRb+l431dOO3mp7MOTDO1jCrDEjYc8CDLgjVbOQz1gtAeMTJ9Vp5YFrkSl34I4yP7dNrJEcf1NCnS4TeMorS8dBkTuSMg/3XdY1EgqSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785871727; c=relaxed/simple;
	bh=wc3Al0KPAQCWRKRVJpBGFdV79fWyCpOeBTms/ZpfcBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0QeODD9H+V56SvVeooM402dqcSLe0DqoTzvLADONhTneVJXpyeKdSPZUkXA9W6jK6b/WAX18IKkUFMsSaZssh2l05mJCM2zMuK90H6JqOxeheTzxJRWCCePzgg3q4t7rOC06nt0bgJc4XZmsu1tlJFxxcNVpsSjKNeoRR7CbUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FtoZWcBQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VEa6dC/4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FtoZWcBQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VEa6dC/4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674J07d9326339
	for <linux-pci@vger.kernel.org>; Tue, 4 Aug 2026 19:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MhA2IU8196JWiRByXGGWXt3G4pGVswpFZCS5BuGud3c=; b=FtoZWcBQaIRPkYal
	jZp2fkeDjiWsLFp6JJZovb7cSZqmsLq3f2SU8fyla0+5dREDVS8kDvqBltSv+Ffb
	gfGmdJxPsaIobwrsD5aKZakAqkBzV4UD1PiL1trVoG1XVlsJ/guKpsp/WHv9Gpqe
	fGLOaOq18enyM+G6fB0eOCiFlv98DeIfb8N+nx/UzNIqbQhEOIpJ+4MoNhwuXqkU
	grGy5whG2gKlk8jq54G1BPWhwE7FxPnexC8CLzaSsDd3ETy/+Ep7vx3t2DdELTep
	ig7FGsXx7bWAdVhnOrKPAjju6YVHVK6NOSyJ34fKIATrpNEjmV1Lu7natRrkMpiz
	dOUtIw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmghvx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 19:28:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so86696a12.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785871722; x=1786476522; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhA2IU8196JWiRByXGGWXt3G4pGVswpFZCS5BuGud3c=;
        b=VEa6dC/4fJ8wb+qivVu5NGT0utzHGkhsJb7/VhpmLEki8LrojGEpnvQxrD4oWkgp8f
         XivUVwFVUt3g/+qt0j81MBJx2AmQlvS2G/NodHTqCrvYHkGeVPf3W2Yc0dQaIcOQi3D8
         OREph5b4B2L/ayT0o8WeezguHX0O/eEll3n+BPduyQDQqzTujHrp8kDwnuu812ISwdGq
         vDnDN52gp8CP/umB8sa+fwp4mbP9/GxLEtK0Yf7s3Ka3Q4vCeLTrcTwMsil6yDACeo3y
         t4opB+sm2uytA7kTC4Cpo72notQ229Q/7agn8vRguLySv8mUvzMU3w4m1f8Gl0rr8hFO
         3Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785871722; x=1786476522;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhA2IU8196JWiRByXGGWXt3G4pGVswpFZCS5BuGud3c=;
        b=c0uKsKbI4fn3iqjipoqR1ldikSLF/le0IQDXuANkr3RU9j+Ed52WknYnkMgNIDo4Ts
         ocL5QtSu74JPTpc/zCLV1QBg0n1c8LuNua0FfUOCWrlOcS5pryYD3+NftttGANPCbJhr
         /v4Rp1pjmWQbDZV0f7YQJjeoaEgisycYWVaCDX2W7cXiNUrfUr5eds0WhwFkiQ/ctUMJ
         fIWoyoCBUxLbN7Ay6UcEj5kes/JApz1eFey2Td78q7RXJggYEEVPW7tkH7qUACKw50j4
         KCFBXKNdW0eJHM2x0+fU+jDonoTBPfKJCA2mBvGc+NC/pCFMQqMCJvjCFeGgn4nCCBll
         LHXg==
X-Forwarded-Encrypted: i=1; AHgh+RqQDMlm+to0DX7tzSvvYdydBqZep6aCZW/QSM9F6qgzn0y/GF7nYIb1PB2H/JO+1UbtHl+bNsHhpl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39GU2WTSbqCMOxWYiV5RTC1tjSg2QOLieiaJwqdVa+jcuvozB
	xJCSxu6Y/sczmj5EzbgYEtoj0/Ix+N2FkZvDYEUJaXtcuhw4KzzcsvI5T6T0p/aFRWRNhVPcUn3
	9Lu3aeOykWgyAP08yTsKQ58Tek3LHjK4bV5E+TKJ0fy+g8tPCzepTuyOQSTsAoeI=
X-Gm-Gg: AR+sD10xfs/0k1N1sNAtKRO24QtKeZU6Yxs9pL30OQ+7LRVcdKAXDBog6KexkQTlb9q
	jvfvGImhrIcLuKrgyLr8lVjql0074AG8DJZOiibIXF6pMLgDRkkPStOtTs3I4PkC/AMYezASJvU
	PWqR21WnmvyANeOy2bPEwfSjBHtdNJ65UbHtL9tQVGtZSbhqtzyQktbv8cRXFw2UC0COlvK+aL2
	suZATWMlNSAIwDOp1d4+rz665XVVT6LrtDfU/C1Yzd9+HmVSH2T/MxuJttqzIuTY45CjHkt7FKM
	L4NFbG0mrTpnVihOQf8JVBBKnS9VrJRRJCTj0vjcTNwex76qKbAsP9Hhxj4Q2GdVRHikVUvCy4T
	mHP7NPNNjhoMTak+LxDuAi0TzzhQEFQzpfg==
X-Received: by 2002:a05:6a20:2447:b0:3bb:2883:a723 with SMTP id adf61e73a8af0-3cb86075abamr805121637.35.1785871722311;
        Tue, 04 Aug 2026 12:28:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:2447:b0:3bb:2883:a723 with SMTP id adf61e73a8af0-3cb86075abamr805086637.35.1785871721856;
        Tue, 04 Aug 2026 12:28:41 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158678ec37sm7150623eec.23.2026.08.04.12.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 12:28:41 -0700 (PDT)
Message-ID: <6698bed9-373f-40f3-819a-25203245f733@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 00:58:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 13/14] i3c: mipi-i3c-hci: Factor out i3c_hci_sysdev()
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-14-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-14-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1NyBTYWx0ZWRfXynH2svhWXI0l
 5H4+aSkL8LFf0pCFseGtOwW/HT8d3YeU//MzPcMoq20VPASaIYgjL5nCB+/FDmdsLjHHr78Kgjt
 Wk34S8aX2XP+phsWn7j5YI34FbljbuQEo9327B4iDmz75qASGy3YEbJt1npVryhYZRTfn9FKXt1
 HwA22UTpiAar8zIQP3xA1VBcETs7auN3rsSyHYK+/1Mb8qU8xsgG/uoYNvbjJxhSqwhOx9B2Qpu
 JhDQltojA8tHJlQHJT0o/2GJNwIuCw7sFeFcPBIrmHqBnuza7AvVal9enAtyYrq1JSIGtD6jAXU
 6j6TrpupHS46Qoy/1ZYOBGsendi75jlLv4Ru16g88EBhbAVRVKcT83kewgH/mdMDjT2+l9slCw7
 wHXRIDdD4uARkH988cXSUWnKfbRd0QXXT634Z+DHMCRaxLXloSgeDPQiAj3Eordv1MgfOGa3Xdy
 HV+1mULgtLS9vka/JPA==
X-Proofpoint-GUID: ga2BmMohzKysM27EyiBPGWhJPwXCEzcH
X-Proofpoint-ORIG-GUID: ga2BmMohzKysM27EyiBPGWhJPwXCEzcH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1NyBTYWx0ZWRfX/pmkdGnNdqAS
 IqPWPWsQBHfh1P14P+XYGzwwZQYYqpVz7YgiP+Siy8qDP+dlOGF5+tWAorj9HjUqy8fJaaP5ie4
 K3+G1usbkShVqZYEtC3fM3zRlKONRfo=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a723d6b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=RAI3vUJYwi-tdmbA44AA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040157

Hi Adrian,

On 8/4/2026 7:08 PM, Adrian Hunter wrote:

[...]

> @@ -117,6 +118,17 @@ static inline struct i3c_hci *to_i3c_hci(struct i3c_master_controller *m)
>   	return container_of(m, struct i3c_hci, master);
>   }
>   
> +/*
> + * Determine the device that does PM / DMA and has IOMMU setup done for it in
> + * case of enabled IOMMU (for use with the DMA API).
> + * Such device is either "mipi-i3c-hci" platform device (OF/ACPI enumeration)
> + * parent or grandparent (PCI enumeration).
> + */
I was kind of confused and could not understand much (excuse me!). But 
could draft below from function definition. I know comments removed from 
below function and kept here.

Hope this can be simplified or improved further if possible.

/**
* i3c_hci_sysdev() - Get the device used for system PM and DMA
* operations
* @dev: HCI device
*
* Return the PCI parent device when the HCI controller is attached
* through PCI, otherwise return @dev itself. The returned device can
* be used for system power management and wakeup configuration.
*
* Return: Device to use for system PM and wakeup handling.
*/
> +struct device *i3c_hci_sysdev(struct device *dev)
> +{
> +	return dev->parent && dev_is_pci(dev->parent) ? dev->parent : dev;
> +}
> +
>   static void i3c_hci_set_master_dyn_addr(struct i3c_hci *hci)
>   {
>   	reg_write(MASTER_DEVICE_ADDR,
> diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
> index 0672ed1132f8..7c2b20474130 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/dma.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
> @@ -15,7 +15,6 @@
>   #include <linux/errno.h>
>   #include <linux/i3c/master.h>
>   #include <linux/io.h>
> -#include <linux/pci.h>
>   
>   #include "hci.h"
>   #include "cmd.h"
> @@ -301,23 +300,11 @@ static int hci_dma_init(struct i3c_hci *hci)
>   {
>   	struct hci_rings_data *rings;
>   	struct hci_rh_data *rh;
> -	struct device *sysdev;
>   	u32 regval;
>   	unsigned int i, nr_rings, xfers_sz, resps_sz;
>   	unsigned int ibi_status_ring_sz, ibi_data_ring_sz;
>   	int ret;
>   
> -	/*
> -	 * Set pointer to a physical device that does DMA and has IOMMU setup
> -	 * done for it in case of enabled IOMMU and use it with the DMA API.
> -	 * Here such device is either
> -	 * "mipi-i3c-hci" platform device (OF/ACPI enumeration) parent or
> -	 * grandparent (PCI enumeration).
> -	 */
> -	sysdev = hci->master.dev.parent;
> -	if (sysdev->parent && dev_is_pci(sysdev->parent))
> -		sysdev = sysdev->parent;
> -
>   	regval = rhs_reg_read(CONTROL);
>   	nr_rings = FIELD_GET(MAX_HEADER_COUNT_CAP, regval);
>   	dev_dbg(&hci->master.dev, "%d DMA rings available\n", nr_rings);
> @@ -332,7 +319,7 @@ static int hci_dma_init(struct i3c_hci *hci)
>   		return -ENOMEM;
>   	hci->io_data = rings;
>   	rings->total = nr_rings;
> -	rings->sysdev = sysdev;
> +	rings->sysdev = i3c_hci_sysdev(hci->master.dev.parent);
>   
>   	for (i = 0; i < rings->total; i++) {
>   		u32 offset = rhs_reg_read(RHn_OFFSET(i));
> diff --git a/drivers/i3c/master/mipi-i3c-hci/hci.h b/drivers/i3c/master/mipi-i3c-hci/hci.h
> index b3d9803b1968..b8d2a3d680f8 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/hci.h
> +++ b/drivers/i3c/master/mipi-i3c-hci/hci.h
> @@ -184,6 +184,8 @@ void amd_set_resp_buf_thld(struct i3c_hci *hci);
>   void i3c_hci_sync_irq_inactive(struct i3c_hci *hci);
>   int i3c_hci_process_xfer(struct i3c_hci *hci, struct hci_xfer *xfer, int n);
>   
> +struct device *i3c_hci_sysdev(struct device *dev);
> +
>   #define DEFAULT_AUTOSUSPEND_DELAY_MS 1000
>   
>   int i3c_hci_rpm_suspend(struct device *dev);

