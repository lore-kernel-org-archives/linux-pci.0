Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256D3DAAC3;
	Wed,  2 Sep 2026 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334141; cv=none; b=mebSPKsbAolcnUaC9e5TKKaYLRngDL3EuYijCAZBcAngDBvMka4PKgruv0GsHuYpLoE0dX7mh//1R4xoNWeC05zsrKxBN70sS/BI5pMyD5QqVUiF2wqlUvdBTjLdLpkJGr++JD1o9Z+wTwJonU2J6Lw6uf6G2dOvHznQ8CKsyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334141; c=relaxed/simple;
	bh=pAfaN+jDCA2d0gxsMNOU7J3a/OQIiXUBd3dXX/RakV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nP9uSp6A0g6SNlrcAyyvpvnZ1JgVMPqCKTvccgb2/tlDNCeoOr4EO2a0XG0iaswaH2ba+P6aDTUZn7YjNNYNV2elO+WP9FHuXJzOJWRvntyXvuLN5cyY46XK7NpHGPy/vx/GNv9o3aGFTL9AnC3Hly7P2wolwG4rsbBs//drISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOIpN1l8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOIpN1l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587161F000E9;
	Wed,  2 Sep 2026 07:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334139;
	bh=nsm2e+vuYYkeIEUmf/SuK3uUkXGDYr8hmbsdJyez/v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AOIpN1l8+aTzQhC8rel45G1zUGjtyGXOCxC5bYbgvc/bOa8S8YFQRzPz+T9+qsuaF
	 Xr7JdWKsgy9N0XHyiexLxOCoDNsxX7sQjxNIF6UrrrafPyUKdOPdQVRYJ06j32JSbq
	 TAoa8d/lRfbqpFBPOvvhp02FT9SJjBHt7aVhc0CB2GQXN5Cowd/3pYZzb8Gitt5qts
	 YX4VcrEQYyeJ+C0QiADCSS/HjstbBzIvtnyfPmr3rnIrLvcQQOiUrICvPU8hAAlnGy
	 LlAlSzCxS4UmqPLyYYFHEgXHUg54H5lrbLxfESv91Si5Mgoze6TxpDI+dUcRHNxChr
	 9me3BKcmitrvg==
Date: Wed, 2 Sep 2026 10:28:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	ankita@nvidia.com, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
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
	rick.p.edgecombe@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260902072856.GQ24140@unreal>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
 <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
 <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>

On Wed, Sep 02, 2026 at 12:20:51PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 2/9/26 12:12, Xu Yilun wrote:
> > On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
> > > 
> > > > Glad to see you all here to make progress! Intel can also help on this.
> > > > Can we have a meeting to discuss on these topics? As Alexey mentioned,
> > > > previously we had a bi-weekly call, perhaps use that for our first
> > > > meeting? Or what time works best for everyone?
> > > 
> > > I prefer we defer such community discussions till September, that
> > > seems appropriate given some dates I've seen.
> > 
> > Hi Ankit & Jason,
> > 
> > Do we have a plan to schedule a meeting to discuss next steps?
> > 
> > If so, we can figure out a specific time on the Discord channel.
> > https://discord.gg/KKqC438c
> 
> 
> So I've been trying to find a time slot. Say, keep it on Thursdays (USA) (kinda short notice), bi-weekly, we can do:
> 
> Scenario A:
> Seattle (PDT, UTC-7)		07:00 – 08:00	Day 1
> Atlantic Time (ADT, UTC-3)	11:00 – 12:00	Day 1
> Berlin (CEST, UTC+2)		16:00 – 17:00	Day 1
> India (IST, UTC+5:30)		19:30 – 20:30	Day 1
> China (CST, UTC+8)		22:00 – 23:00	Day 1
> Sydney (AEST, UTC+10)		00:00 – 01:00	Day 2 (I can do it once in 2 weeks)
> 
> Scenario B:
> Seattle (PDT, UTC-7)		18:00 – 19:00	Day 1
> Atlantic Time (ADT, UTC-3)	22:00 – 23:00	Day 1
> Berlin (CEST, UTC+2)		03:00 – 04:00	Day 2
> India (IST, UTC+5:30)		06:30 – 07:30	Day 2
> China (CST, UTC+8)		09:00 – 10:00	Day 2
> Sydney (AEST, UTC+10)		11:00 – 12:00	Day 2
> 
> Scenario C (which is the current schedule):
> Seattle (PDT, UTC-7)		20:00 – 21:00	Thursday, Sep 3
> Atlantic Time Zone (ADT, UTC-3)	00:00 – 01:00	Friday, Sep 4
> Berlin (CEST, UTC+2)		05:00 – 06:00	Day 2
> India (IST, UTC+5:30)		08:30 – 09:30	Friday, Sep 4
> China (CST, UTC+8)		11:00 – 12:00	Friday, Sep 4
> Sydney (AEST, UTC+10)		13:00 – 14:00	Friday, Sep 4
> 
> The link is:
> https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?password=80705486-101a-4e19-8f11-0baaf92104be
> 
> but if we want to change the time - who do we contact? Or set up a new call (again, how)?
> 
> Please, comment. I find these calls pretty productive syncups. So far we were not having Europe in these calls.

Berlin (CEST, UTC+2)            03:00 – 04:00   Day 2
No wonder that you don't have Europe :)

Thanks
