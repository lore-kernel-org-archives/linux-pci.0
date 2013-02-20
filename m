Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from col0-omc3-s9.col0.hotmail.com ([65.55.34.147]:3035 "EHLO
	col0-omc3-s9.col0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758487Ab3BTTBO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 20 Feb 2013 14:01:14 -0500
Message-ID: <COL002-W10189D7B4C89FE14A17AE16D4F60@phx.gbl>
From: Pramod KS <prsudhee@outlook.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: Linux reserved MSI - how many?
Date: Wed, 20 Feb 2013 19:01:14 +0000
In-Reply-To: <20130220141846.GB5705@kroah.com>
References: <COL002-W3294F1D83AA5EB392D867DD4F50@phx.gbl>,<20130220141846.GB5705@kroah.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

----------------------------------------
> Date: Wed, 20 Feb 2013 06:18:46 -0800
> From: gregkh@linuxfoundation.org
> To: prsudhee@outlook.com
> CC: linux-pci@vger.kernel.org
> Subject: Re: Linux reserved MSI - how many?
>
> On Tue, Feb 19, 2013 at 09:07:09AM +0000, Pramod KS wrote:
> > I'm tasked to find out number of MSI that kinux kernel reserve for itself.
>
> What do you mean by "reserve for itself"? And why do you need this
> number, what will you do with it?

I've been told that kernel reserve 16 out of 256 MSI available for itself to get CPU attention - I'm not sure what kernel really does with these 16 MSIs'.
I need this number because we are configuring a failrly complex PCIe system ( Gen 2) and we are hitting limit of maximum 256 possible MSIs'. We need to budget the available 256 MSI across whole system and for now we have allocated 16 MSI for linux kernel. Now, I speculate if kernel really needs these MSI and if yes, where can I see the description, if any, on how and why kernel uses these MSI'?

>
> > I'm not sure where to find the exact numbers.
>
> Have you run in MSI mode and looked?

You mean, enable MSI while building kernel and spin that kernel to see the MSI usage?
Yes, but what do I look for?



>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html 		 	   		  