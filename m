Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Feb 2016 12:05:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhaskar Jupudi <njupudi@ucsc.edu>
Cc: linux-kernel@vger.kernel.org, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers/pci:Broken link fixed
Message-ID: <20160229180536.GB3653@localhost>
References: <1455055816-3768-1-git-send-email-njupudi@ucsc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455055816-3768-1-git-send-email-njupudi@ucsc.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 09, 2016 at 02:10:16PM -0800, Bhaskar Jupudi wrote:
> From: cmps107-njupudi <njupudi@ucsc.edu>
> 
> Dell developed a way to consistently name devices, 
> and their last proposal was accepted under the name biosdevname.
> 
> Signed-off-by: Naga Venkata Sai Indubhaskar Jupudi <njupudi@ucsc.edu>

Applied to pci/enumeration for v4.6, thanks!

> ---
> Proposal 1 provides a character device interface to ethernet devices.
> 
> Proposal 2 is implemented in the same way as proposal 1 except that
> device nodes are created without any changes in the kernel.
> 
> Proposal 3 is an installer based proposal where it provides the user 
> with options to rename network interfaces.
> 
> Proposal 4 exports system firmware provided SMBIOS strings on
> onboard devices to sysfs.
> 
> Proposal 5 uses the firmware provided index to derive ethN names
> 
> Proposal 6 is named as biosdevname and renames network interfaces 
> to a different names space and accepted upstream.
> 
>  drivers/pci/pci-label.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 024b5c1..27143a0 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -16,7 +16,7 @@
>   * the instance number and string from the type 41 record and exports
>   * it to sysfs.
>   *
> - * Please see http://linux.dell.com/wiki/index.php/Oss/libnetdevname for more
> + * Please see http://linux.dell.com/files/biosdevname/ for more
>   * information.
>   */
>  
> -- 
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
