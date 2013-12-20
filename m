Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from charlotte.tuxdriver.com ([70.61.120.58]:47195 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030197Ab3LTOQI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Dec 2013 09:16:08 -0500
Date: Fri, 20 Dec 2013 09:15:57 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Veaceslav Falico <vfalico@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Knut Petersen <Knut_Petersen@t-online.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI: export MSI mode using attributes, not kobjects
Message-ID: <20131220141557.GA6562@hmsreliant.think-freely.org>
References: <20131219203017.GA1768@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20131219203017.GA1768@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 19, 2013 at 12:30:17PM -0800, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> The PCI MSI sysfs code is a mess with kobjects for things that don't
> really need to be kobjects.  This patch creates attributes dynamically
> for the MSI interrupts instead of using kobjects.
> 
> Note, this removes a directory from the current MSI interrupt sysfs
> code:
> 
> old MSI kobjects:
> pci_device
>    └── msi_irqs
>        └── 40
>            └── mode
> 
> new MSI attributes:
> pci_device
>    └── msi_irqs
>        └── 40
> 
> As there was only one file "mode" with the kobject model, the interrupt
> number is now a file that returns the "mode" of the interrupt (msi vs.
> msix).
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Thanks Greg.
Neil

