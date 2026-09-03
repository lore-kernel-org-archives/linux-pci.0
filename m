Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB82393DC8;
	Thu,  3 Sep 2026 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415160; cv=none; b=SPIPkqQWlVAatBJm4YrVLwkWhKfVHjg3lXDH7Ojbo+PZZXlQWv29+cVzUAl0iJm3XiXoOoq0BVOxht6c7K0BxcQKVqTqsu2vPW2kqgGWiC0swhZK+oRRv0YEgKn9zDYB7rQ5LblsPiFxrZtb2+n4EmzVBMvw8EOEJMV2hK1hDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415160; c=relaxed/simple;
	bh=BqY7EpA/2zO+um0W7g4AtC0Mwe1AhFXongtHJmVYN9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TVsYanId6sq1uGdaEcQfJ1fkFpZQt+8JLrRhNgJTx+beiTH0RmyLhahE+XhHeWrz/k1uY5uyrbsfj6YRQF/S7VpZn3ZAAYO1Fyq9AYznBkCBKel/jcVJ6nHi4uSzW3IWz1JRs2kDyXat1XheHxsnEGhPF0ktMMtLA0mib4sTwhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLqlbf4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLqlbf4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D811F000E9;
	Thu,  3 Sep 2026 05:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788415158;
	bh=GokYarLn2do1OOdi3YtEFsV3SbdTFKOFfI6VuO3FkaQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CLqlbf4gc1V7KqQLo6NWAGVg4DDHyF4AAeQYjUOxAJvZJJkUSAJJWe/qwB7pSqHXu
	 syLNrM+YtPTVr0PYb7EdPpAQljIUOSHfA1YBXFU1P1rYDe8VZqzTg1lty93JsJXLd3
	 k9jcZvQqXi3pHDIQn6RY8FOjjjx4cRkzp43rzoWT3NfuEPmI2D+ayt+X6ZtP6VUh6e
	 dWQNtjqX+KTyOhXCYH8fln3KtNp/HiKGEx6ioX8HT6/6qkSAZIioIqvfM2w1/W2SXO
	 Qn5xeCGeMzbMc1tjPyRpeUR0pCcZBbU7WY0DBqW9L7r8DNzyYajsF8x2vNEZ0qbVMQ
	 tLkhygfGuBi3w==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Alexey Kardashevskiy <aik@amd.com>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, ankita@nvidia.com,
	linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, "Fontenot,
	Nathan" <Nathan.Fontenot@amd.com>, rick.p.edgecombe@intel.com,
	yilun.xu@intel.com, Jiri Pirko <jiri@resnulli.us>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
In-Reply-To: <20260902150125.GD2890729@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com> <amk7Xzm5jmz+6SPJ@ziepe.ca>
 <anFE7m164AmchTy/@yilunxu-OptiPlex-7050> <20260805005533.GB28508@ziepe.ca>
 <apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
 <2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
 <20260902150125.GD2890729@ziepe.ca>
Date: Thu, 03 Sep 2026 11:29:04 +0530
Message-ID: <yq5a5x0mzxhz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Wed, Sep 02, 2026 at 12:20:51PM +1000, Alexey Kardashevskiy wrote:
>> On 2/9/26 12:12, Xu Yilun wrote:
>> > On Tue, Aug 04, 2026 at 09:55:33PM -0300, Jason Gunthorpe wrote:
>> > > On Tue, Aug 04, 2026 at 09:48:30AM +0800, Xu Yilun wrote:
>> > >=20
>> > > > Glad to see you all here to make progress! Intel can also help on =
this.
>> > > > Can we have a meeting to discuss on these topics? As Alexey mentio=
ned,
>> > > > previously we had a bi-weekly call, perhaps use that for our first
>> > > > meeting? Or what time works best for everyone?
>> > >=20
>> > > I prefer we defer such community discussions till September, that
>> > > seems appropriate given some dates I've seen.
>> >=20
>> > Hi Ankit & Jason,
>> >=20
>> > Do we have a plan to schedule a meeting to discuss next steps?
>> >=20
>> > If so, we can figure out a specific time on the Discord channel.
>> > https://discord.gg/KKqC438c
>
>> So I've been trying to find a time slot. Say, keep it on Thursdays
>> (USA) (kinda short notice), bi-weekly, we can do:
>
> I've asked several people in Europe to help on parts of this series,
> and combined with China/Aus someone is going to end up left out.
>
> I know people are anxious about their projects. In the short term I
> will volunteer to send patches (ie bug fixes!) to Linus in the CC area
> Dan was responsible for. Please email me if something needs some
> attention and we can figure it out.
>
> To fully move forward we need to establish a new TSM maintainer
> team. In my past experience a consensus has emerged off list, I
> suggest we try that here as well. Several people should be
> recruited. I will also volunteer to help train and launch a new team.
>
> I can say that several people from NVIDIA are working on the ideas in
> this patch series. Ankit is setting up a team to focus on upstream
> patches for all of CC inside NVIDIA. I've asked Jiri Pirko to work on
> the PCI evidence uAPI based on his deep netlink experience, and Leon
> Romanovsky to work on the binding problem/adversarial/trust level
> driver core idea. They will share their approaches for solving these
> problems as seperate proposals.
>


I can also help with the device trust and iommufd interfaces, as well as
the CCA DA pieces. We need to find someone to take on dma-buf, as that is
one area we have not yet integrated with the full TDISP flow.

>
>> Scenario A:
>> Seattle (PDT, UTC-7)		07:00 =E2=80=93 08:00	Day 1
>> Atlantic Time (ADT, UTC-3)	11:00 =E2=80=93 12:00	Day 1
>> Berlin (CEST, UTC+2)		16:00 =E2=80=93 17:00	Day 1
>> India (IST, UTC+5:30)		19:30 =E2=80=93 20:30	Day 1
>> China (CST, UTC+8)		22:00 =E2=80=93 23:00	Day 1
>> Sydney (AEST, UTC+10)		00:00 =E2=80=93 01:00	Day 2 (I can do it once in =
2 weeks)
>
> This is the only time Europe could reasonably participate in,
> obviously it is not OK for China and Aus.
>

I'm based in India, and all the proposed times work for me. Who is based
in Europe?

Jason -> Canada ?
Yilun -> China
Alexey -> Australia
Ankit Agarwal -> US ?
Aneesh -> India

>
>> Please, comment. I find these calls pretty productive syncups. So
>> far we were not having Europe in these calls.
>
> Calls are undoutably useful!
>
>> Alternatively, wait until the LPC in a month but I suspect not
>> everybody is going to be there.
>=20=20
> LPC is not that far away, I think we should have a goal of having a
> consensus for or at LPC
>
> Regards,
> Jason

-aneesh
