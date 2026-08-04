Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E27D4749D5
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 18:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867687; cv=none; b=KrBhKE11kLJOeXpEY/vhDp3PHhRxpCyompg0IlJYhqP+8g2NrQQTAT6ndzSYnexbhD3TWfoQNOnXtKIRJbpSKyNGUxf/plXdGAs01g5niBq9AzWwd5DJ05Mm9rcX37ENQh2GScKpLAlH/ZttO8RSvj0bimMrwftjbyOuSWKZu5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867687; c=relaxed/simple;
	bh=cIWebNNhd5WCWNDRpeq+4wg5O6YVuBD+ott+AM4Qcrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XN9U+OdUjDZWYSXziO+X/yKiAhIvQED+ZjQe9NAMbqNeyHfAWkRrspSm2RRsjBf3cIt8wX0CFoDkA5BWhgBj4hsI5Wyl4RItu2d3goF2Z0cx+xNVPpWNtaLW16l3Hs5+3vRVOZ32LkawuIpyDI669HRtMxynr0D31Gki9urNMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R5bg7HYc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LnV3uU5X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5bg7HYc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LnV3uU5X"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674H3Q7l404547
	for <linux-pci@vger.kernel.org>; Tue, 4 Aug 2026 18:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4AjFf2wRc96KLV85FfeVqtVQ8LAkWfwTKk1LL7rV1DE=; b=R5bg7HYcPz8Yj0AR
	t8M1djPYY9C8jY2/ETun+qYssnxlMxweryJIH/WXKY8z6x9WexK1Mp2wDQjnHIVM
	eK3bbGLz+XKrI9A8U6xELAvtq+f/2i1+utuhKUqOLZ6yr1Kx0yIZXdVO1IMdzqjc
	t608yxRGzXDPp4JQfyOO+SvRJ/L5Xvhk5DkhbkOfSZ+y9788gHw6JWA3FPNH6TK7
	t/Jy6+VfH29pKOnQORfa6S8amuH+eOOhWbJ2cFjKopXubljJmDsyz6aFDfKhGMXj
	KUUNEo6UuJb9ZXQemLVNmsZKS9crMIuJkg0Q97crNJmeGFK0o/QLIm9AlboeDo4w
	Ohbskw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum56gcfk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 18:21:24 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so196199a91.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Aug 2026 11:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785867684; x=1786472484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4AjFf2wRc96KLV85FfeVqtVQ8LAkWfwTKk1LL7rV1DE=;
        b=LnV3uU5XmTpApwXeRbBtr/cG9FUMlBDabYhTGtfApb+dqWPF6QBDbrBO0cnlSkfvm0
         WBxAqLRqmrjvzawBb+Yl/nEGuKGfYnWD6dIuLeA3qCnVQl0nlAN5+xP9GYJYz9of6dS5
         rC0XxOHzmiTV1qNPO18fIrjFGJWBrYGgKC4FL1VsFRdQtjtt1rvlcdHJmoqBgjvU5dGR
         j97FvcX++aUOXj+sbXevmwfmKJcLajFTJhRafKdyVGGsYgVhjXWL1anxeha8DSM5Yvfy
         q8cR1y24scjRby7pSZX89mGcJPG+no2RQA0vhGfH2lrLB7aK9iWyQOJcLafG89NiBzym
         IBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785867684; x=1786472484;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4AjFf2wRc96KLV85FfeVqtVQ8LAkWfwTKk1LL7rV1DE=;
        b=IJuG3M4VyPKUHRkiHHzNm/bCUbatIoIqmDw6DHHDIuxs4wJavJHaOEQeGpQ21bBmvG
         zm/J8oMLWGrcmCX45qhVAa7wAk/6sOBIhOopshGMHux1YOcm9Ir4Xma87BJPMZF6dZ2l
         o7wZYK2F4LfFzR1fOkIDb5Ptc9U+ktPSYMlXvm578uIzwA7hxiwYlLwSmDUD343Q4Pqu
         trBEl3bU4H25d9F5jdxv96yZfoYiuADcwYwwS1UHqg+qbJpC1B6eHoNB3SpnA4a3bTza
         3Q8z3O5v6tLo76dIqfmQPI+ECfcZsgI9WgvWn3p0/HnTBvzMvzjjLBA6syTE/9tvVBJt
         n99A==
X-Forwarded-Encrypted: i=1; AHgh+Rrlp0SgB2IIVVxfopy88IktLb6t/St32dup09PaZ+qkI31VbUJEQd8JrsgR2UkoZxJlsvXjb6mErdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv7rtSmLtYprVugmZOpDH+TOH6ZdY151du8BcYGMwxIWR7cRXS
	uZRCsNeWjDVWvRMmkhQdE/E5cMQpV1SJIirj7A2W4XNwxVXYg6NRSP0WFZnF22Fr3gaTxdueQk4
	enFu2QaLFNVCSX+u3qJCfjWWRCn5pm/vYY1zdC2Qjw5snPIi+b0gFhiFDZ0WYFXA=
X-Gm-Gg: AR+sD10aHPmNCma9L4njrcAbBjDF6k2mImEMjH2MSJFe69znI0TP5aafWOY1tXPfgeP
	r+jjSaTHUUN30I/q3n+xu5xqCwjd5roCCE3JSJkaHoX/072px96YIePaphGHy0XIpjrc3lH/eFk
	XJXAOcaCHh72Nby+PcdxwycDXArnRsfHjSn/QXhYpmksdmmrchWdPX9cCl0r9npmA/jqmWviHIw
	4kYzau3w8YaLDItuZ1KLL6t2R/WtF4A82l/gmNxE3HEIDgjGTPjTHJLb9BfFzVzrmCF0C1LYw9N
	v+ysd2Hf39zggcXKNq2yxn7BMuzvQDXzq9IazKoZlgHm22b+r2JQ1FW5l6sh+7fh2nnRdDGejlK
	0SFbhuxt9BQAwS56WYY6V6dPzXtmaA6qt1A==
X-Received: by 2002:a17:90b:5111:b0:38e:64b0:8bce with SMTP id 98e67ed59e1d1-3903c633720mr666620a91.20.1785867684210;
        Tue, 04 Aug 2026 11:21:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:38e:64b0:8bce with SMTP id 98e67ed59e1d1-3903c633720mr666592a91.20.1785867683751;
        Tue, 04 Aug 2026 11:21:23 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.234.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm11465837c88.9.2026.08.04.11.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 11:21:23 -0700 (PDT)
Message-ID: <a67a1fd9-1a90-4c82-8ebd-bc6d7d15fe10@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 23:51:18 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 08/14] i3c: master: Support IBI-based wakeup capability
To: Adrian Hunter <adrian.hunter@intel.com>, alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com, akhilrajeev@nvidia.com, rafael@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260804133810.184905-1-adrian.hunter@intel.com>
 <20260804133810.184905-9-adrian.hunter@intel.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260804133810.184905-9-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Sg7oNnuqqHoSsnYXsrdwr8rVdPXKvsF3
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=6a722da4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=/lQgZcjXNA7ZrIsIl4Cfeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Nx64Jw-tU8Eu9UldoZ8A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfXzlwE7308v1C4
 ZJXwtzgeL1w88ddMqZhfL/PBT6uBtSKZf5e6qzNDeNzDupehWvztoSyTSn3brdGmGjjDolxio1a
 4wA/b+eFanBGqzHmFA4mPQWiZGouqmA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfXz3z5WGdevVfu
 HK9oUiHoNormy/RXc1HMaKoT4o/SKwP6He9tApTPc4PAtkKsZyZjq1xUF6mPKD7PICH0LaXtoR2
 2Oxcn+c2nVTCa5GDmhmVUaxveH2/LBIvwsbxXqajfsUWUHndrGMK6oKciemSAiySex6T6D6o68/
 7E3ReYNESud+EumKmmI5t+shH1tgj6ivz7rvF1P0EzabshFMJ9wdwuEV3oZENW7L9sFJ4Fr5ew1
 8RWNaZGLh4kHSntqgvckzLYKSfBFVLtXaH1I8HbS8N7gYhgcQsG704Y55GnrFqj1C0e297Twr+q
 zlr6UxJ22upRJil4wJzHjdU/vvKx2TFocZJ5QwNqK15AfmERq5Ta6bNmQYy7KkAb2iQoyDMbkJL
 GEDXn7YrHIgfd+6hjtUoOZyA9BE5/+KQaS27RAwLT0Fa8bwOzeeziLwrh6Npfz56wOprCSzajrn
 0x5Oyaq8JC3+9GP8HuA==
X-Proofpoint-GUID: Sg7oNnuqqHoSsnYXsrdwr8rVdPXKvsF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040148



On 8/4/2026 7:08 PM, Adrian Hunter wrote:
[...]
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index e7ea41007889..e6b320da475e 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2110,6 +2110,13 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
>   		if (desc->boardinfo)
>   			device_set_node(&desc->dev->dev, desc->boardinfo->fwnode);
>   
> +		/*
> +		 * In the case of IBI wakeup, any IBI-capable device can
> +		 * wakeup.
you are registering a particular device to the master, so why "any 
IBI-capable device " ?

"If device has IBI capability, mark as wakeup capable" to simplify 
comment  ?
> +		 */
> +		if (master->ibi_wakeup && (desc->info.bcr & I3C_BCR_IBI_REQ_CAP))
> +			device_set_wakeup_capable(&desc->dev->dev, true);
> +
>   		list_add_tail(&desc->dev->node, &i3c_unreg_devs);
>   	}
>   
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 2b96c4ea75fb..16394aca7230 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -523,6 +523,7 @@ struct i3c_master_controller_ops {
>    * @hotjoin: true if the master support hotjoin
>    * @rpm_allowed: true if Runtime PM allowed
>    * @rpm_ibi_allowed: true if IBI and Hot-Join allowed while runtime suspended
> + * @ibi_wakeup: IBI can wakeup the system
>    * @shutting_down: set to true when master begins shutdown or unregister
>    * @boardinfo.i3c: list of I3C  boardinfo objects
>    * @boardinfo.i2c: list of I2C boardinfo objects
> @@ -562,6 +563,7 @@ struct i3c_master_controller {
>   	unsigned int hotjoin: 1;
>   	unsigned int rpm_allowed: 1;
>   	unsigned int rpm_ibi_allowed: 1;
> +	unsigned int ibi_wakeup: 1;
>   	bool shutting_down;
>   	struct {
>   		struct list_head i3c;

