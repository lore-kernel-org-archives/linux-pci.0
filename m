Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60033 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755649AbcASDb6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 18 Jan 2016 22:31:58 -0500
Date: Mon, 18 Jan 2016 21:31:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers:pci Add pcie/Kconfig to pci/Kconfig
Message-ID: <20160119033153.GE14080@localhost>
References: <1452608545-32242-1-git-send-email-brutallesale@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452608545-32242-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bogicevic,

On Tue, Jan 12, 2016 at 06:22:25AM -0800, Bogicevic Sasa wrote:
> Architectures currently have to include both
> drivers/pci/Kconfig and drivers/pci/pcie/Kconfig.
> They should include only drivers/pci/Kconfig, and
> that should handle PCIe as well.
> 
> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
> ---
>  drivers/pci/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 73de4ef..005dd7d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -119,3 +119,5 @@ config PCI_LABEL
>  	select NLS
>  
>  source "drivers/pci/host/Kconfig"
> +
> +source "drivers/pci/pcie/Kconfig"

This project is something I'd like to get done, but it requires a
little more work.  If it were this simple, I would have done it long
ago :)

For one thing, we need to update all the Kconfig files that already
include drivers/pci/pcie/Kconfig at the same time.  On x86,
arch/x86/Kconfig already includes both:

  source "drivers/pci/pcie/Kconfig"
  source "drivers/pci/Kconfig"

With your patch applied, I see these new warnings:

  05:42:09 ~/linux (wip/bogicevic-kconfig)$ make menuconfig
  ...
  scripts/kconfig/mconf  Kconfig
  drivers/pci/pcie/Kconfig:61:warning: choice value used outside its choice group
  drivers/pci/pcie/Kconfig:67:warning: choice value used outside its choice group
  drivers/pci/pcie/Kconfig:74:warning: choice value used outside its choice group

I see that you did verify that removing the source line from
arch/x86/Kconfig does the right thing.  We need to put all the related
changes in a single patch so it is self-contained.  The tree should be
buildable and functional at every stage.

Bjorn
