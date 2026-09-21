Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF40475337
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010441; cv=none; b=KRkUMwdGtj7CANvB00GqeJ8KqjVzmwhvNjZe+G0aNZF4wkh04qanXZZkZuEPB0AfsmhFmTyHJewtBNIAHqyx/oS17Vp2pn27jWXXOhOZqdy97Ql2G8xHvle8mE1aAIil/n6NHiEDZki5m3enaA+3M5+FxVw05i1ctM0lmzgvKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010441; c=relaxed/simple;
	bh=JQnBZxB94b7FdJbt6YoVD0ugDd+00IsGczuRtXQr2WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPP6mwbeP0SqydkXTTMehrKbDhJVIO/XN3DNq7HxarNnpY+SA59GwrFjrA42ll8t41NYlmpoKx/TeW9O2UEUkcKNLyKO+R+NHsDDvx43mcMthBfTu1/YZf/qWPigVG9ZV5JvDDIXECx+uRY1T8rwh/j3Swsg7AH8+aZk9ObK2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=OUfKi4xJ; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OUfKi4xJ"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso5091618a12.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1790010438; x=1790615238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m70w/bX3ilZ4pFPnKbI3naBgfETFNPJqRbN1JfmLM1k=;
        b=OUfKi4xJQtRJpmP5Yag0nmozxm7vpHt3W+JkrRsc3Cg9Ju55/7nfokeuTJyzs2K2pr
         u4OdkqEs6ZmFXWzQdlbTxe7cBxMSuEs97rXX3O5niTdM+2HWUeEtgFf/I29lRSMmNZ3c
         6Tp5GZUIbh8zs0qgZmxF/dunFyOZt5mwte8yDr401fEq/S0q0Gepwl8yVPGoKHhVcUHE
         j0k3ksU6CteIzWMD0VcsxIqPUERkGJFu+N+qAn5vVxI7IoP8aYnlxnKuiMncBdnM2+bb
         lal1cD/ua4yfT7oXPT4Edy1j85U7jrFAZxHIaaxqQ4btwvA9lWeSzAq+8iKLZH+6So+e
         jfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010438; x=1790615238;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m70w/bX3ilZ4pFPnKbI3naBgfETFNPJqRbN1JfmLM1k=;
        b=XDIj7A4YZl1HKYJyfnUIRst0piHZj4FlFGy98m99OgRi3KsreyWhiwsVaokJv5tMNO
         Bf1TCPRh11zN5cwTHCPUkvxVgRJijF6qKezOykxtzSVleunCH+6gwdVXG8rHmx7V/h5F
         RXnDxmd4aNYxUQrg7iuu8134G2sGADdBgfExRm+opG8APoXRQVWN2UGKmFcZ8x4O3kiA
         K8/1XvV3QF2FFLh3U1pNsR6aZOwCP1vKsZdj16p2ZxmGNd9VSb3K+6a26jmBK8Id0oni
         0j5LEYEA+eSNRkav3kcMgPh8Tz3Vjngknya/PHpB+P6XRQ+v2D06bAnAHdwJQMaLrawn
         07TA==
X-Forwarded-Encrypted: i=1; AKwUvBy0REAECqIDuHcvtVAu6sNiWntUy+UUsY6RpAvWo1AvfU3Dj5vnr98/uSgN7FmCyQwpwo1UyGi2Sbw=@vger.kernel.org
X-Gm-Message-State: AFuF++lO0ThHnsO5PJi+kQxE3EWTNn8bglfZ5L+ZZuYR+xdz2RPLnpyj
	O5dYZBdIuUJyYlUoEIhEYKkmu367I5zBmEPIp8YLFnP7SFls7GTWi9THobhuMlwskw==
X-Gm-Gg: AYBFou00Lt3fD0azKGPLj055MA4DduMre4QVelrS8gvEXTtjoDlJQvL4QGBpM/nXVCC
	5E01+ilEryYOfbYWvC6DAgy4Ndp7hxECRyuVG3OweUZXnoCbQq7wM6zILnYJ7L+Kle+wdoKESIG
	4d21PpMjNP3NrmCsDAJQIkNeu330cSYe232ijIzdYrubn3hM9zmTiQlu9uX+S5ItyobVqId4Okx
	tqlEyDKy6s5ChewVSRirsDB36OAtcB0ZTw9K8GH/AQIIIYgOIniRz0YS3C1+VdjGoNFLJb2ENVr
	RlGSChuj9MsU2TvtKAEYWBmTFBJFHm1TAIQNK4lY/L1CoYw5u3UzWVC7tUxwbtpwzhAQ332kVmT
	Y3o2ibg5AmKgKHQCOwnmnMQPzPOzWas9CONciQqKFMWL9cVuEWln4s86szjVEfW/VmI9xHX5Ue8
	++UMgd8RGP18tLYT6skfhXqh1S5fUx7KK+DPs+mCxFaQIcAnYYXV6vyXjLv2G/PQPeS9dZS7fI/
	FZL42VSwZusAOtEIRiPLXv3ihjhyM1uramxc6Qr8/Uz/Z0Ynar93pA=
X-Received: by 2002:a17:907:9723:b0:c26:1648:a061 with SMTP id a640c23a62f3a-c2a15e0febemr1007505366b.28.1790010438384;
        Mon, 21 Sep 2026 10:07:18 -0700 (PDT)
Received: from ?IPV6:2a02:8086:c99:c280:94ab:79a9:2843:6b2b? ([2a02:8086:c99:c280:94ab:79a9:2843:6b2b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a3588485bsm348783466b.46.2026.09.21.10.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:07:17 -0700 (PDT)
Message-ID: <b8fe94ae-29ea-4de1-9ec4-9a5840edcb50@arista.com>
Date: Mon, 21 Sep 2026 18:07:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Stop waiting for link status after config read
 failure
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, James Sewart <jamessewart@arista.com>
References: <20260904111318.1063858-1-yurypm@arista.com>
 <6e10813b-3c79-7f61-2bf8-85a6d09674ed@linux.intel.com>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <6e10813b-3c79-7f61-2bf8-85a6d09674ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/26 12:59, Ilpo Järvinen wrote:
> Wouldn't it be better to base such checks on PCI_POSSIBLE_ERROR()?
>
> If you keep the check for the case where pcie_capability_read_word()
> returns error, its return value should be converted with
> pcibios_err_to_errno(), not just return -ENODEV.
1. There is no reason to use PCI_POSSIBLE_ERROR in this case, because 
pcie_capability_read_word() overrides the value returned by 
pci_read_config_word() and sets it to 0 in case of a read failure. So, 
if a read fails, pcie_capability_read_word() returns 0 instead of all Fs.
2. Thanks. I addressed your comment in the v3 patch and used 
pcibios_err_to_errno().

On 9/4/26 12:59, Ilpo Järvinen wrote:
> Kerneldoc wants this formatting:
>
> Return:
3. Addressed this comment as well in the v3 patch.

Thanks

