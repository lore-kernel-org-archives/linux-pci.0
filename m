Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbeIRUDt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Sep 2018 16:03:49 -0400
Subject: Re: [PATCH] PCI/AER: Clear uncorrectable error status for device
To: Oza Pawandeep <poza@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Wei Zhang <wzhang@fb.com>, linux-kernel@vger.kernel.org
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <ab1ee64e-d257-4521-1517-4c2c648d0d9c@kernel.org>
Date: Tue, 18 Sep 2018 10:30:52 -0400
MIME-Version: 1.0
In-Reply-To: <1537258829-15763-1-git-send-email-poza@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 9/18/2018 4:20 AM, Oza Pawandeep wrote:
> +++ b/drivers/pci/pcie/err.c
> @@ -265,6 +265,8 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
>   		 * The error is non fatal so the bus is ok; just invoke
>   		 * the callback for the function that logged the error.
>   		 */
> +		if (cb == report_resume)
> +			pci_cleanup_aer_uncorrect_error_status(dev);
>   		cb(dev, &result_data);
>   	}

In order to follow the existing behavior (drivers are calling
pci_cleanup_aer_uncorrect_error_status() right before return),
you should probably move the pci_cleanup_aer_uncorrect_error_status
after

cb(dev, &result_data);

line.
