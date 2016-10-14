Return-Path: <dan.carpenter@oracle.com>
Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 14 Oct 2016 11:31:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: ying.huang@intel.com, linux-pci@vger.kernel.org
Subject: Re: [bug report] ACPI, APEI, Add PCIe AER error information printing
 support
Message-ID: <20161014082346.GM5630@mwanda>
References: <20161013065847.GA30382@mwanda>
 <20161013175513.GA21529@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161013175513.GA21529@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 13, 2016 at 12:55:13PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 13, 2016 at 09:58:47AM +0300, Dan Carpenter wrote:
> > Hello Huang Ying,
> > 
> > The patch c413d7682020: "ACPI, APEI, Add PCIe AER error information
> > printing support" from Feb 21, 2011, leads to the following static
> > checker warning:
> > 
> > 	drivers/pci/pcie/aer/aerdrv_errprint.c:229 cper_print_aer()
> > 	warn: bool comparison is always 'false'
> 
> Hi Dan,
> 
> Thanks a lot for the report.  Do you have any plans for integrating
> smatch into the kernel build process like sparse is?  I think I did
> figure out how to run smatch myself, but it wasn't quite as easy as
> "apt-get install sparse; make C=2".
> 
> Bjorn

I don't know anything about packaging...  :/

regards,
dan carpenter
