Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968B377EA5
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101932; cv=none; b=BUg3FlHGzzSsd7w7sIGrd9GZDNfgszd+Cd4IJB3C0YqX3E1X3R/jlhzfwEEk3fDOE5pAtmIqA9cjNMjWjMEWjgkoEwOnaRwuhX2IobnoMNHaKJO2ouCxuEb4MFpfpcfXYrw1uW1f/e78omX0mR7VCS7z3WJ32ijxgC6zPLPz6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101932; c=relaxed/simple;
	bh=kSL6GZts6v+waFfKhqYl/IdC+/kKb177D6xHvzMR/4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBN8uo/YMi//8CxrWTOYXe5ndRlI5OWvRWqCNaOr2mN9h7rrO6x7TMpxlou7eICwCkNo8qMqxTKt2b9i9rbBP4aH9ReC6HcBGTz4AKDdO675KMnxeEZrEZm6KYZTiexbdd3qDrG806mp4iJ4KkGwHOx+DdPFhwec43KsLVHfIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEjQuvl1; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEjQuvl1"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1329fc4bf77so5237056c88.1
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779101919; x=1779706719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=guulY/czompKgO0Ba6aB4aCZrOgAPdTJkMrk16h99KQ=;
        b=aEjQuvl1mG3PMKxY6nPk36pUH5JuSipImHLCbJ2/x+AumVgkvzLJEuKtk5SH6bLXDW
         A5J8XXn0hKvGC4uW7a/GErYSQO9jEbc+af8g560RQWCPEVarOZuLrJVwKn6c5FAINpXA
         xRc989kBMp6SdB6ZsPIUfvd5pNJdsn2aT/XHIZ7SjMKShXyDP8OYlUZ3+3803y2LONL6
         xC6n3FbXWw6R01fi6AsMCpmRTI/1vqah5JIPQh6b9Eotq93gfWQLW72/TtYmj4gRnZ30
         EQbTKxEblqBeAniVC2bkkJSjeMjKLRoNDR/YNfGma0laFqymRWpqoMgK+/ww6SGS3wc8
         xo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779101919; x=1779706719;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guulY/czompKgO0Ba6aB4aCZrOgAPdTJkMrk16h99KQ=;
        b=hkrVWeVuSUjLBoNO3Yy6GmytlfZc8nynYAYvyFi+pVjz3wEeY1YWa/9H/zozPu1GRU
         TC/TzpAJbsKfCIdJ9ul4k5Emg2+rcVFdy/A+R4o0HxbEp4vGFiCY0r8G4UAcCzCeTqWW
         RL7F7q+dYuwq5auH2wPRRk/QcQgZEzFsROoHEooy9jUPeViKQeebY3SNEYhwLkfncvzb
         W5TmHIivuEVaO1LkphraXnY3iyohf3wpKPtqwBycRnMMsIXF28PIu8AFsqZxNGpS7WAI
         ZPkIYgfPw4ka1UBViM0yD1WafqTbZJkImwvcE9YAZDIy0Z7o2+VbcppgMbeAW/KbwgJe
         ETrg==
X-Forwarded-Encrypted: i=1; AFNElJ/YuoMxurNo3BMa1vAxtM64vWmD8wq7Im8tnADKl6wyBCr2C7LmEWx3yPerbbl3S9/Er8J6XH/QJNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6fW6eEwzam4r8efDKuoONDVGNTNKz1YQKLT7EP3srsqkVc5N
	3WWa9TXNK8n/0tdrZp8oOFDaLN8LSGrt4K5dzUEyKvNL5ad8lHjEQoKS
X-Gm-Gg: Acq92OHjdIQoHU0hMhav5hZcHkVDoXJbWblMP/uvUI/QFTegF8YgG6ZzPXtM7YLBtlg
	C5QAAUGvKjduCnuGSgB6Nxq/HSkeWS9uXWhH3tpru4wQ6/0X370jgAmx2KNON9cRlcKRzXVoEOA
	aZBSLIWLTipfJariBieKQGTWehW7CngZ7H51vvRrleBY4vV13WCOzC8j28KJjZl1dttw/YXVlE0
	3QIZ3eDshEIVDklcT0/UrzXQ0ER4x5H6iJ9x0zODja0Wbiljk5q02BSvumom0FKKE7SS2ZsKeA0
	aWPKIFSW2y+feaFdYsuf/kqylo4aKDr4+/f7iq3/LqQfNlZOohYzuVwErZeIsNgZYvUG3xR1EQv
	PMSEWT98Snj4USuNBwxJUv8z9zX6d7gOsK7iemTui3lbcuvTYDoJvACcBS/gzQr3dYyw8TNdSds
	24Cpq7xgltPRSnuP+Ws0qZTieQ8rh7tUDFrFUWxLDsdUysVuTAMHJzTTqH9IiKTeB8yZZDf30Q
X-Received: by 2002:a05:7300:a286:b0:2f1:6252:f8fe with SMTP id 5a478bee46e88-303981914a5mr6338309eec.3.1779101919432;
        Mon, 18 May 2026 03:58:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30293e2e69esm16592264eec.1.2026.05.18.03.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:58:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7e0a499d-9517-4559-abf9-ffbaaa45f12e@roeck-us.net>
Date: Mon, 18 May 2026 03:58:37 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] hwmon: add AMD Promontory 21 xHCI temperature
 sensor support
To: Jihong Min <hurryman2212@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Yaroslav Isakov <yaroslav.isakov@gmail.com>
References: <20260517130407.795157-1-hurryman2212@gmail.com>
 <20260517130407.795157-3-hurryman2212@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260517130407.795157-3-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/26 06:04, Jihong Min wrote:
> Add an auxiliary-bus hwmon driver for the temperature sensor exposed by
> AMD Promontory 21 (PROM21) xHCI PCI functions. The driver binds to the
> "hwmon" auxiliary device published by the PROM21 xHCI PCI glue and
> exposes the sensor as temp1_input under the prom21_xhci hwmon device.
> 
> The sensor is accessed through a PROM21 vendor index/data register pair
> in the xHCI PCI MMIO BAR. The driver consumes parent-provided MMIO data
> from the PROM21 PCI glue instead of inspecting the parent PCI driver's
> drvdata. The read path restores the previous vendor index value after
> sampling and does not runtime-resume the parent PCI device; reads from a
> suspended parent return -ENODATA.
> 
> Document the supported device, register access, runtime PM behavior, and
> sysfs lookup method. The documentation also records the observation
> method used to identify the register pair and derive the conversion
> formula.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I'll need an Acked-by: from a maintainer on the first patch to apply
both patches, or this patch can be applied through some other tree.
I am fine with both.

Thanks,
Guenter

