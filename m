Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v5 2/3] PCI: Add tango PCIe host bridge support
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
To: Bjorn Helgaas <helgaas@kernel.org>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <1802aae0-f97b-c437-c00e-5fa7c867286d@sigmadesigns.com>
Message-ID: <654acba8-68b9-fb4c-4681-35af94b6bd74@sigmadesigns.com>
Date: Wed, 7 Jun 2017 10:19:49 +0200
MIME-Version: 1.0
In-Reply-To: <1802aae0-f97b-c437-c00e-5fa7c867286d@sigmadesigns.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mason <slash.tmp@free.fr>,
 Marc Zyngier <marc.zyngier@arm.com>, linux-pci <linux-pci@vger.kernel.org>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Liviu Dudau <liviu.dudau@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 David Laight <david.laight@aculab.com>, Thomas Gleixner <tglx@linutronix.de>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 31/05/2017 15:33, Marc Gonzalez wrote:

> +static int tango_pcie_probe(struct platform_device *pdev)
> +{
> +	int ret = -EINVAL;
> +	void __iomem *base;
> +	struct resource *res;
> +	struct tango_pcie *pcie;
> +	struct device *dev = &pdev->dev;
> +
> +	pr_err("MAJOR ISSUE: PCIe config and mem spaces are muxed\n");
> +	pr_err("Tainting kernel... Use driver at your own risk\n");
> +	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);

Hello Bjorn,

In v4, your only comment was
"[muxing config and mem spaces] is a major issue and possibly even
a security problem [which requires at least an error message and a
kernel taint].

Were there any other issues with the host bridge support?
Or is the HW quirk/bug too severe to mainline the driver?
(I would hate having to discard all that work though.)

Regards.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
