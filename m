Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:53700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752657AbcJNInE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Oct 2016 04:43:04 -0400
From: "Huang\, Ying" <ying.huang@intel.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <ying.huang@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [bug report] ACPI, APEI, Add PCIe AER error information printing support
References: <20161013065847.GA30382@mwanda>
Date: Fri, 14 Oct 2016 16:43:01 +0800
In-Reply-To: <20161013065847.GA30382@mwanda> (Dan Carpenter's message of "Thu,
        13 Oct 2016 09:58:47 +0300")
Message-ID: <87wphbuxre.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dan Carpenter <dan.carpenter@oracle.com> writes:

> Hello Huang Ying,
>
> The patch c413d7682020: "ACPI, APEI, Add PCIe AER error information
> printing support" from Feb 21, 2011, leads to the following static
> checker warning:
>
> 	drivers/pci/pcie/aer/aerdrv_errprint.c:229 cper_print_aer()
> 	warn: bool comparison is always 'false'
>
> drivers/pci/pcie/aer/aerdrv_errprint.c
>    222  void cper_print_aer(struct pci_dev *dev, int aer_severity,
>    223                      struct aer_capability_regs *aer)
>    224  {
>    225          int layer, agent, status_strs_size, tlp_header_valid = 0;
>    226          u32 status, mask;
>    227          const char **status_strs;
>    228  
>    229          if (aer_severity == AER_CORRECTABLE) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> In the current code, aer_severity can only be AER_NONFATAL or AER_FATAL
> so this condition can never be true.  This seems like it a confusing
> thing.

For now, there is no AER_CORRECTABLE usage for cper_print_aer(), but I
think we will need it sometime.

But your tool is very smart! :)

Best Regards,
Huang, Ying

>    230                  status = aer->cor_status;
>    231                  mask = aer->cor_mask;
>    232                  status_strs = aer_correctable_error_string;
>    233                  status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
>    234          } else {
>    235                  status = aer->uncor_status;
>    236                  mask = aer->uncor_mask;
>    237                  status_strs = aer_uncorrectable_error_string;
>    238                  status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
>    239                  tlp_header_valid = status & AER_LOG_TLP_MASKS;
>    240          }
>    241  
>    242          layer = AER_GET_LAYER_ERROR(aer_severity, status);
>    243          agent = AER_GET_AGENT(aer_severity, status);
>    244  
>
> regards,
> dan carpenter
