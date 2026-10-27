Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091723;
	b=4oUKEryDnvUfcaJUGV+KgvCXYvAXpMj7/KEbMeu44Xu0+8PN9llrl6Z1jTQz7y7NOLfX
	 R0DDhlkuj4C0gffzgadQ5sOBLMtQWlLXs7Hl5N4T7FBer6xAWHInGhvUDqK06pxIx0XFA
	 q/GzfsAmPZ+XlSuW+dLiEZtZHYXrqilH0NJnNgVhpxYNYrO6ySeJzjbWutztd/t67btp6
	 uZrzKTrkTGTLzTY3ccYi4vj9/aogse8oDhdObS9odaKLgsGhum3OsIGGS1OcIgfevccaQ
	 AChZNlttrE78wNP4/lQRKidH+vmv4yHM0lby+9hzCwmvFua88Js/yA9LFdEDbLks7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091723;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=5nq/yW3E6nSzBhQE//dTYvgfzBHRxLsoSrzMo34ZjSs=;
	b=hSaOs+4NYwLMO+cyqaWyHBDnMZOOHPdZ64HJvCazT+MhIqlro9N6oJDzz1EV7o8yrBHL
	 LRakrWXeYq2cRrkKkIlI1tmmynsWiGZcDHN1XPTCgZvThCaamD01Bq9LFSlg1AgFXMRsZ
	 /l6f8ujsCEDVEAoSb8UWMkcMShBFJMGNGJplq7QXzSUPDDZfzZzCfbeu5HgCE7tHmCJds
	 rBXP4H0UvVdd2KFAgb9+BrBdOnrMjPkcM9SAwd21AvBiKqB8MFm1bsrpOxvAfSf5OCbFW
	 dBwvxLvgiGFgMhNnQsdy6u1OiTgY9XDVKu6k1wQ0PuBNcolSTTDO+uf4Sq709yCJLvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ulj9p7Jn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4D606A324;
	Tue, 27 Oct 2026 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ulj9p7Jn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4501F01828;
	Tue, 27 Oct 2026 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091723;
	bh=5nq/yW3E6nSzBhQE//dTYvgfzBHRxLsoSrzMo34ZjSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ulj9p7JneLFV1/XhjlgoB/eMNIqEQ4GJO5bi6UfrrD8HhsEGzbsJWw9Fh7Bbk2Zmy
	 dXTv3coxEQCqyoRT50cWG5/xQfcfb+bKo538FX9mXlQkzg7LNrBHXKUlF7evcHRIO6
	 xIHd3fw+SGUx7bY9O/A9rtGBRK1urm4D01a3/mQ8Uyvzumxm0hJJShV2f9I5rF/M4r
	 sHH4Vy0ixTOveeMxJf8ojt1F8pBQYGgoJSXpbxuaFNN8Zg6jEbemlo5+aeWEl6Iyj4
	 KXqOqZUDrUkhuzR+lhyki8q6UFZaHEsvSvX/e6qq2/E2VBr3h2VRD8uZlsfRHZGFUQ
	 aEL9J2u5dvy5Q==
Date: Tue, 27 Oct 2026 11:01:57 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20261027090157.GB28851@unreal>
References: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
 <2026102654-enlighten-perkiness-193c@gregkh>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026102654-enlighten-perkiness-193c@gregkh>

On Mon, Oct 26, 2026 at 09:27:25PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:
> > On Fri, Oct 23, 2026 at 06:13:26PM -0600, Alex Williamson wrote:
> > > On Wed, 23 Sep 2026 12:29:56 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > 
> > > > On Wed, Sep 23, 2026 at 11:54:50AM +0200, Uwe Kleine-König wrote:
> > > > > > No, drivers should NOT have to do that in their .probe() function,
> > > > > > that's what we moved away from decades ago!  The match function should
> > > > > > handle all of that for you, otherwise it's contant duplication
> > > > > > everywhere that is unneeded.  
> > > > > 
> > > > > Well then you have to accept that root can provoke a null pointer
> > > > > exception (e.g. by forcing the pwm-tegra driver on a device) because at
> > > > > least with today's platform bus match function such a match is ok.  
> > > > 
> > > > Agreed, yes, root can cause a crash and can do tons of horrible things
> > > > much worse than this, that's not the issue.
> > > > 
> > > > That's why this taint is there, to make it obvious that this is not a
> > > > "real" bug at all.
> > > > 
> > > > > > Please, learn from our history, don't make the same mistakes.
> > > > > > 
> > > > > > Now I might be convinced that driver_override is the way to go here, but
> > > > > > it still feels really odd as again, bind/unbind was created as a driver
> > > > > > debugging option only, it should NOT be a normal operation that any user
> > > > > > should rely on.  The driver should "just work" properly instead, without
> > > > > > requiring manual bind work, as that's not a good model at all.  
> > > > > 
> > > > > I agree in principle, but (in my case wifi) drivers are buggy sometimes
> > > > > (due to missing documentation and/or engineering effort) and being able
> > > > > to rebind the driver instead of rebooting to get a working device again
> > > > > is very useful.  
> > > > 
> > > > Fine, use it!  Just don't expect that to be "normal".
> > > > 
> > > > > So yes, theoretically bind/unbind isn't needed, but theory and practise
> > > > > differ in practise.  
> > > > 
> > > > Agreed, but again, don't rely on this as a "real" solution fo ranything.
> > > 
> > > Sorry, late to the party, but this isn't a few user scripts that rely
> > > on this behavior.  Effectively every use case of vfio relies on this
> > > behavior.  We rely on unbinding the default driver from the device
> > > before using driver_override and drivers_probe.  That means every
> > > hypervisor with device assignment and every userspace driver use case
> > > now experiences a tainted kernel. That seems like a significant
> > > regression.
> > 
> > Sorry, I was on vacation and missed this change earlier. This change will
> > affect SR-IOV deployments around the world, which *rely* on being able to
> > bind a driver manually *after* virtual functions are created but before
> > they are used.
> 
> Why can't a real driver bind to those virtual functions?  Like is
> happening in the rust apis?

The actual driver is also bound, but at a later stage. I'm not sure what you
mean by “Rust APIs.”

> 
> > This is needed for two reasons: to save hardware and software resources
> > when creating a large number of VFs, and to allow the PCI config space to
> > be configured *before* the driver starts using it.
> 
> How is hardware and software resources an issue here at all?  And you
> can write to PCI config space from userspace today, no driver needed
> anywhere at all, that's always been allowed.

According to the PCI spec—or, at least, the common interpretation of it—
newly created VFs should have equivalent hardware-resource partitions.
For most hardware resources, this is not an issue. One resource, however,
is critical to partition correctly: the number of MSI-X vectors per VF.
These vectors are backed by physical resources and directly affect
performance and utilization.

In a correctly configured system, the number of MSI-X vectors should
match the number of CPUs assigned to the VM. More vectors can leave
hardware underutilized; fewer can degrade performance.

The workflow for cloud operators is therefore:

1. Create a large number of VFs, but do not assign them yet.
2. Lease a VM to a user and determine how many CPUs they requested.
3. Repartition the internal MSI-X table allocation.
4. Assign the VF to the user.
5. Check how many MSI-X vectors remain available, then return to step 2.

The MSI-X table size is read near the beginning of driver initialization
and cannot be changed afterward.

So, no—you cannot change those PCI values without breaking the driver
and OS that are already running.

> 
> > There is no in-kernel alternative.
> 
> Then just don't have a in-kernel driver for the device and all is good?

In addition to Jason's comments, the PF and VF share the same driver because
they are nearly identical, apart from a few differences in PCI
configuration space.

Please revert the series ASAP, you are clearly breaking existing deployments.

Thanks

> 
> thanks,
> 
> greg k-h
> 
