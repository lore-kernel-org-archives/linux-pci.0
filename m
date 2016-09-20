Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbcITNJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Sep 2016 09:09:34 -0400
Date: Tue, 20 Sep 2016 08:08:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: will.deacon@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        Lorenzo.Pieralisi@arm.com, arnd@arndb.de, hanjun.guo@linaro.org,
        okaya@codeaurora.org, jchandra@broadcom.com, cov@codeaurora.org,
        dhdang@apm.com, ard.biesheuvel@linaro.org,
        robert.richter@caviumnetworks.com, mw@semihalf.com,
        Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
        wangyijing@huawei.com, msalter@redhat.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, jcm@redhat.com,
        andrea.gallo@linaro.org, jeremy.linton@arm.com,
        liudongdong3@huawei.com, gabriele.paoloni@huawei.com,
        jhugo@codeaurora.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 4/5] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
Message-ID: <20160920130839.GA13855@localhost>
References: <1473449047-10499-1-git-send-email-tn@semihalf.com>
 <1473449047-10499-5-git-send-email-tn@semihalf.com>
 <20160919154550.GA13775@localhost>
 <d06879a2-d6e9-5d62-77c5-47eff33d9584@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d06879a2-d6e9-5d62-77c5-47eff33d9584@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 20, 2016 at 09:06:23AM +0200, Tomasz Nowicki wrote:
> On 19.09.2016 17:45, Bjorn Helgaas wrote:
> >On Fri, Sep 09, 2016 at 09:24:06PM +0200, Tomasz Nowicki wrote:
> >>ThunderX PCIe controller to off-chip devices (so-called PEM) is not fully
> >>compliant with ECAM standard. It uses non-standard configuration space
> >>accessors (see pci_thunder_pem_ops) and custom configuration space granulation
> >>(see bus_shift = 24). In order to access configuration space and
> >>probe PEM as ACPI based PCI host controller we need to add MCFG quirk
> >>infrastructure. This involves:
> >>1. Export PEM pci_thunder_pem_ops structure so it is visible to MCFG quirk
> >>   code.
> >>2. New quirk entries for each PEM segment. Each contains platform IDs,
> >>   mentioned pci_thunder_pem_ops and CFG resources.
> >>
> >>Quirk is considered for ThunderX silicon pass2.x only which is identified
> >>via MCFG revision 1.
> >
> >Is it really the case that silicon pass2.x has MCFG revision 1, and
> >silicon pass1.x has MCFG revision 2?  That just seems backwards.
> 
> It is weird but silicon pass2.x is more common and it had MCFG
> revision 1 from the beginning. Unless it is allowed to use MCFG
> revision 0 ? Then we could use MCFG revision 0 for pass1.x

There's no reason to avoid revision 0.  The question is really what
firmware is already in the field.  We need to accommodate that.  We don't
want a situation where kernel version X only works with firmware version Y,
but kernel version X+1 only works with firmware version Y+1.

Bjorn
