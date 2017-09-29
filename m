Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Sep 2017 16:31:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, linuxarm@huawei.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        liudongdong3@huawei.com
Subject: Re: [PATCH v3] PCIe AER: report uncorrectable errors only to the
 functions that logged the errors
Message-ID: <20170929213102.GE31210@bhelgaas-glaptop.roam.corp.google.com>
References: <1506609185-8800-1-git-send-email-gabriele.paoloni@huawei.com>
 <20170929211526.GD31210@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170929211526.GD31210@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Sep 29, 2017 at 04:15:26PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 28, 2017 at 03:33:05PM +0100, Gabriele Paoloni wrote:
> > Currently if an uncorrectable error is reported by an EP the AER
> > driver walks over all the devices connected to the upstream port
> > bus and in turns call the report_error_detected() callback.
> > If any of the devices connected to the bus does not implement
> > dev->driver->err_handler->error_detected() do_recovery() will fail
> > leaving all the bus hierarchy devices unrecovered.
> > 
> > According to section "6.2.2.2.2. Non-Fatal Errors" of the PCIe specs
> > << Non-fatal errors are uncorrectable errors which cause a particular
> > transaction to be unreliable but the Link is otherwise fully functional.
> > Isolating Non-fatal from Fatal errors provides Requester/Receiver logic
> > in a device or system management software the opportunity to recover
> > from the error without resetting the components on the Link and
> > disturbing other transactions in progress. Devices not associated with
> > the transaction in error are not impacted by the error.>>
> > therefore for non fatal errors the PCIe link should not be considered
> > compromised and it makes sense to report the error only to all the
> > functions that logged an error.
> > 
> > This patch implements this new behaviour for non fatal errors.
> > Also this patch fixes a bug (filed as in the link below)
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=197055
> > Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
> > Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> > Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> 
> Applied to pci/aer for v4.15, thanks!
> 
> I rewrote some of the changelog to say "non-fatal" instead of
> "uncorrectable", since "uncorrectable" also includes fatal errors,
> and you're not changing those.  Take a look and let me know if
> I broke anything.

Here it is so you don't have to look it up :)

commit 34ba6e7d5f3e37a369097c07c00bfed567860b8c
Author: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Date:   Thu Sep 28 15:33:05 2017 +0100

    PCI/AER: Report non-fatal errors only to the affected endpoint
    
    Previously, if an non-fatal error was reported by an endpoint, we
    called report_error_detected() for the endpoint, every sibling on the
    bus, and their descendents.  If any of them did not implement the
    .error_detected() method, do_recovery() failed, leaving all these
    devices unrecovered.
    
    For example, the system described in the bugzilla below has two devices:
    
      0000:74:02.0 [19e5:a230] SAS controller, driver has .error_detected()
      0000:74:03.0 [19e5:a235] SATA controller, driver lacks .error_detected()
    
    When a device such as 74:02.0 reported a non-fatal error, do_recovery()
    failed because 74:03.0 lacked an .error_detected() method.  But per PCIe
    r3.1, sec 6.2.2.2.2, such an error does not compromise the Link and
    does not affect 74:03.0:
    
      Non-fatal errors are uncorrectable errors which cause a particular
      transaction to be unreliable but the Link is otherwise fully functional.
      Isolating Non-fatal from Fatal errors provides Requester/Receiver logic
      in a device or system management software the opportunity to recover from
      the error without resetting the components on the Link and disturbing
      other transactions in progress.  Devices not associated with the
      transaction in error are not impacted by the error.
    
    Report non-fatal errors only to the endpoint that reported them.  We really
    want to check for AER_NONFATAL here, but the current code structure doesn't
    allow that.  Looking for pci_channel_io_normal is the best we can do now.
    
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=197055
    Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
    Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
    Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
    [bhelgaas: changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 890efcc574cb..744805232155 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -390,7 +390,14 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
 		 */
-		pci_walk_bus(dev->bus, cb, &result_data);
+		if (state == pci_channel_io_normal)
+			/*
+			 * the error is non fatal so the bus is ok, just invoke
+			 * the callback for the function that logged the error.
+			 */
+			cb(dev, &result_data);
+		else
+			pci_walk_bus(dev->bus, cb, &result_data);
 	}
 
 	return result_data.result;
