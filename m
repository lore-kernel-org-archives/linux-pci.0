Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198245;
	b=minWgRbkkFhjWlTv2rhIvtHA9kk3MBNG07iUQCDpXP5mRlmO3s9n4kBqDo4AeUjHmeF8
	 JDI6csTjhS+4nwMOmR+/3rrCEeLDQEd0R4dikGa50PH1HU8uSOSe1WmdgjfnvcJZRl6OU
	 CFHynw1BnQARRFZidQ9pS44UD/8J7MOGuqdJJUfZCExdrrj//J/nHAvCR7LDWiZfPVWQE
	 omxOsZE9Uz+lxG/80zp+3ViLX/JMmxB8E+buKkeyMVFVCnsS9uqcmvSdMcJxLu+xc6Ukk
	 CFfKmBxBBw95MMJI2JuIGS7raOPnHIofTEvnELE7WhrChUWC929LSnjUM27eTe4lLYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198245;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SdOy/V/fPmkUI741doetA5qrJZn9z1hOq0V2f70oSXM=;
	b=AHodEOY5QfeEdtgSROHMHYLsk6pSLD93g8IiM3t12pEEi4PVbumEc1NQJl0B8F/4P+FT
	 KaD5W6MNSyRswnxqRxO1EA5vEama5JexX93ch/5u547bVuOe7/0wB+qkqdmh3q+2aK7Ci
	 85X7iGTfQkN2XtJaXjDBFl1c3rwHVdYZ83KS1EbI43EZxdCnq9wEzUys6zCNaLymfoeb2
	 Zc+l81b68tzxRwyMRT3EXYdzwcDYb/PgoareJubk0S1RLR0rWF3ZfqALH0O0FMrky17+0
	 9xHdRFUvTC94cJBzMB6byLPz/OV3mhC7OMI8TrTNtue77koShtyni3B/UYaL9YZASqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIxAU1NJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78466606D490;
	Fri, 20 Nov 2026 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VIxAU1NJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C861F000D0;
	Fri, 20 Nov 2026 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198245;
	bh=SdOy/V/fPmkUI741doetA5qrJZn9z1hOq0V2f70oSXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VIxAU1NJmwhnb/+qSGq2bRcekpjrxoBIMVIsxD8j1SRpPG3h5NtPlNZN/QZ38pC1m
	 9WbH1HTq5XZ1Zu2CFuaEsJ+m+/RWhvM3fS0NEcmXu2vY6yCEtKT8iLEzjOm/TFw7tF
	 3jQ2DMKJy+hvKBGL7zKlAvy8aaFJDKZGnaRl94+aQFFi43wEQM1JVjT7yYhSldl0K7
	 iCCWdpU5OQs+RK52Nsyt9LmbB3CuOyYUqFAD4IIp2Ckk9zAXqYbxOTuka/JRWtId2R
	 n6y5C1el6nZdMqxNhJ/nhsFG2Jf57dzqEu8j/mZjOkbdOzIeGiNAgm6P4pKBRrUuaA
	 Zg5hoMpWAhxAQ==
Date: Fri, 20 Nov 2026 12:10:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Message-ID: <20261120181043.GA900258@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110215614.3931232-3-yazen.ghannam@amd.com>

[+cc Lukas, Sathya, Jon]

On Tue, Nov 10, 2026 at 03:56:12PM -0600, Yazen Ghannam wrote:
> The correctable and nonfatal "_ratelimit_burst" attributes store
> whatever kstrtoint() parses, so a negative value lands directly in
> ratelimit_state.burst.
> 
> ___ratelimit() reads a negative burst as an uninitialized
> ratelimit_state and gives a WARNing.
> 
> Clamp negative values to zero and document the clamping behavior.
> ...

> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
>  drivers/pci/pcie/aer.c                        |  3 +++
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> index 5ed284523956..215cf8bd4c30 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> @@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
>  Date:		May 2025
>  KernelVersion:	6.16.0
>  Contact:	linux-pci@vger.kernel.org
> -Description:	Writing 0 disables AER correctable error log ratelimiting.
> -		Writing a positive value sets the ratelimit interval in ms.
> -		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> +Description:	Writing 0, or any negative value, disables AER correctable
> +		error log ratelimiting. Writing a positive value sets the
> +		ratelimit interval in ms. Default is
> +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
>  
>  What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
>  Date:		May 2025
> @@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
>  		before ratelimiting. Reading gets the current ratelimit
>  		burst. Default is DEFAULT_RATELIMIT_BURST (10).
>  
> +		Writing 0, or any negative value, suppresses all logs
> +		unless the interval attribute is also 0.
> +
>  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
>  Date:		May 2025
>  KernelVersion:	6.16.0
>  Contact:	linux-pci@vger.kernel.org
> -Description:	Writing 0 disables AER non-fatal uncorrectable error log
> -		ratelimiting. Writing a positive value sets the ratelimit
> -		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
> -		(5000 ms).
> +Description:	Writing 0, or any negative value, disables AER non-fatal
> +		uncorrectable error log ratelimiting. Writing a positive
> +		value sets the ratelimit interval in ms. Default is
> +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
>  
>  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
>  Date:		May 2025
> @@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
>  		allowed per interval before ratelimiting. Reading gets the
>  		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
>  		(10).
> +
> +		Writing 0, or any negative value, suppresses all logs
> +		unless the interval attribute is also 0.
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6f2460231422..401cd3a1b3d0 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
>  		if (kstrtoint(buf, 0, &burst) < 0)			\
>  			return -EINVAL;					\
>  									\
> +		if (burst < 0)						\
> +			burst = 0;					\

Why don't we just return -EINVAL if the user writes a negative value
to either *_ratelimit_interval_ms or *_ratelimit_burst?

I don't think there's any reasonable interpretation of negative
values in either case.

Any non-negative value for the interval makes sense (0 disables).

Any positive value makes sense for burst; I don't know what a 0 burst
value could mean, so maybe that should be an error too?

>  		pdev->aer_info->ratelimit.burst = burst;		\
>  									\
>  		return count;						\
> -- 
> 2.55.0
> 
