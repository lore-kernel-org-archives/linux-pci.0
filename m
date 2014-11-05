Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 5 Nov 2014 12:10:15 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch Part2 v4 00/31] Enable hierarchy irqdomian on x86
 platforms
Message-ID: <20141105111014.GI10744@8bytes.org>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <20141104144730.GE14512@8bytes.org>
 <5458ECF3.4040308@linux.intel.com>
 <20141105085154.GG10744@8bytes.org>
 <5459F0DE.6000307@linux.intel.com>
 <20141105095850.GH10744@8bytes.org>
 <5459FBDD.4020504@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5459FBDD.4020504@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jiang,

On Wed, Nov 05, 2014 at 06:28:45PM +0800, Jiang Liu wrote:
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7423ee16972f..62ba8a6f6e79 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1211,7 +1211,7 @@ int msi_irq_domain_alloc_irqs(struct irq_domain
> *domain, int type,
>                                 msidesc->nvec_used > 1) ?  1 : -ENOSPC;
>                 }
>                 for (i = 0; i < msidesc->nvec_used; i++)
> -                       irq_set_msi_desc_off(virq + i, i, msidesc);
> +                       irq_set_msi_desc_off(virq, i, msidesc);
>         }
> 
>         list_for_each_entry(msidesc, &dev->msi_list, list)

Yes, this fixes the issue, thanks :)


	Joerg

