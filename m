Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E33F399374
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777833991; cv=none; b=AB9j0De4PSLAuimnIMkLgoH59dQhB+TfSI70tN2LJ0PGqXfehkpQdSQhFfoYmL8aBL7bgyBqsgzrZDhXUd7Sy3e3tggMhs9WLZhGbJ86GZCK2z2PNuucXqh321hJ3fM7v/ek9QCnUaREgnM0j/At1EUfITvPP8mKuHHJrgCFY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777833991; c=relaxed/simple;
	bh=hXqSns0mZXRsTyQvYM1QQtbBtCTGXJw/NDYOYiyyiuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtPCgVuTGUVXyrTTl3gc9eezLCeuUaKEAAQukXPF2s90bnGOGvvCeQbQykVXsdp/SMruUElzXKL1lkVenNsZGwpFcQqsnHsw0ptuZN0Hy2CLn4b2cSfJ9FI235gZe7Vi4EWPF6XeloMWeQqxE6Z9O53GQEkc5hZUkF24Q8y5hmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-837dfccd950so12004b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 11:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777833989; x=1778438789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2HxLSSoyWjc7srvpQpGKBdhtVDS99Q1hYlUtIuh62k=;
        b=LmIOvEucb4PIFanRxSCdK+hPj33YqBmcfGUiwZVlCCioze+lZO03LK/dUHRzhBWbA+
         +J5qYv4A9MacMO4vO7o6H0WIU3ltGC5CoDOgdPd/zHtUH+H/5V6qEKEev/64/cVQYktH
         s51bzy3t94naAxW/H9PuQ3US20ctPl0rjDVbhKh0EquY4/MYFCjU7w5c5ljAxKOPTymR
         dEMWjIcC6hMA1LGyPnVei30cvlC7Syg4CPxpx5C3lTcpj8chzuhpPchWNl6Nfqd4A+WS
         Obb4B7H7jba/UF79Hh/Z2X1afOYrBTI8holTLUcJ9C0oRxRjtxVb85kPIU/xeo8mxr/k
         XG9g==
X-Forwarded-Encrypted: i=1; AFNElJ9o4bYEiRU1oeQuYDvsEjKWlDrJJxh0ukfsfYxVGXSpVa0lX0wbnUlusTcfd+SfsgPCS7SEPE/C4Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSARomU8c4wbsgybGsgO1gRPiYs8UpgpmVBx+CIQCdiML73o76
	Kniz/+/li7njO87UMmfaFEijTFtfo+YN9vzN2d6ZD8KmEYtKxF08xcg4
X-Gm-Gg: AeBDieuxm9HCVmzjV3k7GdXzFtEa95GmdAa5SMKxs6olPcmuGZrJjOQEjzuWb2SVnCv
	7SNegf7e99UcGAjARxFtShg1p8YOE1OS9zou25dM9IPQdedO7+epMH0CgBrIQw8n7tRVfc6ikVZ
	OOyx6a6XkGF2HbbUemnhmLTWQVqee+ec2h2f93h+yxdMzM0ZFx9oMvRhuoJDuoCW7BmVbUN23Q7
	tGQl792m8cG2oQ0MGkpxCo0Clbd94xbgN2kEyaqWDYaCYSvMWyhL3mfpTEdwNo+q9/WlMRwIBsu
	TQsePDtsLAxkugRWKq4q87ZCtIEsPiWBe2HJ84boEmNLke/HGjPfzT9KYkccYjXIe1RP1LfJppO
	prIq1G1dRv1AryMYtjoW8gcJK+OkPqFx3wafJyUSgO//sK+xAUtjuX0YmG64w9ptwJaF7gpPuhx
	JaWfwMQFdmkSowLlvlS069j0iGEPYySSQhPkNi0WQE1hXNhNf9ugJKwZGj4iELQUPERDEXLvL9/
	snCUcAXQ8EMM/kLl8imdLQfMbV8qmD7QGaw+n7B4+Lwf2UHNIkHwwJjDK5SWElAVg5l5K4ja8SQ
	yVIVq+2WQu9Olah+Efn50PU3ccaKUG1RWRi1U/9wKQ==
X-Received: by 2002:a05:6a00:bd0d:b0:82c:212a:a9b5 with SMTP id d2e1a72fcca58-8352d24425fmr6654243b3a.36.1777833989242;
        Sun, 03 May 2026 11:46:29 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bc863sm8514553b3a.26.2026.05.03.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 11:46:28 -0700 (PDT)
Date: Mon, 4 May 2026 03:46:27 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+c7604c9fdd7580cca4e0@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI/proc: check __get_user() return value in
 proc_bus_pci_write()
Message-ID: <20260503154557.GA1455207@rocinante>
References: <20260502011446.125268-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502011446.125268-1-kartikey406@gmail.com>

Hello,

> Check __get_user() and return -EFAULT on failure.
[...]
> @@ -136,7 +136,10 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
>  
>  	if ((pos & 1) && cnt) {
>  		unsigned char val;
> -		__get_user(val, buf);
> +		if (__get_user(val, buf)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}

We could move to get_user() here.  This would allow you to drop
the access_ok(), too, as get_user() would return -EFAULT on error.

So, something simple, like:

  if (get_user(val, buf))
  	goto err;

> +out:

Use "err" for a single goto label for the error path.

>  	pci_config_pm_runtime_put(dev);
> -
>  	*ppos = pos;
> -	i_size_write(ino, dev->cfg_size);
> -	return nbytes;
> +	if (ret > 0)
> +		i_size_write(ino, dev->cfg_size);
> +	return ret;

This can be kept simple:

  err:
  	pci_config_pm_runtime_put(dev);
  	return -EFAULT;

The i_size_write() is such an unfortunate band-aid, but unless we have a
way to set the size before the procfs entry is created/made visible, then
the problem that this aims to fix is here to stay for now, see:

  ecb3908046ce ("pci: write file size to inode on proc bus file write")

Having said all that, since you are looking at proc_bus_pci_write(),
then perhaps an update to proc_bus_pci_read() to use put_user() would
also be prudent.

Thank you!

	Krzysztof
