Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Gustavo Pimentel'" <gustavo.pimentel@synopsys.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <Joao.Pinto@synopsys.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
Cc: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com> <e16abfbbb45aff6f45d5e6821d2dc23cf4d61783.1523266508.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <e16abfbbb45aff6f45d5e6821d2dc23cf4d61783.1523266508.git.gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v2 9/9] PCI: dwc: Replace magic number by defines
Date: Tue, 10 Apr 2018 20:07:33 -0400
Message-ID: <000101d3d129$17847f60$468d7e20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, April 9, 2018 5:41 AM, Gustavo Pimentel wrote:
> 
> Replace magic numbers by a well known define in order to make the code
> human readable and also facilitate the code reusability.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

> ---
> Change v1->v2:
> - Nothing changed, just to follow the patch set version.
> 
>  drivers/pci/dwc/pcie-designware-host.c | 34 ++++++++++++++++++++---------
> -----
>  drivers/pci/dwc/pcie-designware.h      |  1 +
>  2 files changed, 21 insertions(+), 14 deletions(-)
> 

[.....]
