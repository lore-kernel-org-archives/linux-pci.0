Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934851AbdGTWTI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jul 2017 18:19:08 -0400
Date: Thu, 20 Jul 2017 16:19:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Feng Kan <fkan@apm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Jonglih (Daniel) Yu" <jyu@apm.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Subject: Re: [PATCH] pci: quirk: Apply APM ACS quirk to XGene devices
Message-ID: <20170720161905.24e300eb@ul30vt.home>
In-Reply-To: <CAL85gmASr719MHsco8GpSfG+xyxkR2gSQA8KbpoAx_NAbRNJxQ@mail.gmail.com>
References: <1500338752-30576-1-git-send-email-fkan@apm.com>
        <20170717202324.105e993c@w520.home>
        <CAL85gmAsjSiThTujA=tbhceOd71ee3AVmGDaFhc3FMFWDsQ4HA@mail.gmail.com>
        <20170718121618.6eea460f@w520.home>
        <CAL85gmASr719MHsco8GpSfG+xyxkR2gSQA8KbpoAx_NAbRNJxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 18 Jul 2017 22:37:00 -0700
Feng Kan <fkan@apm.com> wrote:

> >
> > I don't know what that means, does the hardware support an equivalent
> > to source validation or not?  
> 
> Yes, source validation is done through the smmu.

The SMMU does a context lookup based on the bdf, but if the root port
does not support SV, what is it that prevents the device from spoofing
a different bdf?  How does the smmu intercept this?  Thanks,

Alex
 
>   What's the response of the root port if
> > the downstream device issues a transaction spoofing devices not within
> > the bus number ranges of the bridge?  
> HW guys informs me there is way to disable transactions between root port.
> I will confirm later.
> 
> >  
> >> Alex, the goal here is to enable virtualization to work correctly.
> >> Please let me know if the
> >> above is sufficient. Much thanks.  
> >
> > Of course, but that means that the hardware vendor is vouching that
> > this device provides the equivalent isolation for each of the missing
> > components of ACS.  Claiming to have isolation capabilities that don't
> > exist would be irresponsible and put users of that hardware at risk.  
> Agreed, I believe we do have isolation in our case based on the conference
> we had today.
> 
> > Thanks,
> >
> > Alex  
