Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581941519B4
	for <linux-pci@vger.kernel.org>; Sun,  3 May 2026 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777849337; cv=none; b=S++Tjmmy02wDH0vHJ80OuDXrvKtwfUYB/xQHz/WJZ0GsnVnD6ybtAm6bwsvlJxUEr6kEpdVgydVpE4OIspJ68qy9QzOUbjDmIGjMsGmIGxv3M4aeSdFSaYxUeaatXSXPzdkf/gGFcIK8d8T/YQOX/RhrTm54Myv69naEKn//vAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777849337; c=relaxed/simple;
	bh=0nkPVTIOZtoWybvWRf0WUkhS3Ld5XBksfEFCfzykh1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJsvHVoBi5BSHAVinRxjQvKq6xQLOrXKFOW0v1mUZbl2SpNb1INWA4HNCHeufeLNlgHGown1PEHAPfyWHWp+xjp7w7qKVFSwIIjlr+vxveo7SVg4EUbAOmLs5sSwksP4rb32Wdo+SiMgZrlVpRSOmiSXBHiaGC+t2ym2EDvFYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-835c98b659eso331074b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2026 16:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777849336; x=1778454136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O13aNb1HJ5Ca667sB1UdqKXPXeqoh3GCzMzEHFbbH/I=;
        b=WAFbjPhO25yrUxIoJCBB4Kyovq5Q4wcbuo5srivGb8pVes0hrbhRCKaMoAZ/81537A
         7z06kgq8FmdFkT69TtCLeQhOhvM48UXpGRVeJ/niz7sdNJG9cRkXOG7sFUg9t1wP0eMf
         HUa3LbjeL7P6cgGDV1dLUr0EuIjQ+9xBfOSiWxaSvV9Et1Inx5Oth/Wn9CFj2ML9WfUn
         ipk3oKpUYfA0wuTlv/R8masC7Jlk+aJEMc7yxcdkKwELOYN1hokVpAh5qCzUNS1aqMAM
         maJ0wToWmZ+gysiY7wtbT65ebQIy8frA8Qyz/wZIt9FvdsqDGOuMktMGyuDK4g2VUWCx
         HHXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MztvnR/7+u3qcapMxK9L1fycMt57ki47DaLmxd8GJfu4p4dQp329q1bkBhGf/Sv6vTVwe0dibJN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9kurdAJZISkbr2Qj/lKAg4he++mlnYsPkJC6QL4gGW3Es/cHa
	KR1L8zzVO08ICYccVqGdxSj7K25mbgt4m+VJBN36U3Z3U58Ecm/qeIm1
X-Gm-Gg: AeBDieseBeUu1rRZ8n5YZR1GURZN0Sd897STi7JUvyqQJo9j5Di8fVivYAsDHer9O5J
	k5WHGPHx/9960Y7INmcA+3RyUFOF2miiCbng5IvyBClejB00yzeYyXhBK+4g1o4+5qvsUYJpuFQ
	cZeTcpcRbfYllXDrhlIrG3N3R2MU9iNYxKNyZwa2n9L1tuANWDaFto/q66gPoQG3ObdkdZiUHz2
	S0OTz54xAfGqbrLG0lwmI5eDkkcvf3AaAlGw3G8srG9MBcayTJlGF8e06v8cG4v61ehZmRgU4Mb
	N0WGSQitSvlimfKRA6dl/dA0VZityuxTOfLyvG2Ng6v/YR0EmIkVqThcXCOC87MgzC9pwT2JVnW
	t0ydSH8WN2wavHqIxwh5GGPaKno3lXGtiD8fmCn3ByV6llqIy6syuu54RgmNGnfPVIDIxTO492W
	RcFcW++/tVxckQ2GFsbz4vHr99YhYiK/dFGXQcTL+VLZv1o4AWd0tz6umPTSfYlxj2eiOQ8Npw/
	3BRDIHzwCR2xJ0KAPzdPkIKoPPp1PqqKiDlOySABhHrIPu/D2R+RGOsOFeZSBr4Vck+74KMMin9
	1ibuUAKv7un1rvn+qgXwHoFIu1zOO6GM3VtCIjEoTV6SCCuILngL
X-Received: by 2002:a05:6a00:1d94:b0:82f:8a29:e3b4 with SMTP id d2e1a72fcca58-8352d2f7d66mr6884843b3a.50.1777849335504;
        Sun, 03 May 2026 16:02:15 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b01a4asm9035616b3a.43.2026.05.03.16.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 16:02:14 -0700 (PDT)
Date: Mon, 4 May 2026 08:02:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liuyongqiang13@huawei.com
Subject: Re: [PATCH 1/4] PCI: Align proc_bus_pci_write() with
 pci_write_config()
Message-ID: <20260503223843.GB3862479@rocinante>
References: <20260414024544.2975605-1-duziming2@huawei.com>
 <20260414024544.2975605-2-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414024544.2975605-2-duziming2@huawei.com>

Hello,

> -	if (pos >= size)
> +	if (off >= dev->cfg_size)
>  		return 0;
> -	if (nbytes >= size)
> +	if (off + size > dev->cfg_size) {
> +		size = dev->cfg_size - off;
>  		nbytes = size;
> -	if (pos + nbytes > size)
> -		nbytes = size - pos;
> -	cnt = nbytes;
> +	}

Some of these boundary checks have issues on the sysfs side, where for some
offsets, a gratuitous pci_config_pm_runtime_get()/put() invocation would take
place, even though there would be no real work done.  Something to fix, too,
since you are looking to align both implementations.

> -	if ((pos & 1) && cnt) {
> +	if ((off & 1) && size) {
>  		unsigned char val;
>  		__get_user(val, buf);

Sashiko is complaining about __get_user() here.  However, the following
patch was sent recently, which aims to fix this (seems Syzkaller found
this, too):

  https://lore.kernel.org/linux-pci/20260502011446.125268-1-kartikey406@gmail.com/

If this one is accepted, then there is nothing to do here.  Otherwise, you
could consider moving to get_user(), etc., here, too.

> -	while (cnt >= 4) {
> +	while (size >= 4) {

This can still be aligned between here and sysfs.  Have a look there.

There is also the resource_is_exclusive() check on the sysfs side which
adds a warning and a taint when write is accessing some address ranges
which some driver claimed for itself.  procfs does not have this at the
moment (not sure if on purpose or it simly wasn't ever added).

Thank you!

	Krzysztof
