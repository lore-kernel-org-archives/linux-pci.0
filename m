Return-Path: <SRS0=1wwC=ZA=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=1wwC=ZA=codeaurora.org=okaya@kernel.org>
Subject: Re: How to improve PCI bug tracking?
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20170118225332.GA22960@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <88c6fcac-78d7-e2fd-e08f-62149b34e996@codeaurora.org>
Date: Wed, 18 Jan 2017 18:29:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170118225332.GA22960@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 1/18/2017 5:53 PM, Bjorn Helgaas wrote:
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

I have seen this happening on linux-scsi.

http://www.spinics.net/lists/linux-scsi/msg103272.html

I'd say, why not?

> 
> Any objections or alternate suggestions?
> 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
