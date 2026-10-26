Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793017367;
	b=kkPfD9XWE4KX8J5FF9ZirKPHoE52gORcnt9Ierv9j1L6y845hBsEUAvpyzC/phIqIt7X
	 mpaoybLSC3jbNAPNwWCG0iO6zU7OacjS+eSMIurhLxF/wlFHuDRW7o6XMozJY5dXZjBgk
	 2FOze8UP/S74s82lWWxybxPAfTwcUubQMAkaUvIguYUOi75wfzpDXCR3eDK6BP8hHovxg
	 W/5h++LcdmerbCTSJEtz8oaaZ1I5Lqulc2F/PCMq64Jpv9ffXgvMVAHMVYBdBhoV+YQQt
	 geQkqW7JdVg3X6YoPPD/mBJUiEjyN+2fxjQh2YNYOPt9h/u4MDL0wT+7GxtKkXztdkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793017367;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=RRJWtqm2l0xH+h0URe8qzmm/igRf8rcF8bV+QoG3lFA=;
	b=Evm2a/W1yT+PfN9tKB8CXkxlQMVP9Uxk2wKoIWgT8KmwlY7fJiT8M/1R+6FUgm9GX5MN
	 depqnf8JEZXgbWhM9disyKvYwlb1L1Z5qyH112OZxdVYtxAPYgMdpwjwULVofiCYFwCuM
	 oSaB52BJDLXECLz5MDbrKi5slb6cR0v451zQxiWR0HIn74BrFdE/qaKTCXxNIlY6bvyCH
	 giLGXCILau5DreXXIovlRy7ccFGcVEbcbMTIjiHi6k1sHccaG4Qhrzv9xfUF4k5dVuVRA
	 A4CU2BUv9tVLqTRhh/IBrVP5yVcBROSF3z2EcLaMMy5OZErjvcA3dy54L08iLt4Bleg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K3yXPm5/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6415A606A31A;
	Mon, 26 Oct 2026 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3yXPm5/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02BC1F01825;
	Mon, 26 Oct 2026 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793017367;
	bh=RRJWtqm2l0xH+h0URe8qzmm/igRf8rcF8bV+QoG3lFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K3yXPm5/DJsinKjwvvO6bf0LOL2vawqwdDpyXD5tqG3eAJIITX5pEtXtJbUtP5+WX
	 xXh1A/TDK4nH/Q1pDQq/DNce6qXrlAYHe4N8nPLlEivekLR6UATMxXpJUbIMa1QpDM
	 AnyWEMamA94AFT8VZwY+LsGvuoXyH/+6bgmCJGsSXbhGQ5ZTgJx38YYqHOsQ9JwsoQ
	 cAe1ZZEH2oEsOzVVg/2ci6ifrzU7LcTutv+jvLwgDCQF+vB2yAZf8UbgGsH6Sjd7JW
	 lhd5QZoYxiEqD5jXgquQMduw2hebHpim4jcIlzmnUatVDKIlLoCLvBTva/RMFt/kbA
	 qWVEfHxpOmLzQ==
Date: Mon, 26 Oct 2026 14:22:43 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Alex Williamson <alex@shazbot.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <20261026122243.GA28851@unreal>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261023181326.0dc2f7ed@shazbot.org>

On Fri, Oct 23, 2026 at 06:13:26PM -0600, Alex Williamson wrote:
> On Wed, 23 Sep 2026 12:29:56 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-König wrote:
> > > > No, drivers should NOT have to do that in their .probe() function,
> > > > that's what we moved away from decades ago!  The match function should
> > > > handle all of that for you, otherwise it's contant duplication
> > > > everywhere that is unneeded.  
> > > 
> > > Well then you have to accept that root can provoke a null pointer
> > > exception (e.g. by forcing the pwm-tegra driver on a device) because at
> > > least with today's platform bus match function such a match is ok.  
> > 
> > Agreed, yes, root can cause a crash and can do tons of horrible things
> > much worse than this, that's not the issue.
> > 
> > That's why this taint is there, to make it obvious that this is not a
> > "real" bug at all.
> > 
> > > > Please, learn from our history, don't make the same mistakes.
> > > > 
> > > > Now I might be convinced that driver_override is the way to go here, but
> > > > it still feels really odd as again, bind/unbind was created as a driver
> > > > debugging option only, it should NOT be a normal operation that any user
> > > > should rely on.  The driver should "just work" properly instead, without
> > > > requiring manual bind work, as that's not a good model at all.  
> > > 
> > > I agree in principle, but (in my case wifi) drivers are buggy sometimes
> > > (due to missing documentation and/or engineering effort) and being able
> > > to rebind the driver instead of rebooting to get a working device again
> > > is very useful.  
> > 
> > Fine, use it!  Just don't expect that to be "normal".
> > 
> > > So yes, theoretically bind/unbind isn't needed, but theory and practise
> > > differ in practise.  
> > 
> > Agreed, but again, don't rely on this as a "real" solution fo ranything.
> 
> Sorry, late to the party, but this isn't a few user scripts that rely
> on this behavior.  Effectively every use case of vfio relies on this
> behavior.  We rely on unbinding the default driver from the device
> before using driver_override and drivers_probe.  That means every
> hypervisor with device assignment and every userspace driver use case
> now experiences a tainted kernel. That seems like a significant
> regression.

Sorry, I was on vacation and missed this change earlier. This change will
affect SR-IOV deployments around the world, which *rely* on being able to
bind a driver manually *after* virtual functions are created but before
they are used.

This is needed for two reasons: to save hardware and software resources
when creating a large number of VFs, and to allow the PCI config space to
be configured *before* the driver starts using it.

There is no in-kernel alternative.

Thanks
