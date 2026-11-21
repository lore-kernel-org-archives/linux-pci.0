Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795219923;
	b=glB2z3SkTCAxLwd9bPYjuAli48OFnxabIAUjs+UVYRWgoZifLZ2na7boOUOzH+F30bYz
	 +fv98vOQXe0F/NppTneLbQstBOsKkg4b4k5NXrjhe/NlFkwZ4EXB44JctWuSG5lUBAKCh
	 OGPWegDHAUBu7eaiud0KlDIfcB/vHTlux3B5/9ah5KBDsIrmKoycoepaqvkhdzt3VYK0L
	 72rstg56MomWPsxLeZsNmwqHIbOXAAPcpRkzPlvR8hrno7BiETv2WFamQG63RrZyASwnr
	 OzCbrLukAXlw823BJfwTaPlm76KgEYPoJ3sJxjxjjgqngOem/LP4i1ERwGFxuLRGuYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795219923;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NzwLQl4ULlQo4LJCHP83ov7E+NUDnhifx6wD3YdHpmY=;
	b=2e/hflWMuZY1ls573myd/7JvQhSM4CkZnda7265vl6GdX8/YopryyT7+eqENEDIokE7S
	 hung6dM8itwqv2b7jQi9N7pkSfyX62HnaakUd01Kfde/hXUiduiUZzUjZDMgOxtbpMEor
	 LxqYPCXFdLqVtEmBI6OfX2++qQFj++RZ9M7Ji9w5sONXy0pRNpKDQbkaqjez+vLrovU5r
	 kW0I5zO8kv7wx4mdamgrqYRMawFs1Q8WjtYQLIIGHdzHmrT6IJ4yy36yu7B97AqmrvdYE
	 azHgMzZLEJWU7MyKJ7thIdfJUL4ANsmmzs8QESgw2A2bQgLXtVnmr38NTwXqwJjHx5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBDAa+cq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0948606A6B6;
	Sat, 21 Nov 2026 00:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBDAa+cq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587EE1F000EC;
	Sat, 21 Nov 2026 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795219923;
	bh=NzwLQl4ULlQo4LJCHP83ov7E+NUDnhifx6wD3YdHpmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TBDAa+cq5rJnWSsfMrKZr9M86BTePT6LZ8kFHo31pwcoTPusxSlIS1N5G+lbG+Qzp
	 A9vvBvRvc5wslN23SukG8HAm2Uq96nmFH14F9LP9PVGa59ad/3YjO59w+cu2jlu7N0
	 3xGnnOaUSJwiLr97qDS2KAfVhJ4+1FkXqzJjCDIA7ZM0vYNE/GWcTCozHNPiFyh1t2
	 JYrb9ps/7eL44BRuOWnFQUYT7kpcumqQW11RKM6LC+Ubg81h4N2wubEyNMtwYIuXeX
	 LG+x3V3sjeWicL6xVuqPF5Ws1XfeLmJXpqJPm/AnGDuRJnfE9j+otUL4JK4czEZ0Jw
	 cofH6pDniqiLg==
Date: Fri, 20 Nov 2026 18:12:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jon Pan-Doh <pandoh@google.com>
Subject: Re: [PATCH 2/4] PCI/AER: Clamp negative ratelimit burst to zero
Message-ID: <20261121001202.GA917755@bhelgaas>
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
In-Reply-To: <20261120211307.GA1524494@yaz-khff2.amd.com>

On Fri, Nov 20, 2026 at 04:13:07PM -0500, Yazen Ghannam wrote:
> On Fri, Nov 20, 2026 at 12:10:43PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 10, 2026 at 03:56:12PM -0600, Yazen Ghannam wrote:
> > > The correctable and nonfatal "_ratelimit_burst" attributes store
> > > whatever kstrtoint() parses, so a negative value lands directly in
> > > ratelimit_state.burst.
> > > 
> > > ___ratelimit() reads a negative burst as an uninitialized
> > > ratelimit_state and gives a WARNing.
> > > 
> > > Clamp negative values to zero and document the clamping behavior.
> > > ...
> > 
> > > Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smtp.kernel.org/
> > > Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> > > ---
> > >  .../ABI/testing/sysfs-bus-pci-devices-aer     | 21 ++++++++++++-------
> > >  drivers/pci/pcie/aer.c                        |  3 +++
> > >  2 files changed, 17 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > index 5ed284523956..215cf8bd4c30 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > +++ b/Documentation/ABI/testing/sysfs-bus-pci-devices-aer
> > > @@ -130,9 +130,10 @@ What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_interval_ms
> > >  Date:		May 2025
> > >  KernelVersion:	6.16.0
> > >  Contact:	linux-pci@vger.kernel.org
> > > -Description:	Writing 0 disables AER correctable error log ratelimiting.
> > > -		Writing a positive value sets the ratelimit interval in ms.
> > > -		Default is DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > > +Description:	Writing 0, or any negative value, disables AER correctable
> > > +		error log ratelimiting. Writing a positive value sets the
> > > +		ratelimit interval in ms. Default is
> > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > >  
> > >  What:		/sys/bus/pci/devices/<dev>/aer/correctable_ratelimit_burst
> > >  Date:		May 2025
> > > @@ -143,14 +144,17 @@ Description:	Ratelimit burst for correctable error logs. Writing a value
> > >  		before ratelimiting. Reading gets the current ratelimit
> > >  		burst. Default is DEFAULT_RATELIMIT_BURST (10).
> > >  
> > > +		Writing 0, or any negative value, suppresses all logs
> > > +		unless the interval attribute is also 0.
> > > +
> > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_interval_ms
> > >  Date:		May 2025
> > >  KernelVersion:	6.16.0
> > >  Contact:	linux-pci@vger.kernel.org
> > > -Description:	Writing 0 disables AER non-fatal uncorrectable error log
> > > -		ratelimiting. Writing a positive value sets the ratelimit
> > > -		interval in ms. Default is DEFAULT_RATELIMIT_INTERVAL
> > > -		(5000 ms).
> > > +Description:	Writing 0, or any negative value, disables AER non-fatal
> > > +		uncorrectable error log ratelimiting. Writing a positive
> > > +		value sets the ratelimit interval in ms. Default is
> > > +		DEFAULT_RATELIMIT_INTERVAL (5000 ms).
> > >  
> > >  What:		/sys/bus/pci/devices/<dev>/aer/nonfatal_ratelimit_burst
> > >  Date:		May 2025
> > > @@ -161,3 +165,6 @@ Description:	Ratelimit burst for non-fatal uncorrectable error logs.
> > >  		allowed per interval before ratelimiting. Reading gets the
> > >  		current ratelimit burst. Default is DEFAULT_RATELIMIT_BURST
> > >  		(10).
> > > +
> > > +		Writing 0, or any negative value, suppresses all logs
> > > +		unless the interval attribute is also 0.
> > > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > > index 6f2460231422..401cd3a1b3d0 100644
> > > --- a/drivers/pci/pcie/aer.c
> > > +++ b/drivers/pci/pcie/aer.c
> > > @@ -752,6 +752,9 @@ const struct attribute_group aer_stats_attr_group = {
> > >  		if (kstrtoint(buf, 0, &burst) < 0)			\
> > >  			return -EINVAL;					\
> > >  									\
> > > +		if (burst < 0)						\
> > > +			burst = 0;					\
> > 
> > Why don't we just return -EINVAL if the user writes a negative value
> > to either *_ratelimit_interval_ms or *_ratelimit_burst?
> > 
> > I don't think there's any reasonable interpretation of negative
> > values in either case.
> 
> Right, that's fair. I think the reason to clamp was to be consistent
> with the current code.
> 
> Would you like a follow up patch?
> 
> > Any non-negative value for the interval makes sense (0 disables).
> > 
> > Any positive value makes sense for burst; I don't know what a 0 burst
> > value could mean, so maybe that should be an error too?
> 
> "burst == 0" came from here:
> 084a990ded63 ("ratelimit: Allow zero ->burst to disable ratelimiting")
> 
> IIUC, the goal is to **always** hide/disable the messages. IOW, keep
> logging the errors internally based on the interval, but don't print any
> kernel messages for them. The user can still get the error logs from the
> trace event and leave the kernel buffer alone.

OK, so burst==0 should have the "usual" semantics (disable
ratelimiting IIUC).

Can we make a replacement for this patch?

  - Return -EINVAL for negative values written to either
    *_ratelimit_interval_ms or *_ratelimit_burst 

  - I think the existing *_ratelimit_interval_ms documentation would
    be fine, no change required

  - *_ratelimit_burst documentation needs something, but I don't know
    what.  084a990ded63 ("ratelimit: Allow zero ->burst to disable
    ratelimiting") suggests that burst==0 disables ratelimiting, but 
    you wrote "suppresses all logs", which sounds like the opposite of
    disabling ratelimiting.

    Also, I don't know what "unless the interval attribute is also 0"
    means.  What *does* happen when interval==0 and burst==0?

The pci/aer branch is mutable, so we can just replace the existing
patch.
