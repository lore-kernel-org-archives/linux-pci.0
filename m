Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 1 Dec 2016 16:36:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Duc Dang <dhdang@apm.com>,
        linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
        linux-acpi@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lv Zheng <lv.zheng@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: Add information about describing PCI in ACPI
Message-ID: <20161201223604.GC15867@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 29, 2016 at 03:39:48PM -0600, Bjorn Helgaas wrote:
> Here's another stab at this writeup.  I'd appreciate any comments!
> 
> Changes from v1 to v2:
>   - Consumer/Producer is defined for Extended Address Space descriptors;
>     should be ignored for QWord/DWord/Word Address Space descriptors
>   - New arches may use Extended Address Space descriptors in PNP0A03 for
>     bridge registers, including ECAM (if the arch adds support for this)
>   - Add more details about MCFG and _CBA (Lv's suggestion)
>   - Incorporate Rafael's suggestions
> 
> ---
> 
> Bjorn Helgaas (1):
>       PCI: Add information about describing PCI in ACPI
> 
> 
>  Documentation/PCI/00-INDEX      |    2 
>  Documentation/PCI/acpi-info.txt |  180 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 Documentation/PCI/acpi-info.txt

It's very late in the cycle, but I'm considering trying to squeeze
this into v4.9 on the grounds that:

  - It's only a documentation change and can't break anything, and

  - Distributing it more widely may help the arm64 firmware ecosystem

But I don't want to disseminate misleading or incorrect information,
so if it needs clarification or wordsmithing, or even just maturation,
I'll wait until v4.10.

The Consumer/Producer stuff, in particular, doesn't seem 100% settled
yet.  Your thoughts, and especially your improvements, are welcome!

Bjorn
