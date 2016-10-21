Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 20 Oct 2016 21:41:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com, linux-pci@vger.kernel.org,
        agross@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, wim@djo.tudelft.nl,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
Message-ID: <20161021024111.GA24336@localhost>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
 <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
 <20161018135912.GD18903@localhost>
 <b4a8995e-1454-3b84-0681-1491788087ec@codeaurora.org>
 <0a82f2ef-b072-d847-104a-320cf804ebd5@codeaurora.org>
 <20161019224405.GA14915@localhost>
 <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a418cf9d-5eeb-a588-6653-fd00e0c2693c@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 20, 2016 at 01:01:04PM -0700, Sinan Kaya wrote:
> On 10/19/2016 3:44 PM, Bjorn Helgaas wrote:

> >   - Maintain a mapping of (IRQ, penalty).  Initially all penalties are
> >     zero.  This is for *all* IRQs, not just ISA ones.  This could be a
> >     linked list, but the structure is not important as long as we can
> >     add things dynamically.
> 
> Dynamic allocation doesn't work due to early calls from x86 architecture.
> This is the reason why we iterate the link objects.

Where exactly is this early penalization?  That seems to be the
biggest problem.  Well, maybe the question of ACPI core parsing of
_CRS/_PRS is a bigger structural problem, but the dynamic allocation
thing at least seems solvable.
