Return-Path: <SRS0=qK1b=K6=gmail.com=groeck7@kernel.org>
Return-Path: <SRS0=qK1b=K6=gmail.com=groeck7@kernel.org>
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 15 Aug 2018 15:40:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Hari Vyas <hari.vyas@broadcom.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	ray.jui@broadcom.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] pci: Proof of concept at fixing
 pci_enable_device/bridge races
Message-ID: <20180815224028.GA12104@roeck-us.net>
References: <1530608741-30664-1-git-send-email-hari.vyas@broadcom.com>
 <20180731163727.GK45322@bhelgaas-glaptop.roam.corp.google.com>
 <ecaed7664b46d73888d2494065905f8e108fc0f4.camel@kernel.crashing.org>
 <5e42f7990673d11e3a020e7efcfd333215d48138.camel@kernel.crashing.org>
 <58192cf94de3941f9141aa3203399ae2bcdf6b7a.camel@kernel.crashing.org>
 <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08bc40a6af3e614e97a78fbaab688bfcd14520ac.camel@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 07:50:13AM +1000, Benjamin Herrenschmidt wrote:
> (Resent with lkml on copy)
> 
> [Note: This isn't meant to be merged, it need splitting at the very
> least, see below]
> 
> This is something I cooked up quickly today to test if that would fix
> my problems with large number of switch and NVME devices on POWER.
> 

Is that a problem that can be reproduced with a qemu setup ?

Thanks,
Guenter
