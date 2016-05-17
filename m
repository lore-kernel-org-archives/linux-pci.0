Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] pci: host: Add Broadcom STB PCIE RC controller
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-3-git-send-email-f.fainelli@gmail.com>
 <8520D5D51A55D047800579B094147198258955D9@XAP-PVEXMBX01.xlnx.xilinx.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <573A78D0.9090000@gmail.com>
Date: Mon, 16 May 2016 18:50:08 -0700
MIME-Version: 1.0
In-Reply-To: <8520D5D51A55D047800579B094147198258955D9@XAP-PVEXMBX01.xlnx.xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "jim2101024@gmail.com" <jim2101024@gmail.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 05/11/2016 07:47 AM, Bharat Kumar Gogada wrote:

[snip]

>> +	/* Get the value for the log2 of the scb sizes. Subtract 15 from
>> +	 * each because the target register field has 0==disabled and 1==6KB.
>> +	 */
>> +	log2_scb_sizes = of_get_property(dn, "brcm,log2-scb-sizes", &rlen);
>> +	if (log2_scb_sizes) {
>> +		for (i = 0; i < rlen / sizeof(u32); i++) {
>> +			pcie->scb_size_vals[i]
>> +				= (int)of_read_number(log2_scb_sizes + i, 1)
>> +					- 15;
>> +			pcie->num_memc++;
>> +		}
>> +	}
> In your device tree documentation this is required property, what if this property 
> is missing ?

If you look at the driver, you will see that it assumes a 1GB SCB window
size if this property is absent.

PS: Do you mind trimming your replies in the future just to quote the
relevant part? Pretty much like I just did, this greatly improves the
ability to jump right to where the comments are. Thanks
-- 
Florian

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
