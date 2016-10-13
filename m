Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934641AbcJMSGh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Oct 2016 14:06:37 -0400
Date: Thu, 13 Oct 2016 12:55:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: ying.huang@intel.com, linux-pci@vger.kernel.org
Subject: Re: [bug report] ACPI, APEI, Add PCIe AER error information printing
 support
Message-ID: <20161013175513.GA21529@localhost>
References: <20161013065847.GA30382@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161013065847.GA30382@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 09:58:47AM +0300, Dan Carpenter wrote:
> Hello Huang Ying,
> 
> The patch c413d7682020: "ACPI, APEI, Add PCIe AER error information
> printing support" from Feb 21, 2011, leads to the following static
> checker warning:
> 
> 	drivers/pci/pcie/aer/aerdrv_errprint.c:229 cper_print_aer()
> 	warn: bool comparison is always 'false'

Hi Dan,

Thanks a lot for the report.  Do you have any plans for integrating
smatch into the kernel build process like sparse is?  I think I did
figure out how to run smatch myself, but it wasn't quite as easy as
"apt-get install sparse; make C=2".

Bjorn
