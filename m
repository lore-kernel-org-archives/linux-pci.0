Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160106195339.24780.37612.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Thu, 7 Jan 2016 15:57:33 +0530
Message-ID: <CAHM4w1==yZc54PFysVVhmfyXDpU=onSmWQuh4ZmbapQYbdH7iQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: designware: Simplify config accessors
From: Pratyush Anand <pratyush.anand@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 7, 2016 at 1:24 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> These make the code slightly smaller and easier to read but shouldn't make
> any functional difference.
>
> ---
>
> Bjorn Helgaas (2):
>       PCI: designware: Simplify control flow
>       PCI: designware: Make config accessor override checking symmetric
>

For both the patches
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>

>
>  drivers/pci/host/pcie-designware.c |   53 ++++++++++++------------------------
>  1 file changed, 18 insertions(+), 35 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
