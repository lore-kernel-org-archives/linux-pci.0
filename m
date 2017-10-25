Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 1/8] SOC: brcmstb: add memory API
To: Jim Quinlan <jim2101024@gmail.com>, linux-kernel@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Florian Fainelli <f.fainelli@gmail.com>
References: <1508868949-16652-1-git-send-email-jim2101024@gmail.com>
 <1508868949-16652-2-git-send-email-jim2101024@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a83617d0-8506-7fe4-2870-d9dbd9ffdb3f@gmail.com>
Date: Tue, 24 Oct 2017 17:23:24 -0700
MIME-Version: 1.0
In-Reply-To: <1508868949-16652-2-git-send-email-jim2101024@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-mips@linux-mips.org, linux-pci@vger.kernel.org,
 Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
 bcm-kernel-feedback-list@broadcom.com, Gregory Fong <gregory.0xf0@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jim,

On 10/24/2017 11:15 AM, Jim Quinlan wrote:
> +#elif defined(CONFIG_MIPS)
> +int brcmstb_memory_phys_addr_to_memc(phys_addr_t pa)
> +{
> +	/* The logic here is fairly simple and hardcoded: if pa <= 0x5000_0000,
> +	 * then this is MEMC0, else MEMC1.
> +	 *
> +	 * For systems with 2GB on MEMC0, MEMC1 starts at 9000_0000, with 1GB
> +	 * on MEMC0, MEMC1 starts at 6000_0000.
> +	 */
> +	if (pa >= 0x50000000ULL)
> +		return 1;
> +	else
> +		return 0;
> +}
> +#endif

We may be missing an EXPORT_SYMBOL_GPL(brcmstb_memory_phys_to_addr_memc)
here?

Thanks!
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
