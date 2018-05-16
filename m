Return-Path: <SRS0=dFuP=ID=codeaurora.org=timur@kernel.org>
Return-Path: <SRS0=dFuP=ID=codeaurora.org=timur@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180403203847.GO9322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180402162203.3370-1-keith.busch@intel.com> <20180402162203.3370-3-keith.busch@intel.com>
 <20180403203847.GO9322@bhelgaas-glaptop.roam.corp.google.com>
From: Timur Tabi <timur@codeaurora.org>
Date: Wed, 16 May 2018 10:16:15 -0500
Message-ID: <CAOZdJXXQCGUu+r_hWBt+gAvVbYu0h4KxpUXOMKR3p7y92wxq-w@mail.gmail.com>
Subject: Re: [PATCHv2 2/7] PCI/DPC: Fix PCI legacy interrupt acknowledgement
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Oza Pawandeep <poza@codeaurora.org>,
	Sinan Kaya <okaya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 3, 2018 at 3:38 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Bottom line, I think this patch is fine and I applied it with the
> following changelog:
>
>   PCI/DPC: Clear interrupt status in interrupt handler top half

Bjorn,

I can't find this patch (with either subject line) anywhere on
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/ or
linux-next.  I see you pulled in Oza's other patch set, but this patch
is still MIA.
