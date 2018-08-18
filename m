Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=yCvU=LB=kernel.crashing.org=benh@kernel.org>
Message-ID: <20490639ea65ae09bec4ed33cf07a69b61935959.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/6] pci: Set pci_dev->is_added before calling
 device_add
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Hari Vyas <hari.vyas@broadcom.com>,
        Ray Jui
 <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska
 <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Sat, 18 Aug 2018 13:41:02 +1000
In-Reply-To: <20180817181501.m4j7jibzsrgljmlj@wunner.de>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-3-benh@kernel.crashing.org>
	 <20180817162534.GD128050@bhelgaas-glaptop.roam.corp.google.com>
	 <20180817181501.m4j7jibzsrgljmlj@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2018-08-17 at 20:15 +0200, Lukas Wunner wrote:
> 
> The two steps (enumeration and driver attachment) are protected by
> pci_lock_rescan_remove().  Initially, when a pci_dev is newly allocated
> with kzalloc(), is_added is 0.  The transition from 0 to 1 happens while
> under pci_lock_rescan_remove().  When that lock is released, is_added is
> always 1, barring a device_attach() error, in which case it will remain
> at 0.
> 
> AFAICS, there is no second mutex needed to ensure synchronization of
> is_added, the existing mutex should be sufficient and the only problem
> are RMW races when accessing adjacent flags. Those were correctly addressed
> by Hari's patch.  Benjamin seems to be alleging that concurrency issues
> exist beyond the RMW races, I fail to see them, sorry.

Im saying that fixing those issues using atomic bitops is a generally
unsafe practice even if it happens to work in a specific case.

In this one, I argue that the root problem was simply that is_added was
set in the wrong place. The "fix" from Hari touches 9 files, adds
horrible relative includes to an architecture and generally bloats
things while a single 3 liner would have been sufficient.

The current use of is_added is asymetric (it's cleared during
device_attach but set during detach) which is bogus and the entire race
stems from the fact that it is set after device_attach returns.

So setting it early is, imho, the right fix, is much simpler, and fixes
the odd imbalance we have to begin with.

Ben.
