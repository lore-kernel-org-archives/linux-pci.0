Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 31 Jan 2017 12:22:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shailendra Verma <shailendra.v@samsung.com>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.shailesh@samsung.com,
        ashish.kalra@samsung.com,
        Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: Re: [PATCH] Pci: host - Fix possible NULL derefrence.
Message-ID: <20170131182232.GA18672@bhelgaas-glaptop.roam.corp.google.com>
References: <CGME20170130044942epcas2p4c3e879675c189ff46c27b5f35bbc350f@epcas2p4.samsung.com>
 <1485751775-29126-1-git-send-email-shailendra.v@samsung.com>
 <20170131150900.GB9942@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170131150900.GB9942@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 31, 2017 at 09:09:00AM -0600, Bjorn Helgaas wrote:
> Hi Shailendra,
> 
> On Mon, Jan 30, 2017 at 10:19:35AM +0530, Shailendra Verma wrote:
> > of_match_device could return NULL, and so can cause a NULL
> > pointer dereference later.
> > 
> > Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> > ---
> >  drivers/pci/host/pcie-hisi.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> > index 56154c2..3256f8f 100644
> > --- a/drivers/pci/host/pcie-hisi.c
> > +++ b/drivers/pci/host/pcie-hisi.c
> > @@ -174,6 +174,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
> >  	driver = dev->driver;
> >  
> >  	match = of_match_device(driver->of_match_table, dev);
> > +	if (!match) {
> > +		dev_err(dev, "Error: No device match found\n");
> > +		return -ENODEV;
> > +	}
> >  	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
> >  
> >  	hisi_pcie->subctrl =
> 
> I like this patch and I think it's correct.  I'd like an ack from Zhou
> and/or Gabriele, and I'd propose the following tweak, which just moves the
> check earlier, before we start allocating this:

Geert pointed out in a similar case that it's actually impossible for match
to be NULL here because the only way to call hisi_pcie_probe() is to match
an entry in hisi_pcie_of_match[].  So I think the following patch is even
better because it removes a mention of driver->of_match_table.  I can't
easily build test to be sure, but I think the cast is also unnecessary.


commit 806d19760e48166505818d4efafbdfbad5810989
Author: Shailendra Verma <shailendra.v@samsung.com>
Date:   Mon Jan 30 10:19:35 2017 +0530

    PCI: hisi: Use of_device_get_match_data() to simplify probe
    
    The only way to call hisi_pcie_probe() is to match an entry in
    hisi_pcie_of_match[], so match cannot be NULL.
    
    Use of_device_get_match_data() to retrieve the soc_ops pointer.  No
    functional change intended.
    
    [bhelgaas: use of_device_get_match_data(), changelog]
    Based-on-suggestion-from: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
index a301a7187b30..34d10d242225 100644
--- a/drivers/pci/host/pcie-hisi.c
+++ b/drivers/pci/host/pcie-hisi.c
@@ -259,7 +259,6 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct hisi_pcie *hisi_pcie;
 	struct pcie_port *pp;
-	const struct of_device_id *match;
 	struct resource *reg;
 	struct device_driver *driver;
 	int ret;
@@ -272,11 +271,10 @@ static int hisi_pcie_probe(struct platform_device *pdev)
 	pp->dev = dev;
 	driver = dev->driver;
 
-	match = of_match_device(driver->of_match_table, dev);
-	hisi_pcie->soc_ops = (struct pcie_soc_ops *) match->data;
+	hisi_pcie->soc_ops = of_device_get_match_data(dev);
 
 	hisi_pcie->subctrl =
-	syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
+	    syscon_regmap_lookup_by_compatible("hisilicon,pcie-sas-subctrl");
 	if (IS_ERR(hisi_pcie->subctrl)) {
 		dev_err(dev, "cannot get subctrl base\n");
 		return PTR_ERR(hisi_pcie->subctrl);
