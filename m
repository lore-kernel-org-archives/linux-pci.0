Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <CACK8Z6EfUTDjCM=fmdHfWeu8UV5GN+i6PX9fKkR1H8K90TXozg@mail.gmail.com>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-3-git-send-email-okaya@codeaurora.org>
 <CACK8Z6EfUTDjCM=fmdHfWeu8UV5GN+i6PX9fKkR1H8K90TXozg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 13 Apr 2017 13:25:44 -0500
Message-ID: <CAErSpo4gduGVq2Na0tYbG77Pi23R-RMBvAcJueWrQTJCRsHYGw@mail.gmail.com>
Subject: Re: [PATCH V8 2/5] PCI/ASPM: split pci_aspm_init() into two
To: Rajat Jain <rajatja@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
 Rajat Jain <rajatxjain@gmail.com>, David Daney <david.daney@cavium.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Timur Tabi <timur@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 12, 2017 at 2:16 PM, Rajat Jain <rajatja@google.com> wrote:
> On Fri, Apr 7, 2017 at 9:55 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Split pci_aspm_init() body into pci_aspm_init_upstream()
>> and pci_aspm_init_downstream() for bridge and endpoint
>> specific code behavior.
>>
>> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=194895
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>> ---
>>  drivers/pci/pcie/aspm.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index dc36717..a80d64b 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -826,6 +826,16 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>>         return link;
>>  }
>>
>> +static int pci_aspm_init_downstream(struct pci_dev *pdev)
>> +{
>> +       return 0;
>> +}
>> +
>> +static int pci_aspm_init_upstream(struct pci_dev *pdev)
>> +{
>> +       return 0;
>> +}
>> +
>>  /*
>>   * pci_aspm_init: Initiate PCI express link state.
>>   * It is called from device_add for every single pci device.
>> @@ -833,7 +843,10 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>>   */
>>  int pci_aspm_init(struct pci_dev *pdev)
>>  {
>> -       return 0;
>> +       if (!pdev->has_secondary_link)
>> +               return pci_aspm_init_downstream(pdev);
>> +
>> +       return pci_aspm_init_upstream(pdev);
>>  }
>
> Nit:
>
> if (x_flag())
>    return x();
> return y();
>
> May be better than
>
> if (!x_flag)
>     return y();
> return x();

I agree, and I made that change on my branch.  I also renamed these to
pci_aspm_init_downstream_port() (for Root Ports and Switch Downstream
Ports) and pci_aspm_init_upstream_port() (for Switch Upstream Ports
and Endpoints) to try to match the terminology in the spec.

FWIW, your email didn't seem to make it to the list, Rajat.  Maybe
some gmail weirdness?  I don't *see* anything wrong, but ...  I'm
responding via gmail, so my response probably won't make it to the
list either.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
