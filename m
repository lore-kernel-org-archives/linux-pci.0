Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 24 Aug 2016 21:15:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 7/8] PCI: exynos: make host support explicitly non-modular
Message-ID: <20160824191542.GB31869@kozik-book>
References: <20160822215948.27251-1-paul.gortmaker@windriver.com>
 <20160822215948.27251-8-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160822215948.27251-8-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 22, 2016 at 05:59:47PM -0400, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/pci/host/Kconfig:config PCI_EXYNOS
> drivers/pci/host/Kconfig:       bool "Samsung Exynos PCIe controller"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the couple traces of modular infrastructure use, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/pci/host/pci-exynos.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
