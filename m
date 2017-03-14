Return-Path: <SRS0=M6Q2=2X=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=M6Q2=2X=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Tue, 14 Mar 2017 21:27:13 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Stephen Boyd <stephen.boyd@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: aardvark: Remove msi-controller dt node probing
Message-ID: <20170314212713.1afb7a9f@free-electrons.com>
In-Reply-To: <20170314193005.GC26264@bhelgaas-glaptop.roam.corp.google.com>
References: <20170314190851.28203-1-stephen.boyd@linaro.org>
	<20170314193005.GC26264@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Tue, 14 Mar 2017 14:30:05 -0500, Bjorn Helgaas wrote:
> On Tue, Mar 14, 2017 at 12:08:51PM -0700, Stephen Boyd wrote:
> > This code assigns variables that are never used. Remove them.
> > 
> > Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>  
> 
> I love removing unused code!  Applied to pci/host-aardvark for v4.12,
> thanks!

Why? I have already sent a patch that also does this (and much more!) a
number of times already, and it has never been applied. See:

  [PATCH v3 1/3] pci: pci-aardvark: move to MSI handling using generic MSI support

v1 on September 1st, 2016
v2 on December 23th, 2016
v3 on February 28th, 2017

Best regards,

Thomas

-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
