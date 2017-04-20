Return-Path: <SRS0=zAag=34=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=zAag=34=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <832cb9b3-ceaf-6771-bfc9-7bae35494f6d@redhat.com>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
 <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
 <baed1ecf-7a57-0229-42b0-d87599a225b5@redhat.com> <832cb9b3-ceaf-6771-bfc9-7bae35494f6d@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Apr 2017 08:20:38 -0500
Message-ID: <CAErSpo4+sVEydsxi8quK=avN=mWyoHV=bUxDDKgOfGR7=15zgA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
To: Jon Masters <jcm@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jayachandran C <jnair@caviumnetworks.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 19, 2017 at 7:25 PM, Jon Masters <jcm@redhat.com> wrote:
> One additional footnote. I spent a bunch of time recently on my personal
> Xeon systems walking through the PCIe topology and aligning on how to
> advise the ARM server community proceed going forward. If you look at
> how Intel vs AMD handle their host bridges for example, you'll see two
> very different approaches to the case of cross-socket PCIe.

As a learning opportunity for me, can you share "lspci -vv" examples
that show this Intel vs AMD difference?  Maybe the ACPI host bridge
descriptions from dmesg are relevant too?

> But my
> operating assumption is that anything longer term which looks boring and
> x86 enough is probably fine from an ARM server point of view.

That sounds pretty safe to me.

Bjorn
