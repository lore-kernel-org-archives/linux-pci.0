Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI/ASPM: Suppress common clock mode setting failure
To: linux-pci@vger.kernel.org, timur@codeaurora.org
References: <1516642093-15633-1-git-send-email-okaya@codeaurora.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <9a557c73-ac13-96b3-2eff-6b3a1ccaa7d6@codeaurora.org>
Date: Mon, 22 Jan 2018 14:13:33 -0500
MIME-Version: 1.0
In-Reply-To: <1516642093-15633-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arm-msm@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Rajat Jain <rajatja@google.com>, Yinghai Lu <yinghai@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 1/22/2018 12:28 PM, Sinan Kaya wrote:
> +++ b/drivers/pci/pcie/aspm.c
> @@ -253,6 +253,11 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  
>  	/* Configure upstream component */
>  	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> +
> +	/* Port might be already in common clock mode */
> +	if ((same_clock) && (reg16 & PCI_EXP_LNKCTL_CCC))
> +		return;
> +

I think the placement of this statement is too late. I'll move it a couple of lines
and post V2.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
