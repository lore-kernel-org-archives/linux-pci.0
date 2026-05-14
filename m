Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29073A6B76;
	Thu, 14 May 2026 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778799268; cv=none; b=N+wn4le9WiJwQgmjRePl/3o5LjxvtdPrPXYVb40A1MoXW2paOpTdVUGC9Vv0xuaaBAWKVxWr0ETpkM1ghI9Lf/bleqA7CNpoiOi0nrEwaUjNX90y9fAZ+ZyBBtJUMfod758h9ShwroFENpl8AfT1jvMCWVIFM8/df0o6O4Ne5mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778799268; c=relaxed/simple;
	bh=V28hjOaAnmBMgpEZgMkM6AYG1yahj8QOBtL7VQ6JgnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aiNbnrH0sJkAUE0k4eK6NBrliHKelnIFMd/jG8LGh0X0f0jyA46QNpxAQKhFJofKrY9aBfRabUON5GJojfXnSiY5A3L65eU+lKcQeqxmqMPgX1iOkYnXq5DDVDEqB66uojdtIg30sb6AlwWaKgjIfGBKGdN79ZaQgkPfVGyyuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfai8ns5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfai8ns5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22180C2BCB3;
	Thu, 14 May 2026 22:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778799268;
	bh=V28hjOaAnmBMgpEZgMkM6AYG1yahj8QOBtL7VQ6JgnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mfai8ns5UAvaEaXCXFbfsG4ecZWU/uEml4YgLDNYlV/hKZVkdvlw3jiEZbEXTc1qZ
	 kOv6oj+t0pwKkrkoIfurPX5B8qzlIl1GGihmiOHKPoGjjf+LAzKhPN/wJffHjxJm8I
	 KNkHZhuf9r3fqK2XpnC7Xh0EM9pHpq7xDlgqlrDV0/Iz/ifFH1gYhz8/kgq/PRW/vO
	 scYbo8/UeG948JXcXtahYX4SkYg5fIhMBR1i29WoC8fnsKNS9+Nau3DCgridNAK/ed
	 OG5D4uPIYOGVbc46fX/49GT7fYKY7kJD3lpIT3kD6p+8/qbeCT8WrkIDIZZaaCc9tY
	 +VlbvzSObHe/A==
Date: Thu, 14 May 2026 17:54:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Message-ID: <20260514225426.GA441423@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c6a9ff7-95b2-47dd-87c2-62eec4aefbb1@amd.com>

On Thu, May 14, 2026 at 12:14:29PM -0500, Mario Limonciello wrote:
> On 5/6/26 10:27, Bjorn Helgaas wrote:
> > On Wed, May 06, 2026 at 10:10:47AM -0500, Mario Limonciello wrote:
> > > On 5/5/26 23:53, Mika Westerberg wrote:
> > > > On Tue, May 05, 2026 at 08:09:22PM +0200, Rafael J. Wysocki wrote:
> > > > > On Tue, May 5, 2026 at 12:53 AM Mario Limonciello
> > > > > <mario.limonciello@amd.com> wrote:
> > > ...
> > 
> > > > > > +        * For devicetree platforms, enable L0s and L1 by default.
> > > > > > +        *
> > > > > > +        * For removable devices (e.g., Thunderbolt/USB4), enable L0s and L1
> > > > > > +        * by default if BIOS didn't configure any ASPM states. This handles
> > > > > > +        * hotplugged devices where firmware may not have configured ASPM.
> > > > > > +        */
> > > > 
> > > > Only L1 is supported over TB/USB4 tunnel (no L0s, no L1 substates). The
> > > > PCIe endpoint and the downstream port it connects to of course can support
> > > > the full range as that's a real PCIe link.
> > > 
> > > OK - the comment should be updated but I do expect that below code
> > > (link->aspm_support) should remain OK.
> > 
> > TB/USB4 are examples of removable devices but they're not the only
> > ones, so I think it's OK for the comment to mention L0s.  In fact, it
> > *should* mention L0s since the code below includes L0s, and mentioning
> > only L1 would just be confusing.
> > 
> It sounds like you're suggesting no changes to this proposal then, right?

I'm fine with the comment mentioning "L0s and L1", which matches the
code:

  if (link->aspm_support & PCIE_LINK_STATE_L0S)
          link->aspm_default |= PCIE_LINK_STATE_L0S;
  if (link->aspm_support & PCIE_LINK_STATE_L1)
          link->aspm_default |= PCIE_LINK_STATE_L1;

Sashiko had several comments.  I'm hoping for those to be addressed or
responded to.  Unfortunately the complexity of the ASPM code means the
sashiko comments are also very complicated and a lot of work to go
though.
