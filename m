Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093F4AAC64;
	Wed, 16 Sep 2026 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572868; cv=none; b=PXuWKhU+MJKjEV9l4N6/ofd93jbWOJRN+PQ7ISz3IeNlzAB0thSTmoKzc/S67eieCx7qB59q5JbOinJ3F3nd4pl0dvTqSuzuAJTPJwpdK3RRHUag5qxD0aY8t4wswajae7GrImU/5onKxIP/nTyJrSP5rkZI72VexsFhow8jK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572868; c=relaxed/simple;
	bh=8KVZvc2FJNj6IxVNM7DlKWXAT1xSvoo/C8QRFxbq9rU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GfpmYzPAKWa32+AvZ9czMeW9Zq7heNRdv3m2C3o8zswGP7vmIj1h7Uhp1sUrvvLjCGtWzDcwgF09b0UUK0TlyPqMfrKhnwe05KcmZDIQdRWuqY4cEOJAbPHyhYRk8gGekGZ0vSIzKGSe/3dzHYVWVP/wXVp4cqpNPa8BgHOnLZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D80nzYBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D80nzYBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0D81F000FF;
	Wed, 16 Sep 2026 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789572860;
	bh=+WE/ni2n64GzSwGl4/8BrY2QKJyiDAfM8u2nswU6w9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=D80nzYBCwy1SsvxrDUO3O9v+afefJli1iZG+x6jQqs+eLXCQkiuB/+uBqKRHRWzuk
	 h98XMoxoMkbKBoy/63JRqznhsKDrtCamFieVqeh23RAah9X81hxDIX0/E++9aUn5cM
	 kxzv4MhQl3DFu/Ej1+jD9eEEYHfHb+OzWx9QVmRYfgD7RbrbbwrbeGWNkGwLisLE2C
	 iKMn/wN+mA5LtqL7C6Kd4GDK7VAVdni+ON5eXMB9LdfAlXzcBM3nLEn618rh2boT/a
	 UZzebmF7w6m/Ucow9rXvdw7aF8jMVdfHgeE3yy/+RqhzTiUl0auF+cgAL/m0iXeHl2
	 992jExJAZozog==
Date: Wed, 16 Sep 2026 10:34:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>,
	Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
 with RC power loss
Message-ID: <20260916153418.GA925718@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB120193844E13EAAF122C426448CB92@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Wed, Sep 16, 2026 at 04:00:24AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Thursday, July 30, 2026 6:30 AM
> > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de;
> > lpieralisi@kernel.org; kwilczynski@kernel.org; mani@kernel.org;
> > robh@kernel.org; bhelgaas@google.com; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev; linux-
> > kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> > Subject: Re: [PATCH v2] PCI: dwc: Add suspend_poweroff flag for platforms
> > with RC power loss
> > 
> > On Fri, Jul 17, 2026 at 03:41:21PM +0800, hongxing.zhu@oss.nxp.com wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > >
> > > Some platforms like i.MX power off their PCIe RC controllers
> > > during system suspend, requiring full re-initialization on
> > > resume. These platforms need to enter L2 state to properly
> > > notify endpoints before power loss.
> > >
> > > According to PCIe base spec r7.0, sec 5.2, the system software
> > > should transition the device into D3Hot before broadcasting the
> > > PME_Turn_Off message to initiate L2 entry. However, some
> > > endpoint devices fail the D3cold capability check in
> > > pci_host_common_d3cold_possible(), which would normally prevent
> > > L2 entry.
> > 
> > Wakeup devices that don't support PME from D3cold will fail the
> > D3cold capability check, but I don't think those are the problem
> > you're solving.
> > 
> > This appears to handle devices that are not in D3hot, and that's
> > not a property of the endpoint; it's a property of its driver.  Is
> > the problem here that some driver didn't put its device in D3hot?
> > 
> > > For platforms where the RC loses power during suspend, L2 entry
> > > is essential regardless of D3cold support, as the link will be
> > > lost anyway.  Add a suspend_poweroff flag to force L2 entry in
> > > such cases, and enable it for i.MX PCIe controllers.
> > >
> > > Note: This violates the spec requirement that devices be in
> > > D3Hot before PME_Turn_Off, but is necessary for proper operation
> > > on platforms with RC power loss during suspend.
> > 
> > If the device isn't in D3hot, it may still be active, and I think
> > the PME_Turn_Off will abort any DMAs in progress, which doesn't
> > sound like proper operation of the endpoint.
> 
> I apologize for not addressing your concerns promptly. Let me
> clarify the issue after reviewing this more carefully.
> 
> The problem I'm addressing:
> 
> L2 entry is being blocked for wakeup-capable devices that fail the
> D3cold capability check in `pci_host_common_d3cold_possible()`, even
> when the device is already in D3hot state.
> 
> Specifically:
> - The endpoint device is in D3hot (the driver has done its job correctly)
> - However, because it's a wakeup device that doesn't support PME from D3cold,
>   it fails the D3cold capability check
> - This failure currently prevents L2 entry, even though the device is already
>   in the required D3hot state as per the spec
> - For platforms like i.MX that power off the RC during suspend, we need L2
>   entry to properly notify the endpoint before power loss and complete
>   reinitialization successfully on resume.
> 
> So, the issue isn't about forcing devices into D3hot or handling
> devices that aren't in D3hot - it's about allowing L2 entry for
> devices that are already in D3hot but happen to fail the D3cold
> capability check due to wakeup requirements.
> 
> Regarding your concern about the commit message:
> 
> > "If the device isn't in D3hot, it may still be active, and I think
> > the PME_Turn_Off will abort any DMAs in progress, which doesn't
> > sound like proper operation of the endpoint."
> 
> You're right. The commit message note about "violating the spec
> requirement" is misleading and incorrect. The endpoint device is in
> D3hot (the driver has done its job correctly), so it's compliant
> with the spec requirement. I should remove or reword that note in
> the next version.
> 
> Would you mind if I resubmitted the patch and used clearer
> submission information to accurately describe this situation?

Of course not, please do!

Bjorn
