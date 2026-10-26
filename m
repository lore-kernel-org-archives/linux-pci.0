Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045108;
	b=F0Ip3MryqY85Vdq/dOP9DxjlIfS3PAt2YtPUS+i0lrIzAb9IXmnfn5/OXJJK9GBQs2Ft
	 gYP/h3I35ljYQN8q1di/K0hvv+2zV4O8IP+jB9tQbMybw1srL18PaOaHLZQIXkSR6Todk
	 ewRvV/DZc9BBErVK0+Ki8VlsmmR/Zc+v9AIn7BgjWPktOTR0Uwar03M1z6fmX3Kac6g4t
	 X7kTzPOGJPsUjelo0PU3NLsUVRP7WIrrE+ndBtxGKT3dtLun/WH9Y03URlDL7wMaLK9Fk
	 EPVnhcF3VlbmVQ8L+WMAb3M7pNWbGR1k6FTggD5ks4nKZES3FC3w2cdE8aEXgJdt0iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045108;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BawehOGx+swDNz30BXtD0rUayjwrRWdohfXeiD3Nwuc=;
	b=rxd/TfUd8nEkr+Bhk134tT+Avsdhy0ugVOzSOk2nX0w0aX2B0atn/IoIOEr2rwIY26d7
	 ga1q3AjO5GecHsaWBRcMhyFpR50ROnhOxa9VBnB7huH0LvCshEuMgL0Ab4uGpUocQh8C4
	 pT2Ht/LTW/f89mqFKXVpOlovhOHXrVwEJoXMSjl6+nquGF0tVu6xBZwV1vMQans8JTRdP
	 IGUrAVtCDqC8YHsJmxJDzGlPSVybnX2/R9ZsMpwDjPMziIxP0pjxs/kCpFckCMxl62qkJ
	 bS16L3cvVoho4AEHVyMAgYyMFDz01V5NNfPpPTFQPC2YutztW1LJcoqGrnZl1GyL69A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uqkQoFM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B8C606A31A;
	Mon, 26 Oct 2026 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=uqkQoFM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD41F01825;
	Mon, 26 Oct 2026 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793045107;
	bh=BawehOGx+swDNz30BXtD0rUayjwrRWdohfXeiD3Nwuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uqkQoFM52klwzT7RGNaUFA6Qga4FuWuGaYyefzROIzukjBhIFqREK+pqTr4hriVoK
	 PDd/0ELiJmI8EHpbo0nbvO9gLFbi48BLIx5y9dL4ZVWfdn+SY805AGZXuJumJAO/Tm
	 19C/ca7D7sF/slrGjQ3K2AJ2vFy+qN+CzA+phAus=
Date: Mon, 26 Oct 2026 21:05:06 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
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
	Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <2026102604-tint-catcall-433e@gregkh>
References: <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <20261026122243.GA28851@unreal>
 <20261026184312.GA1685504@ziepe.ca>
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
In-Reply-To: <20261026184312.GA1685504@ziepe.ca>

On Mon, Oct 26, 2026 at 03:43:12PM -0300, Jason Gunthorpe wrote:
> On Mon, Oct 26, 2026 at 02:22:43PM +0200, Leon Romanovsky wrote:
> 
> > This is needed for two reasons: to save hardware and software resources
> > when creating a large number of VFs, and to allow the PCI config space to
> > be configured *before* the driver starts using it.
> > 
> > There is no in-kernel alternative.
> 
> Having userspace involved in driver binding has also always been the
> plan for confidential computing needs. We cannot have a device driver
> bound across some of the HW transitions like TDISP shared/private, so
> there has always been an expectation of bind/unbind.

What, why?  What forces that decision?  What's wrong with the proper
driver for the hardware being bound automatically to the device?

> For this case the existing sysf drivers_probe is good enough for bind,
> but we must have taint-free unbind for PCI devices too.

Why?

> I think this patch should be reverted ASAP, it is a pretty major
> regression for a lot of users.

But this use case hasn't even happened yet, so what would regress?

I'm not talking about the vfio thing, that's different here...

thanks,

greg k-h
