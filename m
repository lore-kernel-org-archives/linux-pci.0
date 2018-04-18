Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7f4c4bad9aa7d7a1d5a6b78f4bf3a4e7c542c7f9.1523973931.git.gustavo.pimentel@synopsys.com>
References: <cover.1523973931.git.gustavo.pimentel@synopsys.com> <7f4c4bad9aa7d7a1d5a6b78f4bf3a4e7c542c7f9.1523973931.git.gustavo.pimentel@synopsys.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 18 Apr 2018 09:05:41 -0500
Message-ID: <CAL_Jsq+juOLU2+EhOL7+_hnEY3G9mJVFL6eTpsG=NeWH1jZaaQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] bindings: PCI: designware: Example update
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 17, 2018 at 9:34 AM, Gustavo Pimentel
<gustavo.pimentel@synopsys.com> wrote:
> Replaces "ctrlreg" reg-name by "dbi" to be coherent with similar drivers,
> however it still be compatible with any previous DT that uses the old
> reg-name.
>
> Replaces the PCIe base address example by a real PCIe base address in use.
>
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes v1->v2:
>  - Removed any iATU reference or changes to avoid confusion.
>  - Add "snps,dw-pcie" compatible string following Kishon's suggestion.
> Changes v2->v3:
>  - Nothing changed, just to follow the patch set version.
> Changes v3->v4:
>  - Reverted "snps,dw-pcie-rc" compatible string requested by Rob Herring.
> Changes v4->v5:
>  - Nothing changed, just to follow the patch set version.
>
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
