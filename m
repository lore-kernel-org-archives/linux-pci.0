Return-Path: <Joao.Pinto@synopsys.com>
Return-Path: <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v4 3/3] pcie-designware: fix typo
To: Bjorn Helgaas <helgaas@kernel.org>, Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1470758382.git.jpinto@synopsys.com>
 <bba00c66a124b80c2bc259b3d2f78e561c3df27a.1470758382.git.jpinto@synopsys.com>
 <20160809165428.GB27301@localhost>
CC: <jingoohan1@gmail.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jszhang@marvell.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <43f8c547-bb0f-96c0-54e0-3b541309ef90@synopsys.com>
Date: Wed, 10 Aug 2016 10:27:56 +0100
MIME-Version: 1.0
In-Reply-To: <20160809165428.GB27301@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

On 8/9/2016 5:54 PM, Bjorn Helgaas wrote:
> Hi Joao,
> 
> On Tue, Aug 09, 2016 at 05:35:34PM +0100, Joao Pinto wrote:
>> Simple fix typo.
> 
> This patch actually does more than fix a typo.  Not sure if you
> intended to split this into separate patches, or to write a better
> changelog for this one.  If these code changes are related and we have
> a good changelog, I don't mind if the typo fix is included as an
> incidental change.

Not sure what happened, but the fix typo should be in a separated patch!
I am going to send you a v5 of the patch set.

Thanks!

> 
> Bjorn
> 
>> Signed-off-by: Joao Pinto <jpinto@synopsys.com>
>> ---
>> changes v1->v4:
>> - Nothing changed. Just to keep up patch set version.
>>
>>  drivers/pci/host/pcie-designware.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
>> index 3fb9036..7731eda 100644
>> --- a/drivers/pci/host/pcie-designware.c
>> +++ b/drivers/pci/host/pcie-designware.c
>> @@ -36,7 +36,7 @@
>>  #define LINK_WAIT_IATU_MIN		9000
>>  #define LINK_WAIT_IATU_MAX		10000
>>  
>> -/* Synopsis specific PCIE configuration registers */
>> +/* Synopsys specific PCIE configuration registers */
>>  #define PCIE_PORT_LINK_CONTROL		0x710
>>  #define PORT_LINK_MODE_MASK		(0x3f << 16)
>>  #define PORT_LINK_MODE_1_LANES		(0x1 << 16)
>> @@ -253,7 +253,7 @@ static void dw_pcie_prog_outbound_atu(struct pcie_port *pp, int index,
>>  		}
>>  
>>  		if (val == PCIE_ATU_ENABLE)
>> -			break;
>> +			return;
>>  
>>  		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
>>  	}
>> @@ -646,11 +646,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>>  		}
>>  	}
>>  
>> +	pp->iatu_unroll_status = dw_pcie_get_atu_mode(pp);
>> +
>>  	if (pp->ops->host_init)
>>  		pp->ops->host_init(pp);
>>  
>> -	pp->iatu_unroll_status = dw_pcie_get_atu_mode(pp);
>> -
>>  	pp->root_bus_nr = pp->busn->start;
>>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>>  		bus = pci_scan_root_bus_msi(pp->dev, pp->root_bus_nr,
>> -- 
>> 1.8.1.5
>>
