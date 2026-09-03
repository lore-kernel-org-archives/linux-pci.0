Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A80332EC1;
	Thu,  3 Sep 2026 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418322; cv=none; b=B4xKrAZ7wGzhfOomtmnAuEQYhpOL0SaEvWad12xtKpMdimJlsx/UVafGP2daWyyFjciyUuE5BtbK4cpNSSU4oX53qqAF9pjbGuWedVpffy5wqN72OskFa0dTeZ3aWh2bPBusntUYnVfmwH9HdaXdBeQIOcfiKshtAvfbwvHWndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418322; c=relaxed/simple;
	bh=aZgF/Upb9K/OZiFLX1yerLvsEMo9DhiK02Fu0s3b3YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJoQOG/be7dT1FImlc41V6YXwjZWd5WXNyBEBhmStOV35SNUttZIoUl6twwAlDEP3hEBGOcFF35Qng8k+8g/donBjrmYDskF2dI1R1c8b55OKq13ddGBu5MSZyafmnsIXSkJeREE7pP0bP05ITVP/6lYHkeGoCleu9x5PcEIMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzqG5t/H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzqG5t/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9CE1F000E9;
	Thu,  3 Sep 2026 06:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788418320;
	bh=vr5cCi0rpgJcIMNvNW0lZWsSJFLwrtXn++DANl8aBeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YzqG5t/HyXg3yDjTosqFWISU0tY5fDQeVBQAh0E2rxGdEIoh+F5PgERhw1+TrNGpz
	 Z4MguECZSlyuAWXNx/qYjyCJBqE5WvzINrYnM7uSaOk7Si6qdRSOUw0zGE/E+ZFYOV
	 VjZWG0y//qsU+ZWOy5b84KnMBAjIj3S3gHENnWt5OycJ/mBTWerhdM5ElUCgcKHa2f
	 vxUrnD1o3qHMhGi6klxCAguPOr0WQfosG3MGjDF9WmuqWs5mweKABcM+HX7H+BnSQZ
	 85/VMMNe633taGP4shqTj8+zqC/l1vM67/C87AGBVi9b+uQnNiKAFUHt3c0bfTbxnY
	 5z8hj230E0qRg==
Date: Thu, 3 Sep 2026 09:51:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, ankita@nvidia.com,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>,
	"Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
	rick.p.edgecombe@intel.com, yilun.xu@intel.com,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260903065156.GX24140@unreal>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
 <yq5a5x0mzxhz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5a5x0mzxhz.fsf@kernel.org>

On Thu, Sep 03, 2026 at 11:29:04AM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Wed, Sep 02, 2026 at 12:20:51PM +1000, Alexey Kardashevskiy wrote:
> >> On 2/9/26 12:12, Xu Yilun wrote:
> >> > On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
> >> > > On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
> >> > > 
> >> > > > Glad to see you all here to make progress! Intel can also help on this.
> >> > > > Can we have a meeting to discuss on these topics? As Alexey mentioned,
> >> > > > previously we had a bi-weekly call, perhaps use that for our first
> >> > > > meeting? Or what time works best for everyone?
> >> > > 
> >> > > I prefer we defer such community discussions till September, that
> >> > > seems appropriate given some dates I've seen.
> >> > 
> >> > Hi Ankit & Jason,
> >> > 
> >> > Do we have a plan to schedule a meeting to discuss next steps?
> >> > 
> >> > If so, we can figure out a specific time on the Discord channel.
> >> > https://discord.gg/KKqC438c
> >
> >> So I've been trying to find a time slot. Say, keep it on Thursdays
> >> (USA) (kinda short notice), bi-weekly, we can do:
> >
> > I've asked several people in Europe to help on parts of this series,
> > and combined with China/Aus someone is going to end up left out.
> >
> > I know people are anxious about their projects. In the short term I
> > will volunteer to send patches (ie bug fixes!) to Linus in the CC area
> > Dan was responsible for. Please email me if something needs some
> > attention and we can figure it out.
> >
> > To fully move forward we need to establish a new TSM maintainer
> > team. In my past experience a consensus has emerged off list, I
> > suggest we try that here as well. Several people should be
> > recruited. I will also volunteer to help train and launch a new team.
> >
> > I can say that several people from NVIDIA are working on the ideas in
> > this patch series. Ankit is setting up a team to focus on upstream
> > patches for all of CC inside NVIDIA. I've asked Jiri Pirko to work on
> > the PCI evidence uAPI based on his deep netlink experience, and Leon
> > Romanovsky to work on the binding problem/adversarial/trust level
> > driver core idea. They will share their approaches for solving these
> > problems as seperate proposals.
> >
> 
> 
> I can also help with the device trust and iommufd interfaces, as well as
> the CCA DA pieces. We need to find someone to take on dma-buf, as that is
> one area we have not yet integrated with the full TDISP flow.

Given my recent involvement in dma-buf, I can try to fill that gap.

> 
> >
> >> Scenario A:
> >> Seattle (PDT, UTC-7)		07:00 – 08:00	Day 1
> >> Atlantic Time (ADT, UTC-3)	11:00 – 12:00	Day 1
> >> Berlin (CEST, UTC+2)		16:00 – 17:00	Day 1
> >> India (IST, UTC+5:30)		19:30 – 20:30	Day 1
> >> China (CST, UTC+8)		22:00 – 23:00	Day 1
> >> Sydney (AEST, UTC+10)		00:00 – 01:00	Day 2 (I can do it once in 2 weeks)
> >
> > This is the only time Europe could reasonably participate in,
> > obviously it is not OK for China and Aus.
> >
> 
> I'm based in India, and all the proposed times work for me. Who is based
> in Europe?

Jiri and I are in the European time zone.

> 
> Jason -> Canada ?

Yes

> Yilun -> China
> Alexey -> Australia
> Ankit Agarwal -> US ?
> Aneesh -> India

Thanks
