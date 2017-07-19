Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:32863 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdGSFhC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2017 01:37:02 -0400
Received: by mail-wr0-f180.google.com with SMTP id v105so23265654wrb.0
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2017 22:37:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170718121618.6eea460f@w520.home>
References: <1500338752-30576-1-git-send-email-fkan@apm.com>
 <20170717202324.105e993c@w520.home> <CAL85gmAsjSiThTujA=tbhceOd71ee3AVmGDaFhc3FMFWDsQ4HA@mail.gmail.com>
 <20170718121618.6eea460f@w520.home>
From: Feng Kan <fkan@apm.com>
Date: Tue, 18 Jul 2017 22:37:00 -0700
Message-ID: <CAL85gmASr719MHsco8GpSfG+xyxkR2gSQA8KbpoAx_NAbRNJxQ@mail.gmail.com>
Subject: Re: [PATCH] pci: quirk: Apply APM ACS quirk to XGene devices
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Jonglih (Daniel) Yu" <jyu@apm.com>,
        "jcm@redhat.com" <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>
> I don't know what that means, does the hardware support an equivalent
> to source validation or not?

Yes, source validation is done through the smmu.

  What's the response of the root port if
> the downstream device issues a transaction spoofing devices not within
> the bus number ranges of the bridge?
HW guys informs me there is way to disable transactions between root port.
I will confirm later.

>
>> Alex, the goal here is to enable virtualization to work correctly.
>> Please let me know if the
>> above is sufficient. Much thanks.
>
> Of course, but that means that the hardware vendor is vouching that
> this device provides the equivalent isolation for each of the missing
> components of ACS.  Claiming to have isolation capabilities that don't
> exist would be irresponsible and put users of that hardware at risk.
Agreed, I believe we do have isolation in our case based on the conference
we had today.

> Thanks,
>
> Alex
