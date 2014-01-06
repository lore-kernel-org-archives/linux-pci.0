Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62003 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753305AbaAFL7h (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jan 2014 06:59:37 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dongsheng Wang <dongsheng.wang@freescale.com>,
	roy.zang@freescale.com, Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC] linux/pci: move pci_platform_pm_ops to linux/pci.h
Date: Mon, 06 Jan 2014 13:13:23 +0100
Message-ID: <2276888.ovWFBgDtau@vostro.rjw.lan>
In-Reply-To: <CAErSpo7+8sLZVi24fi+xxTEW2_DTJ2_zUrW+vobMGsvCEFwY_Q@mail.gmail.com>
References: <1387533832-34554-1-git-send-email-dongsheng.wang@freescale.com> <CAErSpo7+8sLZVi24fi+xxTEW2_DTJ2_zUrW+vobMGsvCEFwY_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 20, 2013 09:42:59 AM Bjorn Helgaas wrote:
> On Fri, Dec 20, 2013 at 3:03 AM, Dongsheng Wang
> <dongsheng.wang@freescale.com> wrote:
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > make Freescale platform use pci_platform_pm_ops struct.
> 
> This changelog doesn't say anything about what the patch does.
> 
> I infer that you want to use pci_platform_pm_ops from some Freescale
> code.  This patch should be posted along with the patches that add
> that Freescale code, so we can see how you intend to use it.
> 
> The existing use is in drivers/pci/pci-acpi.c, so it's possible that
> your new use should be added in the same way, in drivers/pci, so we
> don't have to make pci_platform_pm_ops part of the public PCI
> interface in include/linux/pci.h.
> 
> That said, if Raphael thinks this makes sense, it's OK with me.

Well, I'd like to know why exactly the change is needed in the first place.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
