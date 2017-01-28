Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 28 Jan 2017 14:44:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Abylay Ospan <aospan@netup.ru>
Subject: Re: [PATCH] PCI: iproc: fix kernel crash if dev->of_node not defined
Message-ID: <20170128204458.GB20550@bhelgaas-glaptop.roam.corp.google.com>
References: <1484266817-6725-1-git-send-email-aospan@netup.ru>
MIME-Version: 1.0
In-Reply-To: <1484266817-6725-1-git-send-email-aospan@netup.ru>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 13, 2017 at 03:20:17AM +0300, Abylay Ospan wrote:
> pcie->dev->of_node not always defined (NULL) and can cause crash:
> 
> [   19.053195] Unable to handle kernel NULL pointer dereference at
> virtual address 00000020
> [<c0b0370c>] (of_n_addr_cells) from [<c06599c4>]
> (iproc_pcie_setup+0x30c/0xce0)
> 
> this patch adds sanity check to prevent crash.
> 
> Signed-off-by: Abylay Ospan <aospan@netup.ru>

Hi Abylay, this didn't look quite fully baked yet, so I'm dropping it for
now.  Please repost if everything's been worked out and the patch is still
necessary.

> ---
>  drivers/pci/host/pcie-iproc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 3ebc025..f2836a9 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -952,6 +952,9 @@ static int pci_dma_range_parser_init(struct of_pci_range_parser *parser,
>  	const int na = 3, ns = 2;
>  	int rlen;
>  
> +	if (!node)
> +		return -ENOENT;
> +
>  	parser->node = node;
>  	parser->pna = of_n_addr_cells(node);
>  	parser->np = parser->pna + na + ns;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
