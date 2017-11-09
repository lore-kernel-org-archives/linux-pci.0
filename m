Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: dann frazier <dann.frazier@canonical.com>
Subject: RE: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with
 DT bindings
Date: Thu, 9 Nov 2017 10:05:14 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40CC7ED0@FRAEML521-MBX.china.huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
 <20171109004604.vkrpyrxbogx7r4td@xps13.dannf>
In-Reply-To: <20171109004604.vkrpyrxbogx7r4td@xps13.dannf>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "minyard@acm.org" <minyard@acm.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 John Garry <john.garry@huawei.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "xuwei \(O\)" <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "zhichang.yuan" <yuanzhichang@hisilicon.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "brian.starkey@arm.com" <brian.starkey@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Hi Dann

[...]

> > +
> > +#define START_WORK		0x01
> 
> Any reason not to put this in the LPC_ namespace as well?

No, not really. We'll make it consistent in the next patchset 

> 
> > +/* The minimal nanosecond interval for each query on LPC cycle
> status. */

[...]

> > + * hisilpc_target_in - trigger a series of lpc cycles to read
> required data
> > + *		       from target peripheral.
> > + * @pdev: pointer to hisi lpc device
> 
> It's now lpcdev
> 

Thanks, we'll change it.

> > + * @para: some parameters used to control the lpc I/O operations

[...]

> > + * @pio: the target I/O port address.
> 
> @outval & @pio are in the opposite order of the actual function

Thanks, we'll change it.

> 

[...]

> > +		lpcdev->io_host->devpara = NULL;
> > +		dev_err(dev, "OF: scan hisilpc children got failed(%d)\n",
> > +			ret);
> 
> nit: Maybe "OF: scanning hisilpc children failed(%d)" ?
> 

Yes, thanks we'll change it.

> > +		return ret;
> > +	}
> > +
> > +	dev_info(dev, "hslpc end probing. range[%pa - sz:%pa]\n",
> > +		&lpcdev->io_host->io_start,
> > +		&lpcdev->io_host->size);
> > +
> > +	return ret;
> > +}
> 
> 
>  -dann

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
