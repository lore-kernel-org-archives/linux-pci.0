Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DC3603EF;
	Fri,  8 May 2026 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249149; cv=none; b=NDwRVMskwTBNUavCBLp2cc5qvioLTCUzvQl5PbeEC8fHhyFavyED3GNGcvKupGZ0Qy5ngsYySvC6BC5ahwGu4uZOv+vZOW1lvUOrmj7faDd6l2jWIImQbcE2+BiqpGmJeQ+3lt1OXeqFLdMsmkxUpiKtxY+v+42Vt16vJSzSeUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249149; c=relaxed/simple;
	bh=fLSWRhFbte/FoGtd3CLl6kuuzR05q0bVJXMtb8/dZoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4mwC2jKK5s9xksZqW/Rm/sHBdecUUOo7scYaJR/X92Sra8rJyxbl1RsA7HeSPqm3/iZ6uHjlkQUx/3R3fftGJ1s8isYjC0GWkWH0VhuepAcmt2LtRsJQ0LunbyMdEKLm2+5SUi+WY5oDTKtwvCiCiWyV7n+bn+7zeURUnYFIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azCZp9bY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azCZp9bY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E422C2BCB0;
	Fri,  8 May 2026 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778249148;
	bh=fLSWRhFbte/FoGtd3CLl6kuuzR05q0bVJXMtb8/dZoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=azCZp9bY7pIL0ZVlrNrdlWPTXcJv4fzF9Uk04rSH3jltcVSM+ccR6e/ow/l5kyVo3
	 y468mDk1Zo30ojuwGUsq38OEQiyh+PP92U6wEgTcMRkAdObaeSb/c9NOYHTCID/5xv
	 uAZL1s7VndRqTfTfIdVIxI3IEUD0O12zPgaQIuzxM6QDfrOoyYv22skmC4Cdy2/Ht2
	 V6IhZOMrWMkeAMxfeu9RHeyWqkrHKkRI4dnFjh69j8LK3CEYPUfX8Q5GOaCBFMhkX2
	 f2Ojgg6uXgvvBXMqB6ckowC8LrYsS9GqML1aTWS/KBd+sMEu68RegCFAfO+t7FwxHC
	 1cI4uq/BeT/wQ==
Date: Fri, 8 May 2026 15:05:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 djbw@kernel.org, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com,
 corbet@lwn.net, rafael@kernel.org, xueshuai@linux.alibaba.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v17 02/11] cxl/ras: Unify Endpoint and Port AER trace
 events
Message-ID: <20260508150533.04e19cf9@jic23-huawei>
In-Reply-To: <8913c666-a343-4717-8ab2-0b8546d1bdfb@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
	<20260505173029.2718246-3-terry.bowman@amd.com>
	<20260507190836.70197e24@jic23-huawei>
	<8913c666-a343-4717-8ab2-0b8546d1bdfb@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 13:33:45 -0500
"Bowman, Terry" <terry.bowman@amd.com> wrote:

> On 5/7/2026 1:08 PM, Jonathan Cameron wrote:
> > [Some people who received this message don't often get email from jic23@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Tue, 5 May 2026 12:30:20 -0500
> > Terry Bowman <terry.bowman@amd.com> wrote:
> >   
> >> From: Dan Williams <djbw@kernel.org>  
> > 
> > +CC Mauro - rasdaemon related - see below.
> >   
> >>
> >> CXL protocol error logging uses two parallel sets of trace events. The
> >> cxl_port_aer_correctable_error() and cxl_port_aer_uncorrectable_error()
> >> events are used by CPER for CXL Port devices. The cxl_aer_correctable_error()
> >> and cxl_aer_uncorrectable_error() events are used for CXL Endpoints. Update
> >> the trace routines to use the latter for all CXL devices on both the CPER
> >> and native AER paths.
> >>
> >> Generalize cxl_aer_correctable_error()/cxl_aer_uncorrectable_error to
> >> take a struct device * and a u64 serial argument supplied by the caller.
> >> cxl_handle_ras() and cxl_handle_cor_ras() gain the new u64 serial parameter,
> >> sourced from pci_get_dsn().
> >>
> >> The CPER path keeps its existing Port-vs-Endpoint dispatch and passes the
> >> new arguments to the unified trace events. The CPER path will be folded
> >> together in a following patch.
> >>
> >> Remove the now-unused cxl_port_aer_correctable_error() and
> >> cxl_port_aer_uncorrectable_error().
> >>
> >> **WARNING: ABI BREAK**
> >> Rename the trace event field "memdev" to "device" so all CXL device types
> >> (Ports and Endpoints) can be reported under a common field name. Note this
> >> is an ABI break for userspace tools that key off the old "memdev" field.
> >> Specifically, rasdaemon's ras-cxl-handler.c looks up "memdev" and bails on
> >> NULL, so an unmodified rasdaemon will drop every CXL CE/UCE event once this
> >> kernel ships. A rasdaemon update is needed in a separate series.
> >>
> >> The need for the field rename was discussed in v16 review [1].  
> > 
> > This concerns me (sorry I wasn't paying attention to the v16 thread).
> > It is a userspace regression against code that is out in the wild and typically
> > not updated in sync with the kernel.
> > 
> > If you are suggesting breaking ras-daemon at the very least +CC the maintainer.
> > 
> > To get to a unified tracepoint add a new one that does what you want, but
> > maintain the existing ones as well.  Userspace can then migrate and maybe
> > in 5+ years time we can delete the non unified ones.
> > 
> > No actually comments on the code, just left it all here for Mauro,
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Dan was clear about using a single set of CE and UE handlers for all CXL RAS 
> protocol errors. While I understand there may be concerns, please direct any 
> objections to Dan and clarify what changes are required to avoid this 
> repeatedly going back and forth.
> 
> [1] https://lore.kernel.org/linux-cxl/69cb2d5ba3111_178904100b7@dwillia2-mobl4.notmuch/

Sure - Dan's on this thread so I'm sure he'll see it sooner or later.

Perhaps I'm missing something that makes this less critical than it appears.

You can have a single set of handlers, but at the point of spitting the actual
tracepoints out we need to keep spitting the old ones (+ possibly a new unified
one if you want to one day get rid of the separation.)  Bit fiddly but seems
unlikely to be that bad.  e.g. put a wrapper where you currently have
trace_cxl_aer_uncorrectable_error() and have that omit the new and old (based
on device type) tracepoints.  Then when we eventually drop this after enough
years that we can be sure the new one is in use, the code cleanup is all in
one place.

Note this issue isn't a "maybe" thing - we are talking userspace ABI breakage
in an interface known to be in use in commonly used software that is not
typically updated in time with the kernel cadence.  There have been arguments
that some trace points are not 'stable' but that definitely isn't the case for
the RAS ones which are the main interface from kernel to userspace tooling.

In theory you could make such a change and maybe get away with it (on basis
a regression only exists if anyone notices) but you'd need ALL the distros
on board that ship rasdaemon + if you really don't want to end up reverting
you'd have to work closely with the hyperscalers who might decide to throw a
'regression + revert' request at the list which either means a scramble to
put in place what I describe above, or this series being reverted.  Note there
are downstream forks of rasdaemon to content with as well.

That pain just isn't worth it.

Mauro, any idea if any distros scan for RAS tracepoints for compatibility breakage?
They probably should like they do of ioctls and similar but no idea if anyone
actually does yet.  If they do we'd get the revert request pretty quickly...
If not we get to wait for some one to hit it in a functional test 
- thankfully RAS paths are definitely in those test sets but they tend to
run later and hence when a revert / fix is more painful.

Jonathan

