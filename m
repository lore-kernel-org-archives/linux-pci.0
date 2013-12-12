Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:63525 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab3LLVQg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2013 16:16:36 -0500
Received: by mail-ig0-f174.google.com with SMTP id hk11so212840igb.1
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2013 13:16:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131212160612.GA14655@dhcp-26-207.brq.redhat.com>
References: <cover.1385399393.git.agordeev@redhat.com> <4c879b0928ded8b4c9d2fab3fc413b98d34d8c7c.1385399393.git.agordeev@redhat.com>
 <20131210230847.GG4699@google.com> <20131212160612.GA14655@dhcp-26-207.brq.redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 12 Dec 2013 14:16:16 -0700
Message-ID: <CAErSpo5F=Cce_8QcMRQYgGJFYcXGSfGjqmdnDuxWiYYG_-Kb9Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
To: Alexander Gordeev <agordeev@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michael Ellerman <michael@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tejun Heo <tj@kernel.org>,
	Ben Hutchings <bhutchings@solarflare.com>,
	David Laight <David.Laight@aculab.com>,
	Mark Lord <kernel@start.ca>, "H. Peter Anvin" <hpa@zytor.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 12, 2013 at 9:06 AM, Alexander Gordeev <agordeev@redhat.com> wrote:
> On Tue, Dec 10, 2013 at 04:08:47PM -0700, Bjorn Helgaas wrote:
>> If pci_msix_table_size() is a counterpart to pci_get_msi_cap(), can we make
>> the names similar?
>
> Tejun also pointed this out. What about pci_get_msi_vec_count() and
> pci_get_msix_vec_count()?

Sounds perfect to me.  I think the fact that they return the same type
of information is more important than where the information came from.

> Nevertheless, the existing names are more informative for me, since they
> hint where the MSI/MSI-X vector count comes from. Up to you.
>
> --
> Regards,
> Alexander Gordeev
> agordeev@redhat.com
