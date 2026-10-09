Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544564D17BF
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553056; cv=none; b=ZtP3KMxI4HJpUB8vce216vE39ZNo5+qHMySaAaYlqM5i34/SUL87SsOgAuc4lUHGOk6MKLymCyoiI+++zjHsczTai1o7ChVZdSXdadxSs+SQV3kcZHBUXvmypIIWYpGL1G92jV2CSHqXuw9gBi2cRZLJSUhVrTj+AVDCmSFzCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553056; c=relaxed/simple;
	bh=7KLdZ02G1ijpboEIJvD6mnkYKnoL//zp3KLniMsbsdc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SErQJ+h5LtIA/+RCi5ia3JljPxf+l4h16ZvQ5VRcjgL5uUGDD+Bnr0lIehLLr5msttJTJbikQ5c4b6KMQC7wHA+cCfVBvxCi/bfmKavbcwp+eCD7ZczbReC+0XtrTcXihl+GVj5snoo1fe/A04g2CdnZFrhD/Vql2DhYQl4S+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fRTQBFCj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fRTQBFCj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so34955925e9.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Oct 2026 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1791553052; x=1792157852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHVmwKJx6vlL0Jxf4PIHrwr/lEzD2xz4xusUIoY2sNk=;
        b=fRTQBFCjU2yQWbjVmHSFR6HBdYqyZgxg8RDmzAMn8GUo84bNhVGDVU2c76lOQD2k9L
         oEa1VtNKMp1b53Zm9ZeOvhCGbMmQRTtx/jV62qLt2L0QbnvIc30CGSeM2l8xZlzQMEjk
         XanG2LO90D1CtN+zSb+sobIA8xxG38j3UWFnHwNAthfDugFTbiP9gZQF0At7h1R99EOo
         Mgj9NevR9/E5K8C8UpGRbgHWhbWiT2tP5vYyw80KB+OPzBGttMEks3cBgyUBdCslNhbP
         u8gkJM8piVNGehFsbmfirUi6P95W7yXxvKJutCoML08uW+Fg3QboFXOtZzY3M9c1dwER
         0c4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791553052; x=1792157852;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHVmwKJx6vlL0Jxf4PIHrwr/lEzD2xz4xusUIoY2sNk=;
        b=bFls38FK6oJw5C/0GateATVQmB67qByyBYIlf2jnJO/jaMBNs7RnbUFrRjkyfmOCnA
         96aLdOH6iMOfA7IwVPVT869GDbylmiaRWw2RXuIFfRPf7V827fph4NKqnJFPyEsUh2IV
         3UVnXphGFVKz2LiIY1qRErXA/st3biuRgjqnl/ift/nho2pOjQhyZjzasCJDQXUt7zTR
         ywhILIg88+N3Id4NIY1Pvck5XchAmNAlP7Jxw4o/4mQhWPnY8gHbwggMdXc757LSzDgQ
         cIZhDMslvvNbY9EEaa28/n0HC/8o/H55132kltJpNzSjCBWXMtJB91K+3t12SFJ3kV9/
         U+0g==
X-Forwarded-Encrypted: i=1; AKwUvBzQ/YDmuqBylHbMp+j0iICCH031PO/HSOrqq9kjCKuBFjqCLpkWDZl9qmE7wa0zzgjb8f0sTLuexpA=@vger.kernel.org
X-Gm-Message-State: AFuF++mz6bAIf6FsmotrwTZT9joANKKeRF3w6RPbCTMJfNkJyLfjXp+B
	n/rBqZGSLnl62dDztVvdUSciO7nIZPTTKd3ORIQHZd3xlZ8jUp+UXU/9AZfYPISRI0Y=
X-Gm-Gg: AYBFou2aosPzg8Fls9CWHAOlzneSSKsPeois8IQ2mIPEzP+jzb7ipcPtlvYMbuaNIUO
	Yq74JRkiIDZhQzXNUqohqq33D4UyiLnhQCfbEgXAiroMckPHqU7VIvwfu3QEQtl7uvwtCcIFdIT
	i8rnkd49w4bpJnwLoX2rQNZKEjlBzjvQYSEyWWIYOVFH8oJjGqTXMsk347keooDjrLPckGXYlWT
	zg9yDgsBrIS0djwZuqYA8GK4R+ZpgCYmGOOvCco/uswwLemoJ0o9Jusk6+02OVmUAPlmuFcW3Xc
	sj1f2OS6X579AteYJE2Llk5ZI2I6K9zqUkYe6qnjZX2Krz+L0MOfRZJryB07O8o7MeEIwsREtht
	Ugr784QQHUnA9UgtdJ3V5SI/Tznkm8eU+8UpENnyLpuBhPDviUobFf59BDbTOiudNAR56OTEYGL
	jBSDnrV5ycXAI5VgcvNUi8bueZDc8RBgNjBCnKT72zZ5FrVyqsFs3JZxywjMZ2lYp04Fu3IQ==
X-Received: by 2002:a05:600c:4688:b0:4a1:7d3d:10a4 with SMTP id 5b1f17b1804b1-4a18e49c3dbmr38135205e9.17.1791553052527;
        Fri, 09 Oct 2026 06:37:32 -0700 (PDT)
Received: from localhost ([195.94.150.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dba033a0fsm3244147f8f.14.2026.10.09.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 06:37:30 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 9 Oct 2026 15:41:16 +0200
To: Alex Elder <elder@riscstar.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, bhelgaas@google.com,
	lizhi.hou@amd.com, herve.codina@bootlin.com, daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com, lbiancon@qti.qualcomm.com,
	mani@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] PCI: of: update endpoint ranges dynamically
Message-ID: <asju_HpgXpIyAFdf@apocalypse>
References: <20260924222444.1351466-1-elder@riscstar.com>
 <ase6toUhGn0XD0v9@apocalypse>
 <223c5189-bfda-4c63-b09f-4ebd01bd144a@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223c5189-bfda-4c63-b09f-4ebd01bd144a@riscstar.com>

Hi Alex,

On 10:55 Thu 08 Oct     , Alex Elder wrote:
> On 10/8/26 10:45 AM, Andrea della Porta wrote:
> > After a quick test, it seems that it's not working out of the
> > box on my RPi5. Let me investigate a bit to see what's wrong.

I stand corrected: it works perfectly. So:

Tested-by: Andrea della Porta <andrea.porta@suse.com>


I think it should even be possible to tweak the static RPi5
DT in order to make it work dynamically with your patch. Can
you please provide the relevant PCI DT nodes (from PCI controller
to pci-ep-bus endpoint) from the output of:

dtc -I fs -O dts /sys/firmware/devicetree/base/

taken on your reference board?

Many thanks for your work,
Andrea

> 
> THANK YOU FOR TESTING THIS!!!
> 
> My hope was that the recent change (to avoid doing any
> updating of ranges property unless it was found to be
> "empty") would avoid any trouble with the RPi5.
> 
> I'm eager to hear what more you find.  Please let me
> know if I can be of any other help.
> 
> 					-Alex

