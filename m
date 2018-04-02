Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 03/14] PCI: Add pcie_bandwidth_capable() to compute max
 supported link bandwidth
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Tariq Toukan <tariqt@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Ariel Elior <ariel.elior@cavium.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        everest-linux-l2@cavium.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <152244269202.135666.3064353823697623332.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <152244390359.135666.14890735614456271032.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <31e66048-e8b8-47ba-baf5-023560b4c124@mellanox.com>
 <20180402004049.GA131023@bhelgaas-glaptop.roam.corp.google.com>
 <50346f44-de3f-b226-69ad-6de45e94e261@mellanox.com>
 <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <3decbba0-74a2-c906-b5b4-a04f261860eb@mellanox.com>
Date: Mon, 2 Apr 2018 17:34:06 +0300
MIME-Version: 1.0
In-Reply-To: <20180402140501.GA244675@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4/2/2018 5:05 PM, Bjorn Helgaas wrote:
> On Mon, Apr 02, 2018 at 10:34:58AM +0300, Tal Gilboa wrote:
>> On 4/2/2018 3:40 AM, Bjorn Helgaas wrote:
>>> On Sun, Apr 01, 2018 at 11:38:53PM +0300, Tal Gilboa wrote:
>>>> On 3/31/2018 12:05 AM, Bjorn Helgaas wrote:
>>>>> From: Tal Gilboa <talgi@mellanox.com>
>>>>>
>>>>> Add pcie_bandwidth_capable() to compute the max link bandwidth supported by
>>>>> a device, based on the max link speed and width, adjusted by the encoding
>>>>> overhead.
>>>>>
>>>>> The maximum bandwidth of the link is computed as:
>>>>>
>>>>>      max_link_speed * max_link_width * (1 - encoding_overhead)
>>>>>
>>>>> The encoding overhead is about 20% for 2.5 and 5.0 GT/s links using 8b/10b
>>>>> encoding, and about 1.5% for 8 GT/s or higher speed links using 128b/130b
>>>>> encoding.
>>>>>
>>>>> Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>>>>> [bhelgaas: adjust for pcie_get_speed_cap() and pcie_get_width_cap()
>>>>> signatures, don't export outside drivers/pci]
>>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>> Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
>>>>> ---
>>>>>     drivers/pci/pci.c |   21 +++++++++++++++++++++
>>>>>     drivers/pci/pci.h |    9 +++++++++
>>>>>     2 files changed, 30 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index 43075be79388..9ce89e254197 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -5208,6 +5208,27 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>>>>>     	return PCIE_LNK_WIDTH_UNKNOWN;
>>>>>     }
>>>>> +/**
>>>>> + * pcie_bandwidth_capable - calculates a PCI device's link bandwidth capability
>>>>> + * @dev: PCI device
>>>>> + * @speed: storage for link speed
>>>>> + * @width: storage for link width
>>>>> + *
>>>>> + * Calculate a PCI device's link bandwidth by querying for its link speed
>>>>> + * and width, multiplying them, and applying encoding overhead.
>>>>> + */
>>>>> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
>>>>> +			   enum pcie_link_width *width)
>>>>> +{
>>>>> +	*speed = pcie_get_speed_cap(dev);
>>>>> +	*width = pcie_get_width_cap(dev);
>>>>> +
>>>>> +	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
>>>>> +		return 0;
>>>>> +
>>>>> +	return *width * PCIE_SPEED2MBS_ENC(*speed);
>>>>> +}
>>>>> +
>>>>>     /**
>>>>>      * pci_select_bars - Make BAR mask from the type of resource
>>>>>      * @dev: the PCI device for which BAR mask is made
>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>> index 66738f1050c0..2a50172b9803 100644
>>>>> --- a/drivers/pci/pci.h
>>>>> +++ b/drivers/pci/pci.h
>>>>> @@ -261,8 +261,17 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>>>>>     	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>>>>>     	 "Unknown speed")
>>>>> +/* PCIe speed to Mb/s with encoding overhead: 20% for gen2, ~1.5% for gen3 */
>>>>> +#define PCIE_SPEED2MBS_ENC(speed) \
>>>>
>>>> Missing gen4.
>>>
>>> I made it "gen3+".  I think that's accurate, isn't it?  The spec
>>> doesn't seem to actually use "gen3" as a specific term, but sec 4.2.2
>>> says rates of 8 GT/s or higher (which I think includes gen3 and gen4)
>>> use 128b/130b encoding.
>>>
>>
>> I meant that PCIE_SPEED_16_0GT will return 0 from this macro since it wasn't
>> added. Need to return 15754.
> 
> Oh, duh, of course!  Sorry for being dense.  What about the following?
> I included the calculation as opposed to just the magic numbers to try
> to make it clear how they're derived.  This has the disadvantage of
> truncating the result instead of rounding, but I doubt that's
> significant in this context.  If it is, we could use the magic numbers
> and put the computation in a comment.

We can always use DIV_ROUND_UP((speed * enc_nominator), 
enc_denominator). I think this is confusing and since this introduces a 
bandwidth limit I would prefer to give a wider limit than a wrong one, 
even it is by less than 1Mb/s. My vote is for leaving it as you wrote below.

> 
> Another question: we currently deal in Mb/s, not MB/s.  Mb/s has the
> advantage of sort of corresponding to the GT/s numbers, but using MB/s
> would have the advantage of smaller numbers that match the table here:
> https://en.wikipedia.org/wiki/PCI_Express#History_and_revisions,
> but I don't know what's most typical in user-facing situations.
> What's better?

I don't know what's better but for network devices we measure bandwidth 
in Gb/s, so presenting bandwidth in MB/s would mean additional 
calculations. The truth is I would have prefer to use Gb/s instead of 
Mb/s, but again, don't want to loss up to 1Gb/s.

> 
> 
> commit 946435491b35b7782157e9a4d1bd73071fba7709
> Author: Tal Gilboa <talgi@mellanox.com>
> Date:   Fri Mar 30 08:32:03 2018 -0500
> 
>      PCI: Add pcie_bandwidth_capable() to compute max supported link bandwidth
>      
>      Add pcie_bandwidth_capable() to compute the max link bandwidth supported by
>      a device, based on the max link speed and width, adjusted by the encoding
>      overhead.
>      
>      The maximum bandwidth of the link is computed as:
>      
>        max_link_width * max_link_speed * (1 - encoding_overhead)
>      
>      2.5 and 5.0 GT/s links use 8b/10b encoding, which reduces the raw bandwidth
>      available by 20%; 8.0 GT/s and faster links use 128b/130b encoding, which
>      reduces it by about 1.5%.
>      
>      The result is in Mb/s, i.e., megabits/second, of raw bandwidth.
>      
>      Signed-off-by: Tal Gilboa <talgi@mellanox.com>
>      [bhelgaas: add 16 GT/s, adjust for pcie_get_speed_cap() and
>      pcie_get_width_cap() signatures, don't export outside drivers/pci]
>      Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>      Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 43075be79388..ff1e72060952 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5208,6 +5208,28 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev)
>   	return PCIE_LNK_WIDTH_UNKNOWN;
>   }
>   
> +/**
> + * pcie_bandwidth_capable - calculate a PCI device's link bandwidth capability
> + * @dev: PCI device
> + * @speed: storage for link speed
> + * @width: storage for link width
> + *
> + * Calculate a PCI device's link bandwidth by querying for its link speed
> + * and width, multiplying them, and applying encoding overhead.  The result
> + * is in Mb/s, i.e., megabits/second of raw bandwidth.
> + */
> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> +			   enum pcie_link_width *width)
> +{
> +	*speed = pcie_get_speed_cap(dev);
> +	*width = pcie_get_width_cap(dev);
> +
> +	if (*speed == PCI_SPEED_UNKNOWN || *width == PCIE_LNK_WIDTH_UNKNOWN)
> +		return 0;
> +
> +	return *width * PCIE_SPEED2MBS_ENC(*speed);
> +}
> +
>   /**
>    * pci_select_bars - Make BAR mask from the type of resource
>    * @dev: the PCI device for which BAR mask is made
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 66738f1050c0..37f9299ed623 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -261,8 +261,18 @@ void pci_disable_bridge_window(struct pci_dev *dev);
>   	 (speed) == PCIE_SPEED_2_5GT ? "2.5 GT/s" : \
>   	 "Unknown speed")
>   
> +/* PCIe speed to Mb/s reduced by encoding overhead */
> +#define PCIE_SPEED2MBS_ENC(speed) \
> +	((speed) == PCIE_SPEED_16_0GT ? (16000*(128/130)) : \
> +	 (speed) == PCIE_SPEED_8_0GT  ?  (8000*(128/130)) : \
> +	 (speed) == PCIE_SPEED_5_0GT  ?  (5000*(8/10)) : \
> +	 (speed) == PCIE_SPEED_2_5GT  ?  (2500*(8/10)) : \
> +	 0)
> +
>   enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
>   enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
> +u32 pcie_bandwidth_capable(struct pci_dev *dev, enum pci_bus_speed *speed,
> +			   enum pcie_link_width *width);
>   
>   /* Single Root I/O Virtualization */
>   struct pci_sriov {
> 
