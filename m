Return-Path: <SRS0=0oLo=DL=Oracle.COM=Govinda.Tatti@kernel.org>
Return-Path: <SRS0=0oLo=DL=Oracle.COM=Govinda.Tatti@kernel.org>
Subject: Re: [Xen-devel] [PATCH V3 1/2] Drivers/PCI: Export pcie_has_flr()
 interface
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: jgross@suse.com, Sinan Kaya <okaya@codeaurora.org>,
        Srikanth Jampala <Jampala.Srikanth@cavium.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Satanand Burla <satananda.burla@caviumnetworks.com>,
        linux-pci@vger.kernel.org,
        Felix Manlunas
 <felix.manlunas@caviumnetworks.com>,
        linux-kernel@vger.kernel.org,
        Derek Chickles <derek.chickles@caviumnetworks.com>,
        Christoph Hellwig <hch@infradead.org>, JBeulich@suse.com,
        Russell Currey <ruscur@russell.cc>, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, boris.ostrovsky@Oracle.COM,
        Raghu Vatsavayi <raghu.vatsavayi@caviumnetworks.com>,
        roger.pau@citrix.com
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-2-Govinda.Tatti@Oracle.COM>
 <20171208202424.GC12367@bhelgaas-glaptop.roam.corp.google.com>
 <426eeeab-0dcd-8de3-9c5f-a166acf2c130@Oracle.COM>
 <20171212005919.GB30595@bhelgaas-glaptop.roam.corp.google.com>
 <49956aaf-5fd5-939d-5fc7-231ffdb98b70@Oracle.COM>
 <20171213212420.GH30595@bhelgaas-glaptop.roam.corp.google.com>
 <fea075cf-fe6f-0d0b-11e4-4279fbfc280a@Oracle.COM>
 <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
From: Govinda Tatti <Govinda.Tatti@Oracle.COM>
Message-ID: <0ff910b6-9007-40b3-8943-45339603e868@Oracle.COM>
Date: Fri, 15 Dec 2017 14:01:57 -0600
MIME-Version: 1.0
In-Reply-To: <20171215181801.GU30595@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>


Thanks Bjorn for your response. Please see below for my comments.
>> So, we should consider one of these options.
>>
>> - set PCI_DEV_FLAGS_NO_FLR_RESET if it is not supported.
>> - pcie_flr() should return if it is not supported
>>
>> If we modify pcie_flr() to return error codes, then we need to modify
>> all existing modules that are calling this function.
> Yes, of course.
>
>> Please let me know your preference, so that I can move accordingly. Thanks.
> I think Christoph volunteered to do some restructuring, but I don't
> know his timeframe.  If you can, I would probably wait for that
> because there's so much overlap here.
OK.
>
> The other paths that use PCI_EXP_DEVCTL_BCR_FLR are definitely issues
> and should be fixed, but again should wait for the revised pcie_flr()
> interface.  And if they're not actually required for your Xen issue,
> they sound like "nice to have" cleanups that will not gate your Xen
> fixes.  I added this to my ever-growing list of cleanups to do.
For now, I am planning to use existing pcie_flr() after checking FLR
capability inside Xenpciback driver (like other existing pcie_flr()
usage). We will switch to revised pcie_flr() once it is available.

Cheers
GOVINDA
