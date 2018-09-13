Return-Path: <SRS0=VhGI=L3=gmail.com=oohall@kernel.org>
Return-Path: <SRS0=VhGI=L3=gmail.com=oohall@kernel.org>
MIME-Version: 1.0
In-Reply-To: <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
References: <153677132617.23091.12307288405707171077.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180912165846.GH118330@bhelgaas-glaptop.roam.corp.google.com> <d51126f75116534ec6ba6caee907b9db82363cc7.camel@kernel.crashing.org>
From: Oliver <oohall@gmail.com>
Date: Thu, 13 Sep 2018 21:07:12 +1000
Message-ID: <CAOSf1CH39usAocrtuBnZaPdMBorO9GHrABrEgokxTo-pySUVEg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add PPC contacts for PCI core error handling
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	Russell Currey <ruscur@russell.cc>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oliver OHalloran <oliveroh@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 13, 2018 at 6:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2018-09-12 at 11:58 -0500, Bjorn Helgaas wrote:
>> > Add the generic PCI core error recovery files to the powerpc EEH
>> > MAINTAINERS entry so the powerpc folks will be copied on changes to the
>> > generic PCI error handling strategy.
>>
>> I really want to make sure the powerpc folks are plugged into any PCI core
>> error handling discussions.  Please let me know if there's a better way
>> than this patch, or if there are other people who should be added.
>
> Sounds good. Oliver, you want to be looped in as well ?

Sure, putting all of EEH on Sam is probably not a nice thing to do.

> Cheers,
> Ben.
>
>
