Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59134 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759830Ab2DKAbL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 10 Apr 2012 20:31:11 -0400
Received: by lahj13 with SMTP id j13so296001lah.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Apr 2012 17:31:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F83D109.4000702@freescale.com>
References: <1331104586-5720-1-git-send-email-Chunhe.Lan@freescale.com>
 <4F8252C0.9060002@freescale.com> <20120409081643.18ecfbc2@jbarnes-desktop> <4F83D109.4000702@freescale.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Apr 2012 18:30:49 -0600
Message-ID: <CAErSpo4bYgsFuskZ+REcK1Z1ohbX8y638oV9MaC9erGrPa0bRw@mail.gmail.com>
Subject: Re: [PATCH] PCI: PCIe: Fix uninitialized variable 'cap_mask'
To: Chunhe Lan <b25806@freescale.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2012 at 12:19 AM, Chunhe Lan <b25806@freescale.com> wrote:
>
>
> Jesse Barnes wrote:
>
> On Mon, 9 Apr 2012 11:08:48 +0800
> Chunhe Lan <b25806@freescale.com> wrote:
>
>
>
> Chunhe Lan wrote:
>
>
> Get rid of these:
>
> drivers/pci/pcie/portdrv_core.c: In function 'pcie_port_device_register':
> drivers/pci/pcie/portdrv_core.c:275:16: warning: 'cap_mask' may be used
> uninitialized in this function [-Wuninitialized]
> drivers/pci/pcie/portdrv_core.c:240:6: note: 'cap_mask' was declared here
>
> In some cases, 'cap_mask' may be not set in pcie_port_platform_notify,
> holding a garbage value.
>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv_core.c
> b/drivers/pci/pcie/portdrv_core.c
> index 595654a..751b464 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -237,7 +237,7 @@ static int get_port_device_capability(struct pci_dev
> *dev)
>  	int services = 0, pos;
>  	u16 reg16;
>  	u32 reg32;
> -	int cap_mask;
> +	int cap_mask = 0;
>  	int err;
>
>  	if (pcie_ports_disabled)
>
>
>
> Hello Jesse Barnes,
>
>   Have you any comment about this patch?
>   It locates at http://article.gmane.org/gmane.linux.kernel.pci/14062
>
>   If it has not question, can you merge it to your git tree?
>
>
> Yeah patch looks fine, bounce it over to Bjorn if you want it applied.
>
> I didn't check where it gets used though, and whether 0xffffffff would
> be a better default mask value or not.
>
>
>    I have tested it on the P5020DS board of PowerPC.
>    When it is zero, ping is OK.
>    When it is 0xffffffff, ping fails.
>    So, that it is initialized to zero is right.
>
> Hello Bjorn,
>
>
>     Have you any comment about this patch?
>     If it has not question, could you merge it to your git tree?

This looks good to me.  I'll try to merge it tonight.

I'm out of the office for the next two weeks, until April 23, so I
have pretty limited time until then.

Bjorn
