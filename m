Return-Path: <SRS0=90sa=CO=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=90sa=CO=codeaurora.org=okaya@kernel.org>
Subject: Re: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
To: Bjorn Helgaas <helgaas@kernel.org>, Oza Pawandeep <poza@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dongdong Liu <liudongdong3@huawei.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
Date: Thu, 16 Nov 2017 09:03:37 -0500
MIME-Version: 1.0
In-Reply-To: <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 11/15/2017 4:14 PM, Bjorn Helgaas wrote:
>> +	if (pcie_port_query_uptream_service(dev, PCIE_PORT_SERVICE_DPC)) {
>> +		dev_info(&dev->dev, "AER: Device recovery to be done by DPC\n");
>> +		return;
>> +	}
> What happens without this test?
> 
> Does AER read registers from the now-disabled device and get ~0 data?
> Or is AER reading registers from the port upstream from the disabled
> device and trying to reset the device?
> 
> It looks like get_device_error_info() reads registers and doesn't
> check to see whether it gets ~0 back.  I'm wondering if we *should* be
> checking there and whether doing that would help mitigate the issue
> here.

The issue is two independent software entities are trying to recover the PCIe
link simultaneously. AER and DPC have two different approaches to link recovery.

AER makes a callback into the endpoint drivers for non-fatal errors and hope
that endpoint driver can recover the link. AER also makes a callback in the 
fatal error case but resets the link via secondary bus reset.

The DPC on the other hand stops the drivers immediately since HW took care of
link disable. (Endpoint register reads return ~0 at this point.) DPC driver clears
the interrupt from the DPC capability and brings the link up at the end. Full
enumeration/rescan follows this procedure to go back to functioning state. 

If we don't have this AER-DPC coordination, the endpoint driver gets confused since
it receives a stop command as well as a recover command at about the same time
depending on the timing.

Whether the AER driver reads ~0 or not really depends on timing. The link may come
up from the DPC driver by the time AER driver reaches here as an example.

Bad things do happen. We have seen this with e1000e driver.

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
