Return-Path: <SRS0=YfgC=7R=mm-sol.com=svarbanov@kernel.org>
Return-Path: <SRS0=YfgC=7R=mm-sol.com=svarbanov@kernel.org>
Subject: Re: [PATCHv2 4/6] PCI: layerscape: refactor the host_init function
To: Bjorn Helgaas <helgaas@kernel.org>, Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 Joao.Pinto@synopsys.com, minghuan.lian@nxp.com, mingkai.hu@nxp.com,
 roy.zang@nxp.com, Niklas Cassel <niklas.cassel@axis.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>
References: <1501748620-42866-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1501748620-42866-5-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170814213824.GJ32525@bhelgaas-glaptop.roam.corp.google.com>
 <20170814222605.GK32525@bhelgaas-glaptop.roam.corp.google.com>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <f74fb76f-4797-7d80-703b-440bc9c831dd@mm-sol.com>
Date: Tue, 15 Aug 2017 12:34:25 +0300
MIME-Version: 1.0
In-Reply-To: <20170814222605.GK32525@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 08/15/2017 01:26 AM, Bjorn Helgaas wrote:
> [+cc Stanimir, Niklas, Jesper]
> 
> On Mon, Aug 14, 2017 at 04:38:24PM -0500, Bjorn Helgaas wrote:
>> On Thu, Aug 03, 2017 at 04:23:38PM +0800, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> Make the ls1021a's host_init reuse layerscape platform's common
>>> host_init function.
>>>
>>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>> ---
>>> V2:
>>>  - Removed the disable outbound windows code and the remove duplicate class code
>>>    fixup code from this patch.
>>>
>>>  drivers/pci/dwc/pci-layerscape.c | 54 ++++++++++++++++++++--------------------
>>>  1 file changed, 27 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
>>> index 09056a6..3533a8c 100644
>>> --- a/drivers/pci/dwc/pci-layerscape.c
>>> +++ b/drivers/pci/dwc/pci-layerscape.c
>>> @@ -107,33 +107,6 @@ static int ls1021_pcie_link_up(struct dw_pcie *pci)
>>>  	return 1;
>>>  }
>>>  

<cut>

> 
>   - Enable write permission in dw_pcie_setup_rc() and remove class
>     code update from ls_pcie_host_init()  This will make it obvious
>     that fixing dw_pcie_setup_rc() makes ls_pcie_fix_class() obsolete.
> 
> Does this dw_pcie_setup_rc() fix mean we can also get rid of the
> device class check in qcom_pcie_rd_own_conf()?

Thanks for the CC, I'll manage to test those patches and after that I'll
confirm does this fixes device_class register value for qcom driver.


regards,
Stan
