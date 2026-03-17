Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938FE1531C1
	for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2026 01:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773712678; cv=none; b=aTeWkDsAHBoEPF4hQTyOXOyVzL4QU0D5ZNmefFXTcBrmXw3Q6mrhOnzUdaLUsoJkXRT3TiFbbUgIcE+gLtRwbjArdpRij96Sm4lf2i0xZdJGMF9kCdlaNrdFBKDpSwhsm5dShxbQl3Q8msxiaLRSDKMHtZpP2Hahku6LUQlLdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773712678; c=relaxed/simple;
	bh=7MpELMYCpDZrto/sJnAaeAjtODZchMxfHU9Ae4AeTJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrcKIIOxpqGaWLPuPquL/4OZYVQIM2NFZ76cL1VLdQ30cvMoZP0YaBh1ndCgOyJV37xBx59eRCnD9KAn72mTvRcbKtnG+4DX6ssnTR5e54vdkzjSNIzduAc5bXOrGKsiLuY5MAoxSfRooqqtdB/ycsZ59EaeJ1OqYTVLOq203z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSc8ee9M; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSc8ee9M"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-128ef6c4a41so2350718c88.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2026 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773712676; x=1774317476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzJF+Nrs7fU1Fx3AHrnKIZxJXvNQKPoV9xU43VoH68k=;
        b=aSc8ee9MKt1vTew7jvuOk8KaWFp+w5zk/j6nY4pavgknhbmKvPpyOQZGdd7uiNX2di
         ty/BU0CS6HAY4N+HU7yUlDWXeev40G67lwOtvBeUpSkAXm7GRvpRrbKo+NF5GSrB3RkH
         oZ2yms/pq+YOEyaMbFRTYMhtbNJKC2Nj3RV7bmB4lXX/ey9Hb3PoNvYeEIctzKGEW3Yn
         /1XBm4Hr/UniW6UeBqWeXjNHLMQKA0l1FHeU2giRWkLM4NxXjgjMqdVaiL2tB7tE5ZD8
         skt5+0lsmkYy04uwVVN/hDontMxs6AjKgAKSOQfzFW3nCQPw38gQvECXZLceNFITu03p
         ay3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773712676; x=1774317476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SzJF+Nrs7fU1Fx3AHrnKIZxJXvNQKPoV9xU43VoH68k=;
        b=JDDH4nAUGZyZJe1JspVoFG7K2NR4T541stLAkn+GUp68V1+6tOhxejL+ZhQJueYgHW
         W0SRccU6CaWKH/KAUvdv1XJ2BIz2sikgQc+p60MG3xwcQNPKqJd/dX5VTJwDOVBWFP1J
         03O/ffuV6LJ9howZNloWus4QJWtPO1APIn0XAXFRKXcGAffhWa6ZatTHSFOF0qdzyHHp
         fa/Thnh2GzA17hHOOzuFeGANjPdAQY+xo3DWJHFCouuHJ34j9qM/8a80uaWhnThilGOb
         dSuN7ryuPeIT3RP4bKQNLw7Bz1w041AeaG/+bWYkYn7fhOUSRKlQMqVHLxKnwcb7rL9s
         jbIA==
X-Forwarded-Encrypted: i=1; AJvYcCVKTYGJzly3IBNE77WrRhtP8dpEonH7hj7JRRGZ/kW35ritrrfZzF7EUsIxE88GURY0vYoKPDwR0a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvSSVjjhKJh06F5wLDL/z1M+yus57surdntoY2OMkRlut/0jii
	/U+9l9GVrzZhdecrVyHGeEyRfJoTBhTY0qP4CRVsixor6t1QEXbjDZ26
X-Gm-Gg: ATEYQzxHCmNA1uQ510URjY2PTvkpF5o67nzjpcF3+n2zO39jmJ6RSJzx9TbUSYDZ2TZ
	Ty9eceetNcHShDRtgVjUUpybt7brHxtGnjvClJIPoJgHIggOCA3zPSqzT1cE0ujf/uU43kqc7Pk
	lDHeS6KrmLORtb2m04LnmvZqt2xRz/2DtTw7jU1xHNntRdOd89NvWm8UJttSbX6/3f4Op9yTKrR
	v7CzLPZlJIeRh2E+hbossVV+2PF6JD4vQbeoDkbTgXA4ZOCt5pTqF4MoU1gndXmnChgEJfb3vpd
	m5EbuiiGIDWJWdw/1+UFUKJzMfakHWdg1nCWx2EvJlUDwTy1ZP+BZK+kzSP1JIOvr9OUXG9+Scx
	yZjIGHj5kLs2uVv6qrK/4VLBUpNNynno6GBaX2CEgBu4/lQ6YIFuFfo8+I19vFV4jEcBSjez5lj
	gyK3vWu91PRIBfr9PajoZ5Rd9asNHssptTFbMJWks8f++1zzM=
X-Received: by 2002:a05:7022:1a85:b0:128:d6c3:9b18 with SMTP id a92af1059eb24-128f3d0dcedmr6342292c88.3.1773712675506;
        Mon, 16 Mar 2026 18:57:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0bded43e2sm8677080eec.9.2026.03.16.18.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:57:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Mar 2026 18:57:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Keith Busch <kbusch@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI/IOV: Fix race between SR-IOV enable/disable
 and hotplug
Message-ID: <0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net>
References: <20251216-revert_sriov_lock-v3-0-dac4925a7621@linux.ibm.com>
 <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216-revert_sriov_lock-v3-2-dac4925a7621@linux.ibm.com>

Hi,

On Tue, Dec 16, 2025 at 11:14:03PM +0100, Niklas Schnelle wrote:
> Commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when
> enabling/disabling SR-IOV") tried to fix a race between the VF removal
> inside sriov_del_vfs() and concurrent hot unplug by taking the PCI
> rescan/remove lock in sriov_del_vfs(). Similarly the PCI rescan/remove
> lock was also taken in sriov_add_vfs() to protect addition of VFs.
> 
> This approach however causes deadlock on trying to remove PFs with
> SR-IOV enabled because PFs disable SR-IOV during removal and this
> removal happens under the PCI rescan/remove lock. So the original fix
> had to be reverted.
> 
> Instead of taking the PCI rescan/remove lock in sriov_add_vfs() and
> sriov_del_vfs(), fix the race that occurs with SR-IOV enable and disable
> vs hotplug higher up in the callchain by taking the lock in
> sriov_numvfs_store() before calling into the driver's sriov_configure()
> callback.
> 
> Cc: stable@vger.kernel.org
> Fixes: 05703271c3cd ("PCI/IOV: Add PCI rescan-remove locking when enabling/disabling SR-IOV")
> Reported-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/iov.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 7de5b18647beb69127ba11234fb9f1dec9b50540..4a659c34935e116dd6d0b4ce42ed12a1ba9418d1 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -495,7 +495,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  
>  	if (num_vfs == 0) {
>  		/* disable VFs */
> +		pci_lock_rescan_remove();
>  		ret = pdev->driver->sriov_configure(pdev, 0);
> +		pci_unlock_rescan_remove();
>  		goto exit;
>  	}
>  
> @@ -507,7 +509,9 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  		goto exit;
>  	}
>  
> +	pci_lock_rescan_remove();
>  	ret = pdev->driver->sriov_configure(pdev, num_vfs);
> +	pci_unlock_rescan_remove();
>  	if (ret < 0)
>  		goto exit;
>  
Google's experimental AI review agent provided the following feedback
on this patch.

  Could this introduce an AB-BA deadlock between the device lock and the
  rescan/remove lock?

  Earlier in sriov_numvfs_store(), device_lock(&pdev->dev) is acquired. The
  patch then attempts to acquire pci_lock_rescan_remove() while holding the
  device lock.

  However, during a hotplug removal of the PF (for example, via sysfs),
  remove_store() first acquires pci_lock_rescan_remove() and subsequently
  calls pci_stop_and_remove_bus_device_locked(). That path eventually calls
  device_release_driver(), which attempts to acquire device_lock(&pdev->dev).

  If sriov_numvfs_store() and a concurrent removal of the PF race, it appears
  they could deadlock waiting on each other's locks.

The actual call sequence (at least in v6.12.y, where this patch was
backported to) is as follows.
  remove_store()
  -> pci_stop_and_remove_bus_device_locked()
     -> pci_lock_rescan_remove()
        -> pci_stop_and_remove_bus_device()
	   -> pci_stop_bus_device()
	   -> pci_remove_bus_device()
	      -> pci_remove_bus()
	         -> device_unregister()
		    -> device_del()
		       -> device_lock()

I don't claim to fully understand the code, but the AI does seem to have a
point. Please let me know if the AI analysis is correct or if it misses
something.

Thanks,
Guenter
