Return-Path: <SRS0=EVB7=GM=rock-chips.com=shawn.lin@kernel.org>
Return-Path: <SRS0=EVB7=GM=rock-chips.com=shawn.lin@kernel.org>
Cc: shawn.lin@rock-chips.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/6] PCI: rockchip: Create individual folder for
 rockchip drivers
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1520304173-231081-1-git-send-email-shawn.lin@rock-chips.com>
 <1520304202-232891-1-git-send-email-shawn.lin@rock-chips.com>
 <20180320174633.GA137590@bhelgaas-glaptop.roam.corp.google.com>
 <879a4862-d0d5-21fd-6c47-029c795fe78e@rock-chips.com>
 <20180321181940.GA9760@e107981-ln.cambridge.arm.com>
 <7275bd77-016a-2729-482d-2855703d9b56@rock-chips.com>
 <20180322084735.GC6211@kroah.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <b8173dd9-6cf3-ceaf-4293-655e1a5199a4@rock-chips.com>
Date: Thu, 22 Mar 2018 19:09:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180322084735.GC6211@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 2018/3/22 16:47, Greg Kroah-Hartman wrote:
> On Thu, Mar 22, 2018 at 09:03:58AM +0800, Shawn Lin wrote:

...

> USB is "messy" in that we have hardware that acts both as a host and a
> gadget controller.  Don't use our directory scheme as an example to do
> anything :)
> 

Thanks for comment.

> Do what is right for the PCI subsystem, if a driver is too "complex"
> that it needs lots of different files, make a subdirectory to make it

Clearly it't not too complex for PCI now, so I think we don't need
seperate directory for each controller.

> easier to manage.  That's all we did for USB, nothing really complex.
> 
> good luck!
> 
> greg k-h
> 
> 
> 
