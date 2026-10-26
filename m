Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046446;
	b=dkDdsL+1Q8dA9jZqJgCNbR9LDrCCY3I7XNhpRz48fMSyAmUKqT8CK/ClYXjLtIsEJxVw
	 X1gAP0Yye0In6Mu/MKl8wugG0Ykf0Gsei+ZJnVQbLhlbEBLvWxWMSnte2kYtVpbydV0iZ
	 +4L3U6IcRN69qYvO09ksl45Qoe7uA5sHfWGT/uJ2M5cZq7HZtByqTCZLFB0XO/Neeic7I
	 jJWJQh+xCTsmviLeyuO6ax814OAGGEJ6BcZ/EZEqKmmvrzWgGs0EwDTntfwRFKyIQhCaa
	 t55ciMuNtW4R1v2l8ZJ9tYs+Nv5Saw1T07iAstbg7tWZ0pOdezKuMxeK6W1e/wXFHBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046446;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=LFCglxF3YnOUeWs+Z5oFeCuqJ1fUCZ2MGnIwDKgVXec=;
	b=SdvbJKsuYWFx5h7/wgv+aVy4RsSX15WavLhN3KlOcb7uUDpSRZGUVnejrHETPPd9SCSn
	 DtUC08OfS5pSfP6isr49J+TTx6b5AW9e5bU5ZrLepq4cg//znRb724dXeVr8pNxo7hNaH
	 ekDSTa+uERxpnxxBurg+kdUVl8t5TFooLyQpq0xDNvRT73y2mgWgh8fcrRLjjfHVZjGFy
	 FtX6ZttmPTXMectfzIGi3/uacw7Y2T9BJWuYJibhd/F8wabFBP3xBTratI83dAqCLKSXw
	 LkGgyNHwU4ZSfa1MrR8eSt9g08ntuvZGKJZBfHP6FTx9Ius10Bxsdeh0TroEpyWY/Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=c3W3E1id;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F9606A31A;
	Mon, 26 Oct 2026 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=c3W3E1id
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116BE1F01825;
	Mon, 26 Oct 2026 20:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793046445;
	bh=LFCglxF3YnOUeWs+Z5oFeCuqJ1fUCZ2MGnIwDKgVXec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c3W3E1id0F+qhx0MI/3yl4YHWFa0JK35WvxQQ4ViH7gpyd/iDSJkcOvJlLjIrAM6z
	 91sd+foBp+g36SI388PdvEdp3FoHb4Kp9FkVnpI0qG7GERFpMftCCh8aar+vr2z84g
	 l2PMs8cC/HVVfnTiKkoKwH5h89JA3k4nGZQ6eVgk=
Date: Mon, 26 Oct 2026 21:27:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
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
Message-ID: <2026102654-enlighten-perkiness-193c@gregkh>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
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
In-Reply-To: <20261026122243.GA28851@unreal>

On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:
> On Fri, Oct 23, 2026 at 06:13:26PM -0600, Alex Williamson wrote:
> > On Wed, 23 Sep 2026 12:29:56 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-König wrote:
> > > > > No, drivers should NOT have to do that in their .probe() function,
> > > > > that's what we moved away from decades ago!  The match function should
> > > > > handle all of that for you, otherwise it's contant duplication
> > > > > everywhere that is unneeded.  
> > > > 
> > > > Well then you have to accept that root can provoke a null pointer
> > > > exception (e.g. by forcing the pwm-tegra driver on a device) because at
> > > > least with today's platform bus match function such a match is ok.  
> > > 
> > > Agreed, yes, root can cause a crash and can do tons of horrible things
> > > much worse than this, that's not the issue.
> > > 
> > > That's why this taint is there, to make it obvious that this is not a
> > > "real" bug at all.
> > > 
> > > > > Please, learn from our history, don't make the same mistakes.
> > > > > 
> > > > > Now I might be convinced that driver_override is the way to go here, but
> > > > > it still feels really odd as again, bind/unbind was created as a driver
> > > > > debugging option only, it should NOT be a normal operation that any user
> > > > > should rely on.  The driver should "just work" properly instead, without
> > > > > requiring manual bind work, as that's not a good model at all.  
> > > > 
> > > > I agree in principle, but (in my case wifi) drivers are buggy sometimes
> > > > (due to missing documentation and/or engineering effort) and being able
> > > > to rebind the driver instead of rebooting to get a working device again
> > > > is very useful.  
> > > 
> > > Fine, use it!  Just don't expect that to be "normal".
> > > 
> > > > So yes, theoretically bind/unbind isn't needed, but theory and practise
> > > > differ in practise.  
> > > 
> > > Agreed, but again, don't rely on this as a "real" solution fo ranything.
> > 
> > Sorry, late to the party, but this isn't a few user scripts that rely
> > on this behavior.  Effectively every use case of vfio relies on this
> > behavior.  We rely on unbinding the default driver from the device
> > before using driver_override and drivers_probe.  That means every
> > hypervisor with device assignment and every userspace driver use case
> > now experiences a tainted kernel. That seems like a significant
> > regression.
> 
> Sorry, I was on vacation and missed this change earlier. This change will
> affect SR-IOV deployments around the world, which *rely* on being able to
> bind a driver manually *after* virtual functions are created but before
> they are used.

Why can't a real driver bind to those virtual functions?  Like is
happening in the rust apis?

> This is needed for two reasons: to save hardware and software resources
> when creating a large number of VFs, and to allow the PCI config space to
> be configured *before* the driver starts using it.

How is hardware and software resources an issue here at all?  And you
can write to PCI config space from userspace today, no driver needed
anywhere at all, that's always been allowed.

> There is no in-kernel alternative.

Then just don't have a in-kernel driver for the device and all is good?

thanks,

greg k-h
