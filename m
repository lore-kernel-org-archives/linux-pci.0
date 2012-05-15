Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60798 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966182Ab2EOXKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2012 19:10:48 -0400
Received: by lbbgm6 with SMTP id gm6so92199lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 15 May 2012 16:10:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FAB9BFF.4080802@jp.fujitsu.com>
References: <4FAB9BFF.4080802@jp.fujitsu.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 May 2012 17:10:26 -0600
Message-ID: <CAErSpo7FbzR+xkjK2qMTF3cew0ardH__1QpYpyoxy+k4nH8Guw@mail.gmail.com>
Subject: Re: [PATCH] microblaze/pci: Fix compile error
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 10, 2012 at 4:44 AM, Hiroo Matsumoto
<matsumoto.hiroo@jp.fujitsu.com> wrote:
> Hi
>
>
> There is a compile error for microblaze pci because io_offset is not
> declared. This patch adds declaration of io_offset.
>
>
> * Compile error message
> arch/microblaze/pci/pci-common.c: In function 'pcibios_setup_phb_resources':
> arch/microblaze/pci/pci-common.c:1525: error: 'io_offset' undeclared
> (first use in this function)
> arch/microblaze/pci/pci-common.c:1525: error: (Each undeclared
> identifier is reported only once
> arch/microblaze/pci/pci-common.c:1525: error: for each function it
> appears in.)
> make[1]: *** [arch/microblaze/pci/pci-common.o] Error 1
> make: *** [arch/microblaze/pci] Error 2
>
>
> Regards.
>
> Hiroo MATSUMOTO
>
> Signed-off-by: Hiroo MATSUMOTO <matsumoto.hiroo@jp.fujitsu.com>
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
> index 85f2ac1..90f8238 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -1515,6 +1515,7 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>
>  static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
>  {
> +       unsigned long io_offset;
>        struct resource *res;
>        int i;
>
>

Applied to my "next" branch, thanks.

Bjorn
