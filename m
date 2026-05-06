Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF675481A88;
	Wed,  6 May 2026 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081243; cv=none; b=PW3VYnMfe0qA3kio+mVp/FwFE0NpvD8/qv46aV06UoiDy/IuNbOIIWK8MvD6lh3c1T1ObtH2PLxTX8orSYikI6fvcfQfgfOM+iWpT+GYc+cnhfOxZa4Vo8fDrlpgsWwvItdg8xJMLDw40dLIxLK1mumDbo59w4CtkNq9lM0L97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081243; c=relaxed/simple;
	bh=/esJ3YZzJyUy0eSG2B1OUUhXRvgwi5HAS2K4p+IHGC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qSqPQ8xseJLcOZSvd++leJI536Hi2Bxi+umT9u50v44oID9tsK6eBLTQ/qumriLygoka+ujjgJofL56Mj4BJ4DQlHmNzWEkpGJQ9wJetdEylc9TM3oYaDjsneN/FN230Iij0iTje2dNdKVDlVlHGscowI4MZoxXeFW59fkDEyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXiBhoMn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXiBhoMn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3743FC2BCB8;
	Wed,  6 May 2026 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081243;
	bh=/esJ3YZzJyUy0eSG2B1OUUhXRvgwi5HAS2K4p+IHGC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sXiBhoMnxelMDo7XuHsQRgwe5WMn3QMjnZQ1ISsasxyD4PkDOsyvxS4BwyPbX6SEW
	 u9ENb/+9pzLbJbPz4CsqFrgoXV4cK10PpJ34b3+0gYm6DVmkqKAFpTnJZVPYmH6mNP
	 5VNuV2EynXiGD7qzXSOxwZw/wMsd+0rqyGCW0db7ALpL9YjbhJBMUrT9HbGjjF8sET
	 pPzXshX5V0ovW4Xx0UMdgoZacs8LN/q8AcumCQSvRAE1JikUGLqbwFNcZ67tsr3hrM
	 55000kvAplWDvFzY6jEZyRsx5yu9b3t/cea6OoyfHNICnC+G4avMyMlwt22LyaMFNZ
	 lkppYB8w+eVWQ==
Date: Wed, 6 May 2026 10:27:21 -0500
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
Message-ID: <20260506152721.GA790227@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a6ffd678-65ee-43a0-a9f2-99d45126f5b0@amd.com>

On Wed, May 06, 2026 at 10:10:47AM -0500, Mario Limonciello wrote:
> On 5/5/26 23:53, Mika Westerberg wrote:
> > On Tue, May 05, 2026 at 08:09:22PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, May 5, 2026 at 12:53 AM Mario Limonciello
> > > <mario.limonciello@amd.com> wrote:
> ...

> > > > +        * For devicetree platforms, enable L0s and L1 by default.
> > > > +        *
> > > > +        * For removable devices (e.g., Thunderbolt/USB4), enable L0s and L1
> > > > +        * by default if BIOS didn't configure any ASPM states. This handles
> > > > +        * hotplugged devices where firmware may not have configured ASPM.
> > > > +        */
> > 
> > Only L1 is supported over TB/USB4 tunnel (no L0s, no L1 substates). The
> > PCIe endpoint and the downstream port it connects to of course can support
> > the full range as that's a real PCIe link.
> 
> OK - the comment should be updated but I do expect that below code
> (link->aspm_support) should remain OK.

TB/USB4 are examples of removable devices but they're not the only
ones, so I think it's OK for the comment to mention L0s.  In fact, it
*should* mention L0s since the code below includes L0s, and mentioning
only L1 would just be confusing.

> > > > +       if (of_have_populated_dt() ||
> > > > +           (dev_is_removable(&pdev->dev) && !link->aspm_enabled)) {
> > > >                  if (link->aspm_support & PCIE_LINK_STATE_L0S)
> > > >                          link->aspm_default |= PCIE_LINK_STATE_L0S;
> > > >                  if (link->aspm_support & PCIE_LINK_STATE_L1)
> > > > --
> > > > 2.43.0
> > > > 
> 
