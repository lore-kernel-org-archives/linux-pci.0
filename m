Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 23 Jun 2015 09:35:30 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Boszormenyi Zoltan <zboszor@pr.hu>,
	Len Brown <lenb@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [Patch v1] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32bit kernel
Message-ID: <20150623073530.GA21872@gmail.com>
References: <55871787.5080504@pr.hu>
 <1435032732-26160-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435032732-26160-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Jiang Liu <jiang.liu@linux.intel.com> wrote:

> The data type resource_size_t may be 32 bits or 64 bits depending on
> CONFIG_PHYS_ADDR_T_64BIT. So reject ACPI resource descriptors which
> will cause resource_size_t overflow with 32bit kernel
> 
> This issue was triggered on a platform running 32bit kernel with an
> ACPI resource descriptor with address range [0x400000000-0xfffffffff].
> Please refer to https://lkml.org/lkml/2015/6/19/277 for more information.
> 
> Reported-by: Boszormenyi Zoltan <zboszor@pr.hu>
> Fixes: 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfaces to simplify implementation")
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: stable@vger.kernel.org # 4.0

Yeah, so please use the customary changelog style we use in the kernel:

  " Current code does (A), this causes problem (B) when doing (C).

    In that case the user notices (D).

    We can improve this doing (E), because now the user will experience (F),
    which is more desirable."

Please fill in A-F accordingly.

In particular your changelog is missing 'B' and 'D': what exactly is a 
'resource_size_t overflow' and what does the user notice from it?

Your changelog is also missing 'F'.

Thanks,

    Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
