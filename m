Return-Path: <SRS0=hWXA=ZB=synopsys.com=Joao.Pinto@kernel.org>
Return-Path: <SRS0=hWXA=ZB=synopsys.com=Joao.Pinto@kernel.org>
Subject: Re: How to improve PCI bug tracking?
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
References: <20170118225332.GA22960@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-kernel@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <014be170-8dfc-d0e7-beba-41c66bd6b8da@synopsys.com>
Date: Thu, 19 Jan 2017 11:16:48 +0000
MIME-Version: 1.0
In-Reply-To: <20170118225332.GA22960@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>


Hello,

Às 10:53 PM de 1/18/2017, Bjorn Helgaas escreveu:
> I want to improve PCI bug tracking.  It feels like our bugs don't get
> the attention they need, and I'm soliciting ideas for how to improve
> this.
> 
> Current situation:
> 
>   - People often report bugs via email to linux-pci.  I think this
>     is good because everybody can see it.
> 
>   - Even after an email report, I often request a bugzilla because
>     (1) it helps keep things from being forgotten, (2) it's a
>     convenient place to store bulky data, and (3) I like to have a
>     bugzilla URL to include in the changelog of a patch that fixes the
>     bug.
> 
>   - Sometimes people open a bugzilla directly.  I get email about
>     these (along with one or two other people), but this is sort of a
>     problem because linux-pci never sees it, sometimes I miss it, and
>     things tend to languish.
> 
>   - Discussion on a bugzilla is only seen by people listed in the
>     bugzilla, not on linux-pci.
> 
> I'm contemplating changing this so the bugzilla mail would also go to
> linux-pci.

I agree with your approach.

Thanks,
Joao

> 
> Any objections or alternate suggestions?
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  https://urldefense.proofpoint.com/v2/url?u=http-3A__vger.kernel.org_majordomo-2Dinfo.html&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=VPUOvpl0WPwnjbNCNU9QIRZYycwLGjHenSFYTNE55aQ&s=-Q0zKU59-QDtodMADouOKavaxZxRqwjeWvMuZ9W1zos&e= 
> 
