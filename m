Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3F47604C
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869545; cv=none; b=kEHbx1/+tFbm5zNpTdlTtABN8D7SfpDgGyIwN9uqF+qNMYZbHdpSRhLI/VMRW+Ur7xeebPoeA4OanC+Vwx+4PYPo/XaWA6HyfMX2d3hXRjjdkqD3eiDH4tHXksqX6WpNBWBYjxD/pqrE4aN98VgArW3usVwvVhoH+7+d6YtzFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869545; c=relaxed/simple;
	bh=qplbsh/mSXiKomLy1bCLaoHsZycFdQMuX3h8VoKxnpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqCCB5jSYmdgL8NzrRHDLpkbTPax8HknrERGs/YIjSQkN2dFksGRGFuNbd4ObSvSHkjknpMzWnij4U0jgkQylUVLvQRxV1Dcigf+X9UjYlgkJhhWv3SGb50ga7QLDQ644kZsA9KNxrVOLKknoMPsoLPQTvjVZF3gqVH122P3zCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ovAkk72E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iw7boSKX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ovAkk72E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iw7boSKX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674H0LIO333203
	for <linux-pci@vger.kernel.org>; Tue, 4 Aug 2026 18:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YtP2L62OBcnos1NyatTDhxKiVMhFH9/cdtH1RA7Q+Js=; b=ovAkk72EHYo/90hU
	T2pZh4UCjmwOPBXq/jEDdFzONs5oBoPsDyf+tRP6MVGxkHK2oosn2Dj6c6Zp0IN0
	yDkJZ2SaO05kXBs8r3HAp0cPpmW6tT31Evco7l2usYJqaZzC/wypt1evByg2mjFF
	xYZ/w5gMtmNI42ByiUJjuTtUU1xONCTVymnnxwXKeBmh/uV88/63phP9CQSLh9vg
	J25aULN9xUbUopCi6l7ZgSoxhtimVFtSLxUxK7zTzrPOPV2iMj8y5w316C2hBdtX
	+YtLm1K1K28uBkuM4AMsmsgjH6O8B35E7v2dPt5fp6SE3G1qrSjvlhY4LIhmL3RU
	x4+jkA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3n8hs5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 18:52:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf1c86963bso13049545ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785869542; x=1786474342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YtP2L62OBcnos1NyatTDhxKiVMhFH9/cdtH1RA7Q+Js=;
        b=Iw7boSKXKeSBC/EvwVuz/XakXFH1o/9dTsnm0IBNg+35Ku1B40NDaWJvzSD7pQuvP1
         /+Z20HQXuzvrA1vzyULPqNMOSrgdaHznVMEpv/g5ilRNIIIEPiVgWs50XnxCElFZCnnx
         dtw3l6X7in5+Eat9LyVkD/1uJtBa5rThPAdXzB2IMcc+yFNqvrDq3Aqn3tA/2l5psZbn
         Ecvo9kYVhYHbdgNJm2N6ijWAqgrjwBhEJS1JmjELQ0g/KNm0Z1Vzd30LwO6jucfi6rRy
         o5FS/tl43VXWHdmXjMQ51NhvuIdG7DhAJJVg76ICjdofSZs+71RlDGySpMXUjCByVS3v
         LX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869542; x=1786474342;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtP2L62OBcnos1NyatTDhxKiVMhFH9/cdtH1RA7Q+Js=;
        b=NRUJlfEiz4ui2PUzAwkWpeOCyPhZFtyQxKTwg1ltP56aRcljIEHFM5LQ/I9rv4+wAU
         u+9Kem/fcYnYGhurlvx71EPRvpZyDYAp+argMN2veQibWCAqMghKzlEqOYSUdDc+sdob
         GpYqnvT0WdPMCas+GQ8Uo2wogwaWdoJH7H3YLflXp4WHkdc7SGcO7p7R71KEDmvWm3JC
         QUX7HX6NhfDXCrAmeLXoNx/Zkdu5rkKputJQX9jVNSEk+aCz1Veni/64Sb3Svu/6qalv
         +W07B9nPuH400QtLtqSThxqjWlhTmuG1E+WCyN2HfPO5jl8P5CiSqIdT5XW8aB5fJ7vQ
         O0mA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7DVzLe98AnHH7a6SLXM4xSzWIXaGehBPRCtd9hKku1ftdc3m7blFwGxKNIG9OJBYQp4yNgF/tfAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi4xPTC3b/kREjnkUOo6eufqsEa86YX8l0rlAZlJ15qY3N3MG1
	nprX2v4WtbsFL+Vw7y4rOC+HLHXeQkucwigY2hPXa3H8XptUsN9u1ZHPi8CQpALiF+qzcXOYuz5
	b78WieCejlhxwM3T7hoBiaiA8b52OVeijT6phC9VxBZTxrKSs5bPtSCuW9niVhk4=
X-Gm-Gg: AR+sD10JfwlHTbyF6fAIuUOxcdMp7DZN1e1znP8/xnzJjRbplVfuNvYWcuziNOCpqEw
	AV2NveGjALgHmgIbEAbhMMl3Jhz3fDw3nAjBbhLvqPfZoEpqz3JtzTu7w5irlxSY+pG9fUcz1rp
	2YHzD1bICeXpZKfZTJVLWcgdRA0gzY1EiDVA3QYbSvd1G8yyqGf28nbgpCH/YmT+FWf3byFA6m3
	l76vclRBmxJtkRDN0SFRSr4/M0lZVQQNuuSLrQT4iODGuWkxHwtxgUxJatnIXXxw86L+DsI2Dji
	dwOJ7jFur55lsrmMyTjWG8xVdeAK/jEKO4aX/TwJEzw28tZ0jwDgkm4bXR6+0D9Uws1AutxNaGT
	kQcPa0V683e5fT6jjFcD6Ygs7bEa+Ol27sg==
X-Received: by 2002:a05:6a21:9991:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3cb6c9c1887mr5739257637.22.1785869541527;
        Tue, 04 Aug 2026 11:52:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:9991:b0:3a2:ed4a:5d7e with SMTP id adf61e73a8af0-3cb6c9c1887mr5739208637.22.1785869541078;
        Tue, 04 Aug 2026 11:52:21 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31586447d52sm6700712eec.12.2026.08.04.11.52.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:52:20 -0700 (PDT)
Message-ID: <76c03e2b-649b-4316-9c3d-4ce5d27a86e5@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 00:22:15 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/14] i3c: master: Add helper to query bus wakeup
 requirements
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-11-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-11-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mATre_KExbVN6EEyeZOJncpD8Pn0_nst
X-Authority-Analysis: v=2.4 cv=EvjiaycA c=1 sm=1 tr=0 ts=6a7234e6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=y7ZiA1EjnykWbA9aLYYA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: mATre_KExbVN6EEyeZOJncpD8Pn0_nst
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXwmAhZQMsrStp
 0+hOXtFzzq8berAM1e1XOEh+KG1ZAJFWvnM51y2SCyx9kIk9z4fGI6osZ5MxBaG0+goNgICqGPx
 r3niZbiL82ylW8eg1JDQ1dUDC/vW4LM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXziUOJxnq55e/
 ofmqL0c4+b2A51NNeOfuR4HwC3wRcIuQLv+buhswGxIQcaNxYM/B2hjtT9fSNcIA+Y9OGW+4nDQ
 KDIGtvf+m+zf+G6uQ/3QbKXmTO4Z2T6vBsmfJD6TBmw31WZ3cghbYMxj7qoJgGG0Gv/nT77yud8
 Ojf6RnKGgQufbqhFwgo2Orc9HqggZN4TIDzQkwH2MdOYloguagYxHahc9esgV/0NuqqKTcE8T60
 3x8TC57p+Rt/zKaMBXbpjXcl3Lc4yP9rU2ngXt7xQslqsiFkvgUlI44gdvkmM07EPWFZY1oGgYw
 LsJMJ9mJ2MrVlqYeOQ4a9AclJuafSyrre42rxjFkDR0QRbcnslhe1FISU3LHYTktyYY8JwBj95/
 NA3x4ggSujYIYYZJ4a3vuqjceWQAfHKpyrq5kGQN9CxOdgAM6Egj4Sh6cxvcsqkAitUrACJEhrZ
 OopA40bs8RRvdcv9y9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152



On 8/4/2026 7:08 PM, Adrian Hunter wrote:
[...]

> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 8c9e62e6f146..baf4769f0512 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2150,6 +2150,41 @@ static void i3c_master_reg_work_fn(struct work_struct *work)
>   	i3c_master_register_new_i3c_devs(master);
>   }
>   
> +/**
> + * i3c_master_any_wakeup_enabled() - check if any device can wake the system
> + * @master: I3C master controller
> + *
> + * Iterate over devices on the bus and return true if any device has
> + * system wakeup enabled and IBI enabled.
> + *
> + * Whether a device is enabled for system wakeup is user space policy,
> + * settable at any time through the device's power/wakeup sysfs attribute,
> + * so the answer is only stable once user space is frozen.  Call this from
> + * a system suspend callback.
> + *
> + * Return: true if any device may wake the system via IBI, false otherwise.
> + */
> +bool i3c_master_any_wakeup_enabled(struct i3c_master_controller *master)

wanted to suggest if this function name suits 
?i3c_master_has_wakeup_enabled_devs()
> +{
> +	struct i3c_dev_desc *desc;
> +	bool wakeup = false;
> +
> +	i3c_bus_normaluse_lock(&master->bus);
> +	i3c_bus_for_each_i3cdev(&master->bus, desc) {
> +		if (!desc->dev || desc == master->this || !device_may_wakeup(&desc->dev->dev))
> +			continue;
> +		guard(mutex)(&desc->ibi_lock);
> +		if (desc->ibi && desc->ibi->enabled) {
> +			wakeup = true;
> +			break;
> +		}
> +	}
> +	i3c_bus_normaluse_unlock(&master->bus);
> +
> +	return wakeup;
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_any_wakeup_enabled);\[...]
[...]
