Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1433433105.24429.30.camel@deneb.redhat.com>
Subject: Re: [Patch v4 0/8] Consolidate ACPI PCI root common code into ACPI
 core
From: Mark Salter <msalter@redhat.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Lv Zheng <lv.zheng@intel.com>,
	"lenb @ kernel . org" <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Date: Thu, 04 Jun 2015 11:51:45 -0400
In-Reply-To: <556FF32B.9010900@linux.intel.com>
References: <1433225576-8215-1-git-send-email-jiang.liu@linux.intel.com>
	 <556F6332.2040501@redhat.com> <556FAFEF.6040802@linux.intel.com>
	 <556FF0AD.6000901@linaro.org> <556FF32B.9010900@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-06-04 at 14:41 +0800, Jiang Liu wrote:
> On 2015/6/4 14:31, Hanjun Guo wrote:
> > Hi Jiang,
> > 
> > On 2015年06月04日 09:54, Jiang Liu wrote:
> >> On 2015/6/4 4:27, Al Stone wrote:
> >>> On 06/02/2015 12:12 AM, Jiang Liu wrote:
> >>>> This patch set consolidates common code to support ACPI PCI root on x86
> >>>> and IA64 platforms into ACPI core, to reproduce duplicated code and
> >>>> simplify maintenance. And a patch set based on this to support ACPI
> >>>> based
> >>>> PCIe host bridge on ARM64 has been posted at:
> >>>
> >>> Link is missing (or it's a typo of some flavor).
> >> HI Al,
> >>     Sorry, I missed the link. It has been posted at:
> >> https://lkml.org/lkml/2015/5/26/207
> > 
> > I failed to get io resources for PCI hostbridge  when I was testing PCI
> > on ARM64 QEMU, I debugged this for quite a while, and finally found out
> > that ACPI resource parsing for IO is not suitable for ARM64, because io
> > space for x86 is 64K, but 16M for ARM64.
> > 
> > This issue is only found when the firmware representing the io resource
> > using the type ACPI_RESOURCE_TYPE_ADDRESS32, so the io address will
> > greater than 64k.
> > 
> > In drivers/acpi/resource.c:
> > 
> > static void acpi_dev_ioresource_flags(struct resource *res, u64 len,
> >                                       u8 io_decode, u8 translation_type)
> > {
> >         res->flags = IORESOURCE_IO;
> > 
> > [...]
> > 
> >         if (res->end >= 0x10003)
> >                 res->flags |= IORESOURCE_DISABLED | IORESOURCE_UNSET;
> > 
> > [...]
> > }
> > 
> > so the code will filter out res->end >= 0x10003, and in my case, it will
> > more than 64K, so we can't get the IO resources.
> > 
> > I got a question, why we use if (res->end >= 0x10003) here?
> > I mean 64k will be 0x10000, and in that case, we should use
> > if (res->end >= 0x10000) here, not 0x10003, any history behind that?
> 
> Hi Hanjun,
> This is a special tricky for x86. You may read a dword(four bytes) from
> IO port 0xffff, so the effective io port space is 0x10003 bytes.
> 

Is there something in ACPI spec which would limit PCI IO space to 64K?
PCI itself allows 32-bit IO addresses and at least some arm64 platforms
use PCI bus addresses above 64K for IO transactions. From a PCI view,
the (res->end >= 0x10003) check doesn't make sense. Am I missing
something?



