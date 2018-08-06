Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH 3/3] PCI/portdrv: Add support for sharing xilinx
 controller irq with AER
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, rgummal@xilinx.com
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-4-git-send-email-bharat.kumar.gogada@xilinx.com>
 <7d5ae8ed-5623-3cd2-7769-77702448b2d6@kernel.org>
 <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <b50328a5-2def-d1ff-c202-8d4b44bd3e28@kernel.org>
Date: Mon, 6 Aug 2018 17:24:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180806205614.GC30691@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 8/6/2018 4:56 PM, Bjorn Helgaas wrote:
>> I remember seeing a similar patch before.
> Are you thinking of [1]?
> 

yup.
