Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Subject: Re: ACPI namespace details for ARM64
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com>
Cc: Al Stone <ahs3@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christopher Covington <cov@codeaurora.org>,
        Don Dutile <ddutile@redhat.com>,
        Dongdong Liu <liudongdong3@huawei.com>, Duc Dang <dhdang@apm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Salter <msalter@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Robert Richter <rrichter@cavium.com>,
        Sinan Kaya <okaya@codeaurora.org>, Tomasz Nowicki <tn@semihalf.com>,
        linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org
From: Jon Masters <jcm@redhat.com>
Message-ID: <1d7424da-f9f8-68e3-5571-b9fc46f13a7f@redhat.com>
Date: Thu, 1 Dec 2016 23:52:00 -0500
MIME-Version: 1.0
In-Reply-To: <20161109220506.GN14322@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 11/09/2016 05:05 PM, Bjorn Helgaas wrote:

> We've been working through the details of getting ACPI to work on
> arm64, and there have been lots of questions about what this means for
> PCI.  I've outlined this for several people individually, but I'm
> going to send this separately, apart from a specific patch series, to
> make sure we're all on the same page.  Please correct my errors and
> misunderstandings.

Thanks so much again for writing this.

When we originally created the SBBR (Server Base Boot Requirements) we
were very vague about things like PCI. On x86, it "just worked", and so
we said generic things about MCFG tables and implementing PCI correctly,
but we didn't think of all of the many ways it might be done badly. In
that respect, Intel and AMD have spoiled us over the years (thanks!) :)

Since then, we've had a lot of opportunity to learn about buggy IP
that's out there and we've done a lot to have it fixed, and to get
all of the vendors to take care of these problems before their next
generation silicon lands. Indeed, we're doing a lot more on the pre
silicon front as well these days, but that's for another time.

And of course, once you have all the Linux distros and other OSes out
there, it's easier for the next wave to come along anyway. It will
either boot for them, or it won't. And if it doesn't boot, the
vendors will have two choices: upstream a fix and get every distro to
pick it up at some future point (and wait until then because you won't
even be able to boot the installation media to install an update) or
don't make the mistake in the first place and fix it pre-silicon.

What I would like to get out of this experience is not only the
summary you've written, which we will point people to as a living
document, but also a more useful update to the ARM SBBR that spells
out the many actual requirements and expectations. I want to go a
lot further and start prescribing lots of other things in the next
major update to the SBBR (everything from "you will map your RAM at
zero", and you will implement your SMMU topology in this way...")
that were too hand wavy before, but definitely want a giant section
on how to do PCI right. So we'll come ping you for input on that :)

> The basic requirement is that the ACPI namespace should describe
> *everything* that consumes address space unless there's another
> standard way for the OS to find it [1, 2].

...and by the way, this was a key lesson for me, too. I had not
fully internalized before that you don't just want to describe the
ECAM region in the MCFG but you also need to ensure it's properly
described in the ACPI namespace. Lots of good things learned.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
