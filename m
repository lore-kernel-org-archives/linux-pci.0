Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62887287268
	for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773521650; cv=none; b=DPGqyHZiq97L6k5I1i/uV7I4LGpAN6XoHlIlrBYb/5x4wd0ZlWor9m+1UacS1DjLBpxygDcLkslBiHhGER761M8fdb5EszZ1eOLFhcrpAIIG7WilSkez4QrgZxYzK8zxPr6+6tL1maLAFgKiVOTabiCb94P4VlpgInln52Ug3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773521650; c=relaxed/simple;
	bh=CRsU+6ICttD3gKex3EXog5ECo86CbY1P5lEAfUFwBzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQtpjnvWkJVBiVwLn7rJjM+4DLMVjniel5Ex/g7TIHnP5uMBpZzuSEta5/RTFw4Qo9ULk7I25i3WDXjuiMrnFH3Fd6cVqjZEmBjirEP1nH+Ssr3yPeiKFz0TxbhHXwxV7ZNDtea2mlhDUuwBOLjvkNJrbYkHYk+Xsnb1FA2YXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so332232a91.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Mar 2026 13:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773521649; x=1774126449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAGPFAKjNzDeumSjC72VjFRaDAA9KGhJNKncxPl46fM=;
        b=PkSlYfTFgV0IF0kU48DNe1U0vW/iBQaAYMS4ONFz570RVnxp+mLvVC+7q+5h2Vo5aU
         +Ri3Ro8Jo928SJ9hCATHeD1MR0jpB1skivCA31GJ+AhwGMYmnud1zB3gNL63COOLtf1z
         lSL+sWRcUD2JB6vBt4exIk3cYfktBWdn9oYvVbB1V/XKRBYexag+QYvp0GlH/zsETsXU
         nzfYQCU0mhem5AEOPPxFeYGq8hNT65FKqKSmFN3V1Uw/WE0dK9dttLNhs7uii/O/UHRs
         Aqi0O4iUzUl843MxFykfglO61lNfrTpX7oCAhpKpgk8rlzAxC3nHYzBRE/fkKmzORKlO
         4lvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaAJ57UdX0i0h85yZ7qUEWuRhrP5NtZRs5ih+u/mSoez+s4aIK8AwjhaSz2o6Qn8Ya1zvUcPSUkwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TFc1SaIG7NGLUo74HACXasRAr01LmYGn5Z59b+DQDUe1XlaM
	rtJ90ThuazjGHkr/rkrjSSHETGF3IK5J+cTeFna9jcJgWU3yK1nmUa1I
X-Gm-Gg: ATEYQzzi0WvMqiVfdN6u6eTbfupXtIewbGqd2TKpw0dn7MfVdAFp8HLFnr34+hFGssS
	wi4tDsjzx8Xdzt5f3I3j78XgqkBiy9jY3W77UqBdR7AxholYEVtDMDG7xJz04fIoQ878KLbIXCp
	8fXur5bgOFqXKD8tnjGy6XIJ3Z5agLoJh80OpGSesI0DkDzEwA3RLb2YJxHmbPtv7HpD6ch5ukH
	bRtHAZ2eftLc//536BVbwiKpM73ZPNbZoMwTa1pQIciOytiYC+wSyM/XDA66jE546tWENmBFRrh
	48JG4QCL3Kd9CDn+U1Jj7kjHg8K/46oeVW6gP2NxctOd3Ex9DWO/StAq8rIay2oEmWKQnvLsZ2Q
	XiN4os347hN9HLnGyyEovrlHg1jDBU5sy+dhEvTZJKb3ASlY5/epbZkCNp+/s6ATL8qkeQuOlZy
	SEbDMAC8a6ISVHtQm5IEHBW/bH91KAdbyIMjm8ikouQ6MYQJsKeslSdUPHEdiysLhN/ND4dVO3Z
	tIh8M37iElj0bkZWDLCF2f64O1ygfQ9d+WPKi+xC7nFrfRD/d4=
X-Received: by 2002:a17:90b:1c11:b0:356:7025:56c7 with SMTP id 98e67ed59e1d1-35a21e9ef5amr6144454a91.5.1773521648721;
        Sat, 14 Mar 2026 13:54:08 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9230f2fasm1139953a91.9.2026.03.14.13.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:54:08 -0700 (PDT)
Date: Sun, 15 Mar 2026 05:54:07 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: sysfs: Suppress FW_BUG warning when NUMA node
 already matches
Message-ID: <20260314205407.GB672783@rocinante>
References: <20260313050826.2126-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313050826.2126-1-lirongqing@baidu.com>

Hello,

> The numa_node sysfs interface allows users to manually override a PCI
> device's NUMA node assignment. Currently, every write triggers a
> FW_BUG warning and taints the kernel, even when writing the same value
> that is already set.

So, this works as intended, then?

What makes multiple writes to this sysfs attribute, if you don't mind me
asking?  Do you have some tool that does this?  Some automation?

Especially, that you seem to be writing the same value over and over.

>  	if (node != NUMA_NO_NODE && !node_online(node))
>  		return -EINVAL;
>  
> -	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> -	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
> -		  node);
> +	if (node != dev->numa_node) {
> +		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> +		pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
> +			  node);
> +		dev->numa_node = node;
> +	}

You could invert the check and make it an early return where you just
return count.  Would save on the new indent level.

Thank you!

	Krzysztof
