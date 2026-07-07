Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41818175A60;
	Tue,  7 Jul 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438893; cv=none; b=DXU8O6/polvnCUFcKTzZNRX4XNRiqmrrXsZUWjYnA1TOfWq916kwjJFYHSIrUkmlpyvHnNzAPjkUrrK8SvPevBGXwJlb4oOiI0g+RJx+ilh/Ev0xLLhaGAYX+77C0pPViJiXlnsJAskMyL73HUe0WcBno8CRJOrS9x6nk4ZXAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438893; c=relaxed/simple;
	bh=LwsjovfpbGjUYDUE+hGvSr0VbIY/8dbOfADTatOaBSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZlRLrt2u1ytMROf852rj/2xXitLK/TWgUXqLARe+DqEl6bnCfce8OjpQQ4aIsWUP08ckkbbl2h+KJV6UxprAquYcwybUhDS42fTHRdzP4R76rss+0K+OpWe4HcMg3kIvd+AeVCDLsfDInNrG7JUi/BDLVFG5O4UxTx3gITQd5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIrRwsun; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIrRwsun"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CED1F000E9;
	Tue,  7 Jul 2026 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783438891;
	bh=Q1Kwud0dvJdx+NdcimkPz3yZCGnaN/yJ0h1aVkDOmMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=cIrRwsunHV1lDrfE3muhzbxHCOAELWIUY4Y8Dr11AdxgevUodaWpzzfaQgziBJqFg
	 Z60VV1AYFgIGExsq+K4YD+E8mINg+UGjQjUucqjzcYkgvyChec5TQWT0r8JRcDzzsO
	 ajeOF6AnC3vYj9l0S8854nCl1kGiv6wC6OWjfR1j5vCDMbro8IHNrAuBnjzLg2/wuL
	 VqonITdE1JIZFFud4MWnWk9fVlfKdlXHpLspgt148IMfd9dcj7xTk/HgJ6AtxoGDq9
	 A1oZLgLvBqEPzV03Fl4gc3HqWQhBJod8ryZmA41BJag+VMtLxNAh6tIiEUqhF3XZp1
	 hBkNn203hcJFA==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Jonathan Corbet <corbet@lwn.net>,  Josh Hilke
 <jrhilke@google.com>,  Leon Romanovsky <leonro@nvidia.com>,  Lukas Wunner
 <lukas@wunner.de>,  Mike Rapoport <rppt@kernel.org>,  Parav Pandit
 <parav@nvidia.com>,  Pranjal Shrivastava <praan@google.com>,  Saeed
 Mahameed <saeedm@nvidia.com>,  Samiullah Khawaja <skhawaja@google.com>,
  Shuah Khan <skhan@linuxfoundation.org>,  Vipin Sharma
 <vipinsh@google.com>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
In-Reply-To: <CALzav=fN8m9+rso7RSLR35bozZpNKv6McOR3jv1-ngxApM1BCg@mail.gmail.com>
	(David Matlack's message of "Mon, 29 Jun 2026 11:48:55 -0700")
References: <20260522202410.3104264-1-dmatlack@google.com>
	<20260522202410.3104264-4-dmatlack@google.com>
	<178144432039.1257322.9644414453415904478.b4-review@b4>
	<ajBgj_aSuzMZG47e@google.com> <2vxzechulmcp.fsf@kernel.org>
	<CALzav=fN8m9+rso7RSLR35bozZpNKv6McOR3jv1-ngxApM1BCg@mail.gmail.com>
Date: Tue, 07 Jul 2026 17:41:25 +0200
Message-ID: <2vxzechen6xm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29 2026, David Matlack wrote:

> On Thu, Jun 25, 2026 at 7:35=E2=80=AFAM Pratyush Yadav <pratyush@kernel.o=
rg> wrote:
>>
>> Hi David,
>>
>> On Mon, Jun 15 2026, David Matlack wrote:
>>
>> > On 2026-06-14 01:38 PM, Pasha Tatashin wrote:
>> >> On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.co=
m> wrote:
>> [...]
>> >> > +  }
>> >> > +
>> >> > +  pci_info(dev, "Device was preserved by previous kernel across Li=
ve Update\n");
>> >> > +  dev->liveupdate.incoming =3D dev_ser;
>> >> > +
>> >> > +  /*
>> >> > +   * Hold the ref on the incoming FLB until pci_liveupdate_finish(=
) so
>> >> > +   * that dev->liveupdate.incoming does not get freed while it is =
in use.
>> >> > +   */
>> >>
>> >> How would that work? If finish is not called FLB stays around until t=
he
>> >> next reboot.
>> >
>> > True... I think if the PCI core trusts drivers to call
>> > pci_liveupdate_finish() then we don't need to hold onto the incoming
>> > reference here.
>>
>> That was my point when I was arguing against refcounts on outgoing FLBs.
>> This is very easy to abuse, especially when we are talking about device
>> drivers. And this refcounting mechanism makes the FLB no longer
>> file-lifecycle-bound, since now it is entirely up to drivers to decide
>> the lifecycle of this data.
>
> The PCI core holds a reference to the incoming FLB for as long as it
> maintains a pointer to that FLB in struct pci_dev
> (dev->liveupdate.incoming). The lifetime of that pointer is aligned
> with the lifetime of the file as long as the driver calls
> pci_liveupdate_finish() in its file finish() callback.
>
> If there is a bug in the driver that causes it to not call
> pci_liveupdate_finish() then the FLB will leak past the file yes. But
> the alternative would be to leak a pointer to freed memory in
> dev->liveupdate.incoming, which could lead to UAF.
>
> Leaking the FLB seems safer than UAF, which is why I went for the
> refcounting approach.

Hmm, that does make sense. I still feel a bit odd doing this, but since
I don't have any better ideas, I think let's keep this as-is. If this
does turn out to be a real problem, we can fix it later. This is kernel
internal API anyway.

Also, I didn't know the plan was to do VFIO only. I thought at some
point in the near future we will get support for PF drivers. With only
VFIO, I think this is a lot simpler and problems will be a lot easier to
fix since there is only one user. I was mainly worried about random
drivers holding on to PCI/LUO core data structures.

>
> Another approach entirely would be to drop the
> dev->liveupdate.incoming and do the xarray lookup everytime instead.

But then you'd need to have a lifetime for the xarray, no?

>
>>
>> I have been thinking about this a bit more in the last couple days, and
>> I wonder if we are doing this right. Here's an idea I have been thinking
>> of.
>>
>> We should make live update a first class citizen in PCI. Instead of
>> patching in liveupdate via the liveupdate.incoming field, and letting
>> drivers figure out when to use it, we should separate out probe and
>> retrieve paths entirely.
>>
>> Probe and retrieve are fundamentally different operations. While they
>> may share some common initialization logic for the _software_ state, how
>> they interface with the hardware is completely different. I think mixing
>> the two will result in driver code being more spaghetti by having
>> liveupdate checks sprayed out all over.
>
> We are only planning on supporting Live Update for VFIO drivers for
> the forseeable future. The VFIO work during probe is almost entirely
> software state setup. The only hardware logic we need to "if" out in
> the vfio-pci driver's probe() is putting the device into a low-power
> mode via the runtime power manager. So I don't think we will get any
> benefit from this approach, and it would be a lot more intrusive to
> both the PCI core driver framework, and VFIO itself, to support this.
>
>> This series doesn't add support for any drivers, but looking at some of
>> the code we have downstream, I see this problem. The liveupdate code is
>> all over the place in the driver and it is very hard to wrap one's head
>> around how the device is actually retrieved.
>
> You can find the vfio-pci driver changes here:
>
>   https://lore.kernel.org/kvm/20260511234802.2280368-1-vipinsh@google.com/
>
> Let's keep the discussion focused on upstream VFIO drivers since that
> is all we are planning to support right now due to LUO's requirement
> of file-based preservation. The downstream driver changes we are
> carrying is not reflective of what we want to support upstream.
>
>> So I think PCI core should track preserved devices, and if the device is
>> preserved, it should skip the probe and wait for retrieve. Retrieve does
>> the full initialization of the device. This fits in with the LUO model
>> as well. You can make retrieve a callback of struct pci_driver and do
>> some wrappers to talk with LUO, so device drivers don't directly
>> interface with LUO at all.
>>
>> We should do similar things on the shutdown path. Shutdown is a
>> fundamentally different operation from freeze, and so we should separate
>> them out as well.
>
> This is speculative. In practice, we haven't needed to change VFIO's
> shutdown() or probe() functions so far. The only change I anticipate
> needing is skipping runtime power management "put" during probe() I
> mentioned above.
>
> If we actually made retrieve() a first-class callback and used that
> instead of probe(), VFIO would internally just call its probe()
> function because that would be the cleanest way to set up all the
> software state it needs to manage the device.

Right, for only VFIO this doesn't make much sense. I wrote this thinking
we will add PF preservation support at some point.

>
>> This solves the lifetime problem as well. When PCI core is initializing,
>> it knows for sure that no retrievals are going to happen. That's because
>> none of the drivers have registered yet. So it can safely access the FLB
>> and initialize its state. After that, drivers can register themselves
>> and start accepting retrieve() calls. Once the last driver goes away,
>> the FLB is freed automatically.
>
> It's not so simple. The PCI core does not really initialize itself.
> Scanning devices gets triggered externally, e.g. by ACPI, device
> trees, runtime hotplug events, etc., and that is when the PCI core
> gets notified about a device. None of this is synchronized with "when
> drivers have registered", which I assume you are referring to
> registering with LUO.
>
>>
>> I am sorry for suggesting a big refactor at v6, but the early versions
>> looked good to me at the time, and I only thought more deeply about this
>> when trying to figure out how we can make the lifetimes cleaner.

--=20
Regards,
Pratyush Yadav
