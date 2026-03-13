Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D4332EB1;
	Fri, 13 Mar 2026 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410762; cv=none; b=uGoZ1ZxArMkmXIzWD1rIlU8pqd1NvxTEcLqN3zA8zf5xb30C5a8s2eDKqu1isOOjEUt3XVANWiYiL/jQTo4wjnyl58Bgj22H1pV82FIOcTY2qHxuwYv02PqVhiiaQ2YGxGZbFvUjQ9kyiON2UTWdOJhRjD3xCAdO2/oJsPbZVdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410762; c=relaxed/simple;
	bh=CtWBsxNWkPj8OE14jFaHauUv7MbBm2S14GcKwHf3QlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAVhUN5lJ+MQkjaU4BQGRBI9egJWfWIu/mXuInYYR5YdoT6/7+72TTQBBNl+dlV99c8v6X9a9+jkAKzJnGD3DQYcHWZPVg1yX3FmwbXNQ3TtnlL9der/mnCMI0E5/58DZM2XPkYrBZMw/UIEOB0URuUXhS/K6SCfQjsqsUt/y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohqqRSxe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohqqRSxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30084C19421;
	Fri, 13 Mar 2026 14:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410761;
	bh=CtWBsxNWkPj8OE14jFaHauUv7MbBm2S14GcKwHf3QlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohqqRSxeyqxwDPUmrevk/jyKsdpNpcf9V9MhgfY7ddRP7pk1g9yy5wKLEnhwnredY
	 u+DEI5H1qe8jDeUzia1TzGuGNyk0tkBJGqp63AAgnCKmZ0jAYCswFC+yVax99omKrq
	 tqr0rJA4uvt0dXWrX14ledkG2neVs/98nsxG2D/RPC/kVrThQgRwO5T44A22amvS0E
	 ON+ph8o3qz/fksqt9NXCeOiW11EesdVvALyC84cf13lmWXXQ0pQ48zvz1lBGUVU/QN
	 A2tNA5jlRVqZKeCpnZxvBeJd0KX+1oL6lPymtJToWcBt8bC3ZCrFHc82PI+D+Ka5x+
	 GHKGamJ27plpA==
Date: Fri, 13 Mar 2026 19:35:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Hans Zhang <18255117159@163.com>, Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Grimmauld <grimmauld@grimmauld.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, driver-core@lists.linux.dev, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Enable async probe by default
Message-ID: <gm7p37yom64doo3bbrcri3chbrzpm5zifqk256qqla2krhrrrw@tknda7rvjklv>
References: <177260693908.10259.13055467642416391434.b4-ty@kernel.org>
 <87bc37ee-234c-4568-b72e-955c130a6838@arm.com>
 <f7tfshf7riljjibuqge4ubfjmludubpyh3ppdf6lasurzdzbtj@sw4xxagfhnn3>
 <5d88fb5b-e771-4ea6-8d2c-c5cfd21e5860@arm.com>
 <qwanhqrpztzkudik5fmberhabnzaly7v53677dohqzj5nq4wi2@6ndpiubyxcbi>
 <DGZXF3LPSRK6.2QYN63QTKUQAX@kernel.org>
 <cp5uktfqdf6zs53qsye57ior2ikmssgevxxdtevkzpisaif22h@7mrxspkuibow>
 <DH09EDBW3X6T.2996UB1CFCAW2@kernel.org>
 <55c28218-1638-4b90-a9cd-a177fb5abcb6@arm.com>
 <DH0TM60TVX5D.20W4O1X696ALA@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DH0TM60TVX5D.20W4O1X696ALA@kernel.org>

On Thu, Mar 12, 2026 at 01:59:52PM +0100, Danilo Krummrich wrote:
> On Thu Mar 12, 2026 at 1:48 PM CET, Robin Murphy wrote:
> > On 2026-03-11 9:09 pm, Danilo Krummrich wrote:
> >>  From a driver-core perspective I think we're rather limited on what we can do;
> >> we are already in async context at this point and can't magically go back to
> >> initcall context.
> >> 
> >> So, the only thing I can think of is to kick off work on a workqueue, which in
> >> the end would be the same as the deferred probe handling.
> >
> > Hmm, in fact, isn't the deferred probe mechanism itself actually quite
> > appropriate?
> 
> Yes, I've also mentioned this in [1], including the fact that it technically
> even complies with the guarantees given by PROBE_FORCE_SYNCHRONOUS. I.e. the
> documentation says:
> 
> 	Use this to annotate drivers that need their probe routines to run
> 	synchronously with driver and device registration (with the exception of
> 	-EPROBE_DEFER handling - re-probing always ends up being done
> 	asynchronously).
> 
> However, I'm still not sure how I feel about this, since I consider this to be
> more like a workaround that just moves things to a "more approprite" async
> context.
> 
> On the other hand, eventually we want everything to work with
> PROBE_PREFER_ASYNCHRONOUS, so maybe it's also good enough for the time being.
> 

FWIW, I'd love to handle this corner case in the driver core and not spawn a
workqueue/thread in the bus drivers as we would end up duplicating it all over
defeating the purpose of PROBE_PREFER_ASYNCHRONOUS flag.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
