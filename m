Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2351727A91D;
	Thu,  3 Sep 2026 05:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413762; cv=none; b=ulhoyzll/DrRvOz62wctcBfc7TagOCQVElZUBSaqJIFru894wuRauai91WMlA2rYlwpcR3b+wheVV4+jyEqdsztWRZ7a14NEUtTx1YqcRCVVqCYwpnD4QkZV+gFMHPRYutwpZ4UWTYVNetdTBL4gFQ7PYGtz4oYtAdr/8p1hwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413762; c=relaxed/simple;
	bh=m6s7G1Z5GduH34WPHbUvn9l9NjcI+pmZA5DaoDuGT+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx2d27Kw+Kw4dXPwbBX4pARO3RAbfNvB2p7/Ubl7R7hRtm6EHk2SoGYcLuioZvWq5wx0y/2upIecqBZ3WlqB/XriQ93RfKGXFWYQfNh0ZpNlotRo7o6+8DsdssHWH0hwgZIqrulczzGjDMBuUdNq4moKnFW4DubIrh2FRfK9nL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8EPFsrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8EPFsrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACFB1F00A3E;
	Thu,  3 Sep 2026 05:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788413760;
	bh=tUA6cs7SSO7VGHiCSGmJHENTOug33QoHWUSWBFOuFB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J8EPFsrVc1+TQ3jk1dYqkSHyOXPwkBJKZp5QF/xXkKTNsYbV5wL6sqo/ZyRI4Zp6C
	 PeIdU+cOPjPtYK6I/NjoGysTJ3S7ooQliGfd7uS5iolcYPk+r8OWbTQS0YdB1lnoYH
	 sAdrHc1Xhv4WdDlnT7yOZa2Jb9zzcZYTAFwd8kwJdbFTlZAsCAPFq3g2mmpDuDrIGM
	 7W1Q2X4Kja+o09f6ryKhmfs739UcbNRwRX+655jSVwlKPHOQNlBn4eg2HvZFVxV4St
	 flGsNRS1o2J6Z5Oh5kqFb1T7EzDOkxGbDl//d1Jv99BYuSstd1akpqvAw9wDthXeAs
	 KtLjuUzrVvq0w==
Date: Thu, 3 Sep 2026 07:35:44 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konradybcio@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI: Allow D3 for native Hotplug capable Root Ports
 on non-x86 platforms
Message-ID: <eefir4nbvksvuhh2dzvwaojifdiuyj5fo3jy2jnsendg5tdvlx@id3vn34pbd4w>
References: <20260811232245.GA805297@bhelgaas>
 <3eeb3465-a1e6-4fdc-8019-3907d9c55691@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3eeb3465-a1e6-4fdc-8019-3907d9c55691@gmail.com>

On Wed, Sep 02, 2026 at 07:09:58PM +0200, Konrad Dybcio wrote:
> On 8/12/26 1:22 AM, Bjorn Helgaas wrote:
> > On Wed, Jul 29, 2026 at 06:50:05PM +0200, Manivannan Sadhasivam wrote:
> >> Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"),
> >> prevented native Hotplug capable Root Ports from entering D3 citing issues
> >> on old Intel SkyLake Xeon-SP platform.
> >>
> >> But there is no reason to restrict D3 for native Hotplug capable Root
> >> Ports on non-x86 platforms. We recently enabled D3 on non-Hotplug capable
> >> Root Ports on non-x86 platforms (specifically for DT platforms) in commit
> >> a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
> >> do the same for native Hotplug capable Root Ports as well.
> >>
> >> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Applied to pci/pm for v7.3, thanks!
> 
> This breaks system suspend entry (crashes the system) on Qualcomm SC8280XP
> CRD.. this SoC is known for fragile PCIe.
> 

If RP D3 is what breaking the suspend, then the breakage should've been present
between below commits:

a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86")
33a76fc3c3e6 ("PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support")

First one allowed D3 on all non-x86 platforms and should've broke suspend. Then
second commit enabled Hotplug for RPs, which prevented D3 until *this* patch
landed.

> It doesn't repro on e.g. the Qualcomm Glymur CRD (2 gens newer), perhaps we
> need an explicit opt-out like
> 
> if (of_machine_is_compatible("qcom,sc8280xp"))
> 
> or some targetted fix inside the qcom driver
> 

Will investigate a bit more and come back. Thanks for reporting!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
