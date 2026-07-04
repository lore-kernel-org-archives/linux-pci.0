Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C2C27FD49
	for <linux-pci@vger.kernel.org>; Sat,  4 Jul 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783175217; cv=pass; b=aJCgiEVwZ4heiPoc+5Ww/QD9fq9roYGaxCwJMCT0RFD/G+pny2zFokq032OTZ+hO633MyKMadvr2ewZeRuJlesJGttRw0NgSlknmOwLkhwJX4Ks6EdkSS+sS4TVmYwRrW+bwTrQYbdQxHh+B+nYDpwoXCyi5PFQyVgzvZ4CtZH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783175217; c=relaxed/simple;
	bh=9YDFkrKXe8+xQwIOAGKt+OLc4uyD4YgCdy+nIHJ3u8A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYBxyebE47W8AZOqgp/plbgNIFIILwcju/2RUkx81/msyTAohy9Gf4cMxfgiAhfI5skOeV9zL5AZyxzmagj6ETPy3OtqFODguWv0UHgYGdFbHXlxPWBt3ZNrcCV3YYy3ZaDJXBvDU4IgxqY5PDu4cLvjf7nItnva3w3Lx2DLvS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1baawTn; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1baawTn"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso215605ad.2
        for <linux-pci@vger.kernel.org>; Sat, 04 Jul 2026 07:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783175215; cv=none;
        d=google.com; s=arc-20260327;
        b=hO9DD5iEl28s93qnEzlJcVZZTq8tMfclak9Kp579gCGXod2VxmcEWEEECQUaeOzx8q
         oSU3c3kT8K2drmBqaMDfg85KBkPAxx7BydLvoKDnOdOVQxOcRBKv67EsS7P16FqFKp+Q
         YFaIhbN/8DtdKryXy6oILcxwH7/L6D8rZBuKDKGnKU1VUPI8W2KkhPC4QCZiXjhdWpD6
         iImRmEDy5FHUJ4SYVB77tXFWNfnDqIFb0otCT3palC1avxR8wlOmYqOKdGfWuRLCcUwH
         Vn+jVWuwCHNEPJDbcFwhkqQf0ftG1sYFKSvqh7+x2XQ5NP0QhJFH4ToMWgMGz3sSwj0w
         /N5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WFnktr3xnr1z9FtsyBzXxn1YoZbHM5Izj7pi+H56QNg=;
        fh=zgtkgrkNd+WLkKQJrqkoS/jkpd9VFJl307AZgRFoTa0=;
        b=np3b4I6zpAxAnZ6x0q3B4vo6YcwwZBEICp0ri9C/7E48+2OvAf83Klpia+iYW6shBh
         x3KHnGclhzqPPmefSOsJBX1yp0tSrcI/Th+HE0aU9ieo9hvm3eTQ2sGmH5q4qazMfzxi
         9/1gI3LfUN4SchUuL6wg3JlvdaDEO219EZXMX09SFoYeQyAkQnoe7C6MaZvcc77Q3wIR
         DJ9e+2+4g58o8gY2r4VtBIK3ysuHNpHSwQhWl70TeZeWxoMiR646OM2cbhPMWws9R3ic
         CqV4c/bfbZaySG4ZrCTGP9KdM/uzVpMY0BOIxlY/Sya1L5Ye2szRAAeDKZ2ZJ1nGd+eV
         E6ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783175215; x=1783780015; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WFnktr3xnr1z9FtsyBzXxn1YoZbHM5Izj7pi+H56QNg=;
        b=M1baawTn9ZGAkIeapgq+EKg6iQ3Braxw5mPSq+yOk9IURTYNAjV/izx+ShHHke3+Zv
         61wiMqaIun7SXk6LLntP13lSfZ3y8aiI8dvMwXSBB/Fn2AhCEEAXl3S09Tca3P1j0raE
         Xz/DuZz4yprQNAjIqnnQDj1W0UQZgGEgBGxS/1WYFDnFBl4G00QMvnNFoQ0DLhVzWRlq
         1keiRaipatCWZdJOK/wsWlK1dASpLw5DvK7VAzESrwvoY9TZN1lFfHvQEFfd4xiUjHOE
         ncaD1AhnZPIrWXOPgDJbzTk5xy01dUgPDkPh7mzEP0+IGIshOt5Huc6s2qsE+l0VsMV9
         1Hdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783175215; x=1783780015;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WFnktr3xnr1z9FtsyBzXxn1YoZbHM5Izj7pi+H56QNg=;
        b=WmYrj1FI/DiYxzy0+t+XDzyRcJZLkzhFUwK58gJvXUslr74UUscpNcWQho9OC/GIJZ
         LHdVhNAXUJhuw1F3xhBDurxo4a7NhzHRelh9k94UFwGMe9HG2KYX7SyIgD+QPPfVsUfc
         u6yEb/wFaNutIC88qyOlAbaSVN82XmI1YarDiiJC6z9XAx9HBKKKcDHexTzqypq4JW2s
         fyhYOWTsjRofqJVFnaksW1qbg37JpYpfTlfrx8Z3/jp+/GwlQNfwDrsZoPI4LL62qrDw
         TNwg/QY5VvVq+1+WNfiLkkh24smkZ0F9LPZiVPsm1+GUFd62lAze4nHi8kFb8mRA3an7
         /yGA==
X-Forwarded-Encrypted: i=1; AHgh+RrpTw3qrZKOSLihfkcjkofHeND7ODcci0dIQwzDHbO0s+EFLmJ4fzvT2X+c5knrSFK88pwdgcwiD9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTaf+LmMl0Mxx8SMDiDR84n6+CVGllU0PpuORmUtkCG2/8f/cQ
	jq9ZvXksgdptjlfsoKqXfjKjC0f89Lrpai6aJ9vJeSUzwl6v1JL6KOfBTKQLHJl47y9kTSmEhUj
	WF1zovZxHlESRTYFf/zcF1x0isloY2KA+98L+c2bp
X-Gm-Gg: AfdE7ckEd4lFfmWOeC4zoLOVXu3IuRVlwEID3a1X9Kl67S5i8AzvYwe+Z8mqVQX2vPg
	WXdTt9gajFMwRYMPcLhyCzkclbdXyGei6WPJ9vFUSUWOAK+fXczk/B/htFZlV+IednLEJBZfXJs
	UtwmSl9KwfCbMWX5/9xdbV4YyYdoMFoyNnDtnbZQUlygW2448pQ4HWsqEsQhw3skQoYu96ZxDOa
	tiaFPH0R6/zIXfGJ2S7kAliW4S++97gbMDiCh9/++rY1l1q5637Q3ogzQ8tlg0qD7Ts6QO8Luwh
	sA1yIxPszY7izcNPMRGfor7vdnvgAFDAhZvsjF4=
X-Received: by 2002:a17:903:1ce:b0:2c6:a012:6241 with SMTP id
 d9443c01a7336-2cbb201b39cmr35063005ad.6.1783175214863; Sat, 04 Jul 2026
 07:26:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:26:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 4 Jul 2026 07:26:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260327160132.2946114-16-yilun.xu@linux.intel.com>
References: <20260327160132.2946114-1-yilun.xu@linux.intel.com> <20260327160132.2946114-16-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 4 Jul 2026 07:26:53 -0700
X-Gm-Features: AVVi8CfdRsR_CKNKNIUlkjPTBxsOwA_Mmn0xqA4DX_E8qDCY3KX5iWgXVn3NJRs
Message-ID: <CAEvNRgHauBdavhq68BepiOpJd1_UmBUQTkfsRmNimZycZ4VW-Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/31] coco/tdx-host: Introduce a "tdx_host" device
To: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
	linux-pci@vger.kernel.org, dan.j.williams@intel.com, x86@kernel.org
Cc: chao.gao@intel.com, dave.jiang@intel.com, baolu.lu@linux.intel.com, 
	yilun.xu@intel.com, zhenzhong.duan@intel.com, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@linux.intel.com, kas@kernel.org, 
	xiaoyao.li@intel.com, vishal.l.verma@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Xu Yilun <yilun.xu@linux.intel.com> writes:

> From: Chao Gao <chao.gao@intel.com>
>
> TDX depends on a platform firmware module that is invoked via instructions
> similar to vmenter (i.e. enter into a new privileged "root-mode" context to
> manage private memory and private device mechanisms). It is a software
> construct that depends on the CPU vmxon state to enable invocation of
> TDX module ABIs. Unlike other Trusted Execution Environment (TEE) platform
> implementations that employ a firmware module running on a PCI device with
> an MMIO mailbox for communication, TDX has no hardware device to point to
> as the TEE Secure Manager (TSM).
>

I'm trying to get up to speed on Confidential IO. Thank you for this
summary!

s/TEE Secure Manager (TSM)/TEE Security Manager/

> Create a virtual device not only to align with other implementations but
> also to make it easier to
>
>  - expose metadata (e.g., TDX module version, seamldr version etc) to
>    the userspace as device attributes
>
>  - implement firmware uploader APIs which are tied to a device. This is
>    needed to support TDX module runtime updates
>
>  - enable TDX Connect which will share a common infrastructure with other
>    platform implementations. In the TDX Connect context, every
>    architecture has a TSM, represented by a PCIe or virtual device. The
>    new "tdx_host" device will serve the TSM role.
>
> A faux device is used for TDX because the TDX module is singular within
> the system and lacks associated platform resources. Using a faux device
> eliminates the need to create a stub bus.
>
> The call to tdx_get_sysinfo() ensures that the TDX module is ready to
> provide services.
>
> Note that AMD has a PCI device for the PSP for SEV and ARM CCA will
> likely have a faux device [1].
>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>
> [...snip...]
>
