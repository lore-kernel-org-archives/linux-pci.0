Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36939 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbcJMHFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2016 03:05:16 -0400
Date: Thu, 13 Oct 2016 09:58:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: ying.huang@intel.com
Cc: linux-pci@vger.kernel.org
Subject: [bug report] ACPI, APEI, Add PCIe AER error information printing
 support
Message-ID: <20161013065847.GA30382@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Huang Ying,

The patch c413d7682020: "ACPI, APEI, Add PCIe AER error information
printing support" from Feb 21, 2011, leads to the following static
checker warning:

	drivers/pci/pcie/aer/aerdrv_errprint.c:229 cper_print_aer()
	warn: bool comparison is always 'false'

drivers/pci/pcie/aer/aerdrv_errprint.c
   222  void cper_print_aer(struct pci_dev *dev, int aer_severity,
   223                      struct aer_capability_regs *aer)
   224  {
   225          int layer, agent, status_strs_size, tlp_header_valid = 0;
   226          u32 status, mask;
   227          const char **status_strs;
   228  
   229          if (aer_severity == AER_CORRECTABLE) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
In the current code, aer_severity can only be AER_NONFATAL or AER_FATAL
so this condition can never be true.  This seems like it a confusing
thing.

   230                  status = aer->cor_status;
   231                  mask = aer->cor_mask;
   232                  status_strs = aer_correctable_error_string;
   233                  status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
   234          } else {
   235                  status = aer->uncor_status;
   236                  mask = aer->uncor_mask;
   237                  status_strs = aer_uncorrectable_error_string;
   238                  status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
   239                  tlp_header_valid = status & AER_LOG_TLP_MASKS;
   240          }
   241  
   242          layer = AER_GET_LAYER_ERROR(aer_severity, status);
   243          agent = AER_GET_AGENT(aer_severity, status);
   244  

regards,
dan carpenter
