Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 24 Sep 2013 18:19:02 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: tianyu.lan@intel.com
Cc: lenb@kernel.org, rjw@sisk.pl, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/ACPI: Convert ACPI PCI Hot Plug core debug
 fuction to dynamic debug function
Message-ID: <20130925001902.GF9302@google.com>
References: <1378783035-15681-1-git-send-email-tianyu.lan@intel.com>
 <1378783035-15681-2-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378783035-15681-2-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 09, 2013 at 11:17:15PM -0400, tianyu.lan@intel.com wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> This patch is to use pr_debug/info/warn/err to replace acpiphp debug
> functions and remove module's debug param.
> ...

>  /* local variables */
> @@ -61,9 +60,7 @@ static struct acpiphp_attention_info *attention_info;
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE("GPL");
> -MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
>  MODULE_PARM_DESC(disable, "disable acpiphp driver");
> -module_param_named(debug, acpiphp_debug, bool, 0644);

I have notes about booting with the "acpiphp.debug" parameter to turn
on debugging.  Can you tell me the way to do the equivalent with
dynamic debug?  I'll add that to the changelog before merging this.

Bjorn
