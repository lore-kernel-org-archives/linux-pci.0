Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230F93D34AA
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779271218; cv=none; b=Fs8BmrA8x3mCwS3JPjnR6sjFhdVHyXWCltjwgCIMyPjwBgCtM5aTAlkhaUU/6AYkN6rb9qqomlQGCd+iloi9SmvTvN5OjZVr6V1CNrLj344r4/KmylkJsyC1P9U7BqaZdbUnyYADRHSovWuZKyWoUqyDNzi/OdKiwDpYU0yY/K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779271218; c=relaxed/simple;
	bh=PRApF+rMwWzU1TrpWtwUSFJUXFpGR+lCqV+M8068n50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiQBQSYVxgIPPBBA7PkJ87FgndnQfvZ/hvTPJbtgFCQiHTe93OcrJLRW3sLZNTvv7RW0d98+uUktD2cJLnu88XSMjJQCTtg73FNH+slVlpESFf4/uVEekkl1pf248JlSB2HSoSqswAdoER8zJo8Qhtz4LW/3W/Vr2fzg2UFH/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=E7yqIWnO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="E7yqIWnO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so55121025e9.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1779271214; x=1779876014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eevHLhUKWkGMV3Q7eGSbySZ/65dImn12/rg7tybSy8o=;
        b=E7yqIWnOunftVwFDOEVESXMrbo6jLyVSzpC3sgPc3ToGXTy72eyBgBtMT/acpd8626
         VJEgogsZcXUBg8drTbayHTIon7a0LCyqFSekH5aZGOCkqACYva4hhlVct0Ti2/0stsn0
         8vttoHBm4wiSU/k9iKUq8/SqW+eB48wGh3k4LWml/ZUqBqSi03q9O3v70mbXLEUaA9xd
         I0iqPoOYUHWys5dj1j07ZH6yZUQ2opERMU0kAhCIQadOzRw6uP56IQbIHRvNYmsquKNX
         t6UXaQQL0zDcJTXZSMWli3QgXD3gaz1tVv45L35o4Rfa0yvH0eHH2bJzigv9NVrvzkwh
         Q3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779271214; x=1779876014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eevHLhUKWkGMV3Q7eGSbySZ/65dImn12/rg7tybSy8o=;
        b=WnUX78R+Ruv2SvbMNnt9pHNIlvaJihWhU9iRTMxKSAL53jgDSLTVveByN44jSE/xNM
         3T+b5S+UbZa4IPxhu7mnwiscbvb7FBtBIfrZzJmbR+vgsB/R0Y02UBuXXTjRHApF7TjQ
         uDxMMuxG8g+quWzUtimXhd4AHbBCKnjwwonwkcwPkBE7gnESQRAXxdLSWFcaoPtantFd
         i/TzwSL77F8hVwmGp3QYyU2KnooEgy9/FNCtbtuEZBdVi3OoKmI84lUkRQvWwJdSUSRB
         SpMsC8tL/aqXa3snNpDtwRNmM38Kwts1eEdYZXH8NAye6WA+w66estQkoVVkFtk180kW
         SNLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8/OPvlzY2pLHo4wYneZ3OhpBnFeRz/H3x49vPkeDGWJpFiixVFWk8yCwGXXMHnFumzEQmvkzw7XWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0coS4HldvsIhd3BU4G1VrjqI5WFjNvINWqJXYqTjBYzW1x59
	ohteIojKMTvqpg4p+JuYN5d5+KMZmKzxmvjtYtZoblKv5Z1jka3gW2oyFubZ7Yj6CA==
X-Gm-Gg: Acq92OEpa3AK1FT0m9vA/+yEvqJIB+utL+I/8RJcd4NO7WhISie68ysulZI/hh95ZlH
	aB1C9NHDupOgSbW0z+ilGXIl0kDwxS0sK58sG9fyPmxPqrdtgDr1NWs+h1ArIdI9HeuxED+8yzE
	tf4XqK7WEME1XXw7SifK8+CXzTVN8gDuMNEDUKs0Qk1c//NxRdtO/tg2bnolvTCc1tm7CeqpGDZ
	yvLCh7FPJ4TYEpEk/0XA6ZjGjyi9sYsql4Cz/sqqn0HGQ40kGsYWz3e8MEJzXXGuppogwgdsrUW
	lMeObSA2HcjqR4v8D9UpEKD8vh90C/gJc/m76klrjdFV0btAub8v7iybUZe8E0gZdfp4j4HG6ls
	z15y3eBitaJXeSpKhkT6Ub8ckATYu/BcJSU/dh46tTrPzm9TPJdHKlNSycYXMe5bJoQkRjdd6t1
	OTL6En0PaJvy5vGNqTWCg8hMsB5NEGxGN/
X-Received: by 2002:a05:600c:1f89:b0:48e:526e:101a with SMTP id 5b1f17b1804b1-48fe60e7a13mr343604215e9.12.1779271213845;
        Wed, 20 May 2026 03:00:13 -0700 (PDT)
Received: from [192.168.1.34] ([51.37.155.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm378173475e9.14.2026.05.20.03.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 03:00:13 -0700 (PDT)
Message-ID: <988a07dd-871d-41fe-b432-d740e3122e38@arista.com>
Date: Wed, 20 May 2026 11:00:12 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Clear non-fatal errors on AER recovery failure
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com>
 <agwzHzF3bpPM6jcC@wunner.de>
 <3633b587-5782-4cfa-b967-997de86866bb@arista.com>
 <ag10ON5pZ4ymPT9U@wunner.de>
Content-Language: en-US
From: "Yury M." <yurypm@arista.com>
In-Reply-To: <ag10ON5pZ4ymPT9U@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/26 09:43, Lukas Wunner wrote:

> No, is_error_source() considers bus number 0 as a bogus number
> and will iterate over all devices on the bus.

Right, if address is 0, is_error_source accepts any device with AER 
error and returns 'true' for any device on a bus. But 
when is_error_source reports 'true' for the first device on a bus, we 
stop iterating in find_device_iter. We stop iterating if 
"e_info->multi_error_valid == 0", that is our case. So, the error is 
reported only for the first device on a bus.


On 5/20/26 10:02, Lukas Wunner wrote:
> One more thing, recovery is failing here because those four devices
> on bus 46 are unbound.  I've got two patches under development to
> allow error recovery for unbound devices.  You may want to try those
> and see if error recovery succeeds:
>
> https://github.com/l1k/linux/commits/aer_unbound

I believe that aer_unbound will fix our issue. I need some time to 
confirm that the commit fixes our particular issue.

But I think that we still have an issue in the pcie_do_recovery 
function. It is still possible that AER recovery will fail. The reason 
could be different, and most of these cases should be investigated and 
fixed. But until these issues are fixed and there is possibility that 
AER recovery could fail, users should not experience the kind of issues 
I described in this patch. For me, it looks better to do an AER error 
cleanup even if AER recovery failed. We can add an error log with a 
warning that we did the AER errors cleanup although AER recovery failed.

