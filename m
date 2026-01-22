Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9280349AEB;
	Thu, 22 Jan 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077878; cv=none; b=W3+GTzAsqVhhf7MxhgXliycdy4lJYoiZPVzO/OTzuNKzhavqzJJGuvbts6k2VIUsugkK99Kuv2wLyFlV7mZxHNGDS07bVn8JyP7R2wsHg2OXOoAS1elmi9Yd65mi0zeqk+thE27C0xMcm9KMGxe8OArhWBTGpIhRVZBMlooB+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077878; c=relaxed/simple;
	bh=cqS7KKnEw2XlLBSCbeCJMDjXnGZt5elRteE1142HIMU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0Nwii9CSuzZNvLhnM0sZ7htoQTvHnroOFwJ12xlYQgmx/586xmkcmBpmMin5WpUFSEQCIz3DO0nE9Upfq9ohLOUZipQg85rQ4LbQzJm9LaLsoG73dLK2TRTejt3MB0niQmCWxEE2fEFfx+JEH1xCnJLJ9/6F6c8ZqS2uslAINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxcll6J5LzJ46Cx;
	Thu, 22 Jan 2026 18:30:43 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 7031E40086;
	Thu, 22 Jan 2026 18:31:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 10:31:10 +0000
Date: Thu, 22 Jan 2026 10:31:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Vikram Sethi <vsethi@nvidia.com>
CC: Srirangan Madhavan <smadhavan@nvidia.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "ming.li@zohomail.com"
	<ming.li@zohomail.com>, "rrichter@amd.com" <rrichter@amd.com>,
	"Smita.KoralahalliChannabasappa@amd.com"
	<Smita.KoralahalliChannabasappa@amd.com>, "huaisheng.ye@intel.com"
	<huaisheng.ye@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, Vishal Aslot <vaslot@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Matt
 Ochs <mochs@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>, Souvik
 Chakravarty <souvik.chakravarty@arm.com>, <james.morse@arm.com>
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
Message-ID: <20260122103109.000049d6@huawei.com>
In-Reply-To: <PH7PR12MB9175CDFC163843BB497073CEBD96A@PH7PR12MB9175.namprd12.prod.outlook.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-8-smadhavan@nvidia.com>
	<20260121112005.00001e80@huawei.com>
	<PH7PR12MB9175CDFC163843BB497073CEBD96A@PH7PR12MB9175.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 21 Jan 2026 20:36:01 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> Hi Jonathan,
>=20
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Date: Wednesday, January 21, 2026 at 5:20=E2=80=AFAM
> To: Srirangan Madhavan <smadhavan@nvidia.com>
> Cc: dave@stgolabs.net <dave@stgolabs.net>, dave.jiang@intel.com <dave.jia=
ng@intel.com>, alison.schofield@intel.com <alison.schofield@intel.com>, vis=
hal.l.verma@intel.com <vishal.l.verma@intel.com>, ira.weiny@intel.com <ira.=
weiny@intel.com>, dan.j.williams@intel.com <dan.j.williams@intel.com>, bhel=
gaas@google.com <bhelgaas@google.com>, ming.li@zohomail.com <ming.li@zohoma=
il.com>, rrichter@amd.com <rrichter@amd.com>, Smita.KoralahalliChannabasapp=
a@amd.com <Smita.KoralahalliChannabasappa@amd.com>, huaisheng.ye@intel.com =
<huaisheng.ye@intel.com>, linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.=
org>, linux-pci@vger.kernel.org <linux-pci@vger.kernel.org>, Vishal Aslot <=
vaslot@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Shanker Donthineni <s=
donthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, Matt Ochs <mochs@n=
vidia.com>, Jason Sequeira <jsequeira@nvidia.com>
> Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-functio=
n reset
>=20

Hi Vikram, Happy new year!

> On Tue, 20 Jan 2026 22:26:07 +0000
> smadhavan@nvidia.com wrote:
>=20
> >> From: Srirangan Madhavan <smadhavan@nvidia.com>
> >>Flush host CPU caches for mapped HDM ranges after teardown and prepare
> >> sibling Type 2 functions on multi-function devices. The host cache
> > >maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+ =
=20
>=20
> >That's not sufficient in general on arm64.  It might flush far enough
> >or there might be buffers beyond the point of coherence that are not
> >flushed. =20
> snip
>=20
> >Needs to some sort of arch_ call as well, not hidden in the cxl driver. =
=20
>=20
> Yes, and in fact it cannot be a cache flush by VA while PTE mappings
> to the memory are valid, as the core can prefetch the lines back
> right away, and later evictions post device reset can cause device
> errors as the device snoop filter isn=E2=80=99t aware of host having any
> lines.

Prefetching should (hopefully) not make any dirty lines. Hopefully
no one does clean writebacks (and there is a way to check if they
do in the ACPI tables).  You need to flush again after to force out
that stale stuff though before any demand fetches occur.

+ don't forget PA based prefetchers.  Doesn't even need to
be a mapping for fetches into distance caches to happen.  A given
platform might have restrictions on where those PA prefetchers will
go but we currently have no way to discover that.

I need to think a bit more on this as there are some scary
comments in the spec on CXL.reset such as all CXL.mem reads
are dropped (timeout fun). Mind you a device is permitted
to do that anyway before cxl.mem is enabled, so hopefully n
one times out if a prefetcher hits the device before that's on..

> The only way to do this correctly is via a SMC call to Arm
> trusted Firmware to handle in SOC specific way (after the memory has
> been offlined and removed from the PTEs), since there is no
> architectural way to flush by PA (set/way isn=E2=80=99t usable in the
> kernel). There was a SMC call defined for this in the PSCI spec 2
> years ago, but was removed for some reason. I had a discussion with
> some ARM folks maintaining the PSCI and SMCCC specifications and the
> direction was to bring the SMC call back in SMCCC specification. Like
> you say, that can be a separate patch series. Adding Souvik for SMCCC
> specification details once it is available.
>=20

There are other possible paths which is where drivers/cache stuff
came from.+CC James Morse.

=46rom a kernel point of view SMCCC needs to be just one option as a
bunch of hardware (I'll only point at ours as not sure what else is
public) provide MMIO accessible agents to do this stuff and going via
EL3 to talk to an engine the kernel can poke directly is silly.

I'm not against the PSCI thing coming back though if someone needs it.
Preferably without the CPU rendezvous stuff though -> or Linux can
just reject anyone who does that.

We could also revisit the approach of using an AML op region to issue
the SMCCC, thus allowing us to support vendor SMCCC calls (+ a general
one if ARM do bring that back) or whatever magic they want to use.
https://lore.kernel.org/all/20250820102950.175065-8-Jonathan.Cameron@huawei=
.com/

Advantage of that is you can wrap SMCCC, MMIO or whatever else you like
up and the kernel only needs one driver.  Disadvantage is need a spec
and only ACPI etc so we need a driver anyway if anyone cares on DT systems.=
..

If you want to mess with that I can dig out the QEMU emulation and rebase
that driver.  I thought it was kind of cute, just a solution we didn't need
at the time!

Jonathan

