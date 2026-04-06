Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1643182D0;
	Mon,  6 Apr 2026 01:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775439115; cv=none; b=u/XQbTyU4nYg+fGzOMvcRiJh5cRg+T42He1l2JTGbKTfdviyeKPZPp+/V+ehMsiXy2lo+tE8fdNJ3fdaPFCbqZtyopCzhZqzMpZJsbBgEu7cT2qMbadBtCcOi0cOVmnbSihz9cOGd9ds9ug/uVkkVXVNnpElGbtigNNJ+tvNqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775439115; c=relaxed/simple;
	bh=2/d3VES2wtYS1eTthHKPdxu/CyepSxHlBICjf23XUW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwWk5BmWSp2dQrEBgY/x3OpLmscvB/co/2NtIOUDFcLs1DKSPtVsFnGw7+1FpZqEL2HxhmgW8870mDIf+VvIPt28taAKQ4nYOKLiohrIycV4jK8okAyruaYY2DFX/iUP60TbNwdavjPXs+TRlVLt+M80AuIIvdY1BvTB+h/V/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojTB78Wc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojTB78Wc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BDCC116C6;
	Mon,  6 Apr 2026 01:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775439114;
	bh=2/d3VES2wtYS1eTthHKPdxu/CyepSxHlBICjf23XUW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojTB78WcBboNtkuXi0RdMyTlUAP0WxEsTmQp2++sm+2T6hj0s3PhqjCNYRA56Sr8D
	 1F/Y+HKXoF2KxFVWGVmVTbNq4c4Qj988LpFTRHV0YQvpXDqJ6OwHdRUNUZBCYT474l
	 Fb3zDjJgr1vBLzBv2sPTt/gg8eb9wYmgB6sRNACisgV+ijzkBf9JbybU07h8kIF8Ru
	 vdF07GI1lhUg3OpmN36G0LXcS9aZ16SWoy1QrYbIG9GG0142wfYKiadEAle/wIrvUy
	 LnJgRhBpuy30pi8NQ2lcgqQMXV4w0rfT963bIek/tf9UlUhueJq/Pl9c8x1lHgGVCd
	 pTXD2Alia+t3Q==
Date: Mon, 6 Apr 2026 09:31:50 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] usb: cdnsp: Add support for device-only configuration
Message-ID: <adMNBsPYNg497Doa@nchen-desktop>
References: <20260331-device_only-v1-1-00378b80365c@cadence.com>
 <ac9WnY5C+yTVi0X/@nchen-desktop>
 <PH7PR07MB9538FCAFEBF0072EA5B5B815DD5EA@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538FCAFEBF0072EA5B5B815DD5EA@PH7PR07MB9538.namprd07.prod.outlook.com>

On 26-04-03 10:33:52, Pawel Laszczak wrote:
> >>
> >> +	if (cdns->no_drd) {
> >> +		cdns->version  = CDNSP_CONTROLLER_V2;
> >> +		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
> >
> >With "no_drd", are configurations fixed, no other options?
> 
> Yes, no other option.

Is it possible for host-only configurations?

Peter

> 
> Pawel
> 
> >
> >> +		return 0;
> >> +	}
> >> +
> >>  	regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
> >>  	if (IS_ERR(regs))
> >>  		return PTR_ERR(regs);
> >> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h index
> >> 406abf629be2..a931fb201402 100644
> >> --- a/include/linux/pci_ids.h
> >> +++ b/include/linux/pci_ids.h
> >> @@ -2424,6 +2424,7 @@
> >>  #define PCI_DEVICE_ID_CDNS_USBSS	0x0100
> >>  #define PCI_DEVICE_ID_CDNS_USB		0x0120
> >>  #define PCI_DEVICE_ID_CDNS_USBSSP	0x0200
> >> +#define PCI_DEVICE_ID_CDNS_UDC_USBSSP	0x0400
> >>
> >>  #define PCI_VENDOR_ID_ARECA		0x17d3
> >>  #define PCI_DEVICE_ID_ARECA_1110	0x1110
> >>
> >> ---
> >> base-commit: 5196f2c98340297e1fdd36555285e991ceddf776
> >> change-id: 20260331-device_only-192d539430b5
> >>
> >> Best regards,
> >> --
> >> Pawel Laszczak <pawell@cadence.com>
> >>
> >>
> >
> >--
> >
> >Best regards,
> >Peter

-- 

Best regards,
Peter
