Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Fri, 12 Jul 2013 16:05:08 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC][PATCH 23/30] ACPI / hotplug / PCI: Do not exectute _PS0
 and _PS3 directly
Message-ID: <20130712130508.GK4898@intel.com>
References: <26431283.HJCKsss0rt@vostro.rjw.lan>
 <3718119.FLASu5DBx8@vostro.rjw.lan>
 <1757750.sf0hy8txF5@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1757750.sf0hy8txF5@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 12, 2013 at 02:01:30AM +0200, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/pci/hotplug/acpiphp.h
> ===================================================================
> --- linux-pm.orig/drivers/pci/hotplug/acpiphp.h
> +++ linux-pm/drivers/pci/hotplug/acpiphp.h
> @@ -160,7 +160,6 @@ struct acpiphp_attention_info
>  
>  /* slot flags */
>  
> -#define SLOT_POWEREDON		(0x00000001)
>  #define SLOT_ENABLED		(0x00000002)
>  #define SLOT_MULTIFUNCTION	(0x00000004)
>  
> @@ -168,11 +167,7 @@ struct acpiphp_attention_info
>  
>  #define FUNC_HAS_STA		(0x00000001)
>  #define FUNC_HAS_EJ0		(0x00000002)
> -#define FUNC_HAS_PS0		(0x00000010)
> -#define FUNC_HAS_PS1		(0x00000020)
> -#define FUNC_HAS_PS2		(0x00000040)
> -#define FUNC_HAS_PS3		(0x00000080)
> -#define FUNC_HAS_DCK            (0x00000100)
> +#define FUNC_HAS_DCK            (0x00000003)

These are flags not enum so the above wants to be

	#define FUNC_HAS_DCK            (0x00000004)

otherwise we accidentally match checks like:

	/* install notify handler */
	if (!(newfunc->flags & FUNC_HAS_DCK)) {
		...
