Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1482565780.1928.1.camel@perches.com>
Subject: Re: [PATCH] pci: hotplug: This patch removes unnecessary return
 statement using spatch tool
From: Joe Perches <joe@perches.com>
To: Rahul Krishnan <mrahul.krishnan@gmail.com>, bhelgaas@google.com
Cc: mpe@ellerman.id.au, mika.westerberg@linux.intel.com,
        gwshan@linux.vnet.ibm.com, mayurkumar.patel@intel.com,
        keith.busch@intel.com, julia.lawall@lip6.fr,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 23 Dec 2016 23:49:40 -0800
In-Reply-To: <20161224073307.GA18826@rahul>
References: <20161224073307.GA18826@rahul>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2016-12-24 at 13:03 +0530, Rahul Krishnan wrote:
> This patch removes unnecessary return statement using spatch tool
[]
> diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
[]
> @@ -463,8 +463,7 @@ int __init rpadlpar_io_init(void)
>  		return -EPERM;
>  	}
>  
> -	rc = dlpar_sysfs_init();
> -	return rc;
> +	return dlpar_sysfs_init();
>  }
>  
>  void rpadlpar_io_exit(void)

If you are going to submit these types
of patches, please make sure you compile
test them before sending so that you can
look at new warnings.

Now rc is unused and its declaration
should be removed.
