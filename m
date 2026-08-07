Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F035AC03
	for <linux-pci@vger.kernel.org>; Fri,  7 Aug 2026 20:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136304; cv=none; b=FvaFKRkrTOYlJnQXFyOxSBT7AGd5y/A4sLdSBCyv81ARZKyv+yXniuv76I4avDiMppypIiisysjYggclIy9fFWWeiOdL95nmrJxQvyDE46tuGhmdSUfi1fcYYLy1t/04NVY/F61kRPCEEjQDHhB5gUBbkYZkIzyE4ctK9EAJfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136304; c=relaxed/simple;
	bh=2JoD3JO2pW5pi92+cVlcHhTmMg3nDMhKO466t82pHT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u15Rcc1k2NO1H+fOi1eF6uiPREsBZlXTSEmF6ZQOtCTX4sof7g/mDL4bfw1+n+TleQdkhAPInOcqvIxKB4GLO+82hSqqkNpmWmA6+RPM9P8NzRBDHdV/enLyHAF5o0TZCVUK+WrlZrvJdaBlpYsBNN0e3IEOVj0xiGIOk7Z8F04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=lSzTW3oM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="lSzTW3oM"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-934974844ffso258467385a.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Aug 2026 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786136302; x=1786741102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kj8kzkNEBS/XA58S5M4C363N701v5oQh8U+/4A1gICg=;
        b=lSzTW3oMQbVr8DD6SWLhegR0IZaHXqUSZI8d4lxlLX1xn0qDnolTgZUz+1h0GQaKAA
         XPdpF7F3HvZmrquN1/EiNPwml4dj82dcl0WDeMSBDKRPYp/XRNuLY35vP2SE+zq3bKx7
         E3wL3/bHZ+55nrWaZmFdPR4XQRLmMMfWHd6YLNd6AOglPDwiYl7eMpEF6SRfGXFBrhBb
         raw9P+F2EROwdzmfuCocm/mrz0l15tHA2ezqIhMY3RX/7uu3akkARi57tlZLsaT06n8Y
         uDxD5YoYOV/cqi22bGvhXIffsJT+DmY2btj2KexlfaZaBjIjjsyvWsQyLuIksw90wsxr
         xjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136302; x=1786741102;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kj8kzkNEBS/XA58S5M4C363N701v5oQh8U+/4A1gICg=;
        b=P9nxom5xHJKrSVlRxj1K8/rSQTemda29b8pjuhXIPjz5rrFB1/o1scm4bpsHfNZxZt
         cXy7nV1TcBZ5Q7Ri5XUzaRrA1QNJMPvTCwo5/9QXemDRMLFCR5j1SDL2Va4mw29UgUfn
         pmtmmQell5g8Co294ifjJws2EcgAUb9J7RPCIKmnHUtjfifxH6z/UGlO6izjH0SryHSl
         xrMPYmTJXhnklxAdbIFEkPYr/XL0znOSniCCtE1XEu06uc8dnzcT/FhAlVqyd985/BTl
         YZ/j6O2iejoAXlAB/mgd+tyG9oIIuX5vy8lt4U/dFul9oH+255NPGr1iQ8Qv1wlGNYs6
         Rcjg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/BhMDeb47k+ZOQdgOYo/6SjklqC5GXCecL4C/uTMc8OlVIjn0y6VvFcwdiaQz1QXvR/T3JXPz3cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQxnYSxhFX0lbqXGrE0JQm0yUpNjd4qxmLefaa6kZ+tOEk8xD
	jLHgGMcSYt9cpQcOp5znbj2oDCOIKamS0SFxXJvo98N0obq89JAy2r3sP0zGB5TebdU=
X-Gm-Gg: AR+sD12C37QZCyyWx6d5VlSsyBUPWrNXvXJgFX9c/GSEaPsKTWDzGSmWuc0ClX+MT1W
	TQ+qhI4yr1o/d8DwJS0mmVImw2zRXus93DKNWEA7k7GG7UzZEB/EupDFjnQh7C9EVa/+yUVvTGP
	7uQkcVcOsdPDYpgKASbzHlbNo8E3eW4j5CG3/hCiYbEyYYH524vg+Nt5wKfNhJAU7KLdzTP+K68
	IBYOSG/9xT5dMojyjQqLdW2OmtE+fTlxtew7aGCGtitioG+Q4/qxGOqYkvszQnFgpwIM/GAL5SJ
	hGQf0SGGBEKjScIWqj6qjw1nVeygw7f1S2eEM03d/LPp2UwJQZdUXmBWSkTYf29VyeDAGKzKtJ2
	x76zy2C3MO3PrbIXJHC7mlFs+iOi4gmtMrBC6J45jQp4Q/xzMzj+16Id1Sj3l1mk9y6mkQ6WjGS
	GmlLlc5BA+VRMLVQaRLyRmLS+9DcjxY94xZt20jH1By8GYZ4cHfiw+j3yS+3ZN
X-Received: by 2002:a05:620a:4416:b0:930:9fdd:f4e0 with SMTP id af79cd13be357-9367984defdmr383213385a.26.1786136302464;
        Fri, 07 Aug 2026 13:58:22 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e09dc07sm233090185a.15.2026.08.07.13.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 13:58:22 -0700 (PDT)
Message-ID: <929976b6-0960-4e90-a7cd-f163ecaeef3b@riscstar.com>
Date: Fri, 7 Aug 2026 15:58:21 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] PCI: of: introduce of_pci_verify_node()
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260807194100.455599-1-elder@riscstar.com>
 <20260807194100.455599-5-elder@riscstar.com>
 <20260807194944.DEE001F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20260807194944.DEE001F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/26 2:49 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The static DT node verification function `of_pci_verify_node()` is mistakenly placed under `#ifdef CONFIG_PCI_DYNAMIC_OF_NODES`, making it a silent no-op on systems that only use statically-defined nodes.

This is a good observation.  I think it's correct that
this check is worth doing on static DT nodes even if
CONFIG_PCI_DYNAMIC_OF_NODES is not enabled.

I will plan to send v2 of this series with this
suggestion implemented.

					-Alex
> --
> 
> --- Patch [4]: [PATCH 4/4] PCI: of: introduce of_pci_verify_node() ---
> commit 29170ab92dd207c740eed74438cd2e09bad49131
> Author: Alex Elder <elder@riscstar.com>
> 
> PCI: of: introduce of_pci_verify_node()
> 
> This commit introduces a runtime check to verify that statically-defined
> (pre-existing) devicetree nodes for non-bridge PCI endpoints do not
> incorrectly contain the device_type = "pci" property. It adds a call to
> of_pci_verify_node() during PCI bus device addition to catch these errors.
> 
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -1265,6 +1265,7 @@ static inline int of_pci_get_equalization_presets(struct device *dev,
>>   struct of_changeset;
>>   
>>   #ifdef CONFIG_PCI_DYNAMIC_OF_NODES
>> +void of_pci_verify_node(struct pci_dev *pdev);
> 
> [Severity: Medium]
> Since the intent is to verify statically-defined devicetree nodes, will
> placing this declaration inside the CONFIG_PCI_DYNAMIC_OF_NODES block
> accidentally disable the check on platforms that only use static nodes?
> 
> If CONFIG_PCI_DYNAMIC_OF_NODES is disabled, this falls back to the empty
> stub below, causing the verification to be silently skipped.
> 
>>   void of_pci_make_dev_node(struct pci_dev *pdev);
>>   void of_pci_remove_node(struct pci_dev *pdev);
> 
> [ ... ]
> 
>>   #else
>> +static inline void of_pci_verify_node(struct pci_dev *pdev) { }
>>   static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }
> 

