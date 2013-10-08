Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36917 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab3JHQIN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 12:08:13 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so19619961ieb.40
        for <linux-pci@vger.kernel.org>; Tue, 08 Oct 2013 09:08:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20131008092137.0ed32a32@skate>
References: <20131007233846.11805.50302.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20131008092137.0ed32a32@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 8 Oct 2013 10:07:52 -0600
Message-ID: <CAErSpo4bn_TVbquQrs_WzLnL8Q=2urk1VyrWPiqDBnh6OrQbtQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Make mvebu_pcie_align_resource() static
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 8, 2013 at 1:21 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Mon, 07 Oct 2013 17:38:46 -0600, Bjorn Helgaas wrote:
>> mvebu_pcie_align_resource() is only used inside pci-mvebu.c, so
>> make it static.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I'm obviously fine with that, but there is already a patch "[PATCH V2
> 2/3] PCI: mvebu: make local functions static" hanging around to do the
> same.

OK, sorry for the duplication.  I dropped Jingoo's patch from
patchwork because Jason C. is merging mvebu stuff, and then it's "out
of sight, out of mind."

Bjorn
