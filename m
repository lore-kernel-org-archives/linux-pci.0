Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA6270545;
	Thu, 23 Apr 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957351; cv=none; b=fniHchefDZXJZI/sJjQa1LatGDLicoGAJFimXO1Oi3E3tImLn/35pgvUzGv5j3VVJ1eH9zI2VoMqO4wzLuRkM1LS4KkDGy92hkGrmw0nofVAUT53lxFIeoev+nzLY1wxMhAIv/+80PiUk7atWEfMinGse+Mwlea4vEBsm0ERteY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957351; c=relaxed/simple;
	bh=oTqmn846eDcPC24miKu77LDWVbxha/8Sm/ChagtCJQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgRQS0C55+f3zo5lScrJfyauwZSPSfNQA1fCiMp2DfHoFX5ZM21lQvTKnhea0xkgSoAQpRdt3neZ/5oFVbpfp7o972i58iHicZ7zddW/JSnIqJwJSsFzd0JKyudWpWLlH8lLmg0ifqsYE0DA2W9qsgwD3SSyklU8ZHI1px+DqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozdPHSNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozdPHSNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7700EC2BCAF;
	Thu, 23 Apr 2026 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776957351;
	bh=oTqmn846eDcPC24miKu77LDWVbxha/8Sm/ChagtCJQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozdPHSNwwS+Qj7yZnttq+jJAL8YEIfTguuS/p1JGVEk1aeJOKb2+AXsxTGKTvst7u
	 Rj2vnFjITKXV7jty01dmvewi9Umeic+hyQfHBhrAObX+n7nXSnssl4vzdSTvKkspYU
	 y9GyeEjEj4Qpj51X5awiIumPfMCm7u+WSk7Phyqv7PQaYXquWVtVyw2GJ4rYtN0RYX
	 SCtR08dlfMJgPB5m5dutcaJZ2s+qwB7tvAI0dxyEUzQtaMYPSGngzwJEVMgf80A5tn
	 4tS0GeZkR5dkI81b9I8QrOeyn9AYOxbNbpDn8wvJ2vtpKKD4Il6o2HLdjwAGKi3TX+
	 /QDJlG8jSIjHA==
Date: Thu, 23 Apr 2026 20:45:42 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] PCI: qcom: Indicate broken L1ss exit during resume
 from system suspend
Message-ID: <sssgkayhnxjbgav3jfkroyk4usez7rjbktjlurubovhq5bvf2m@aupvtrjxiuu4>
References: <bkejoqdchyv55efsyl7o6b3ewiwaj5kbc2hgltxt5vwqdvt5yf@cxvwcjo5zcrp>
 <20260422234938.GA416865@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422234938.GA416865@bhelgaas>

On Wed, Apr 22, 2026 at 06:49:38PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 21, 2026 at 10:41:08PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 20, 2026 at 03:49:15PM -0500, Bjorn Helgaas wrote:
> > > On Sat, Apr 18, 2026 at 11:09:11AM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Apr 17, 2026 at 05:26:15PM -0500, Bjorn Helgaas wrote:
> > > > ...
> > > 
> > > > > Does L1.2 have to meet the advertised L1 Exit Latency?  I assume
> > > > > maybe it does because I don't see an exception for L1.x or any
> > > > > exit latencies advertised in the L1 PM Substates Capability.
> > > > 
> > > > As per my understanding, 'L1 Exit Latency' only covers ASPM L1
> > > > state, not L1ss.  Because, 'L1 Exit Latency' field exists even
> > > > before L1 PM Substates got introduced in r3.1. So it doesn't cover
> > > > L1.2 exit latency.
> 
> FWIW, this FAQ from https://pcisig.com/faq?keys=3.0 confirms your
> understanding:
> 
>   Section 7.8.6 - Is the L1 Exit Latency in the Link Capabilities
>   register only the ASPM L1.0 exit latency or does it include the
>   added ASPM L1.2 to ASPM L1.0 latency?
> 
>     The ASPM L1 Exit Latency in the Link Capabilities register
>     indicates the L1/L1.0 to L0 latency, and does not include added
>     latency due to Clock Power Management, L1.1 or L1.2.
> 

Thanks for cross checking.

> > > > > Regardless, I'd be kind of surprised if *any* system could meet an
> > > > > L1.2 exit latency from a system suspend situation where PHY power
> > > > > is removed.  On ACPI systems, the OS doesn't know how to remove
> > > > > PHY power, so I don't think that situation can happen unless
> > > > > firmware is involved in the suspend.
> > > > 
> > > > Yes, you are right. Even for systems turning off the PHY completely,
> > > > they should have some mechanism to detect the CLKREQ# assert and
> > > > turn ON the PHY within the expected time.
> > > 
> > > What would the expected time be?
> > 
> > That's mostly L10_REFCLK_ON + T_COMMONMODE. But nevertheless, the
> > system wakeup and controller driver resume() time would be far
> > greater than it.
> 
> This patch sets "pp->bridge->broken_l1ss_resume = true".  I'm trying
> to understand how we know to set this.  There might be other platforms
> that need to do this but I don't know how to identify them.
>

As I said earlier, if the other platforms do not have any hardware mechanism to
detect CLKREQ# assert and enable refclk/establish common mode voltage, then they
would also suffer from the same issue. But it is not possible to identify them
only by looking at the host controller driver. Because, even if the controller
driver power off the PHY, some other hardware entity could be handling CLKREQ#
and taking care of refclk/common mode voltage.

So this flag should only be set when the host controller driver is solely
responsible for controlling refclk.
 
> This comment:
> 
>   + * Some host bridges power off the PHY to enter deep low-power modes
>   + * during system suspend. Exiting L1 PM Substates from this condition
>   + * violates strict timing requirements and results in Link Down (LDn).
>   + * On such platforms, the endpoint must be prepared for context loss.
> 
> suggests that the L1.2 exit takes too long and results in the link
> going down, which is essentially a reset for the downstream device,
> which would destroy the context.
> 
> Is there some spec language that determines how long the Downstream
> Port waits for the L1.2 exit before it gives up and decides the link
> is down?

Spec r7.0, sec 5.5.3.3.1 defines the timing requirements for refclk restoration
and common mode recovery. But it doesn't specify what happens when these timing
requirements are not satisfied by the downstream port and this could be the
implementation behavior. On the Qcom platforms, we are seeing endpoints giving
up and moving to LDn if they didn't receive refclk within L10_REFCLK_ON.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
