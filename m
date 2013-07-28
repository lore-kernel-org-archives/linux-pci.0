Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH V2] x86/PCI: MMCONFIG: cleanup and add address warning to pci_mmconfig_insert
From: Mark D Rustad <mrustad@gmail.com>
In-Reply-To: <1374953558-4704-1-git-send-email-ethan.kernel@gmail.com>
Date: Sat, 27 Jul 2013 20:09:41 -0700
Cc: bhelgaas@google.com, yinghai@kernel.org, jbarnes@virtuousgeek.org,
	linux-kernel@vger.kernel.org, jiang.liu@huawei.com,
	linux-pci@vger.kernel.org, joe.jin@oracle.com,
	"ethan.zhao" <ethan.zhao@oracle.com>
Message-Id: <7F52345F-242F-4A9D-8CD2-5805936ABAEE@gmail.com>
References: <1374953558-4704-1-git-send-email-ethan.kernel@gmail.com>
To: ethan.kernel@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Another nit below:

On Jul 27, 2013, at 12:32 PM, ethan.kernel@gmail.com wrote:

> Cleanup the -EINVAL return value handling and add warning message for invalid
> start,end,addr parameters.
> 
> V2: Corrected code style and tested for Linux v 3.11-rc2
> 
> Signed-off-by: ethan.zhao <ethan.zhao@oracle.com>
> ---
> arch/x86/pci/mmconfig-shared.c |   12 ++++++------
> 1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 082e881..37f6c7f 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -700,8 +700,13 @@ int pci_mmconfig_insert(struct device *dev, u16 seg, u8 start, u8 end,
> 	if (!(pci_probe & PCI_PROBE_MMCONF) || pci_mmcfg_arch_init_failed)
> 		return -ENODEV;
> 
> -	if (start > end)
> +	if (start > end || !addr) {
> +		dev_warn(dev, FW_INFO
> +			"Invalid address to add MMCONFIG"
> +			"start %02x end %02x addr %pR\n",

As it is here, there will be no space between MMCONFIG and the word start. Better still, put the entire string on one line to aid those searching for the message. There is a general exception to the 80-column rule for user-visible messages such as this.

<snip>

-- 
Mark Rustad, MRustad@gmail.com

