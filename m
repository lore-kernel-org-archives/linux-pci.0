Return-Path: <SRS0=0EeQ=3I=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=0EeQ=3I=free.fr=slash.tmp@kernel.org>
Subject: Re: [PATCH v3 0/2] Tango PCIe controller support
From: Mason <slash.tmp@free.fr>
To: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, David Laight <david.laight@aculab.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <5309e718-5813-5b79-db57-9d702b50d0f9@sigmadesigns.com>
 <1561c381-bfa7-6e4d-a016-8ad7293a60ce@free.fr>
Message-ID: <88af8239-bef4-dfd5-2280-66104bee72e8@free.fr>
Date: Sat, 1 Apr 2017 00:05:27 +0200
MIME-Version: 1.0
In-Reply-To: <1561c381-bfa7-6e4d-a016-8ad7293a60ce@free.fr>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 30/03/2017 22:56, Mason wrote:

> I've run into an issue.
> 
> If I boot the system with earlyprintk enabled (as I've
> been doing throughout my dev), things work as expected.
> 
> But if I boot with earlyprintk disabled, then the system
> does not "see" the PCIe board, because reading the vendor
> ID returns 0xffffffff.
> 
> What we think is happening, is that when earlyprintk is
> disabled, the system proceeds much faster through the
> various inits, and the PCIe init happens when PCIe
> link training has not completed yet.
> 
> If that is the case, then it seems I would need to check
> the link state in my probe function.

I determined empirically that link training takes around
10-15 ms. Though I suppose this might depend on the
specific PCIe board? (I'm only considering x1 link.)

So I added an msleep(20); in the probe function, and in
the config_read callback, I check the link status on the
first read to the device.

Should I msleep(40) to be safe?

Regards.
