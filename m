Return-Path: <SRS0=4K84=45=mm-sol.com=svarbanov@kernel.org>
Return-Path: <SRS0=4K84=45=mm-sol.com=svarbanov@kernel.org>
Subject: Re: [PATCH] PCI: qcom: Add support for IPQ4019 PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>, John Crispin <john@phrozen.org>
References: <20170505152524.29337-1-john@phrozen.org>
 <20170523200719.GG7241@bhelgaas-glaptop.roam.corp.google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <41f174d7-7d11-f80f-5508-17f53af1ee97@mm-sol.com>
Date: Wed, 24 May 2017 02:31:27 +0300
MIME-Version: 1.0
In-Reply-To: <20170523200719.GG7241@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 23.05.2017 23:07, Bjorn Helgaas wrote:
> Stanimir?
>
> On Fri, May 05, 2017 at 05:25:24PM +0200, John Crispin wrote:
>> Add support for the IPQ4019 PCIe controller. IPQ4019 supports Gen
>> 1/2, one lane, one PCIe root complex with support for MSI and legacy
>> interrupts, and it conforms to PCI Express Base 2.1 specification.
>>
>> The core init is the sames as for the MSM8996, however the clocks and
>> reset lines differ.
>>
>> Signed-off-by: John Crispin <john@phrozen.org>
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie.txt          |  20 +-
>>  drivers/pci/host/pcie-qcom.c                       | 304 +++++++++++++++++++++
>
> pcie-qcom.c was recently moved to drivers/pci/dwc, but I was able to
> apply this by hand pretty easily.  But I would like Stanimir's ack
> first.

Bjorn, thanks for the reminder.

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

regards,
Stan
