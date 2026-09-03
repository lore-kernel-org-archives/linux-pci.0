Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F5503BC7;
	Thu,  3 Sep 2026 20:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465767; cv=none; b=fndxilaMLvUR0wxrqq9uWi6dAnfOfAk0jEqHRVYOf9+qmyzUFH7B7Ohq+TW2lKiYvhjaEDWpN6uHPDPa+OFRgKLCECm2l2Xo6U5IEBwYmQknxBx7oyaMPsCmzv1tIHEx5ripTWLIqxoP6GjXPRVuGgcWL3JWdDoLVx5XJ6OkeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465767; c=relaxed/simple;
	bh=qJJ5raCRpgBI8ewp6BNw1ciVc1vyObw1PwwHYuqV6wE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhAiOmP37RDDgLaFR23RkPHR6tSWaCgMEYyOBpgMSFBFImnvUm5DgGe56622f7iALBONgs3zXydzft6L2ZoPid43TBct9y1PxvDuL3NT9cApyfKnviijFWwlQUms91Xcew7JsLEX9JKCwgAki7bvrXUqYyup1MCpJo2YYbob4AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se9ZMR/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se9ZMR/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878A71F000E9;
	Thu,  3 Sep 2026 20:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465753;
	bh=gz3U4hpdbHxsrgzXwzDUIpXw+xWWSplij4ZGhOwzFyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Se9ZMR/G/E/eiv/UZyOf6tc0jWbzoIkfr+csBi9hlZSVTNWqlNKC8dORlxkpHaeys
	 TgjZzL3vxSZHosXHwBtP0uFsTXB5ZtnDoJ3Aew+xpqiqgFpto9JwD29FmRHfpTopwp
	 vDGqBlLtGh5IAATRJ98+i90aFRh7JAcNdW9raXulVNltif9ZDqAoRVCIHGZOigEw2T
	 COiHbHZqHHwltH1bek2gT3Fb/EolTsr2pBKizoNMAAvHmj9mcZz+aRnsIxqotaQO7e
	 tHYVOe38Upkrdi0Q6Q5B4nI4B9jGgZaOws7/RWsCMBo8mdGAwEIVlI84xvibw4ZS2n
	 bBrfavgJZSWdw==
Date: Thu, 3 Sep 2026 21:02:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Lukas Wunner <lukas@wunner.de>, Alexey Kardashevskiy <aik@amd.com>, Xu
 Yilun <yilun.xu@linux.intel.com>, ankita@nvidia.com,
 linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, Aaron Tomlin <atomlin@atomlin.com>, Alistair
 Francis <alistair.francis@wdc.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>, Donald Hunter
 <donald.hunter@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sami Tolvanen
 <samitolvanen@google.com>, Samuel Ortiz <sameo@rivosinc.com>, Saravana
 Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>, "Fontenot,
 Nathan" <Nathan.Fontenot@amd.com>, rick.p.edgecombe@intel.com,
 yilun.xu@intel.com, Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky
 <leon@kernel.org>, jonathan.cameron@oss.qualcomm.com
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security
 Protocol (TDISP)
Message-ID: <20260903210223.43ec3e03@jic23-huawei>
In-Reply-To: <20260903175332.GN2890729@ziepe.ca>
References: <20260705220819.2472765-1-djbw@kernel.org>
	<4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
	<amk7Xzm5jmz+6SPJ@ziepe.ca>
	<anFE7m164AmchTy/@yilunxu-OptiPlex-7050>
	<20260805005533.GB28508@ziepe.ca>
	<apeF/peEzdxvKeWR@yilunxu-OptiPlex-7050>
	<2e721509-0aee-47ee-b17a-688876e02f74@amd.com>
	<20260902150125.GD2890729@ziepe.ca>
	<apl39vOiMPP7VloW@wunner.de>
	<20260903175332.GN2890729@ziepe.ca>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 14:53:32 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Sep 03, 2026 at 03:36:54PM +0200, Lukas Wunner wrote:
> > Dan was added as third devsec maintainer to host tsm.git:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/
> > 
> > Jonathan and I retain access to both repositories.  
> 
> Fortunately they are on kernel.org so Konstantin can always recover
> anything, we can get to that when there is a community consensus on
> the new team.
> 
> In the short term Linus doesn't care so much about where the tree
> comes from. Personally I'd rather leave that as is until the new team
> is ready to put work into it. It looks like there a number of things
> that may need preservation..
> 
> > > This is the only time Europe could reasonably participate in,
> > > obviously it is not OK for China and Aus.  
> > 
> > FWIW, I'm likewise based in Europe, as is Jonathan.  
> 
> I was wondering if we should try to have two calls on opposite
> sides.

I've shifted, now West Coast US.  However, given many things going
on at the moment, my direct involvement in this may be limited for now.

I'll be pulling in some other Qualcomm folk though to help out where
we can. Most like mixture of US and India based folk.

> 
> > Obviously, one cannot separate discussing Dan's work from Dan.  
> 
> Yes, please lets all have patience and understanding
> 
> Personally I feel seeing the overall work finished and products using
> it in the market will be a "in memorandum" dedication for Dan.

Fully agree with this sentiment as one of the ways to remember Dan.

Jonathan

> 
> Jason

