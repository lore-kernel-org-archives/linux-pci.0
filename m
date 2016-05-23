Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59280 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbcEWOkI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2016 10:40:08 -0400
Date: Mon, 23 May 2016 07:40:06 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Amir Levy <amir.jer.levy@intel.com>
Cc: andreas.noever@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, michael.jamet@intel.com,
	dan.alloun@intel.com, mika.westerberg@intel.com,
	kai.svahn@intel.com, andriy.shevchenko@intel.com,
	tomas.winkler@intel.com
Subject: Re: [PATCH 1/6] thunderbolt: Updating the register definitions
Message-ID: <20160523144006.GA28980@kroah.com>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
 <1463993336-2750-2-git-send-email-amir.jer.levy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463993336-2750-2-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 23, 2016 at 11:48:51AM +0300, Amir Levy wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2618,6 +2618,8 @@
>  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE  0x156b
>  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI     0x156c
>  #define PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE  0x156d
> +#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_NHI        0x157d
> +#define PCI_DEVICE_ID_INTEL_WIN_RIDGE_2C_BRIDGE     0x157e
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_NHI     0x1575 /* Thunderbolt 3 */
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_2C_BRIDGE  0x1576
>  #define PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_4C_NHI     0x1577

Please read the top of this file for why you shouldn't be adding new
ids to it.
