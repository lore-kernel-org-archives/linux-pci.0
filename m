Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:46623 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321Ab3GZMmM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2013 08:42:12 -0400
MIME-Version: 1.0
In-Reply-To: <20130725175720.6006.96448.stgit@bhelgaas-glaptop>
References: <20130725175242.6006.56007.stgit@bhelgaas-glaptop>
	<20130725175720.6006.96448.stgit@bhelgaas-glaptop>
Date: Fri, 26 Jul 2013 05:42:11 -0700
Message-ID: <CAE9FiQVNYB7z7e1s=1PGsgQe_kexy+7V10WAxkReA-kiQ=10yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: hotplug: Convert to be builtin only, not modular
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	linux-sh@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 25, 2013 at 10:57 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Convert CONFIG_HOTPLUG_PCI from tristate to bool.  This only affects
> the hotplug core; several of the hotplug drivers can still be modules.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/ia64/configs/generic_defconfig    |    2 +-
>  arch/ia64/configs/gensparse_defconfig  |    2 +-
>  arch/ia64/configs/tiger_defconfig      |    2 +-
>  arch/ia64/configs/xen_domu_defconfig   |    2 +-
>  arch/powerpc/configs/ppc64_defconfig   |    2 +-
>  arch/powerpc/configs/ppc64e_defconfig  |    2 +-
>  arch/powerpc/configs/pseries_defconfig |    2 +-
>  arch/sh/configs/sh03_defconfig         |    2 +-
>  drivers/pci/hotplug/Kconfig            |    5 +----
>  9 files changed, 9 insertions(+), 12 deletions(-)

Acked-by: Yinghai Lu <yinghai@kernel.org>
