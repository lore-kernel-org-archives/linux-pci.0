Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795477141;
	b=FbnPEBZ3xTr0ZusvMD2/LYfeIConJr8adCXP+8llvCxCSG7IFR/XjESvPnxlCUP/zDqk
	 ZYk/XqJEBnH4r/QT++67iOdsytzTZs5z8JJXpwT2wneWxVFLHGNyJub8Z88T5qps2J3Cm
	 +rJf0PG1HxUfdBl1xqfMsXE7vM/M1VdyQKIu6JARZsRVJvQyBAqZUNLipGvX7git8dAge
	 T2nnb7xjo44eE36oun/WLJi0JJS7Suw7fuVDLn38eceGhRzf+9tSg19FZj3SaG12iYZ6e
	 jGEeA5v/eJpxF9EQm8hi+e1C932tg75WMJA39NlPSQO6LPItigQcLDBf6PV1qb1vxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477141;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qjO6Sro+kkot/CXJkVtro+u1s9e/UqIOwqJIGnSgPrQ=;
	b=NyHqf2LRJfnelZKdUpqRuJCQfPUzTlBrQpPoZBLnpLt2pljXHQbavTCba5gqEsYL57DT
	 ijDDIk8MD+einohAEcdsWC0JOWIJGI9JVRLJ70gz6FAPCMdzgLaukYnSaS2mfEKhe8LtX
	 Y+z1JCkyeAhVqDFjZ3CfXF7OAP/ZC+YwAfSVIWxBobToN/vnaq6QvhE3rWVb7b6BPHJjv
	 7nUfhj2bvz/RmbD07zfzr2Wrt1IzsEevwP2gt4WKQHiqAYDVzptDfEwnERl/wmtmejMif
	 gPXjGux4MiHSwx4RaW2iWJGOVSIUpXxrqgywokpIE1a5Jc965pULQ+ldKPcXwRn7D3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bx1I1XPv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28913606A31E;
	Mon, 23 Nov 2026 23:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bx1I1XPv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6901F1F000C4;
	Mon, 23 Nov 2026 23:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477140;
	bh=qjO6Sro+kkot/CXJkVtro+u1s9e/UqIOwqJIGnSgPrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=bx1I1XPvvUamhT9t3ZhqQPFKJlpys5hQwY6Au1NMilDu7XkGaRwEFoaa8s7KvRuNJ
	 SbsYX0B/P1DVzr4/NehWpdhgs9pSDOZvplHzuOkseqaTdZu5JyyQv1AIw1vQOmDfH4
	 ThkEkYsjAhedS3KtY4N2dK/+wT3jvBeJRX6iRIRVEYOX/Lz/OLqvpgVPgyHxeuNho1
	 FdIJ8kXVZT0TfAUPp6EcYSM0tNRN+ymfdAehG0/SOUX5FO0OHZlnhSBoL1sBB3n75U
	 rk+TOwudJyu7Ns65LQL445mLsb9jp7T73mRyQA89rS266ySxUhJ+KRvTYfnvMgjcOf
	 iBLTG8DSd+zMw==
Date: Mon, 23 Nov 2026 17:38:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Message-ID: <20261123233859.GA1120797@bhelgaas>
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
In-Reply-To: <20261123165050.GA1741477@yaz-khff2.amd.com>

On Mon, Nov 23, 2026 at 11:50:50AM -0500, Yazen Ghannam wrote:
> On Fri, Nov 20, 2026 at 06:12:02PM -0600, Bjorn Helgaas wrote:
> > On Fri, Nov 20, 2026 at 04:13:07PM -0500, Yazen Ghannam wrote:
> > > On Fri, Nov 20, 2026 at 12:10:43PM -0600, Bjorn Helgaas wrote:
> > > > On Tue, Nov 10, 2026 at 03:56:12PM -0600, Yazen Ghannam wrote:
> > > > > The correctable and nonfatal "_ratelimit_burst" attributes store
> > > > > whatever kstrtoint() parses, so a negative value lands directly in
> > > > > ratelimit_state.burst.
> > > > > 
> > > > > ___ratelimit() reads a negative burst as an uninitialized
> > > > > ratelimit_state and gives a WARNing.
> > > > > 
> > > > > Clamp negative values to zero and document the clamping behavior.
> > > > > ...
> > > > 
> > > > > Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> > > > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > > > Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> > > > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > > > ---
> > > > >  .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
> > > > >  drivers/pci/pcie/aer.c                        |  3 +++
> > > > >  2 files changed, 17 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > > index 5ed284523956..215cf8bd4c30 100644
> > > > > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > > > @@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
> > > > >  Date:		May 2025
> > > > >  KernelVersion:	6.16.0
> > > > >  Contact:	linux-pci@vger.kernel.org
> > > > > -Description:	Writing 0 disables AER correctable error log ratelimiting.
> > > > > -		Writing a positive value sets the ratelimit interval in ms.
> > > > > -		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > > > +Description:	Writing 0, or any negative value, disables AER correctable
> > > > > +		error log ratelimiting. Writing a positive value sets the
> > > > > +		ratelimit interval in ms. Default is
> > > > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > > >  
> > > > >  What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
> > > > >  Date:		May 2025
> > > > > @@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
> > > > >  		before ratelimiting. Reading gets the current ratelimit
> > > > >  		burst. Default is DEFAULT_RATELIMIT_BURST (10).
> > > > >  
> > > > > +		Writing 0, or any negative value, suppresses all logs
> > > > > +		unless the interval attribute is also 0.
> > > > > +
> > > > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
> > > > >  Date:		May 2025
> > > > >  KernelVersion:	6.16.0
> > > > >  Contact:	linux-pci@vger.kernel.org
> > > > > -Description:	Writing 0 disables AER non-fatal uncorrectable error log
> > > > > -		ratelimiting. Writing a positive value sets the ratelimit
> > > > > -		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
> > > > > -		(5000 ms).
> > > > > +Description:	Writing 0, or any negative value, disables AER non-fatal
> > > > > +		uncorrectable error log ratelimiting. Writing a positive
> > > > > +		value sets the ratelimit interval in ms. Default is
> > > > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > > >  
> > > > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
> > > > >  Date:		May 2025
> > > > > @@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
> > > > >  		allowed per interval before ratelimiting. Reading gets the
> > > > >  		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
> > > > >  		(10).
> > > > > +
> > > > > +		Writing 0, or any negative value, suppresses all logs
> > > > > +		unless the interval attribute is also 0.
> > > > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > > > index 6f2460231422..401cd3a1b3d0 100644
> > > > > --- a/drivers/pci/pcie/aer.c
> > > > > +++ b/drivers/pci/pcie/aer.c
> > > > > @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
> > > > >  		if (kstrtoint(buf, 0, &burst) < 0)			\
> > > > >  			return -EINVAL;					\
> > > > >  									\
> > > > > +		if (burst < 0)						\
> > > > > +			burst = 0;					\
> > > > 
> > > > Why don't we just return -EINVAL if the user writes a negative value
> > > > to either *_ratelimit_interval_ms or *_ratelimit_burst?
> > > > 
> > > > I don't think there's any reasonable interpretation of negative
> > > > values in either case.
> > > 
> > > Right, that's fair. I think the reason to clamp was to be consistent
> > > with the current code.
> > > 
> > > Would you like a follow up patch?
> > > 
> > > > Any non-negative value for the interval makes sense (0 disables).
> > > > 
> > > > Any positive value makes sense for burst; I don't know what a 0 burst
> > > > value could mean, so maybe that should be an error too?
> > > 
> > > "burst == 0" came from here:
> > > 084a990ded63 ("ratelimit: Allow zero ->burst to disable ratelimiting")
> > > 
> > > IIUC, the goal is to **always** hide/disable the messages. IOW, keep
> > > logging the errors internally based on the interval, but don't print any
> > > kernel messages for them. The user can still get the error logs from the
> > > trace event and leave the kernel buffer alone.
> > 
> > OK, so burst==0 should have the "usual" semantics (disable
> > ratelimiting IIUC).
> > 
> > Can we make a replacement for this patch?
> > 
> >   - Return -EINVAL for negative values written to either
> >     *_ratelimit_interval_ms or *_ratelimit_burst 
> > 
> >   - I think the existing *_ratelimit_interval_ms documentation would
> >     be fine, no change required
> > 
> >   - *_ratelimit_burst documentation needs something, but I don't know
> >     what.  084a990ded63 ("ratelimit: Allow zero ->burst to disable
> >     ratelimiting") suggests that burst==0 disables ratelimiting, but 
> >     you wrote "suppresses all logs", which sounds like the opposite of
> >     disabling ratelimiting.
> > 
> >     Also, I don't know what "unless the interval attribute is also 0"
> >     means.  What *does* happen when interval==0 and burst==0?
> > 
> > The pci/aer branch is mutable, so we can just replace the existing
> > patch.
> 
> No, burst==0 is the extreme opposite of disable ratelimiting. It's
> basically a mute button.
> 
> "Interval" takes precedences, so interval==0 means burst is "don't
> care".
> 
> The three scenarios:
> No ratelimiting (interval==0, burst==X) => show every message.
> Ratelimiting (interval>0, burst>0) => show messages based on settings.
> "Total" limiting (interval>0, burst==0) => *never* show messages.
> 
> I guess a user could tune the settings to get to certain level of
> "quiet". But there isn't a way to 100% filter/hide the messages. The
> burst==0 setting gives that option.
> 
> What do you think?

I think the patch below is great, but should be split into "reject
negative burst" and "update documentation" patches since the negative
part is trivial but the doc part is unrelated and will always be a
little confusing.

It's more work than I think it should be to integrate "interval" and
"burst," partly because the "interval" documentation refers to
"ratelimiting" while "burst" refers to "messages."  And we mix "0" and
"zero."  Maybe something like this?

  correctable_ratelimit_interval_ms

    Writing 0 disables ratelimiting and prints all messages,
    regardless of burst.

  aer/correctable_ratelimit_burst

    Writing 0 never prints any messages (unless interval is also 0,
    which prints all messages regardless of burst)

> ================================
> 
> From 88cfa8ba46d3f212cb94679c3a8211ff15bdf678 Mon Sep 17 00:00:00 2001
> In-Reply-To: <20261121001202.GA917755@bhelgaas>
> References: <20261121001202.GA917755@bhelgaas>
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> Date: Mon, 23 Nov 2026 08:59:07 -0600
> Subject: [PATCH v2 2/4] PCI/AER: Reject negative ratelimit interval and burst
>  values
> 
> The AER "*_ratelimit_interval_ms" and "*_ratelimit_burst" sysfs
> attributes accept negative values. A negative interval is treated as
> 0, which disables ratelimiting. A negative burst is stored as is, and
> ___ratelimit() then warns about an uninitialized ratelimit_state.
> 
> However, a negative value has no meaningful interpretation for either
> attribute.
> 
> Return -EINVAL for negative input.
> 
> Also, document 'burst=0' behavior.
> 
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Replaces "PCI/AER: Clamp negative ratelimit burst to zero" on pci/aer.
> 
> v1->v2:
> - Return -EINVAL for negative interval and burst values instead of
>   clamping. (Bjorn)
> - Keep the original interval descriptions.
> - Describe what a burst of 0 does.
> 
> The rest of pci/aer applies on top. The only conflict is in "PCI/AER:
> Enable baseline capability error reporting", in the two interval
> descriptions. The resolution keeps Lukas's capitalization without
> "or any negative value":
> 
>   Writing 0 disables Correctable Error log ratelimiting.
>   Writing 0 disables Non-Fatal Uncorrectable Error log ratelimiting.
> 
> Tested in a QEMU guest with injected correctable and non-fatal errors,
> for every combination of interval {-1, 0, positive} and burst {-1, 0,
> positive}. Negative writes fail with -EINVAL. Every error is counted
> and traced. Interval 0 logs every error, whatever the burst. A positive
> interval with burst 0 logs none.
> 
> An LLM coding assistant helped check the ___ratelimit() semantics,
> draft the change, resolve the conflict and write the QEMU test.
> 
> v1: https://lore.kernel.org/r/20261110215614.3931232-3-yazen.ghannam@amd.com
> 
>  .../ABI/testing/sysfs-bus-pci-devices-aer          |  9 +++++++++
>  drivers/pci/pcie/aer.c                             | 14 +++++++++-----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> index 5ed284523956..e4c39839cc6a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> @@ -143,6 +143,10 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
>  		before ratelimiting. Reading gets the current ratelimit
>  		burst. Default is DEFAULT_RATELIMIT_BURST (10).
>  
> +		Writing 0 suppresses all correctable error log messages.
> +
> +		Burst value is only used when interval is greater than zero.
> +
>  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
>  Date:		May 2025
>  KernelVersion:	6.16.0
> @@ -161,3 +165,8 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
>  		allowed per interval before ratelimiting. Reading gets the
>  		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
>  		(10).
> +
> +		Writing 0 suppresses all non-fatal uncorrectable error log
> +		messages.
> +
> +		Burst value is only used when interval is greater than zero.
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6f2460231422..2c42d6e8bd9a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -690,7 +690,8 @@ const struct attribute_group aer_stats_attr_group = {
>  
>  /*
>   * Ratelimit interval
> - * <=0: disabled with ratelimit.interval = 0
> + * <0: rejected
> + * 0: disabled with ratelimit.interval = 0
>   * >0: enabled with ratelimit.interval in ms
>   */
>  #define aer_ratelimit_interval_attr(name, ratelimit)			\
> @@ -717,10 +718,10 @@ const struct attribute_group aer_stats_attr_group = {
>  		if (kstrtoint(buf, 0, &interval) < 0)			\
>  			return -EINVAL;					\
>  									\
> -		if (interval <= 0)					\
> -			interval = 0;					\
> -		else							\
> -			interval = msecs_to_jiffies(interval); 		\
> +		if (interval < 0)					\
> +			return -EINVAL;					\
> +									\
> +		interval = msecs_to_jiffies(interval);			\
>  									\
>  		pdev->aer_info->ratelimit.interval = interval;		\
>  									\
> @@ -752,6 +753,9 @@ const struct attribute_group aer_stats_attr_group = {
>  		if (kstrtoint(buf, 0, &burst) < 0)			\
>  			return -EINVAL;					\
>  									\
> +		if (burst < 0)						\
> +			return -EINVAL;					\
> +									\
>  		pdev->aer_info->ratelimit.burst = burst;		\
>  									\
>  		return count;						\
> -- 
> 2.55.0
> 
