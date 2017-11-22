Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 29/30] i7300_idle: deprecate pci_get_bus_and_slot()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
 <1511328675-21981-30-git-send-email-okaya@codeaurora.org>
 <20171122075345.GC26583@kroah.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <81de37c1-26b5-41f7-ab32-b98012890971@codeaurora.org>
Date: Wed, 22 Nov 2017 11:15:47 -0500
MIME-Version: 1.0
In-Reply-To: <20171122075345.GC26583@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, open list <linux-kernel@vger.kernel.org>,
 Philippe Ombredanne <pombredanne@nexb.com>, linux-arm-msm@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 11/22/2017 2:53 AM, Greg Kroah-Hartman wrote:
>> +++ b/include/linux/i7300_idle.h
>> @@ -48,7 +48,7 @@ static inline int i7300_idle_platform_probe(struct pci_dev **fbd_dev,
>>  	int i;
>>  	struct pci_dev *memdev, *dmadev;
>>  
>> -	memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);
>> +	memdev = pci_get_domain_bus_and_slot(0, MEMCTL_BUS, MEMCTL_DEVFN);
> You have a pci_dev, why can't you use it here to get the domain?
> 

Both fbd_dev and ioat_dev are output parameters. 

dmadev = pci_get_bus_and_slot(IOAT_BUS, IOAT_DEVFN);
memdev = pci_get_bus_and_slot(MEMCTL_BUS, MEMCTL_DEVFN);

	for (i = 0; fbd_ioat_list[i].vendor != 0; i++) {
		if (dmadev->vendor == fbd_ioat_list[i].vendor &&
		    dmadev->device == fbd_ioat_list[i].ioat_dev) {
			if (!(fbd_ioat_list[i].enabled || enable_all))
				continue;

			if (fbd_dev)
				*fbd_dev = memdev;
			if (ioat_dev)
				*ioat_dev = dmadev;

Funny thing is nobody is calling this function. Maybe, I should just kill it
instead.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
