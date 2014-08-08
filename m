Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53E4F0AA.6000404@iam.tj>
Date: Fri, 08 Aug 2014 16:45:46 +0100
From: TJ <linux@iam.tj>
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org >> linux-kernel"
	<linux-kernel@vger.kernel.org>
CC: linux-pci@vger.kernel.org
Subject: Re: Regression: pci=realloc fails to modify bridge windows, causing
 devices to fail BAR allocation
References: <53D9FADA.6020304@iam.tj>
In-Reply-To: <53D9FADA.6020304@iam.tj>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 31/07/14 09:14, TJ wrote:
> See https://bugzilla.kernel.org/show_bug.cgi?id=81431
>
> Summary:
>
> Up until v3.15.7 booting with "pci=realloc,use_crs" successfully modifies the PCI bridge windows to allow an external ExpressCard <> ViDock4 + Nvidia Quadro NVS420 with its 2 GPUs to be configured.
>
> With v3.16rc6 and rc7 it fails to do this, leaving the NVS420 inoperable.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

This continues to affect 3.16.
