Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38535 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752142Ab2BVWrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 22 Feb 2012 17:47:21 -0500
Received: by wics10 with SMTP id s10so372087wic.19
        for <linux-pci@vger.kernel.org>; Wed, 22 Feb 2012 14:47:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1329946909.20389.10.camel@pasglop>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com> <1329946909.20389.10.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 22 Feb 2012 14:47:00 -0800
Message-ID: <CAErSpo7bMNbZgEZFmezJwTvGGoRsCe-qZavBJZS_q4DmnNAE7A@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with pci_flags
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 22, 2012 at 1:41 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
>> We already use pci_flags, so this just sets pci_flags directly and removes
>> the intermediate step of figuring out pci_probe_only, then using it to set
>> pci_flags.
>
> Ah yes, those flags are now common indeed.
>
>> The PCI core provides a pci_flags definition (currently __weak), so drop
>> the powerpc definitions in favor of that.  Note that we must set the ppc64
>> default (PCI_PROBE_ONLY set) in the 64-bit setup_arch() before calling
>> the platform .setup_arch() method, which may override the default.
>
> Ah wait, I have a patch about to hit -next that flips the ppc64
> default...
>
> Maybe it's easier if you just pick it up and stick it in your series,
> that will avoid integration clashes..
>
> http://patchwork.ozlabs.org/patch/141225/

Sure, I'll pick up that patch and repost the series.  I'll wait until
tomorrow or so in case anybody else has comments.

Thanks,
  Bjorn
