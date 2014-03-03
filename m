Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Mar 2014 17:26:00 +0800
From: Lee Jones <lee.jones@linaro.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: linux-kernel@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] timberdale: Use pci_enable_msix_exact() instead of
 pci_enable_msix()
Message-ID: <20140303092600.GB8282@lee--X1>
References: <1392804931-30671-3-git-send-email-agordeev@redhat.com>
 <20140219114424.GD10504@lee--X1>
 <20140221165606.GH17353@dhcp-26-207.brq.redhat.com>
 <20140221165809.GI17353@dhcp-26-207.brq.redhat.com>
 <20140224162902.GI15847@lee--X1>
 <20140303072551.GC4674@lee--X1>
 <20140303081023.GA25705@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140303081023.GA25705@dhcp-26-207.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > > Applied, thanks.
> > 
> > I've reverted this patch, as it doesn't build othognally.
> > 
> > drivers/mfd/timberdale.c:718:2:
> >   error: implicit declaration of function ‘pci_enable_msix_exact’
> >      [-Werror=implicit-function-declaration]
> 
> I should have to clarify it I think. Do you build on top of 3.14-rc4?

Not yet. Is the required patch in there?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
